Received: from eggs.gnu.org ([209.51.188.92]:60529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gwU7v-0004CW-WF
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:49:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gwU7u-0005Xn-QT
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:49:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1gwU7s-0005TX-I0
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:49:38 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3805889C40
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 12:58:44 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 20 Feb 2019 13:57:54 +0100
Message-Id: <20190220125755.3906-3-quintela@redhat.com>
In-Reply-To: <20190220125755.3906-1-quintela@redhat.com>
References: <20190220125755.3906-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/3] multifd: compression support variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index d57db00ce4..7de27e1a35 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -597,6 +597,12 @@ typedef struct {
     uint64_t num_pages;
     /* syncs main thread and channels */
     QemuSemaphore sem_sync;
+    /* stream for compression */
+    z_stream zs;
+    /* compressed buffer */
+    uint8_t *zbuff;
+    /* size of compressed buffer */
+    uint32_t zbuff_len;
 }  MultiFDSendParams;
=20
 typedef struct {
@@ -632,6 +638,12 @@ typedef struct {
     uint64_t num_pages;
     /* syncs main thread and channels */
     QemuSemaphore sem_sync;
+    /* stream for compression */
+    z_stream zs;
+    /* compressed buffer */
+    uint8_t *zbuff;
+    /* size of compressed buffer */
+    uint32_t zbuff_len;
 } MultiFDRecvParams;
=20
 static int multifd_send_initial_packet(MultiFDSendParams *p, Error **err=
p)
@@ -969,6 +981,9 @@ void multifd_save_cleanup(void)
         p->packet_len =3D 0;
         g_free(p->packet);
         p->packet =3D NULL;
+        deflateEnd(&p->zs);
+        g_free(p->zbuff);
+        p->zbuff =3D NULL;
     }
     qemu_sem_destroy(&multifd_send_state->channels_ready);
     qemu_sem_destroy(&multifd_send_state->sem_sync);
@@ -1132,6 +1147,7 @@ int multifd_save_setup(void)
=20
     for (i =3D 0; i < thread_count; i++) {
         MultiFDSendParams *p =3D &multifd_send_state->params[i];
+        z_stream *zs =3D &p->zs;
=20
         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem, 0);
@@ -1145,6 +1161,17 @@ int multifd_save_setup(void)
         p->packet =3D g_malloc0(p->packet_len);
         p->name =3D g_strdup_printf("multifdsend_%d", i);
         socket_send_channel_create(multifd_new_send_channel_async, p);
+        zs->zalloc =3D Z_NULL;
+        zs->zfree =3D Z_NULL;
+        zs->opaque =3D Z_NULL;
+        if (deflateInit(zs, migrate_compress_level()) !=3D Z_OK) {
+            printf("deflate init failed\n");
+            return -1;
+        }
+        /* We will never have more than page_count pages */
+        p->zbuff_len =3D page_count * qemu_target_page_size();
+        p->zbuff_len *=3D 2;
+        p->zbuff =3D g_malloc0(p->zbuff_len);
     }
     return 0;
 }
@@ -1212,6 +1239,9 @@ int multifd_load_cleanup(Error **errp)
         p->packet_len =3D 0;
         g_free(p->packet);
         p->packet =3D NULL;
+        inflateEnd(&p->zs);
+        g_free(p->zbuff);
+        p->zbuff =3D NULL;
     }
     qemu_sem_destroy(&multifd_recv_state->sem_sync);
     g_free(multifd_recv_state->params);
@@ -1330,6 +1360,7 @@ int multifd_load_setup(void)
=20
     for (i =3D 0; i < thread_count; i++) {
         MultiFDRecvParams *p =3D &multifd_recv_state->params[i];
+        z_stream *zs =3D &p->zs;
=20
         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem_sync, 0);
@@ -1339,6 +1370,21 @@ int multifd_load_setup(void)
                       + sizeof(ram_addr_t) * page_count;
         p->packet =3D g_malloc0(p->packet_len);
         p->name =3D g_strdup_printf("multifdrecv_%d", i);
+
+        zs->zalloc =3D Z_NULL;
+        zs->zfree =3D Z_NULL;
+        zs->opaque =3D Z_NULL;
+        zs->avail_in =3D 0;
+        zs->next_in =3D Z_NULL;
+        if (inflateInit(zs) !=3D Z_OK) {
+            printf("inflate init failed\n");
+            return -1;
+        }
+        /* We will never have more than page_count pages */
+        p->zbuff_len =3D page_count * qemu_target_page_size();
+        /* We know compression "could" use more space */
+        p->zbuff_len *=3D 2;
+        p->zbuff =3D g_malloc0(p->zbuff_len);
     }
     return 0;
 }
--=20
2.20.1
