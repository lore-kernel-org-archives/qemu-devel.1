Received: from eggs.gnu.org ([209.51.188.92]:60117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nMa-0002lw-CJ
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nMX-0005in-H7
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:42 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
	id 1h1nMU-0005fG-ND
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:39 -0500
From: elena.ufimtseva@oracle.com
Date: Wed,  6 Mar 2019 23:22:20 -0800
Message-Id: <20190307072220.9207-1-elena.ufimtseva@oracle.com>
Subject: [Qemu-devel] [multiprocess RFC PATCH 23/37] multi-process: add
 command line options rdrive and rdevice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, ross.lagerwall@citrix.com, stefanha@redhat.com, liran.alon@oracle.com, kanth.ghatraju@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com, konrad.wilk@oracle.com, sstabellini@kernel.org, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

These command option have the same notion as the drive and device,
except these will be emulated in remote process.
Added parameter rid identified the remote process group.

As an example, this will create the device emulated by the remote
process:

/usr/local/bin/qemu-system-x86_64 -name vm -m 6G -drive file=/root/ol7.qcow2,format=raw
 -enable-kvm -machine q35,accel=kvm
 -rdevice lsi53c895a,rid=0,id=scsi0,command=qemu-scsi-dev
 -rdevice scsi-hd,rid=0,drive=drive0,bus=scsi0.0,scsi-id=0
 -rdrive id=drive0,rid=0,file=/root/cirros-0.4.0-x86_64-disk.img,format=qcow3
 -object memory-backend-file,id=mem,mem-path=/dev/shm/,size=6G,share=on -numa node,memdev=mem
 -display none -vnc :0 -monitor stdio

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
---
 blockdev.c              | 12 ++++++++++++
 include/sysemu/sysemu.h |  2 ++
 qdev-monitor.c          |  9 +++++++++
 qemu-options.hx         | 26 ++++++++++++++++++++++++++
 4 files changed, 49 insertions(+)

diff --git a/blockdev.c b/blockdev.c
index 7e6bf99..c03a09f 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -4580,3 +4580,15 @@ QemuOptsList qemu_drive_opts = {
         { /* end of list */ }
     },
 };
+
+QemuOptsList qemu_rdrive_opts = {
+    .name = "rdrive",
+    .head = QTAILQ_HEAD_INITIALIZER(qemu_rdrive_opts.head),
+    .desc = {
+        /*
+         * no elements => accept any params
+         * validation will happen later
+         */
+        { /* end of list */ }
+    },
+};
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 89604a8..82622be 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -193,5 +193,7 @@ extern QemuOptsList qemu_nic_opts;
 extern QemuOptsList qemu_net_opts;
 extern QemuOptsList qemu_global_opts;
 extern QemuOptsList qemu_mon_opts;
+extern QemuOptsList qemu_rdevice_opts;
+extern QemuOptsList qemu_rdrive_opts;
 
 #endif
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 46d0ad0..eb7e542 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -964,6 +964,15 @@ QemuOptsList qemu_global_opts = {
     },
 };
 
+QemuOptsList qemu_rdevice_opts = {
+    .name = "rdevice",
+    .implied_opt_name = "driver",
+    .head = QTAILQ_HEAD_INITIALIZER(qemu_rdevice_opts.head),
+    .desc = {
+        { /* end of list */ }
+    },
+};
+
 int qemu_global_option(const char *str)
 {
     char driver[64], property[64];
diff --git a/qemu-options.hx b/qemu-options.hx
index 1cf9aac..0b82013 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -535,6 +535,17 @@ Like the KCS interface, but defines a BT interface.  The default port is
 
 ETEXI
 
+DEF("rdevice", HAS_ARG, QEMU_OPTION_rdevice,
+    "-rdevice driver[,prop[=value][,...]]\n"
+    "                add device (based on driver)\n"
+    "                prop=value,... sets driver properties\n"
+    "                use '-device help' to print all possible drivers\n"
+    "                use '-device driver,help' to print all possible properties\n",
+    QEMU_ARCH_ALL)
+STEXI
+Remote device options.
+ETEXI
+
 DEF("name", HAS_ARG, QEMU_OPTION_name,
     "-name string1[,process=string2][,debug-threads=on|off]\n"
     "                set the name of the guest\n"
@@ -786,6 +797,21 @@ Please refer to the QAPI documentation of the @code{blockdev-add} QMP command.
 
 ETEXI
 
+DEF("rdrive", HAS_ARG, QEMU_OPTION_rdrive,
+    "-rdrive [file=file][,if=type][,bus=n][,unit=m][,media=d][,index=i]\n"
+    "       [,cache=writethrough|writeback|none|directsync|unsafe][,format=f]\n"
+    "       [,snapshot=on|off][,rerror=ignore|stop|report]\n"
+    "       [,werror=ignore|stop|report|enospc][,id=name][,aio=threads|native]\n"
+    "       [,readonly=on|off][,copy-on-read=on|off]\n"
+    "       [,discard=ignore|unmap][,detect-zeroes=on|off|unmap]\n"
+    "       [[,bps=b]|[[,bps_rd=r][,bps_wr=w]]]\n"
+    "       [[,iops=i]|[[,iops_rd=r][,iops_wr=w]]]\n"
+    "       [[,bps_max=bm]|[[,bps_rd_max=rm][,bps_wr_max=wm]]]\n"
+    "       [[,iops_max=im]|[[,iops_rd_max=irm][,iops_wr_max=iwm]]]\n"
+    "       [[,iops_size=is]]\n"
+    "       [[,group=g]]\n"
+    "                use 'file' as a drive image\n", QEMU_ARCH_ALL)
+
 DEF("drive", HAS_ARG, QEMU_OPTION_drive,
     "-drive [file=file][,if=type][,bus=n][,unit=m][,media=d][,index=i]\n"
     "       [,cache=writethrough|writeback|none|directsync|unsafe][,format=f]\n"
-- 
1.8.3.1
