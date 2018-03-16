Received: from eggs.gnu.org ([2001:4830:134:3::10]:59127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ewnwH-0006fA-Ie
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:54:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ewnwG-0002cV-G8
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:54:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37984 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ewnwG-0002bn-Bu
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:54:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DACA08151D47
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 11:54:23 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 16 Mar 2018 12:53:57 +0100
Message-Id: <20180316115403.4148-10-quintela@redhat.com>
In-Reply-To: <20180316115403.4148-1-quintela@redhat.com>
References: <20180316115403.4148-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v11 09/15] migration: Add multifd traces for
 start/end thread
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 migration/ram.c        | 6 ++++++
 migration/trace-events | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 4ba03cf9c9..7d9e363bbe 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -505,6 +505,8 @@ static void *multifd_send_thread(void *opaque)
 {
     MultiFDSendParams *p =3D opaque;
=20
+    trace_multifd_send_thread_start(p->id);
+
     while (true) {
         qemu_sem_wait(&p->sem);
         qemu_mutex_lock(&p->mutex);
@@ -521,6 +523,7 @@ static void *multifd_send_thread(void *opaque)
         }
         qemu_mutex_unlock(&p->mutex);
     }
+    trace_multifd_send_thread_end(p->id);
=20
     return NULL;
 }
@@ -668,6 +671,8 @@ static void *multifd_recv_thread(void *opaque)
 {
     MultiFDRecvParams *p =3D opaque;
=20
+    trace_multifd_recv_thread_start(p->id);
+
     while (true) {
         qemu_sem_wait(&p->sem);
         qemu_mutex_lock(&p->mutex);
@@ -685,6 +690,7 @@ static void *multifd_recv_thread(void *opaque)
         qemu_mutex_unlock(&p->mutex);
     }
=20
+    trace_multifd_recv_thread_end(p->id);
     return NULL;
 }
=20
diff --git a/migration/trace-events b/migration/trace-events
index 551d325daf..9c92d3ec14 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -83,6 +83,10 @@ multifd_send_sync_wait(uint8_t id, bool quit, bool run=
ning) "channel %d quit %d
 multifd_recv_sync_main(void) ""
 multifd_recv_sync_signal(uint8_t id, bool quit, bool running) "channel %=
d quit %d running %d"
 multifd_recv_sync_wait(uint8_t id, bool quit, bool running) "channel %d =
quit %d running %d"
+multifd_send_thread_start(uint8_t id) "%d"
+multifd_send_thread_end(uint8_t id) "%d"
+multifd_recv_thread_start(uint8_t id) "%d"
+multifd_recv_thread_end(uint8_t id) "%d"
=20
 # migration/migration.c
 await_return_path_close_on_source_close(void) ""
--=20
2.14.3
