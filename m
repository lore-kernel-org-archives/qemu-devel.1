Received: from eggs.gnu.org ([2001:4830:134:3::10]:39435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eKo5M-0008Bc-GS
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:23:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eKo4I-0005Um-HQ
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:22:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eKo4I-0005T9-3g
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:21:38 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DD16F61D3B
	for <qemu-devel@nongnu.org>; Thu, 30 Nov 2017 19:15:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 30 Nov 2017 20:15:03 +0100
Message-Id: <1512069303-16986-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12] hmp-commands: Remove the deprecated
 usb_add and usb_del
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

It's easy to use device_add and device_del as replacement instead.
The usb_add and usb_del commands are deprecated since QEMU 2.10,
and nobody complained that they are still needed, so let's get rid
of them now to make the HMP interface a little bit less overloaded.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hmp-commands.hx         | 33 ---------------------------------
 include/sysemu/sysemu.h |  2 --
 qemu-doc.texi           |  8 --------
 vl.c                    | 44 --------------------------------------------
 4 files changed, 87 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 4afd57c..6d5ebdf 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -666,39 +666,6 @@ Compute the checksum of a memory region.
 ETEXI
 
     {
-        .name       = "usb_add",
-        .args_type  = "devname:s",
-        .params     = "device",
-        .help       = "add USB device (e.g. 'host:bus.addr' or 'host:vendor_id:product_id')",
-        .cmd        = hmp_usb_add,
-    },
-
-STEXI
-@item usb_add @var{devname}
-@findex usb_add
-Add the USB device @var{devname}. This command is deprecated, please
-use @code{device_add} instead. For details of available devices see
-@ref{usb_devices}
-ETEXI
-
-    {
-        .name       = "usb_del",
-        .args_type  = "devname:s",
-        .params     = "device",
-        .help       = "remove USB device 'bus.addr'",
-        .cmd        = hmp_usb_del,
-    },
-
-STEXI
-@item usb_del @var{devname}
-@findex usb_del
-Remove the USB device @var{devname} from the QEMU virtual USB
-hub. @var{devname} has the syntax @code{bus.addr}. Use the monitor
-command @code{info usb} to see the devices you can remove. This
-command is deprecated, please use @code{device_del} instead.
-ETEXI
-
-    {
         .name       = "device_add",
         .args_type  = "device:O",
         .params     = "driver[,prop=value][,...]",
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index c083869..31612ca 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -166,8 +166,6 @@ extern Chardev *serial_hds[MAX_SERIAL_PORTS];
 
 extern Chardev *parallel_hds[MAX_PARALLEL_PORTS];
 
-void hmp_usb_add(Monitor *mon, const QDict *qdict);
-void hmp_usb_del(Monitor *mon, const QDict *qdict);
 void hmp_info_usb(Monitor *mon, const QDict *qdict);
 
 void add_boot_device_path(int32_t bootindex, DeviceState *dev,
diff --git a/qemu-doc.texi b/qemu-doc.texi
index db2351c..ee206b8 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2518,14 +2518,6 @@ The ``host_net_add'' command is replaced by the ``netdev_add'' command.
 
 The ``host_net_remove'' command is replaced by the ``netdev_del'' command.
 
-@subsection usb_add (since 2.10.0)
-
-The ``usb_add'' command is replaced by the ``device_add'' command.
-
-@subsection usb_del (since 2.10.0)
-
-The ``usb_del'' command is replaced by the ``device_del'' command.
-
 @section System emulator devices
 
 @subsection ivshmem (since 2.6.0)
diff --git a/vl.c b/vl.c
index 1ad1c04..fc8bd93 100644
--- a/vl.c
+++ b/vl.c
@@ -1479,28 +1479,6 @@ done:
     return 0;
 }
 
-static int usb_device_del(const char *devname)
-{
-    int bus_num, addr;
-    const char *p;
-
-    if (strstart(devname, "host:", &p)) {
-        return -1;
-    }
-
-    if (!machine_usb(current_machine)) {
-        return -1;
-    }
-
-    p = strchr(devname, '.');
-    if (!p)
-        return -1;
-    bus_num = strtoul(devname, NULL, 0);
-    addr = strtoul(p + 1, NULL, 0);
-
-    return usb_device_delete_addr(bus_num, addr);
-}
-
 static int usb_parse(const char *cmdline)
 {
     int r;
@@ -1511,28 +1489,6 @@ static int usb_parse(const char *cmdline)
     return r;
 }
 
-void hmp_usb_add(Monitor *mon, const QDict *qdict)
-{
-    const char *devname = qdict_get_str(qdict, "devname");
-
-    error_report("usb_add is deprecated, please use device_add instead");
-
-    if (usb_device_add(devname) < 0) {
-        error_report("could not add USB device '%s'", devname);
-    }
-}
-
-void hmp_usb_del(Monitor *mon, const QDict *qdict)
-{
-    const char *devname = qdict_get_str(qdict, "devname");
-
-    error_report("usb_del is deprecated, please use device_del instead");
-
-    if (usb_device_del(devname) < 0) {
-        error_report("could not delete USB device '%s'", devname);
-    }
-}
-
 /***********************************************************/
 /* machine registration */
 
-- 
1.8.3.1
