Received: from eggs.gnu.org ([209.51.188.92]:60377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nMx-00039F-Hl
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:23:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nMw-0006lO-9U
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:23:07 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:51310)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
	id 1h1nMv-0006at-6G
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:23:05 -0500
From: elena.ufimtseva@oracle.com
Date: Wed,  6 Mar 2019 23:22:56 -0800
Message-Id: <20190307072256.9917-1-elena.ufimtseva@oracle.com>
Subject: [Qemu-devel] [multiprocess RFC PATCH 37/37] multi-process: add
 configure and usage information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, ross.lagerwall@citrix.com, stefanha@redhat.com, liran.alon@oracle.com, kanth.ghatraju@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com, konrad.wilk@oracle.com, sstabellini@kernel.org

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
---
 docs/qemu-multiprocess.txt | 104 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 docs/qemu-multiprocess.txt

diff --git a/docs/qemu-multiprocess.txt b/docs/qemu-multiprocess.txt
new file mode 100644
index 0000000..b0428da
--- /dev/null
+++ b/docs/qemu-multiprocess.txt
@@ -0,0 +1,104 @@
+/*
+ * Copyright 2019, Oracle and/or its affiliates. All rights reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+
+Multi-process QEMU
+
+This document describes how to configure and use multi-process qemu.
+For the design document refer to docs/devel/qemu-multiprocess.
+
+Configure
+
+To enable support for multi-process add --enable-mpqemu
+to the list of options for configure.
+
+Usage
+
+Command line
+
+To start qemu with devices intended to run in the separate emulation
+process, the following options are used:
+
+    -rdevice, -rdrive:
+    this is similar to -device option, with only difference being
+    the "rid" option that identifies the remote process.
+ 
+For exmaple, for non multi-process qemu:
+    -device lsi53c895a,id=scsi0 device
+    -device scsi-hd,drive=drive0,bus=scsi0.0,scsi-id=0
+    -drive id=drive0,file=data-disk.img
+
+and for multi-process qemu:
+    -rdevice lsi53c895a,id=scsi0,rid=0
+    -rdevice scsi-hd,drive=drive0,bus=scsi0.0,scsi-id=0,rid=0
+    -rdrive id=drive0,file=data-disk.img,rid=0
+
+
+The memorybackend object has to be specified on the command line:
+-object memory-backend-file,id=mem,mem-path=/dev/shm/,size=4096M,share=on
+
+
+Example of running scsi drive in the guest in separate qemu
+process:
+
+qemu-system-x86_64 -enable-kvm -machine q35 -smp 4 -m 4096M -vnc :0 \
+-net nic -net user,hostfwd=tcp::5022-:22 -hda os.qcow2 \
+-rdevice lsi53c895a,rid=0,id=scsi0 \
+-rdevice scsi-hd,rid=0,drive=drive0,bus=scsi0.0,scsi-id=0 \
+-rdrive id=drive0,rid=0,file=data-disk.img \
+-object memory-backend-file,id=mem,mem-path=/dev/shm/,size=4096M,share=on -numa node,memdev=mem
+
+HMP commands
+
+For hotplugging in multi-process qemu the following commands
+can be used:
+
+- rdevice_add;
+- rdevice_del;
+- rdrive_add;
+- rdrive_del;
+- remote_proc_list
+
+Example:
+
+qemu-system-x86_64 -enable-kvm -machine q35 -smp 4 -m 4096M -vnc :0 \
+-net nic -net user,hostfwd=tcp::5022-:22 \
+-drive file=/root/ol7.qcow2,format=raw \
+-rdevice lsi53c895a,rid=0,id=scsi0 \
+-object memory-backend-file,id=mem,mem-path=/dev/shm/,size=4096M,share=on \
+-numa node,memdev=mem \
+-monitor stdio
+
+(qemu) rdrive_add 0 drive0 file=/root/cirros-0.4.0-x86_64-disk.img
+(qemu) rdevice_add 0 scsi-hd drive1 drive0 scsi0.0
+(qemu) remote_proc_list 
+     PID	             RID	         QEMU ID	    PROCESS NAME
+
+00011079	               0	          drive0	   qemu-scsi-dev
+00011079	               0	          drive1	   qemu-scsi-dev
+00011079	               0	               0	   qemu-scsi-dev
+
+After running rescan_scsi_bus.sh -a, guest will be able to identify newly
+added devices.
+
+
+
-- 
1.8.3.1
