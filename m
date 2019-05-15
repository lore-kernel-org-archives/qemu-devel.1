Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6EBC04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 12:23:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E63E420578
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 12:23:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E63E420578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36419 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQsw2-0005Tq-6S
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 08:23:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1hQsq3-0000Ty-Kf
	for qemu-devel@nongnu.org; Wed, 15 May 2019 08:16:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1hQsq2-0002r1-Af
	for qemu-devel@nongnu.org; Wed, 15 May 2019 08:16:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hQsq2-0002q2-3A
	for qemu-devel@nongnu.org; Wed, 15 May 2019 08:16:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 67E568535D
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 12:16:49 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-37.ams2.redhat.com
	[10.36.116.37])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 828285C1A3;
	Wed, 15 May 2019 12:16:47 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 15 May 2019 14:15:43 +0200
Message-Id: <20190515121544.4597-8-quintela@redhat.com>
In-Reply-To: <20190515121544.4597-1-quintela@redhat.com>
References: <20190515121544.4597-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Wed, 15 May 2019 12:16:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 7/8] multifd: Add zlib compression support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Juan Quintela <quintela@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/core/qdev-properties.c |  2 +-
 migration/migration.c     |  9 ++++++++
 migration/migration.h     |  1 +
 migration/ram.c           | 47 +++++++++++++++++++++++++++++++++++++++
 qapi/migration.json       |  2 +-
 tests/migration-test.c    |  6 +++++
 6 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index ebeeb5c88d..e40aa806e2 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -651,7 +651,7 @@ const PropertyInfo qdev_prop_fdc_drive_type =3D {
 const PropertyInfo qdev_prop_multifd_compress =3D {
     .name =3D "MultifdCompress",
     .description =3D "multifd_compress values, "
-                   "none",
+                   "none/zlib",
     .enum_table =3D &MultifdCompress_lookup,
     .get =3D get_enum,
     .set =3D set_enum,
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
index 6679e4f213..fdb5bf07a5 100644
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
 typedef struct {
@@ -1071,6 +1084,9 @@ void multifd_save_cleanup(void)
         p->packet_len =3D 0;
         g_free(p->packet);
         p->packet =3D NULL;
+        deflateEnd(&p->zs);
+        g_free(p->zbuff);
+        p->zbuff =3D NULL;
     }
     qemu_sem_destroy(&multifd_send_state->channels_ready);
     qemu_sem_destroy(&multifd_send_state->sem_sync);
@@ -1240,6 +1256,7 @@ int multifd_save_setup(void)
=20
     for (i =3D 0; i < thread_count; i++) {
         MultiFDSendParams *p =3D &multifd_send_state->params[i];
+        z_stream *zs =3D &p->zs;
=20
         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem, 0);
@@ -1253,6 +1270,17 @@ int multifd_save_setup(void)
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
@@ -1322,6 +1350,9 @@ int multifd_load_cleanup(Error **errp)
         p->packet_len =3D 0;
         g_free(p->packet);
         p->packet =3D NULL;
+        inflateEnd(&p->zs);
+        g_free(p->zbuff);
+        p->zbuff =3D NULL;
     }
     qemu_sem_destroy(&multifd_recv_state->sem_sync);
     g_free(multifd_recv_state->params);
@@ -1440,6 +1471,7 @@ int multifd_load_setup(void)
=20
     for (i =3D 0; i < thread_count; i++) {
         MultiFDRecvParams *p =3D &multifd_recv_state->params[i];
+        z_stream *zs =3D &p->zs;
=20
         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem_sync, 0);
@@ -1449,6 +1481,21 @@ int multifd_load_setup(void)
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
diff --git a/qapi/migration.json b/qapi/migration.json
index 8ec1944b7a..e6c27fae06 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -493,7 +493,7 @@
 #
 ##
 { 'enum': 'MultifdCompress',
-  'data': [ 'none' ] }
+  'data': [ 'none', 'zlib' ] }
=20
 ##
 # @MigrationParameter:
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
2.21.0


