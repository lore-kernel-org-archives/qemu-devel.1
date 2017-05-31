Received: from eggs.gnu.org ([2001:4830:134:3::10]:39357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dGBgd-00017G-N0
	for qemu-devel@nongnu.org; Wed, 31 May 2017 18:01:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dGBgb-0005UU-NV
	for qemu-devel@nongnu.org; Wed, 31 May 2017 18:01:51 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:34994)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dGBgb-0005Lv-9t
	for qemu-devel@nongnu.org; Wed, 31 May 2017 18:01:49 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Thu,  1 Jun 2017 00:01:18 +0200
Message-Id: <20170531220129.27724-20-aurelien@aurel32.net>
In-Reply-To: <20170531220129.27724-1-aurelien@aurel32.net>
References: <20170531220129.27724-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH v3 19/30] target/s390x: fix adj_len_to_page
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

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/s390x/mem_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index aaa347c121..6dfa087ff1 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -61,7 +61,7 @@ static inline uint32_t adj_len_to_page(uint32_t len, uint64_t addr)
 {
 #ifndef CONFIG_USER_ONLY
     if ((addr & ~TARGET_PAGE_MASK) + len - 1 >= TARGET_PAGE_SIZE) {
-        return -addr & ~TARGET_PAGE_MASK;
+        return -(addr | TARGET_PAGE_MASK);
     }
 #endif
     return len;
-- 
2.11.0
