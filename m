Received: from eggs.gnu.org ([209.51.188.92]:36647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1ggr1t-0002mV-KS
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 08:02:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1ggr1r-0003Uu-SP
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 08:02:49 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45780)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1ggr1r-0003M1-HD
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 08:02:47 -0500
Received: by mail-wr1-x444.google.com with SMTP id t6so3920699wrr.12
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 05:02:47 -0800 (PST)
From: Jon Doron <arilou@gmail.com>
Date: Tue,  8 Jan 2019 15:02:19 +0200
Message-Id: <20190108130219.18550-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2] dump: Set correct vaddr for ELF dump
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
index 4ec94c5e25..7a56e254d4 100644
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
+		cpu_to_dump32(s, memory_mapping->virt_addr) ? : phdr.p_paddr;
 
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
