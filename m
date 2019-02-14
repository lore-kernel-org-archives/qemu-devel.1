Received: from eggs.gnu.org ([209.51.188.92]:54082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMLL-00084H-If
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMLK-0004uZ-Bf
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:43 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:38802)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guMLJ-0004qr-WA
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:42 -0500
Received: by mail-wr1-x436.google.com with SMTP id v13so7709922wrw.5
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 11:06:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	n184sm7798471wmf.5.2019.02.14.11.06.36 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 14 Feb 2019 11:06:36 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 19:06:02 +0000
Message-Id: <20190214190603.25030-27-peter.maydell@linaro.org>
In-Reply-To: <20190214190603.25030-1-peter.maydell@linaro.org>
References: <20190214190603.25030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 26/27] target/arm: Add missing clear_tail calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Fortunately, the functions affected are so far only called from SVE,
so there is no tail to be cleared.  But as we convert more of AdvSIMD
to gvec, this will matter.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190209033847.9014-13-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/vec_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 10f17e4b5cf..dfc635cf9a5 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -638,6 +638,7 @@ void HELPER(NAME)(void *vd, void *vn, void *stat, uint32_t desc)  \
     for (i = 0; i < oprsz / sizeof(TYPE); i++) {                  \
         d[i] = FUNC(n[i], stat);                                  \
     }                                                             \
+    clear_tail(d, oprsz, simd_maxsz(desc));                       \
 }
 
 DO_2OP(gvec_frecpe_h, helper_recpe_f16, float16)
@@ -688,6 +689,7 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *stat, uint32_t desc) \
     for (i = 0; i < oprsz / sizeof(TYPE); i++) {                           \
         d[i] = FUNC(n[i], m[i], stat);                                     \
     }                                                                      \
+    clear_tail(d, oprsz, simd_maxsz(desc));                                \
 }
 
 DO_3OP(gvec_fadd_h, float16_add, float16)
-- 
2.20.1
