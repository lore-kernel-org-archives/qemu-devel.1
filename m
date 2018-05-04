Received: from eggs.gnu.org ([2001:4830:134:3::10]:50251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fEPPX-0000qu-Qe
	for qemu-devel@nongnu.org; Thu, 03 May 2018 21:21:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fEPPU-0005YN-M7
	for qemu-devel@nongnu.org; Thu, 03 May 2018 21:21:23 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:42248)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fEPPU-0005Xc-Fz
	for qemu-devel@nongnu.org; Thu, 03 May 2018 21:21:20 -0400
Received: by mail-pg0-x243.google.com with SMTP id p9-v6so11441027pgc.9
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 18:21:20 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Fri,  4 May 2018 13:19:54 +1200
Message-Id: <1525396794-17042-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH] device_tree: Add qemu_fdt_totalsize function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Alistair Francis <Alistair.Francis@wdc.com>, Peter Maydell <peter.maydell@linaro.org>

Currently the device-tree create_device_tree function
returns the size of the allocated device tree buffer
however there is no way to get the actual amount of
buffer space used by the device-tree.

14ec3cbd7c1e31dca4d23f028100c8f43e156573 increases
the FDT_MAX_SIZE to 1 MiB. This creates an issue
for boards that have less than 1 MiB in their ROM
for device tree. While cpu_physical_memory_write
will not write past the end of a buffer there is
and a board is aware of its ROM buffer size, so
can use min(fdt_size,rom_size); this provides no
indication as to whether the device-tree may be
truncated. qemu_fdt_totalsize allows a board to
check that a dynamically created device tree will
fit within its alloted ROM space.

Add qemu_fdt_totalsize which uses the logic and
public APIs from libfdt to calculate the device
size: struct_offset + struct_size + strings_size
+ terminator.

Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Alexander Graf <agraf@suse.de>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
---
 device_tree.c                | 6 ++++++
 include/sysemu/device_tree.h | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/device_tree.c b/device_tree.c
index 52c3358a5583..3a2166d61f37 100644
--- a/device_tree.c
+++ b/device_tree.c
@@ -215,6 +215,12 @@ void *load_device_tree_from_sysfs(void)
 
 #endif /* CONFIG_LINUX */
 
+size_t qemu_fdt_totalsize(void *fdt)
+{
+    return fdt_off_dt_struct(fdt) + fdt_size_dt_struct(fdt) +
+           fdt_size_dt_strings(fdt) + sizeof(uint32_t) /* terminator */;
+}
+
 static int findnode_nofail(void *fdt, const char *node_path)
 {
     int offset;
diff --git a/include/sysemu/device_tree.h b/include/sysemu/device_tree.h
index e22e5bec9c3f..4af232dfdc65 100644
--- a/include/sysemu/device_tree.h
+++ b/include/sysemu/device_tree.h
@@ -26,6 +26,12 @@ void *load_device_tree_from_sysfs(void);
 #endif
 
 /**
+ * qemu_fdt_total_size: returns the size required to store the current
+ * device tree versus the buffer size returned by create_device_tree
+ */
+size_t qemu_fdt_totalsize(void *fdt);
+
+/**
  * qemu_fdt_node_path: return the paths of nodes matching a given
  * name and compat string
  * @fdt: pointer to the dt blob
-- 
2.7.0
