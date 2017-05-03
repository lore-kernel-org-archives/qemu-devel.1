Received: from eggs.gnu.org ([2001:4830:134:3::10]:58129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d5rkS-0000do-Na
	for qemu-devel@nongnu.org; Wed, 03 May 2017 06:43:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d5rkN-0001PG-QX
	for qemu-devel@nongnu.org; Wed, 03 May 2017 06:43:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d5rkN-0001Ol-GD
	for qemu-devel@nongnu.org; Wed, 03 May 2017 06:43:03 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9DD873B717
	for <qemu-devel@nongnu.org>; Wed,  3 May 2017 10:43:01 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed,  3 May 2017 11:42:57 +0100
Message-Id: <20170503104257.5127-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH] block migration: Allow compile time disable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, jcody@redhat.com, kwolf@redhat.com
Cc: kashyap@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Many users now prefer to use drive_mirror over NBD as an
alternative to the older migrate -b option; drive_mirror is
more complex to setup but gives you more options (e.g. only
migrating some of the disks if some of them are shared).

Allow the large chunk of block migration code to be compiled
out for those who don't use it.

Based on a downstream-patch we've had for a while by Jeff Cody.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 configure               | 11 +++++++++++
 migration/Makefile.objs |  2 +-
 migration/migration.c   | 12 ++++++++++++
 vl.c                    |  2 ++
 4 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 48a9370cc6..69eed5fb8d 100755
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
@@ -1168,6 +1169,10 @@ for opt do
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
@@ -1400,6 +1405,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   libnfs          nfs support
   smartcard       smartcard support (libcacard)
   libusb          libusb (for usb passthrough)
+  live-block-migration   Block migration in the main migration stream
   usb-redir       usb network redirection support
   lzo             support of lzo compression library
   snappy          support of snappy compression library
@@ -5210,6 +5216,7 @@ echo "TPM support       $tpm"
 echo "libssh2 support   $libssh2"
 echo "TPM passthrough   $tpm_passthrough"
 echo "QOM debugging     $qom_cast_debug"
+echo "Live block migration $live_block_migration"
 echo "lzo support       $lzo"
 echo "snappy support    $snappy"
 echo "bzip2 support     $bzip2"
@@ -5776,6 +5783,10 @@ if test "$libssh2" = "yes" ; then
   echo "LIBSSH2_LIBS=$libssh2_libs" >> $config_host_mak
 fi
 
+if test "$live_block_migration" = "yes" ; then
+  echo "CONFIG_LIVE_BLOCK_MIGRATION=y" >> $config_host_mak
+fi
+
 # USB host support
 if test "$libusb" = "yes"; then
   echo "HOST_USB=libusb legacy" >> $config_host_mak
diff --git a/migration/Makefile.objs b/migration/Makefile.objs
index 480dd493a9..200b5e0c67 100644
--- a/migration/Makefile.objs
+++ b/migration/Makefile.objs
@@ -9,5 +9,5 @@ common-obj-y += qjson.o
 
 common-obj-$(CONFIG_RDMA) += rdma.o
 
-common-obj-y += block.o
+common-obj-$(CONFIG_LIVE_BLOCK_MIGRATION) += block.o
 
diff --git a/migration/migration.c b/migration/migration.c
index 353f2728cf..ffce72aabc 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -692,6 +692,7 @@ MigrationInfo *qmp_query_migrate(Error **errp)
 
         populate_ram_info(info, s);
 
+#ifdef CONFIG_LIVE_BLOCK_MIGRATION
         if (blk_mig_active()) {
             info->has_disk = true;
             info->disk = g_malloc0(sizeof(*info->disk));
@@ -699,6 +700,7 @@ MigrationInfo *qmp_query_migrate(Error **errp)
             info->disk->remaining = blk_mig_bytes_remaining();
             info->disk->total = blk_mig_bytes_total();
         }
+#endif
 
         if (cpu_throttle_active()) {
             info->has_cpu_throttle_percentage = true;
@@ -720,6 +722,7 @@ MigrationInfo *qmp_query_migrate(Error **errp)
 
         populate_ram_info(info, s);
 
+#ifdef CONFIG_LIVE_BLOCK_MIGRATION
         if (blk_mig_active()) {
             info->has_disk = true;
             info->disk = g_malloc0(sizeof(*info->disk));
@@ -727,6 +730,7 @@ MigrationInfo *qmp_query_migrate(Error **errp)
             info->disk->remaining = blk_mig_bytes_remaining();
             info->disk->total = blk_mig_bytes_total();
         }
+#endif
 
         get_xbzrle_cache_stats(info);
         break;
@@ -1222,6 +1226,14 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     params.blk = has_blk && blk;
     params.shared = has_inc && inc;
 
+#ifndef CONFIG_LIVE_BLOCK_MIGRATION
+    if (params.blk || params.shared) {
+        error_setg(errp, "QEMU compiled without old-style block migration. "
+                         "Use drive_mirror+NBD.");
+        return;
+    }
+#endif
+
     if (migration_is_setup_or_active(s->state) ||
         s->state == MIGRATION_STATUS_CANCELLING ||
         s->state == MIGRATION_STATUS_COLO) {
diff --git a/vl.c b/vl.c
index f46e070e0d..d0fc99a41d 100644
--- a/vl.c
+++ b/vl.c
@@ -4471,7 +4471,9 @@ int main(int argc, char **argv, char **envp)
         }
     }
 
+#ifdef CONFIG_LIVE_BLOCK_MIGRATION
     blk_mig_init();
+#endif
     ram_mig_init();
 
     /* If the currently selected machine wishes to override the units-per-bus
-- 
2.12.2
