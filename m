Received: from eggs.gnu.org ([209.51.188.92]:45276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1gooLR-0002i8-SW
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 06:47:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1gooLQ-00032y-WE
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 06:47:53 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:42859)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <catherine.hecx@gmail.com>)
	id 1gooLQ-0002xa-Mk
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 06:47:52 -0500
Received: by mail-pg1-x544.google.com with SMTP id d72so10224756pga.9
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 03:47:43 -0800 (PST)
From: Catherine Ho <catherine.hecx@gmail.com>
Date: Wed, 30 Jan 2019 06:43:26 -0500
Message-Id: <1548848606-23864-1-git-send-email-catherine.hecx@gmail.com>
Subject: [Qemu-devel] [PATCH RESEND] tcg: add early clober modifier in
 atomic16_cmpxchg on aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Catherine Ho <catherine.hecx@gmail.com>

Without this patch, gcc might mess up the Input/Output registers and
cause unpredictable error.

Fixes: 1ec182c33379 ("target/arm: Convert to HAVE_CMPXCHG128")

Signed-off-by: Catherine Ho <catherine.hecx@gmail.com>
---
Resend: sent previous patch before subscribing maillist

 include/qemu/atomic128.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/atomic128.h b/include/qemu/atomic128.h
index a6af22ff10..ddd0d55d31 100644
--- a/include/qemu/atomic128.h
+++ b/include/qemu/atomic128.h
@@ -68,7 +68,7 @@ static inline Int128 atomic16_cmpxchg(Int128 *ptr, Int128 cmp, Int128 new)
         "cbnz %w[tmp], 0b\n"
         "1:"
         : [mem] "+m"(*ptr), [tmp] "=&r"(tmp),
-          [oldl] "=&r"(oldl), [oldh] "=r"(oldh)
+          [oldl] "=&r"(oldl), [oldh] "=&r"(oldh)
         : [cmpl] "r"(cmpl), [cmph] "r"(cmph),
           [newl] "r"(newl), [newh] "r"(newh)
         : "memory", "cc");
-- 
2.17.1
