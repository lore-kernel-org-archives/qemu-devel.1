Received: from eggs.gnu.org ([2001:4830:134:3::10]:34407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOtt-0003b6-KB
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOtq-0002GL-Az
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:41 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:34084)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dIOtq-0002GG-6i
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:38 -0400
Received: by mail-qt0-x242.google.com with SMTP id o21so22863108qtb.1
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 17:32:38 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  6 Jun 2017 17:31:05 -0700
Message-Id: <20170607003119.14778-57-rth@twiddle.net>
In-Reply-To: <20170607003119.14778-1-rth@twiddle.net>
References: <20170607003119.14778-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL v2 56/70] target/s390x: fix adj_len_to_page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, aurelien@aurel32.net

From: Aurelien Jarno <aurelien@aurel32.net>

adj_len_to_page doesn't return the correct result when the address
is already page aligned and the length is bigger than a page. Fix that.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Message-Id: <20170531220129.27724-20-aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/mem_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 4ed0b65..2326f0b 100644
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
2.9.4
