Received: from eggs.gnu.org ([209.51.188.92]:59825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1hBeZ8-0005NV-JL
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:00:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1hBeZ7-0006Hy-2J
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:00:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hBeZ6-0006Gr-N2
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:00:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5F916307CDEA
	for <qemu-devel@nongnu.org>; Wed,  3 Apr 2019 11:51:45 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  3 Apr 2019 13:49:57 +0200
Message-Id: <20190403114958.3705-8-quintela@redhat.com>
In-Reply-To: <20190403114958.3705-1-quintela@redhat.com>
References: <20190403114958.3705-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 7/8] multifd: Add zlib compression support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c  |  9 ++++++++
 migration/migration.h  |  1 +
 migration/ram.c        | 47 ++++++++++++++++++++++++++++++++++++++++++
 qapi/common.json       |  4 +++-
 tests/migration-test.c |  6 ++++++
 5 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index d6f8ef342a..69d85cbe5e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2141,6 +2141,15 @@ bool migrate_use_multifd(void)
     return s->enabled_capabilities[MIGRATION_CAPABILITY_MULTIFD];
 }
=20
+bool migrate_use_multifd_zlib(void)
+{
+    MigrationState *s;
+
+    s =3D migrate_get_current();
+
+    return s->parameters.multifd_compress =3D=3D MULTIFD_COMPRESS_ZLIB;
+}
+
 bool migrate_pause_before_switchover(void)
 {
     MigrationState *s;
diff --git a/migration/migration.h b/migration/migration.h
index 438f17edad..fc4fb841d4 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -269,6 +269,7 @@ bool migrate_ignore_shared(void);
=20
 bool migrate_auto_converge(void);
 bool migrate_use_multifd(void);
+bool migrate_use_multifd_zlib(void);
 bool migrate_pause_before_switchover(void);
 int migrate_multifd_channels(void);
=20
diff --git a/migration/ram.c b/migration/ram.c
index d7f8fe45a8..06b25ac66d 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -582,6 +582,7 @@ exit:
 #define MULTIFD_VERSION 1
=20
 #define MULTIFD_FLAG_SYNC (1 << 0)
+#define MULTIFD_FLAG_ZLIB (1 << 1)
=20
 /* This value needs to be a multiple of qemu_target_page_size() */
 #define MULTIFD_PACKET_SIZE (512 * 1024)
@@ -663,6 +664,12 @@ typedef struct {
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
@@ -698,6 +705,12 @@ typedef struct {
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
@@ -1035,6 +1048,9 @@ void multifd_save_cleanup(void)
         p->packet_len =3D 0;
         g_free(p->packet);
         p->packet =3D NULL;
+        deflateEnd(&p->zs);
+        g_free(p->zbuff);
+        p->zbuff =3D NULL;
     }
     qemu_sem_destroy(&multifd_send_state->channels_ready);
     qemu_sem_destroy(&multifd_send_state->sem_sync);
@@ -1198,6 +1214,7 @@ int multifd_save_setup(void)
=20
     for (i =3D 0; i < thread_count; i++) {
         MultiFDSendParams *p =3D &multifd_send_state->params[i];
+        z_stream *zs =3D &p->zs;
=20
         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem, 0);
@@ -1211,6 +1228,17 @@ int multifd_save_setup(void)
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
@@ -1278,6 +1306,9 @@ int multifd_load_cleanup(Error **errp)
         p->packet_len =3D 0;
         g_free(p->packet);
         p->packet =3D NULL;
+        inflateEnd(&p->zs);
+        g_free(p->zbuff);
+        p->zbuff =3D NULL;
     }
     qemu_sem_destroy(&multifd_recv_state->sem_sync);
     g_free(multifd_recv_state->params);
@@ -1396,6 +1427,7 @@ int multifd_load_setup(void)
=20
     for (i =3D 0; i < thread_count; i++) {
         MultiFDRecvParams *p =3D &multifd_recv_state->params[i];
+        z_stream *zs =3D &p->zs;
=20
         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem_sync, 0);
@@ -1405,6 +1437,21 @@ int multifd_load_setup(void)
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
diff --git a/qapi/common.json b/qapi/common.json
index 7248172792..89df6854cb 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -201,8 +201,10 @@
 #
 # @none: no compression.
 #
+# @zlib: Compress using zlib.
+#
 # Since: 4.1
 #
 ##
 { 'enum': 'MultifdCompress',
-  'data': [ 'none' ] }
+  'data': [ 'none', 'zlib' ] }
diff --git a/tests/migration-test.c b/tests/migration-test.c
index 8a1ccc2516..2dd4d4c5b4 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -1119,6 +1119,11 @@ static void test_multifd_tcp_none(void)
     test_multifd_tcp("none");
 }
=20
+static void test_multifd_tcp_zlib(void)
+{
+    test_multifd_tcp("zlib");
+}
+
 int main(int argc, char **argv)
 {
     char template[] =3D "/tmp/migration-test-XXXXXX";
@@ -1174,6 +1179,7 @@ int main(int argc, char **argv)
     /* qtest_add_func("/migration/ignore_shared", test_ignore_shared); *=
/
     qtest_add_func("/migration/xbzrle/unix", test_xbzrle_unix);
     qtest_add_func("/migration/multifd/tcp/none", test_multifd_tcp_none)=
;
+    qtest_add_func("/migration/multifd/tcp/zlib", test_multifd_tcp_zlib)=
;
=20
     ret =3D g_test_run();
=20
--=20
2.20.1
