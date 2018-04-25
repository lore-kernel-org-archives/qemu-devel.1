Received: from eggs.gnu.org ([2001:4830:134:3::10]:34164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fBIaI-0002nB-NH
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:27:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fBIaH-0004xW-Fy
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:27:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33580 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fBIaH-0004wc-At
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:27:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E8983EC013
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 11:27:36 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 25 Apr 2018 13:27:10 +0200
Message-Id: <20180425112723.1111-9-quintela@redhat.com>
In-Reply-To: <20180425112723.1111-1-quintela@redhat.com>
References: <20180425112723.1111-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v12 08/21] migration: Transmit initial package
 through the multifd channels
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

--

Be network agnostic.
Add error checking for all values.
---
 migration/ram.c | 101 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 96 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 5a87d74862..1aab392d8f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -52,6 +52,8 @@
 #include "qemu/rcu_queue.h"
 #include "migration/colo.h"
 #include "migration/block.h"
+#include "sysemu/sysemu.h"
+#include "qemu/uuid.h"
=20
 /***********************************************************/
 /* ram save/restore */
@@ -400,6 +402,16 @@ static void compress_threads_save_setup(void)
=20
 /* Multiple fd's */
=20
+#define MULTIFD_MAGIC 0x11223344U
+#define MULTIFD_VERSION 1
+
+typedef struct {
+    uint32_t magic;
+    uint32_t version;
+    unsigned char uuid[16]; /* QemuUUID */
+    uint8_t id;
+} __attribute__((packed)) MultiFDInit_t;
+
 struct MultiFDSendParams {
     uint8_t id;
     char *name;
@@ -412,6 +424,65 @@ struct MultiFDSendParams {
 };
 typedef struct MultiFDSendParams MultiFDSendParams;
=20
+static int multifd_send_initial_packet(MultiFDSendParams *p, Error **err=
p)
+{
+    MultiFDInit_t msg;
+    int ret;
+
+    msg.magic =3D cpu_to_be32(MULTIFD_MAGIC);
+    msg.version =3D cpu_to_be32(MULTIFD_VERSION);
+    msg.id =3D p->id;
+    memcpy(msg.uuid, &qemu_uuid.data, sizeof(msg.uuid));
+
+    ret =3D qio_channel_write_all(p->c, (char *)&msg, sizeof(msg), errp)=
;
+    if (ret !=3D 0) {
+        return -1;
+    }
+    return 0;
+}
+
+static int multifd_recv_initial_packet(QIOChannel *c, Error **errp)
+{
+    MultiFDInit_t msg;
+    int ret;
+
+    ret =3D qio_channel_read_all(c, (char *)&msg, sizeof(msg), errp);
+    if (ret !=3D 0) {
+        return -1;
+    }
+
+    be32_to_cpus(&msg.magic);
+    be32_to_cpus(&msg.version);
+
+    if (msg.magic !=3D MULTIFD_MAGIC) {
+        error_setg(errp, "multifd: received packet magic %d "
+                   "expected %d", msg.magic, MULTIFD_MAGIC);
+        return -1;
+    }
+
+    if (msg.version !=3D MULTIFD_VERSION) {
+        error_setg(errp, "multifd: received packet version %d "
+                   "expected %d", msg.version, MULTIFD_VERSION);
+        return -1;
+    }
+
+    if (memcmp(msg.uuid, &qemu_uuid, sizeof(qemu_uuid))) {
+        char *uuid =3D qemu_uuid_unparse_strdup(&qemu_uuid);
+        error_setg(errp, "multifd: received uuid '%s' and expected "
+                   "uuid '%s' for channel %hhd", msg.uuid, uuid, msg.id)=
;
+        g_free(uuid);
+        return -1;
+    }
+
+    if (msg.id > migrate_multifd_channels()) {
+        error_setg(errp, "multifd: received channel version %d "
+                   "expected %d", msg.version, MULTIFD_VERSION);
+        return -1;
+    }
+
+    return msg.id;
+}
+
 struct {
     MultiFDSendParams *params;
     /* number of created threads */
@@ -474,6 +545,11 @@ int multifd_save_cleanup(Error **errp)
 static void *multifd_send_thread(void *opaque)
 {
     MultiFDSendParams *p =3D opaque;
+    Error *local_err =3D NULL;
+
+    if (multifd_send_initial_packet(p, &local_err) < 0) {
+        goto out;
+    }
=20
     while (true) {
         qemu_mutex_lock(&p->mutex);
@@ -485,6 +561,11 @@ static void *multifd_send_thread(void *opaque)
         qemu_sem_wait(&p->sem);
     }
=20
+out:
+    if (local_err) {
+        multifd_send_terminate_threads(local_err);
+    }
+
     qemu_mutex_lock(&p->mutex);
     p->running =3D false;
     qemu_mutex_unlock(&p->mutex);
@@ -669,12 +750,22 @@ bool multifd_recv_all_channels_created(void)
 void multifd_recv_new_channel(QIOChannel *ioc)
 {
     MultiFDRecvParams *p;
-    /* we need to invent channels id's until we transmit */
-    /* we will remove this on a later patch */
-    static int i;
+    Error *local_err =3D NULL;
+    int id;
=20
-    p =3D &multifd_recv_state->params[i];
-    i++;
+    id =3D multifd_recv_initial_packet(ioc, &local_err);
+    if (id < 0) {
+        multifd_recv_terminate_threads(local_err);
+        return;
+    }
+
+    p =3D &multifd_recv_state->params[id];
+    if (p->c !=3D NULL) {
+        error_setg(&local_err, "multifd: received id '%d' already setup'=
",
+                   id);
+        multifd_recv_terminate_threads(local_err);
+        return;
+    }
     p->c =3D ioc;
     object_ref(OBJECT(ioc));
=20
--=20
2.17.0
