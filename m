Received: from eggs.gnu.org ([2001:4830:134:3::10]:52495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dAGd3-0004Ru-Re
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:05:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dAGcz-0002pm-Qa
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:05:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dAGcz-0002pS-Ha
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:05:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 831593DBD7
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 14:05:36 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 15 May 2017 15:05:29 +0100
Message-Id: <20170515140529.23264-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v2] block migration: Allow compile time disable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, kashyap@redhat.com, eblake@redhat.com, jcody@redhat.com, kwolf@redhat.com

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
 configure                 | 11 +++++++++++
 include/migration/block.h | 23 +++++++++++++++++++++++
 migration/Makefile.objs   |  2 +-
 migration/migration.c     |  9 +++++++++
 4 files changed, 44 insertions(+), 1 deletion(-)

v2
  use error_append_hint, remove a '.' - Eric
  Move ifdef's to block.h header - Juan
  Explicitly state the blk/-b inc/-i in the message - Kashyap

diff --git a/configure b/configure
index 39e727ef7e..29f5f626d7 100755
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
@@ -5215,6 +5221,7 @@ echo "TPM support       $tpm"
 echo "libssh2 support   $libssh2"
 echo "TPM passthrough   $tpm_passthrough"
 echo "QOM debugging     $qom_cast_debug"
+echo "Live block migration $live_block_migration"
 echo "lzo support       $lzo"
 echo "snappy support    $snappy"
 echo "bzip2 support     $bzip2"
@@ -5781,6 +5788,10 @@ if test "$libssh2" = "yes" ; then
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
index 41a1ac8f79..1a096e3978 100644
--- a/include/migration/block.h
+++ b/include/migration/block.h
@@ -14,10 +14,33 @@
 #ifndef MIGRATION_BLOCK_H
 #define MIGRATION_BLOCK_H
 
+#ifdef CONFIG_LIVE_BLOCK_MIGRATION
 void blk_mig_init(void);
 int blk_mig_active(void);
 uint64_t blk_mig_bytes_transferred(void);
 uint64_t blk_mig_bytes_remaining(void);
 uint64_t blk_mig_bytes_total(void);
 
+#else
+static inline void blk_mig_init(void) { };
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
 #endif /* MIGRATION_BLOCK_H */
diff --git a/migration/Makefile.objs b/migration/Makefile.objs
index 480dd493a9..200b5e0c67 100644
--- a/migration/Makefile.objs
+++ b/migration/Makefile.objs
@@ -9,5 +9,5 @@ common-obj-y += qjson.o
 
 common-obj-$(CONFIG_RDMA) += rdma.o
 
-common-obj-y += block.o
+common-obj-$(CONFIG_LIVE_BLOCK_MIGRATION) += block.o
 
diff --git a/migration/migration.c b/migration/migration.c
index a5ade23e24..457f0b92df 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1213,6 +1213,15 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     params.blk = has_blk && blk;
     params.shared = has_inc && inc;
 
+#ifndef CONFIG_LIVE_BLOCK_MIGRATION
+    if (params.blk || params.shared) {
+        error_setg(errp, "QEMU compiled without old-style (blk/-b, inc/-i) "
+                         "block migration");
+        error_append_hint(errp, "Use drive_mirror+NBD instead.\n");
+        return;
+    }
+#endif
+
     if (migration_is_setup_or_active(s->state) ||
         s->state == MIGRATION_STATUS_CANCELLING ||
         s->state == MIGRATION_STATUS_COLO) {
-- 
2.13.0
