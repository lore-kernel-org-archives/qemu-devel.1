Received: from eggs.gnu.org ([2001:4830:134:3::10]:37779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1gH82B-0003UH-Ed
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:56:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1gH828-0003IN-1A
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:56:47 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:44218 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.markovic@rt-rk.com>)
	id 1gH827-0002gQ-Pb
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:56:43 -0400
From: Stefan Markovic <stefan.markovic@rt-rk.com>
Date: Mon, 29 Oct 2018 14:55:13 +0100
Message-Id: <1540821315-28346-5-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1540821315-28346-1-git-send-email-stefan.markovic@rt-rk.com>
References: <1540821315-28346-1-git-send-email-stefan.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v2 4/6] Read and set FP ABI value from MIPS
 abiflags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, riku.voipio@iki.fi, laurent@vivier.eu

From: Stefan Markovic <smarkovic@wavecomp.com>

Set fp_abi and interp_fp_abi values to current fp_abi value read from
MIPS.abiflags.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 linux-user/elfload.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 5881233..5bccd2e 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2396,6 +2396,7 @@ static void load_elf_image(const char *image_name, int image_fd,
                 }
             }
             bswap_mips_abiflags(&abiflags);
+            info->fp_abi = abiflags.fp_abi;
 #endif
         }
     }
@@ -2708,6 +2709,9 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
             target_mmap(0, qemu_host_page_size, PROT_READ | PROT_EXEC,
                         MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
         }
+#ifdef TARGET_MIPS
+        info->interp_fp_abi = interp_info.fp_abi;
+#endif
     }
 
     bprm->p = create_elf_tables(bprm->p, bprm->argc, bprm->envc, &elf_ex,
-- 
1.9.1
