Received: from eggs.gnu.org ([2001:4830:134:3::10]:57890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riemensberger@cadami.net>) id 1eXzMC-0005Qu-Ql
	for qemu-devel@nongnu.org; Sat, 06 Jan 2018 20:02:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riemensberger@cadami.net>) id 1eXzM8-0004CO-Sv
	for qemu-devel@nongnu.org; Sat, 06 Jan 2018 20:02:36 -0500
Received: from dd7730.kasserver.com ([85.13.132.46]:54003)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <riemensberger@cadami.net>)
	id 1eXzM8-0004B3-LY
	for qemu-devel@nongnu.org; Sat, 06 Jan 2018 20:02:32 -0500
From: Maximilian Riemensberger <riemensberger@cadami.net>
Date: Sun,  7 Jan 2018 01:01:44 +0000
Message-Id: <1515286904-86418-1-git-send-email-riemensberger@cadami.net>
Subject: [Qemu-devel] [PATCH v2] linux-user/mmap.c: Avoid choosing NULL as
 start address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Maximilian Riemensberger <riemensberger@cadami.net>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>

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
---
Changes since v1:
    - Applied feedback from Laurent Vivier

 linux-user/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 4888f53..0fbfd6d 100644
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
2.7.4
