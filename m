Received: from eggs.gnu.org ([2001:4830:134:3::10]:44001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fhaOR-0004zU-5g
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 08:56:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fhaOO-0007d0-4d
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 08:56:51 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:41216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fhaON-0007ck-R8
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 08:56:48 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 23 Jul 2018 14:56:23 +0200
Message-Id: <20180723125624.18863-2-laurent@vivier.eu>
In-Reply-To: <20180723125624.18863-1-laurent@vivier.eu>
References: <20180723125624.18863-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 1/2] linux-user: fix ELF load alignment error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

When we try to use some targets on ppc64, it can happen the target
doesn't support the host page size to align ELF load sections and
fails with:

  ELF load command alignment not page-aligned

Since commit a70daba3771 ("linux-user: Tell guest about big host
page sizes") the host page size is used to align ELF sections, but
this doesn't work if the alignment required by the load section is
smaller than the host one.  For these cases, we continue to use the
TARGET_PAGE_SIZE instead of the host one.

I have tested this change on ppc64, and it fixes qemu linux-user for:
  s390x, m68k, i386, arm, aarch64, hppa
and I have tested it doesn't break the following targets:
  x86_64, mips64el, sh4
mips and mipsel abort, but I think for another reason.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
[lv: fixed "info->alignment = 0"]
Message-Id: <20180716195349.29959-1-laurent@vivier.eu>
---
 linux-user/elfload.c | 10 +++++++++-
 linux-user/qemu.h    |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 942a1b661f..df07055361 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1875,7 +1875,13 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     NEW_AUX_ENT(AT_PHDR, (abi_ulong)(info->load_addr + exec->e_phoff));
     NEW_AUX_ENT(AT_PHENT, (abi_ulong)(sizeof (struct elf_phdr)));
     NEW_AUX_ENT(AT_PHNUM, (abi_ulong)(exec->e_phnum));
-    NEW_AUX_ENT(AT_PAGESZ, (abi_ulong)(MAX(TARGET_PAGE_SIZE, getpagesize())));
+    if ((info->alignment & ~qemu_host_page_mask) != 0) {
+        /* Target doesn't support host page size alignment */
+        NEW_AUX_ENT(AT_PAGESZ, (abi_ulong)(TARGET_PAGE_SIZE));
+    } else {
+        NEW_AUX_ENT(AT_PAGESZ, (abi_ulong)(MAX(TARGET_PAGE_SIZE,
+                                               qemu_host_page_size)));
+    }
     NEW_AUX_ENT(AT_BASE, (abi_ulong)(interp_info ? interp_info->load_addr : 0));
     NEW_AUX_ENT(AT_FLAGS, (abi_ulong)0);
     NEW_AUX_ENT(AT_ENTRY, info->entry);
@@ -2202,6 +2208,7 @@ static void load_elf_image(const char *image_name, int image_fd,
     /* Find the maximum size of the image and allocate an appropriate
        amount of memory to handle that.  */
     loaddr = -1, hiaddr = 0;
+    info->alignment = 0;
     for (i = 0; i < ehdr->e_phnum; ++i) {
         if (phdr[i].p_type == PT_LOAD) {
             abi_ulong a = phdr[i].p_vaddr - phdr[i].p_offset;
@@ -2213,6 +2220,7 @@ static void load_elf_image(const char *image_name, int image_fd,
                 hiaddr = a;
             }
             ++info->nsegs;
+            info->alignment |= phdr[i].p_align;
         }
     }
 
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index bb85c81aa4..7b16a1cdea 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -51,6 +51,7 @@ struct image_info {
         abi_ulong       file_string;
         uint32_t        elf_flags;
 	int		personality;
+        abi_ulong       alignment;
 
         /* The fields below are used in FDPIC mode.  */
         abi_ulong       loadmap_addr;
-- 
2.17.1
