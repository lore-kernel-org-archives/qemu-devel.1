Received: from eggs.gnu.org ([2001:4830:134:3::10]:54604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1gG30e-0007SZ-B0
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:22:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1gG30a-0002QG-92
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:22:44 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:54272 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.markovic@rt-rk.com>)
	id 1gG30Y-0002L2-LB
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:22:40 -0400
From: Stefan Markovic <stefan.markovic@rt-rk.com>
Date: Fri, 26 Oct 2018 16:21:04 +0200
Message-Id: <1540563667-23300-4-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1540563667-23300-1-git-send-email-stefan.markovic@rt-rk.com>
References: <1540563667-23300-1-git-send-email-stefan.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 3/6] Extract MIPS abiflags from ELF file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, pjovanovic@wavecomp.com, riku.voipio@iki.fi, laurent@vivier.eu

From: Stefan Markovic <smarkovic@wavecomp.com>

Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 linux-user/elfload.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 055f6a9..5881233 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1517,11 +1517,25 @@ static void bswap_sym(struct elf_sym *sym)
     bswaptls(&sym->st_size);
     bswap16s(&sym->st_shndx);
 }
+
+#ifdef TARGET_MIPS
+static void bswap_mips_abiflags(Mips_elf_abiflags_v0 *abiflags)
+{
+    bswap16s(&abiflags->version);
+    bswap32s(&abiflags->ases);
+    bswap32s(&abiflags->isa_ext);
+    bswap32s(&abiflags->flags1);
+    bswap32s(&abiflags->flags2);
+}
+#endif
 #else
 static inline void bswap_ehdr(struct elfhdr *ehdr) { }
 static inline void bswap_phdr(struct elf_phdr *phdr, int phnum) { }
 static inline void bswap_shdr(struct elf_shdr *shdr, int shnum) { }
 static inline void bswap_sym(struct elf_sym *sym) { }
+#ifdef TARGET_MIPS
+static inline void bswap_mips_abiflags(Mips_elf_abiflags_v0 *abiflags) { }
+#endif
 #endif
 
 #ifdef USE_ELF_CORE_DUMP
@@ -2364,6 +2378,25 @@ static void load_elf_image(const char *image_name, int image_fd,
                 goto exit_errmsg;
             }
             *pinterp_name = interp_name;
+#ifdef TARGET_MIPS
+        } else if (eppnt->p_type == PT_MIPS_ABIFLAGS) {
+            Mips_elf_abiflags_v0 abiflags;
+            if (eppnt->p_filesz < sizeof(Mips_elf_abiflags_v0)) {
+                errmsg = "Invalid PT_MIPS_ABIFLAGS entry";
+                goto exit_errmsg;
+            }
+            if (eppnt->p_offset + eppnt->p_filesz <= BPRM_BUF_SIZE) {
+                memcpy(&abiflags, bprm_buf + eppnt->p_offset,
+                       sizeof(Mips_elf_abiflags_v0));
+            } else {
+                retval = pread(image_fd, &abiflags, sizeof(Mips_elf_abiflags_v0),
+                               eppnt->p_offset);
+                if (retval != sizeof(Mips_elf_abiflags_v0)) {
+                    goto exit_perror;
+                }
+            }
+            bswap_mips_abiflags(&abiflags);
+#endif
         }
     }
 
-- 
1.9.1
