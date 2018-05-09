Received: from eggs.gnu.org ([2001:4830:134:3::10]:58460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGNCy-0004NM-8x
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:24:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGNCw-0000pz-Ps
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:24:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37848 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fGNCw-0000pC-L2
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:24:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A3F640200A0
	for <qemu-devel@nongnu.org>; Wed,  9 May 2018 11:24:30 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  9 May 2018 13:23:32 +0200
Message-Id: <20180509112406.6183-8-quintela@redhat.com>
In-Reply-To: <20180509112406.6183-1-quintela@redhat.com>
References: <20180509112406.6183-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/41] migration: terminate_* can be called for
 other threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Once there, make  count field to always be accessed with atomic
operations.  To make blocking operations, we need to know that the
thread is running, so create a bool to indicate that.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

--

Once here, s/terminate_multifd_*-threads/multifd_*_terminate_threads/
This is consistente with every other function
---
 migration/ram.c | 44 ++++++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 826172c342..1aa661e6ab 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -439,6 +439,7 @@ struct MultiFDSendParams {
     QemuThread thread;
     QemuSemaphore sem;
     QemuMutex mutex;
+    bool running;
     bool quit;
 };
 typedef struct MultiFDSendParams MultiFDSendParams;
@@ -449,7 +450,7 @@ struct {
     int count;
 } *multifd_send_state;
=20
-static void terminate_multifd_send_threads(Error *err)
+static void multifd_send_terminate_threads(Error *err)
 {
     int i;
=20
@@ -465,7 +466,7 @@ static void terminate_multifd_send_threads(Error *err=
)
         }
     }
=20
-    for (i =3D 0; i < multifd_send_state->count; i++) {
+    for (i =3D 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p =3D &multifd_send_state->params[i];
=20
         qemu_mutex_lock(&p->mutex);
@@ -483,11 +484,13 @@ int multifd_save_cleanup(Error **errp)
     if (!migrate_use_multifd()) {
         return 0;
     }
-    terminate_multifd_send_threads(NULL);
-    for (i =3D 0; i < multifd_send_state->count; i++) {
+    multifd_send_terminate_threads(NULL);
+    for (i =3D 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p =3D &multifd_send_state->params[i];
=20
-        qemu_thread_join(&p->thread);
+        if (p->running) {
+            qemu_thread_join(&p->thread);
+        }
         qemu_mutex_destroy(&p->mutex);
         qemu_sem_destroy(&p->sem);
         g_free(p->name);
@@ -514,6 +517,10 @@ static void *multifd_send_thread(void *opaque)
         qemu_sem_wait(&p->sem);
     }
=20
+    qemu_mutex_lock(&p->mutex);
+    p->running =3D false;
+    qemu_mutex_unlock(&p->mutex);
+
     return NULL;
 }
=20
@@ -528,7 +535,7 @@ int multifd_save_setup(void)
     thread_count =3D migrate_multifd_channels();
     multifd_send_state =3D g_malloc0(sizeof(*multifd_send_state));
     multifd_send_state->params =3D g_new0(MultiFDSendParams, thread_coun=
t);
-    multifd_send_state->count =3D 0;
+    atomic_set(&multifd_send_state->count, 0);
     for (i =3D 0; i < thread_count; i++) {
         MultiFDSendParams *p =3D &multifd_send_state->params[i];
=20
@@ -537,10 +544,11 @@ int multifd_save_setup(void)
         p->quit =3D false;
         p->id =3D i;
         p->name =3D g_strdup_printf("multifdsend_%d", i);
+        p->running =3D true;
         qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
                            QEMU_THREAD_JOINABLE);
=20
-        multifd_send_state->count++;
+        atomic_inc(&multifd_send_state->count);
     }
     return 0;
 }
@@ -551,6 +559,7 @@ struct MultiFDRecvParams {
     QemuThread thread;
     QemuSemaphore sem;
     QemuMutex mutex;
+    bool running;
     bool quit;
 };
 typedef struct MultiFDRecvParams MultiFDRecvParams;
@@ -561,7 +570,7 @@ struct {
     int count;
 } *multifd_recv_state;
=20
-static void terminate_multifd_recv_threads(Error *err)
+static void multifd_recv_terminate_threads(Error *err)
 {
     int i;
=20
@@ -575,7 +584,7 @@ static void terminate_multifd_recv_threads(Error *err=
)
         }
     }
=20
-    for (i =3D 0; i < multifd_recv_state->count; i++) {
+    for (i =3D 0; i < migrate_multifd_channels(); i++) {
         MultiFDRecvParams *p =3D &multifd_recv_state->params[i];
=20
         qemu_mutex_lock(&p->mutex);
@@ -593,11 +602,13 @@ int multifd_load_cleanup(Error **errp)
     if (!migrate_use_multifd()) {
         return 0;
     }
-    terminate_multifd_recv_threads(NULL);
-    for (i =3D 0; i < multifd_recv_state->count; i++) {
+    multifd_recv_terminate_threads(NULL);
+    for (i =3D 0; i < migrate_multifd_channels(); i++) {
         MultiFDRecvParams *p =3D &multifd_recv_state->params[i];
=20
-        qemu_thread_join(&p->thread);
+        if (p->running) {
+            qemu_thread_join(&p->thread);
+        }
         qemu_mutex_destroy(&p->mutex);
         qemu_sem_destroy(&p->sem);
         g_free(p->name);
@@ -625,6 +636,10 @@ static void *multifd_recv_thread(void *opaque)
         qemu_sem_wait(&p->sem);
     }
=20
+    qemu_mutex_lock(&p->mutex);
+    p->running =3D false;
+    qemu_mutex_unlock(&p->mutex);
+
     return NULL;
 }
=20
@@ -639,7 +654,7 @@ int multifd_load_setup(void)
     thread_count =3D migrate_multifd_channels();
     multifd_recv_state =3D g_malloc0(sizeof(*multifd_recv_state));
     multifd_recv_state->params =3D g_new0(MultiFDRecvParams, thread_coun=
t);
-    multifd_recv_state->count =3D 0;
+    atomic_set(&multifd_recv_state->count, 0);
     for (i =3D 0; i < thread_count; i++) {
         MultiFDRecvParams *p =3D &multifd_recv_state->params[i];
=20
@@ -648,9 +663,10 @@ int multifd_load_setup(void)
         p->quit =3D false;
         p->id =3D i;
         p->name =3D g_strdup_printf("multifdrecv_%d", i);
+        p->running =3D true;
         qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
                            QEMU_THREAD_JOINABLE);
-        multifd_recv_state->count++;
+        atomic_inc(&multifd_recv_state->count);
     }
     return 0;
 }
--=20
2.17.0
