Received: from eggs.gnu.org ([2001:4830:134:3::10]:52138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpvLe-0004fE-Fh
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 08:56:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpvLb-0001Gl-SO
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 08:56:25 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 15 Aug 2018 14:55:24 +0200
Message-Id: <20180815125537.10651-9-kwolf@redhat.com>
In-Reply-To: <20180815125537.10651-1-kwolf@redhat.com>
References: <20180815125537.10651-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 08/21] block: Remove deprecated -drive option
 addr
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

This reinstates commit eae3bd1eb7c6b105d30ec06008b3bc3dfc5f45bb,
which was temporarily reverted for the 3.0 release so that libvirt gets
some extra time to update their command lines.

The -drive option addr was deprecated in QEMU 2.10. It's time to remove
it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
---
 include/sysemu/blockdev.h |  1 -
 blockdev.c                | 17 +----------------
 device-hotplug.c          |  4 ----
 qemu-deprecated.texi      |  5 -----
 qemu-options.hx           |  5 +----
 5 files changed, 2 insertions(+), 30 deletions(-)

diff --git a/include/sysemu/blockdev.h b/include/sysemu/blockdev.h
index 37ea39719e..c0ae3700ec 100644
--- a/include/sysemu/blockdev.h
+++ b/include/sysemu/blockdev.h
@@ -28,7 +28,6 @@ typedef enum {
 } BlockInterfaceType;
 
 struct DriveInfo {
-    const char *devaddr;
     BlockInterfaceType type;
     int bus;
     int unit;
diff --git a/blockdev.c b/blockdev.c
index c23587b075..6c530769fd 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -731,10 +731,6 @@ QemuOptsList qemu_legacy_drive_opts = {
             .type = QEMU_OPT_STRING,
             .help = "interface (ide, scsi, sd, mtd, floppy, pflash, virtio)",
         },{
-            .name = "addr",
-            .type = QEMU_OPT_STRING,
-            .help = "pci address (virtio only)",
-        },{
             .name = "serial",
             .type = QEMU_OPT_STRING,
             .help = "disk serial number",
@@ -777,7 +773,6 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
     DriveMediaType media = MEDIA_DISK;
     BlockInterfaceType type;
     int max_devs, bus_id, unit_id, index;
-    const char *devaddr;
     const char *werror, *rerror;
     bool read_only = false;
     bool copy_on_read;
@@ -786,7 +781,7 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
     Error *local_err = NULL;
     int i;
     const char *deprecated[] = {
-        "serial", "addr"
+        "serial"
     };
 
     /* Change legacy command line options into QMP ones */
@@ -976,12 +971,6 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
     }
 
     /* Add virtio block device */
-    devaddr = qemu_opt_get(legacy_opts, "addr");
-    if (devaddr && type != IF_VIRTIO) {
-        error_report("addr is not supported by this bus type");
-        goto fail;
-    }
-
     if (type == IF_VIRTIO) {
         QemuOpts *devopts;
         devopts = qemu_opts_create(qemu_find_opts("device"), NULL, 0,
@@ -993,9 +982,6 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
         }
         qemu_opt_set(devopts, "drive", qdict_get_str(bs_opts, "id"),
                      &error_abort);
-        if (devaddr) {
-            qemu_opt_set(devopts, "addr", devaddr, &error_abort);
-        }
     }
 
     filename = qemu_opt_get(legacy_opts, "file");
@@ -1040,7 +1026,6 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
     dinfo->type = type;
     dinfo->bus = bus_id;
     dinfo->unit = unit_id;
-    dinfo->devaddr = devaddr;
     dinfo->serial = g_strdup(serial);
 
     blk_set_legacy_dinfo(blk, dinfo);
diff --git a/device-hotplug.c b/device-hotplug.c
index 23fd6656f1..cd427e2c76 100644
--- a/device-hotplug.c
+++ b/device-hotplug.c
@@ -69,10 +69,6 @@ void hmp_drive_add(Monitor *mon, const QDict *qdict)
     if (!dinfo) {
         goto err;
     }
-    if (dinfo->devaddr) {
-        monitor_printf(mon, "Parameter addr not supported\n");
-        goto err;
-    }
 
     switch (dinfo->type) {
     case IF_NONE:
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index f90436da56..6d7aaab2cd 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -99,11 +99,6 @@ provided per NIC.
 The drive serial argument is replaced by the the serial argument
 that can be specified with the ``-device'' parameter.
 
-@subsection -drive addr=... (since 2.10.0)
-
-The drive addr argument is replaced by the the addr argument
-that can be specified with the ``-device'' parameter.
-
 @subsection -usbdevice (since 2.10.0)
 
 The ``-usbdevice DEV'' argument is now a synonym for setting
diff --git a/qemu-options.hx b/qemu-options.hx
index b5155c925a..a42917f41c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -805,7 +805,7 @@ ETEXI
 DEF("drive", HAS_ARG, QEMU_OPTION_drive,
     "-drive [file=file][,if=type][,bus=n][,unit=m][,media=d][,index=i]\n"
     "       [,cache=writethrough|writeback|none|directsync|unsafe][,format=f]\n"
-    "       [,snapshot=on|off][,serial=s][,addr=A][,rerror=ignore|stop|report]\n"
+    "       [,snapshot=on|off][,serial=s][,rerror=ignore|stop|report]\n"
     "       [,werror=ignore|stop|report|enospc][,id=name][,aio=threads|native]\n"
     "       [,readonly=on|off][,copy-on-read=on|off]\n"
     "       [,discard=ignore|unmap][,detect-zeroes=on|off|unmap]\n"
@@ -883,9 +883,6 @@ an untrusted format header.
 This option specifies the serial number to assign to the device. This
 parameter is deprecated, use the corresponding parameter of @code{-device}
 instead.
-@item addr=@var{addr}
-Specify the controller's PCI address (if=virtio only). This parameter is
-deprecated, use the corresponding parameter of @code{-device} instead.
 @item werror=@var{action},rerror=@var{action}
 Specify which @var{action} to take on write and read errors. Valid actions are:
 "ignore" (ignore the error and try to continue), "stop" (pause QEMU),
-- 
2.13.6
