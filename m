Received: from eggs.gnu.org ([2001:4830:134:3::10]:59427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cjq6I-0003w5-Ta
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:30:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cjq6H-0002QR-P1
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:30:38 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36683)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cjq6H-0002QE-FR
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:30:37 -0500
Received: by mail-wm0-x244.google.com with SMTP id v190so3934884wme.3
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 08:30:37 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  3 Mar 2017 17:30:29 +0100
Message-Id: <1488558630-21522-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1488558630-21522-1-git-send-email-pbonzini@redhat.com>
References: <1488558630-21522-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 20/21] memory: show region offset and ROM/RAM
 type in "info mtree -f"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, William Tambe <tambewilliam@gmail.com>

"info mtree -f" output is currently hard to use for large RAM regions, because
there is no hint as to what part of the region is being mapped.  Add the offset
if it is nonzero.

Secondly, FlatView has a readonly field, that can override the MemoryRegion
in the presence of aliases.  Take it into account.

Together, with this patch this:

address-space (flat view): KVM-SMRAM
  0000000000000000-00000000000bffff (prio 0, ram): pc.ram
  00000000000c0000-00000000000c9fff (prio 0, ram): pc.ram
  00000000000ca000-00000000000ccfff (prio 0, ram): pc.ram
  00000000000cd000-00000000000ebfff (prio 0, ram): pc.ram
  00000000000ec000-00000000000effff (prio 0, ram): pc.ram
  00000000000f0000-00000000000fffff (prio 0, ram): pc.ram
  0000000000100000-00000000bfffffff (prio 0, ram): pc.ram
  00000000fd000000-00000000fdffffff (prio 1, ram): vga.vram
  00000000febc0000-00000000febdffff (prio 1, i/o): e1000-mmio
  00000000febf0400-00000000febf041f (prio 0, i/o): vga ioports remapped
  00000000febf0500-00000000febf0515 (prio 0, i/o): bochs dispi interface
  00000000febf0600-00000000febf0607 (prio 0, i/o): qemu extended regs
  00000000fec00000-00000000fec00fff (prio 0, i/o): kvm-ioapic
  00000000fed00000-00000000fed003ff (prio 0, i/o): hpet
  00000000fee00000-00000000feefffff (prio 4096, i/o): kvm-apic-msi
  00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
  0000000100000000-000000013fffffff (prio 0, ram): pc.ram

becomes this:

address-space (flat view): KVM-SMRAM
  0000000000000000-00000000000bffff (prio 0, ram): pc.ram
  00000000000c0000-00000000000c9fff (prio 0, rom): pc.ram @00000000000c0000
  00000000000ca000-00000000000ccfff (prio 0, ram): pc.ram @00000000000ca000
  00000000000cd000-00000000000ebfff (prio 0, rom): pc.ram @00000000000cd000
  00000000000ec000-00000000000effff (prio 0, ram): pc.ram @00000000000ec000
  00000000000f0000-00000000000fffff (prio 0, rom): pc.ram @00000000000f0000
  0000000000100000-00000000bfffffff (prio 0, ram): pc.ram @0000000000100000
  00000000fd000000-00000000fdffffff (prio 1, ram): vga.vram
  00000000febc0000-00000000febdffff (prio 1, i/o): e1000-mmio
  00000000febf0400-00000000febf041f (prio 0, i/o): vga ioports remapped
  00000000febf0500-00000000febf0515 (prio 0, i/o): bochs dispi interface
  00000000febf0600-00000000febf0607 (prio 0, i/o): qemu extended regs
  00000000fec00000-00000000fec00fff (prio 0, i/o): kvm-ioapic
  00000000fed00000-00000000fed003ff (prio 0, i/o): hpet
  00000000fee00000-00000000feefffff (prio 4096, i/o): kvm-apic-msi
  00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
  0000000100000000-000000013fffffff (prio 0, ram): pc.ram @00000000c0000000

This should make it easier to understand what's going on.

Cc: Peter Xu <peterx@redhat.com>
Cc: "William Tambe" <tambewilliam@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 memory.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/memory.c b/memory.c
index 573fa6e..284894b 100644
--- a/memory.c
+++ b/memory.c
@@ -2588,13 +2588,24 @@ static void mtree_print_flatview(fprintf_function p, void *f,
 
     while (n--) {
         mr = range->mr;
-        p(f, MTREE_INDENT TARGET_FMT_plx "-"
-          TARGET_FMT_plx " (prio %d, %s): %s\n",
-          int128_get64(range->addr.start),
-          int128_get64(range->addr.start) + MR_SIZE(range->addr.size),
-          mr->priority,
-          memory_region_type(mr),
-          memory_region_name(mr));
+        if (range->offset_in_region) {
+            p(f, MTREE_INDENT TARGET_FMT_plx "-"
+              TARGET_FMT_plx " (prio %d, %s): %s @" TARGET_FMT_plx "\n",
+              int128_get64(range->addr.start),
+              int128_get64(range->addr.start) + MR_SIZE(range->addr.size),
+              mr->priority,
+              range->readonly ? "rom" : memory_region_type(mr),
+              memory_region_name(mr),
+              range->offset_in_region);
+        } else {
+            p(f, MTREE_INDENT TARGET_FMT_plx "-"
+              TARGET_FMT_plx " (prio %d, %s): %s\n",
+              int128_get64(range->addr.start),
+              int128_get64(range->addr.start) + MR_SIZE(range->addr.size),
+              mr->priority,
+              range->readonly ? "rom" : memory_region_type(mr),
+              memory_region_name(mr));
+        }
         range++;
     }
 
-- 
1.8.3.1
