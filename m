Received: from eggs.gnu.org ([2001:4830:134:3::10]:52098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpvLd-0004eD-L0
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 08:56:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpvLW-00017v-Ju
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 08:56:24 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 15 Aug 2018 14:55:23 +0200
Message-Id: <20180815125537.10651-8-kwolf@redhat.com>
In-Reply-To: <20180815125537.10651-1-kwolf@redhat.com>
References: <20180815125537.10651-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 07/21] block: Remove deprecated -drive geometry
 options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

This reinstates commit a7aff6dd10b16b67e8b142d0c94c5d92c3fe88f6,
which was temporarily reverted for the 3.0 release so that libvirt gets
some extra time to update their command lines.

The -drive options cyls, heads, secs and trans were deprecated in
QEMU 2.10. It's time to remove them.

hd-geo-test tested both the old version with geometry options in -drive
and the new one with -device. Therefore the code using -drive doesn't
have to be replaced there, we just need to remove the -drive test cases.
This in turn allows some simplification of the code.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 include/sysemu/blockdev.h |  1 -
 blockdev.c                | 75 +----------------------------------------------
 hw/block/block.c          | 14 ---------
 tests/hd-geo-test.c       | 37 +++++------------------
 hmp-commands.hx           |  1 -
 qemu-deprecated.texi      |  5 ----
 qemu-options.hx           |  7 +----
 7 files changed, 9 insertions(+), 131 deletions(-)

