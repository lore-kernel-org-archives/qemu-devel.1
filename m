Received: from eggs.gnu.org ([209.51.188.92]:43109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grEw0-0001TS-91
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 23:35:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grEvz-0007UA-F5
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 23:35:40 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:34562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1grEvz-0007Jx-81
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 23:35:39 -0500
Received: by mail-wm1-x334.google.com with SMTP id y185so825485wmd.1
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 20:35:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Feb 2019 04:35:15 +0000
Message-Id: <20190206043516.11462-2-richard.henderson@linaro.org>
In-Reply-To: <20190206043516.11462-1-richard.henderson@linaro.org>
References: <20190206043516.11462-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 1/2] tcg: add early clober modifier in
 atomic16_cmpxchg on aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Catherine Ho <catherine.hecx@gmail.com>

From: Catherine Ho <catherine.hecx@gmail.com>

Without this patch, gcc might up the Input/Output registers and
cause unpredictable error.

Fixes: 1ec182c33379 ("target/arm: Convert to HAVE_CMPXCHG128")

Signed-off-by: Catherine Ho <catherine.hecx@gmail.com>
Message-Id: <1548838794-23757-1-git-send-email-catherine.hecx@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
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
2.17.2
