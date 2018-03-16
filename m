Received: from eggs.gnu.org ([2001:4830:134:3::10]:44196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ewmgu-0003Kz-8g
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 06:34:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ewmgr-0006o7-71
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 06:34:28 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:39824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ewmgr-0006nu-0u
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 06:34:25 -0400
Received: by mail-pl0-x241.google.com with SMTP id k22-v6so4813131pls.6
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 03:34:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 16 Mar 2018 18:34:08 +0800
Message-Id: <20180316103408.22295-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH] linux-user: Allocate extra space for brk in
 PIE executable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, 1749393@bugs.launchpad.net

Limit this to 16M; there does not appear to be any special
support for this in the kernel itself, at least for i686.

Fixes: https://bugs.launchpad.net/bugs/1749393
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

Commentary in the launchpad bug suggests 128M gap for x86_64, but that's
somewhat irrelevant to the given i686 test case.  There's certainly nothing
in the referenced kernel patch that does any more than we had been doing
without this patch.

I'm not sure what other limits on extra_size might we want to impose.
With -R set to something less than the full address space we could easily
wind up asking for more space than is available.


r~
---
 linux-user/elfload.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 9d10a5f592..e51d441fb9 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2055,7 +2055,15 @@ static void load_elf_image(const char *image_name, int image_fd,
            image is pre-linked, LOADDR will be non-zero.  Since we do
            not supply MAP_FIXED here we'll use that address if and
            only if it remains available.  */
-        load_addr = target_mmap(loaddr, hiaddr - loaddr, PROT_NONE,
+        abi_ulong total_size = hiaddr - loaddr;
+        if (pinterp_name != NULL) {
+            /* This is the main executable.
+             * Hack to reserve some extra space for brk.
+             */
+            abi_ulong extra_size = 16 * 1024 * 1024;
+            load_addr = mmap_find_vma(loaddr, total_size + extra_size);
+        }
+        load_addr = target_mmap(load_addr, total_size, PROT_NONE,
                                 MAP_PRIVATE | MAP_ANON | MAP_NORESERVE,
                                 -1, 0);
         if (load_addr == -1) {
-- 
2.14.3
