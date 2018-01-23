Received: from eggs.gnu.org ([2001:4830:134:3::10]:43602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1edzsC-0007G2-Dh
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:48:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1edzs7-0002X8-TX
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:48:28 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:52011)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1edzs7-0002W8-JI
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:48:23 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 23 Jan 2018 15:48:00 +0100
Message-Id: <20180123144807.5618-7-laurent@vivier.eu>
In-Reply-To: <20180123144807.5618-1-laurent@vivier.eu>
References: <20180123144807.5618-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 06/13] linux-user/mmap.c: Avoid choosing NULL as
 start address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Maximilian Riemensberger <riemensberger@cadami.net>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>

From: Maximilian Riemensberger <riemensberger@cadami.net>

mmap() is required by the linux kernel ABI and POSIX to return a
non-NULL address when the implementation chooses a start address for the
mapping.

The current implementation of mmap_find_vma_reserved() can return NULL
as start address of a mapping which leads to subsequent crashes inside
the guests glibc, e.g. output of qemu-arm-static --strace executing a
test binary stx_test:

    1879 mmap2(NULL,8388608,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS|0x20000,-1,0) = 0x00000000
    1879 write(2,0xf6fd39d0,79) stx_test: allocatestack.c:514: allocate_stack: Assertion `mem != NULL' failed.

This patch fixes mmap_find_vma_reserved() by skipping NULL as start
address while searching for a suitable mapping start address.

CC: Riku Voipio <riku.voipio@iki.fi>
CC: Laurent Vivier <laurent@vivier.eu>
CC: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Maximilian Riemensberger <riemensberger@cadami.net>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <1515286904-86418-1-git-send-email-riemensberger@cadami.net>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 4888f53139..0fbfd6dff2 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -234,7 +234,7 @@ static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong size)
         if (prot) {
             end_addr = addr;
         }
-        if (addr + size == end_addr) {
+        if (addr && addr + size == end_addr) {
             break;
         }
         addr -= qemu_host_page_size;
-- 
2.14.3
