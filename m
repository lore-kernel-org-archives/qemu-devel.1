Received: from eggs.gnu.org ([2001:4830:134:3::10]:47736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCb3B-0002WC-Ry
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 21:55:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCb3B-00071U-39
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 21:55:05 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:35131)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gCb3A-0006zx-NJ
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 21:55:04 -0400
Received: by mail-pl1-x643.google.com with SMTP id f8-v6so11891485plb.2
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 18:55:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 16 Oct 2018 18:54:56 -0700
Message-Id: <20181017015456.3293-4-richard.henderson@linaro.org>
In-Reply-To: <20181017015456.3293-1-richard.henderson@linaro.org>
References: <20181017015456.3293-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 3/3] linux-user: Align mmap_find_vma to host
 page size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu

This can avoid stack allocation failures for i386 guest
on ppc64 (64k page) host.

Suggested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 47950ee9d7..735bc928fe 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -262,6 +262,8 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
     abi_ulong addr;
     int wrapped, repeat;
 
+    align = MAX(align, qemu_host_page_size);
+
     /* If 'start' == 0, then a default start address is used. */
     if (start == 0) {
         start = mmap_next_start;
-- 
2.17.2