diff --git a/include/sysemu/blockdev.h b/include/sysemu/blockdev.h
index ac22f2ae1f..37ea39719e 100644
--- a/include/sysemu/blockdev.h
+++ b/include/sysemu/blockdev.h
@@ -35,7 +35,6 @@ struct DriveInfo {
     int auto_del;               /* see blockdev_mark_auto_del() */
     bool is_default;            /* Added by default_drive() ?  */
     int media_cd;
-    int cyls, heads, secs, trans;
     QemuOpts *opts;
     char *serial;
     QTAILQ_ENTRY(DriveInfo) next;
diff --git a/blockdev.c b/blockdev.c
index dcf8c8d2ab..c23587b075 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -731,22 +731,6 @@ QemuOptsList qemu_legacy_drive_opts = {
             .type = QEMU_OPT_STRING,
             .help = "interface (ide, scsi, sd, mtd, floppy, pflash, virtio)",
         },{
-            .name = "cyls",
-            .type = QEMU_OPT_NUMBER,
-            .help = "number of cylinders (ide disk geometry)",
-        },{
-            .name = "heads",
-            .type = QEMU_OPT_NUMBER,
-            .help = "number of heads (ide disk geometry)",
-        },{
-            .name = "secs",
-            .type = QEMU_OPT_NUMBER,
-            .help = "number of sectors (ide disk geometry)",
-        },{
-            .name = "trans",
-            .type = QEMU_OPT_STRING,
-            .help = "chs translation (auto, lba, none)",
-        },{
             .name = "addr",
             .type = QEMU_OPT_STRING,
             .help = "pci address (virtio only)",
@@ -792,7 +776,6 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
     QemuOpts *legacy_opts;
     DriveMediaType media = MEDIA_DISK;
     BlockInterfaceType type;
-    int cyls, heads, secs, translation;
     int max_devs, bus_id, unit_id, index;
     const char *devaddr;
     const char *werror, *rerror;
@@ -803,7 +786,7 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
     Error *local_err = NULL;
     int i;
     const char *deprecated[] = {
-        "serial", "trans", "secs", "heads", "cyls", "addr"
+        "serial", "addr"
     };
 
     /* Change legacy command line options into QMP ones */
@@ -932,57 +915,6 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
         type = block_default_type;
     }
 
-    /* Geometry */
-    cyls  = qemu_opt_get_number(legacy_opts, "cyls", 0);
-    heads = qemu_opt_get_number(legacy_opts, "heads", 0);
-    secs  = qemu_opt_get_number(legacy_opts, "secs", 0);
-
-    if (cyls || heads || secs) {
-        if (cyls < 1) {
-            error_report("invalid physical cyls number");
-            goto fail;
-        }
-        if (heads < 1) {
-            error_report("invalid physical heads number");
-            goto fail;
-        }
-        if (secs < 1) {
-            error_report("invalid physical secs number");
-            goto fail;
-        }
-    }
-
-    translation = BIOS_ATA_TRANSLATION_AUTO;
-    value = qemu_opt_get(legacy_opts, "trans");
-    if (value != NULL) {
-        if (!cyls) {
-            error_report("'%s' trans must be used with cyls, heads and secs",
-                         value);
-            goto fail;
-        }
-        if (!strcmp(value, "none")) {
-            translation = BIOS_ATA_TRANSLATION_NONE;
-        } else if (!strcmp(value, "lba")) {
-            translation = BIOS_ATA_TRANSLATION_LBA;
-        } else if (!strcmp(value, "large")) {
-            translation = BIOS_ATA_TRANSLATION_LARGE;
-        } else if (!strcmp(value, "rechs")) {
-            translation = BIOS_ATA_TRANSLATION_RECHS;
-        } else if (!strcmp(value, "auto")) {
-            translation = BIOS_ATA_TRANSLATION_AUTO;
-        } else {
-            error_report("'%s' invalid translation type", value);
-            goto fail;
-        }
-    }
-
-    if (media == MEDIA_CDROM) {
-        if (cyls || secs || heads) {
-            error_report("CHS can't be set with media=cdrom");
-            goto fail;
-        }
-    }
-
     /* Device address specified by bus/unit or index.
      * If none was specified, try to find the first free one. */
     bus_id  = qemu_opt_get_number(legacy_opts, "bus", 0);
@@ -1105,11 +1037,6 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
     dinfo = g_malloc0(sizeof(*dinfo));
     dinfo->opts = all_opts;
 
-    dinfo->cyls = cyls;
-    dinfo->heads = heads;
-    dinfo->secs = secs;
-    dinfo->trans = translation;
-
     dinfo->type = type;
     dinfo->bus = bus_id;
     dinfo->unit = unit_id;
diff --git a/hw/block/block.c b/hw/block/block.c
index b91e2b6d7e..b6c80ab0b7 100644
--- a/hw/block/block.c
+++ b/hw/block/block.c
@@ -108,20 +108,6 @@ bool blkconf_geometry(BlockConf *conf, int *ptrans,
                       unsigned cyls_max, unsigned heads_max, unsigned secs_max,
                       Error **errp)
 {
-    DriveInfo *dinfo;
-
-    if (!conf->cyls && !conf->heads && !conf->secs) {
-        /* try to fall back to value set with legacy -drive cyls=... */
-        dinfo = blk_legacy_dinfo(conf->blk);
-        if (dinfo) {
-            conf->cyls  = dinfo->cyls;
-            conf->heads = dinfo->heads;
-            conf->secs  = dinfo->secs;
-            if (ptrans) {
-                *ptrans = dinfo->trans;
-            }
-        }
-    }
     if (!conf->cyls && !conf->heads && !conf->secs) {
         hd_geometry_guess(conf->blk,
                           &conf->cyls, &conf->heads, &conf->secs,
diff --git a/tests/hd-geo-test.c b/tests/hd-geo-test.c
index 24870b38f4..ce665f1f83 100644
--- a/tests/hd-geo-test.c
+++ b/tests/hd-geo-test.c
@@ -201,7 +201,7 @@ static void setup_mbr(int img_idx, MBRcontents mbr)
 
 static int setup_ide(int argc, char *argv[], int argv_sz,
                      int ide_idx, const char *dev, int img_idx,
-                     MBRcontents mbr, const char *opts)
+                     MBRcontents mbr)
 {
     char *s1, *s2, *s3;
 
@@ -216,7 +216,7 @@ static int setup_ide(int argc, char *argv[], int argv_sz,
         s3 = g_strdup(",media=cdrom");
     }
     argc = append_arg(argc, argv, argv_sz,
-                      g_strdup_printf("%s%s%s%s", s1, s2, s3, opts));
+                      g_strdup_printf("%s%s%s", s1, s2, s3));
     g_free(s1);
     g_free(s2);
     g_free(s3);
@@ -260,7 +260,7 @@ static void test_ide_mbr(bool use_device, MBRcontents mbr)
     for (i = 0; i < backend_last; i++) {
         cur_ide[i] = &hd_chst[i][mbr];
         dev = use_device ? (is_hd(cur_ide[i]) ? "ide-hd" : "ide-cd") : NULL;
-        argc = setup_ide(argc, argv, ARGV_SIZE, i, dev, i, mbr, "");
+        argc = setup_ide(argc, argv, ARGV_SIZE, i, dev, i, mbr);
     }
     args = g_strjoinv(" ", argv);
     qtest_start(args);
@@ -327,16 +327,12 @@ static void test_ide_drive_user(const char *dev, bool trans)
     const CHST expected_chst = { secs / (4 * 32) , 4, 32, trans };
 
     argc = setup_common(argv, ARGV_SIZE);
-    opts = g_strdup_printf("%s,%s%scyls=%d,heads=%d,secs=%d",
-                           dev ?: "",
-                           trans && dev ? "bios-chs-" : "",
-                           trans ? "trans=lba," : "",
+    opts = g_strdup_printf("%s,%scyls=%d,heads=%d,secs=%d",
+                           dev, trans ? "bios-chs-trans=lba," : "",
                            expected_chst.cyls, expected_chst.heads,
                            expected_chst.secs);
     cur_ide[0] = &expected_chst;
-    argc = setup_ide(argc, argv, ARGV_SIZE,
-                     0, dev ? opts : NULL, backend_small, mbr_chs,
-                     dev ? "" : opts);
+    argc = setup_ide(argc, argv, ARGV_SIZE, 0, opts, backend_small, mbr_chs);
     g_free(opts);
     args = g_strjoinv(" ", argv);
     qtest_start(args);
@@ -347,22 +343,6 @@ static void test_ide_drive_user(const char *dev, bool trans)
 }
 
 /*
- * Test case: IDE device (if=ide) with explicit CHS
- */
-static void test_ide_drive_user_chs(void)
-{
-    test_ide_drive_user(NULL, false);
-}
-
-/*
- * Test case: IDE device (if=ide) with explicit CHS and translation
- */
-static void test_ide_drive_user_chst(void)
-{
-    test_ide_drive_user(NULL, true);
-}
-
-/*
  * Test case: IDE device (if=none) with explicit CHS
  */
 static void test_ide_device_user_chs(void)
@@ -392,8 +372,7 @@ static void test_ide_drive_cd_0(void)
     for (i = 0; i <= backend_empty; i++) {
         ide_idx = backend_empty - i;
         cur_ide[ide_idx] = &hd_chst[i][mbr_blank];
-        argc = setup_ide(argc, argv, ARGV_SIZE,
-                         ide_idx, NULL, i, mbr_blank, "");
+        argc = setup_ide(argc, argv, ARGV_SIZE, ide_idx, NULL, i, mbr_blank);
     }
     args = g_strjoinv(" ", argv);
     qtest_start(args);
@@ -422,8 +401,6 @@ int main(int argc, char **argv)
     qtest_add_func("hd-geo/ide/drive/mbr/blank", test_ide_drive_mbr_blank);
     qtest_add_func("hd-geo/ide/drive/mbr/lba", test_ide_drive_mbr_lba);
     qtest_add_func("hd-geo/ide/drive/mbr/chs", test_ide_drive_mbr_chs);
-    qtest_add_func("hd-geo/ide/drive/user/chs", test_ide_drive_user_chs);
-    qtest_add_func("hd-geo/ide/drive/user/chst", test_ide_drive_user_chst);
     qtest_add_func("hd-geo/ide/drive/cd_0", test_ide_drive_cd_0);
     qtest_add_func("hd-geo/ide/device/mbr/blank", test_ide_device_mbr_blank);
     qtest_add_func("hd-geo/ide/device/mbr/lba", test_ide_device_mbr_lba);
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 91dfe51c37..c1fc747403 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1306,7 +1306,6 @@ ETEXI
         .params     = "[-n] [[<domain>:]<bus>:]<slot>\n"
                       "[file=file][,if=type][,bus=n]\n"
                       "[,unit=m][,media=d][,index=i]\n"
-                      "[,cyls=c,heads=h,secs=s[,trans=t]]\n"
                       "[,snapshot=on|off][,cache=on|off]\n"
                       "[,readonly=on|off][,copy-on-read=on|off]",
         .help       = "add drive to PCI storage controller",
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 9920a85adc..f90436da56 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -94,11 +94,6 @@ with ``-device ...,netdev=x''), or ``-nic user,smb=/some/dir''
 (for embedded NICs). The new syntax allows different settings to be
 provided per NIC.
 
-@subsection -drive cyls=...,heads=...,secs=...,trans=... (since 2.10.0)
-
-The drive geometry arguments are replaced by the the geometry arguments
-that can be specified with the ``-device'' parameter.
-
 @subsection -drive serial=... (since 2.10.0)
 
 The drive serial argument is replaced by the the serial argument
diff --git a/qemu-options.hx b/qemu-options.hx
index b1bf0f485f..b5155c925a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -804,9 +804,8 @@ ETEXI
 
 DEF("drive", HAS_ARG, QEMU_OPTION_drive,
     "-drive [file=file][,if=type][,bus=n][,unit=m][,media=d][,index=i]\n"
-    "       [,cyls=c,heads=h,secs=s[,trans=t]][,snapshot=on|off]\n"
     "       [,cache=writethrough|writeback|none|directsync|unsafe][,format=f]\n"
-    "       [,serial=s][,addr=A][,rerror=ignore|stop|report]\n"
+    "       [,snapshot=on|off][,serial=s][,addr=A][,rerror=ignore|stop|report]\n"
     "       [,werror=ignore|stop|report|enospc][,id=name][,aio=threads|native]\n"
     "       [,readonly=on|off][,copy-on-read=on|off]\n"
     "       [,discard=ignore|unmap][,detect-zeroes=on|off|unmap]\n"
@@ -847,10 +846,6 @@ This option defines where is connected the drive by using an index in the list
 of available connectors of a given interface type.
 @item media=@var{media}
 This option defines the type of the media: disk or cdrom.
-@item cyls=@var{c},heads=@var{h},secs=@var{s}[,trans=@var{t}]
-Force disk physical geometry and the optional BIOS translation (trans=none or
-lba). These parameters are deprecated, use the corresponding parameters
-of @code{-device} instead.
 @item snapshot=@var{snapshot}
 @var{snapshot} is "on" or "off" and controls snapshot mode for the given drive
 (see @option{-snapshot}).
-- 
2.13.6
