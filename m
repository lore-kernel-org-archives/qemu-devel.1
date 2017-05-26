Received: from eggs.gnu.org ([2001:4830:134:3::10]:60833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dE3Av-0003Hc-Pp
	for qemu-devel@nongnu.org; Thu, 25 May 2017 20:32:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dE3Au-0007cg-TF
	for qemu-devel@nongnu.org; Thu, 25 May 2017 20:32:17 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:38692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dE3Au-0007ca-N2
	for qemu-devel@nongnu.org; Thu, 25 May 2017 20:32:16 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Fri, 26 May 2017 02:32:07 +0200
Message-Id: <20170526003207.3101-1-aurelien@aurel32.net>
In-Reply-To: <20170525210508.4910-1-aurelien@aurel32.net>
References: <20170525210508.4910-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH 27/26] target/s390x: fix adj_len_to_page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

adj_len_to_page doesn't return the correct result when the address
is already page aligned and the length is bigger than a page. Fix that.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/s390x/mem_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

The patch 17 (improve MOVE LONG and MOVE LONG EXTENDED) triggered a bug
in adj_len_to_page. This is the fix, I just didn't want to respin the
series just for that.

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 6add413531..7841808fa2 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -61,7 +61,7 @@ static inline uint32_t adj_len_to_page(uint32_t len, uint64_t addr)
 {
 #ifndef CONFIG_USER_ONLY
     if ((addr & ~TARGET_PAGE_MASK) + len - 1 >= TARGET_PAGE_SIZE) {
-        return -addr & ~TARGET_PAGE_MASK;
+        return (~addr & ~TARGET_PAGE_MASK) + 1;
     }
 #endif
     return len;
-- 
2.11.0
