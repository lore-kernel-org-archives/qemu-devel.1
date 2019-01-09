Received: from eggs.gnu.org ([209.51.188.92]:58527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1gh98N-0001B4-7B
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 03:22:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1gh98M-0005pu-Fd
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 03:22:43 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1gh98M-0005pX-3p
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 03:22:42 -0500
Received: by mail-wr1-x441.google.com with SMTP id t6so6640695wrr.12
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 00:22:41 -0800 (PST)
From: Jon Doron <arilou@gmail.com>
Date: Wed,  9 Jan 2019 10:22:03 +0200
Message-Id: <20190109082203.27142-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3] dump: Set correct vaddr for ELF dump
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lersek@redhat.com, marcandre.lureau@redhat.com, Jon Doron <arilou@gmail.com>

vaddr needs to be equal to the paddr since the dump file represents the
physical memory image.

Without setting vaddr correctly, GDB would load all the different memory
regions on top of each other to vaddr 0, thus making GDB showing the wrong
memory data for a given address.

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 dump.c                       | 5 +++--
 scripts/dump-guest-memory.py | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/dump.c b/dump.c
index 4ec94c5e25..de7f70f099 100644
--- a/dump.c
+++ b/dump.c
@@ -192,7 +192,7 @@ static void write_elf64_load(DumpState *s, MemoryMapping *memory_mapping,
     phdr.p_paddr = cpu_to_dump64(s, memory_mapping->phys_addr);
     phdr.p_filesz = cpu_to_dump64(s, filesz);
     phdr.p_memsz = cpu_to_dump64(s, memory_mapping->length);
-    phdr.p_vaddr = cpu_to_dump64(s, memory_mapping->virt_addr);
+    phdr.p_vaddr = cpu_to_dump64(s, memory_mapping->virt_addr) ? : phdr.p_paddr;
 
     assert(memory_mapping->length >= filesz);
 
@@ -216,7 +216,8 @@ static void write_elf32_load(DumpState *s, MemoryMapping *memory_mapping,
     phdr.p_paddr = cpu_to_dump32(s, memory_mapping->phys_addr);
     phdr.p_filesz = cpu_to_dump32(s, filesz);
     phdr.p_memsz = cpu_to_dump32(s, memory_mapping->length);
-    phdr.p_vaddr = cpu_to_dump32(s, memory_mapping->virt_addr);
+    phdr.p_vaddr =
+        cpu_to_dump32(s, memory_mapping->virt_addr) ? : phdr.p_paddr;
 
     assert(memory_mapping->length >= filesz);
 
diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.py
index 198cd0fe40..2c587cbefc 100644
--- a/scripts/dump-guest-memory.py
+++ b/scripts/dump-guest-memory.py
@@ -163,6 +163,7 @@ class ELF(object):
         phdr = get_arch_phdr(self.endianness, self.elfclass)
         phdr.p_type = p_type
         phdr.p_paddr = p_paddr
+        phdr.p_vaddr = p_paddr
         phdr.p_filesz = p_size
         phdr.p_memsz = p_size
         self.segments.append(phdr)
-- 
2.19.2
