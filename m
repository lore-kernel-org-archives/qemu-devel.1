Received: from eggs.gnu.org ([2001:4830:134:3::10]:38582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dB122-0000tE-Na
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:38:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dB11x-0004vU-Mq
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:38:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dB11x-0004un-DU
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:38:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5C282C057FA4
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 15:38:28 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 17 May 2017 17:38:12 +0200
Message-Id: <20170517153812.21993-6-quintela@redhat.com>
In-Reply-To: <20170517153812.21993-1-quintela@redhat.com>
References: <20170517153812.21993-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 5/5] block migration: Allow compile time disable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, eblake@redhat.com, armbru@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Many users now prefer to use drive_mirror over NBD as an
alternative to the older migrate -b option; drive_mirror is
more complex to setup but gives you more options (e.g. only
migrating some of the disks if some of them are shared).

Allow the large chunk of block migration code to be compiled
out for those who don't use it.

Based on a downstream-patch we've had for a while by Jeff Cody.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 configure                 | 11 +++++++++++
 include/migration/block.h | 24 +++++++++++++++++++++++-
 migration/Makefile.objs   |  2 +-
 migration/migration.c     | 13 +++++++++++++
 4 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 57b5ae6..ace1a52 100755
--- a/configure
+++ b/configure
@@ -316,6 +316,7 @@ vte=""
 virglrenderer=""
 tpm="yes"
 libssh2=""
+live_block_migration="yes"
 numa=""
 tcmalloc="no"
 jemalloc="no"
@@ -1169,6 +1170,10 @@ for opt do
   ;;
   --enable-libssh2) libssh2="yes"
   ;;
+  --disable-live-block-migration) live_block_migration="no"
+  ;;
+  --enable-live-block-migration) live_block_migration="yes"
+  ;;
   --disable-numa) numa="no"
   ;;
   --enable-numa) numa="yes"
@@ -1401,6 +1406,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   libnfs          nfs support
   smartcard       smartcard support (libcacard)
   libusb          libusb (for usb passthrough)
+  live-block-migration   Block migration in the main migration stream
   usb-redir       usb network redirection support
   lzo             support of lzo compression library
   snappy          support of snappy compression library
@@ -5216,6 +5222,7 @@ echo "TPM support       $tpm"
 echo "libssh2 support   $libssh2"
 echo "TPM passthrough   $tpm_passthrough"
 echo "QOM debugging     $qom_cast_debug"
+echo "Live block migration $live_block_migration"
 echo "lzo support       $lzo"
 echo "snappy support    $snappy"
 echo "bzip2 support     $bzip2"
@@ -5782,6 +5789,10 @@ if test "$libssh2" = "yes" ; then
   echo "LIBSSH2_LIBS=$libssh2_libs" >> $config_host_mak
 fi
 
+if test "$live_block_migration" = "yes" ; then
+  echo "CONFIG_LIVE_BLOCK_MIGRATION=y" >> $config_host_mak
+fi
+
 # USB host support
 if test "$libusb" = "yes"; then
   echo "HOST_USB=libusb legacy" >> $config_host_mak
diff --git a/include/migration/block.h b/include/migration/block.h
index 5225af9..28cff53 100644
--- a/include/migration/block.h
+++ b/include/migration/block.h
@@ -14,12 +14,34 @@
 #ifndef MIGRATION_BLOCK_H
 #define MIGRATION_BLOCK_H
 
+#ifdef CONFIG_LIVE_BLOCK_MIGRATION
 void blk_mig_init(void);
 int blk_mig_active(void);
 uint64_t blk_mig_bytes_transferred(void);
 uint64_t blk_mig_bytes_remaining(void);
 uint64_t blk_mig_bytes_total(void);
 
+#else
+static inline void blk_mig_init(void) { }
+static inline int blk_mig_active(void)
+{
+    return false;
+}
+static inline uint64_t blk_mig_bytes_transferred(void)
+{
+    return 0;
+}
+
+static inline uint64_t blk_mig_bytes_remaining(void)
+{
+    return 0;
+}
+
+static inline uint64_t blk_mig_bytes_total(void)
+{
+    return 0;
+}
+#endif /* CONFIG_LIVE_BLOCK_MIGRATION */
+
 void migrate_set_block_enabled(bool value, Error **errp);
-
 #endif /* MIGRATION_BLOCK_H */
diff --git a/migration/Makefile.objs b/migration/Makefile.objs
index c1920b6..00a3f4a 100644
--- a/migration/Makefile.objs
+++ b/migration/Makefile.objs
@@ -9,5 +9,5 @@ common-obj-y += qjson.o
 
 common-obj-$(CONFIG_RDMA) += rdma.o
 
-common-obj-y += block.o
+common-obj-$(CONFIG_LIVE_BLOCK_MIGRATION) += block.o
 
diff --git a/migration/migration.c b/migration/migration.c
index 168b648..d5ebcd2 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -547,6 +547,11 @@ MigrationCapabilityStatusList *qmp_query_migrate_capabilities(Error **errp)
 
     caps = NULL; /* silence compiler warning */
     for (i = 0; i < MIGRATION_CAPABILITY__MAX; i++) {
+#ifndef CONFIG_LIVE_BLOCK_MIGRATION
+        if (i == MIGRATION_CAPABILITY_BLOCK) {
+            continue;
+        }
+#endif
         if (i == MIGRATION_CAPABILITY_X_COLO && !colo_supported()) {
             continue;
         }
@@ -763,6 +768,14 @@ void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
     }
 
     for (cap = params; cap; cap = cap->next) {
+#ifndef CONFIG_LIVE_BLOCK_MIGRATION
+        if (cap->value->capability == MIGRATION_CAPABILITY_BLOCK) {
+            error_setg(errp, "QEMU compiled without old-style (blk/-b, inc/-i) "
+                       "block migration");
+            error_append_hint(errp, "Use drive_mirror+NBD instead.\n");
+            continue;
+        }
+#endif
         if (cap->value->capability == MIGRATION_CAPABILITY_X_COLO) {
             if (!colo_supported()) {
                 error_setg(errp, "COLO is not currently supported, please"
-- 
2.9.3
