Received: from eggs.gnu.org ([2001:4830:134:3::10]:52602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqST-00051b-1j
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSD-0004n2-Rs
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:29 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1doqSD-0004ma-KI
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:13 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSC-0005W7-Lg
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:26:12 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  4 Sep 2017 13:25:47 +0100
Message-Id: <1504527967-29248-17-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
References: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 16/36] loader: Handle ELF files with overlapping
 zero-initialized data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

For embedded systems, notably ARM, one common use of ELF
file segments is that the 'physical addresses' represent load addresses
and the 'virtual addresses' execution addresses, such that
the load addresses are packed into ROM or flash, and the
relocation and zero-initialization of data is done at runtime.
This means that the 'memsz' in the segment header represents
the runtime size of the segment, but the size that needs to
be loaded is only the 'filesz'. In particular, paddr+memsz
may overlap with the next segment to be loaded, as in this
example:

0x70000001 off    0x00007f68 vaddr 0x00008150 paddr 0x00008150 align 2**2
         filesz 0x00000008 memsz 0x00000008 flags r--
    LOAD off    0x000000f4 vaddr 0x00000000 paddr 0x00000000 align 2**2
         filesz 0x00000124 memsz 0x00000124 flags r--
    LOAD off    0x00000218 vaddr 0x00000400 paddr 0x00000400 align 2**3
         filesz 0x00007d58 memsz 0x00007d58 flags r-x
    LOAD off    0x00007f70 vaddr 0x20000140 paddr 0x00008158 align 2**3
         filesz 0x00000a80 memsz 0x000022f8 flags rw-
    LOAD off    0x000089f0 vaddr 0x20002438 paddr 0x00008bd8 align 2**0
         filesz 0x00000000 memsz 0x00004000 flags rw-
    LOAD off    0x000089f0 vaddr 0x20000000 paddr 0x20000000 align 2**0
         filesz 0x00000000 memsz 0x00000140 flags rw-

where the segment at paddr 0x8158 has a memsz of 0x2258 and
would overlap with the segment at paddr 0x8bd8 if QEMU's loader
tried to honour it. (At runtime the segments will not overlap
since their vaddrs are more widely spaced than their paddrs.)

Currently if you try to load an ELF file like this with QEMU then
it will fail with an error "rom: requested regions overlap",
because we create a ROM image for each segment using the memsz
as the size.

Support ELF files using this scheme, by truncating the
zero-initialized part of the segment if it would overlap another
segment. This will retain the existing loader behaviour for
all ELF files we currently accept, and also accept ELF files
which only need 'filesz' bytes to be loaded.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1502116754-18867-2-git-send-email-peter.maydell@linaro.org
---
 include/hw/elf_ops.h | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
index a172a60..2e526d3 100644
--- a/include/hw/elf_ops.h
+++ b/include/hw/elf_ops.h
@@ -362,6 +362,54 @@ static int glue(load_elf, SZ)(const char *name, int fd,
                     goto fail;
                 }
             }
+
+            /* The ELF spec is somewhat vague about the purpose of the
+             * physical address field. One common use in the embedded world
+             * is that physical address field specifies the load address
+             * and the virtual address field specifies the execution address.
+             * Segments are packed into ROM or flash, and the relocation
+             * and zero-initialization of data is done at runtime. This
+             * means that the memsz header represents the runtime size of the
+             * segment, but the filesz represents the loadtime size. If
+             * we try to honour the memsz value for an ELF file like this
+             * we will end up with overlapping segments (which the
+             * loader.c code will later reject).
+             * We support ELF files using this scheme by by checking whether
+             * paddr + memsz for this segment would overlap with any other
+             * segment. If so, then we assume it's using this scheme and
+             * truncate the loaded segment to the filesz size.
+             * If the segment considered as being memsz size doesn't overlap
+             * then we use memsz for the segment length, to handle ELF files
+             * which assume that the loader will do the zero-initialization.
+             */
+            if (mem_size > file_size) {
+                /* If this segment's zero-init portion overlaps another
+                 * segment's data or zero-init portion, then truncate this one.
+                 * Invalid ELF files where the segments overlap even when
+                 * only file_size bytes are loaded will be rejected by
+                 * the ROM overlap check in loader.c, so we don't try to
+                 * explicitly detect those here.
+                 */
+                int j;
+                elf_word zero_start = ph->p_paddr + file_size;
+                elf_word zero_end = ph->p_paddr + mem_size;
+
+                for (j = 0; j < ehdr.e_phnum; j++) {
+                    struct elf_phdr *jph = &phdr[j];
+
+                    if (i != j && jph->p_type == PT_LOAD) {
+                        elf_word other_start = jph->p_paddr;
+                        elf_word other_end = jph->p_paddr + jph->p_memsz;
+
+                        if (!(other_start >= zero_end ||
+                              zero_start >= other_end)) {
+                            mem_size = file_size;
+                            break;
+                        }
+                    }
+                }
+            }
+
             /* address_offset is hack for kernel images that are
                linked at the wrong physical address.  */
             if (translate_fn) {
-- 
2.7.4
