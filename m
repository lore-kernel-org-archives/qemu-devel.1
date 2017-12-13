Received: from eggs.gnu.org ([2001:4830:134:3::10]:51427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWV-0004d1-Qk
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWU-0007fc-Sb
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:51 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:39114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ePBWU-0007XQ-Ln
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:50 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Dec 2017 17:52:28 +0000
Message-Id: <1513187549-2435-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1513187549-2435-1-git-send-email-peter.maydell@linaro.org>
References: <1513187549-2435-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 1/2] exec: Don't reuse unassigned_mem_ops for
 io_mem_rom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, Paul Burton <paul.burton@mips.com>

We set up the io_mem_rom special memory region using the
unassigned_mem_ops structure; this is then used when a guest tries to
write to ROM.  This is incorrect, because the behaviour of unassigned
memory may be different from that of ROM for writes.  In particular,
on some architectures writing to unassigned memory generates a guest
exception, whereas writing to ROM is generally ignored.  Use a
special readonly_mem_ops for this purpose instead, so writes to
ROM are ignored for all guest CPUs.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 exec.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index 03238a3..74b8727 100644
--- a/exec.c
+++ b/exec.c
@@ -2720,6 +2720,37 @@ static uint16_t dummy_section(PhysPageMap *map, FlatView *fv, MemoryRegion *mr)
     return phys_section_add(map, &section);
 }
 
+static void readonly_mem_write(void *opaque, hwaddr addr,
+                               uint64_t val, unsigned size)
+{
+    /* Ignore any write to ROM. */
+}
+
+static bool readonly_mem_accepts(void *opaque, hwaddr addr,
+                                 unsigned size, bool is_write)
+{
+    return is_write;
+}
+
+/* This will only be used for writes, because reads are special cased
+ * to directly access the underlying host ram.
+ */
+static const MemoryRegionOps readonly_mem_ops = {
+    .write = readonly_mem_write,
+    .valid.accepts = readonly_mem_accepts,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+        .unaligned = false,
+    },
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+        .unaligned = false,
+    },
+};
+
 MemoryRegion *iotlb_to_region(CPUState *cpu, hwaddr index, MemTxAttrs attrs)
 {
     int asidx = cpu_asidx_from_attrs(cpu, attrs);
@@ -2732,7 +2763,8 @@ MemoryRegion *iotlb_to_region(CPUState *cpu, hwaddr index, MemTxAttrs attrs)
 
 static void io_mem_init(void)
 {
-    memory_region_init_io(&io_mem_rom, NULL, &unassigned_mem_ops, NULL, NULL, UINT64_MAX);
+    memory_region_init_io(&io_mem_rom, NULL, &readonly_mem_ops,
+                          NULL, NULL, UINT64_MAX);
     memory_region_init_io(&io_mem_unassigned, NULL, &unassigned_mem_ops, NULL,
                           NULL, UINT64_MAX);
 
-- 
2.7.4
