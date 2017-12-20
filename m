Received: from eggs.gnu.org ([2001:4830:134:3::10]:56530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyU-0004mg-Qv
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyQ-0007IJ-Rj
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:10 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:41770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRhyQ-0007Ht-LZ
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:06 -0500
Received: by mail-wm0-x244.google.com with SMTP id g75so11357961wme.0
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 09:16:06 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 18:14:41 +0100
Message-Id: <1513790098-9815-30-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 29/46] exec: Don't reuse unassigned_mem_ops for
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
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

We set up the io_mem_rom special memory region using the
unassigned_mem_ops structure; this is then used when a guest tries to
write to ROM.  This is incorrect, because the behaviour of unassigned
memory may be different from that of ROM for writes.  In particular,
on some architectures writing to unassigned memory generates a guest
exception, whereas writing to ROM is generally ignored.  Use a
special readonly_mem_ops for this purpose instead, so writes to
ROM are ignored for all guest CPUs.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <1513187549-2435-2-git-send-email-peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index 6b5828e..4722e52 100644
--- a/exec.c
+++ b/exec.c
@@ -2725,6 +2725,37 @@ static uint16_t dummy_section(PhysPageMap *map, FlatView *fv, MemoryRegion *mr)
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
@@ -2737,7 +2768,8 @@ MemoryRegion *iotlb_to_region(CPUState *cpu, hwaddr index, MemTxAttrs attrs)
 
 static void io_mem_init(void)
 {
-    memory_region_init_io(&io_mem_rom, NULL, &unassigned_mem_ops, NULL, NULL, UINT64_MAX);
+    memory_region_init_io(&io_mem_rom, NULL, &readonly_mem_ops,
+                          NULL, NULL, UINT64_MAX);
     memory_region_init_io(&io_mem_unassigned, NULL, &unassigned_mem_ops, NULL,
                           NULL, UINT64_MAX);
 
-- 
1.8.3.1
