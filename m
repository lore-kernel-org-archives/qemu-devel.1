Received: from eggs.gnu.org ([2001:4830:134:3::10]:54463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fb8by-0000Ut-Hg
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:04:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fb8bv-0004yA-EN
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:04:10 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:46180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fb8bv-0004xd-0B
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:04:07 -0400
Received: by mail-pf0-x242.google.com with SMTP id l123-v6so6091363pfl.13
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 11:04:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  5 Jul 2018 11:04:03 -0700
Message-Id: <20180705180403.11928-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [RFC] target/arm: Suppress Coverity warning for PRF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, armbru@redhat.com, pbonzini@redhat.com

These instructions must perform the sve_access_check, but
since they are implemented as NOPs there is no generated
code to elide when the access check fails.

Fixes: Coverity issues 1393780 & 1393779.
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

Does anyone know if this actually works for Coverity?
I'd hate to churn the code without knowing.

---
 target/arm/translate-sve.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index c080345b9c..d41f1155f9 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -5164,7 +5164,7 @@ static bool trans_ST1_zpiz(DisasContext *s, arg_ST1_zpiz *a, uint32_t insn)
 static bool trans_PRF(DisasContext *s, arg_PRF *a, uint32_t insn)
 {
     /* Prefetch is a nop within QEMU.  */
-    sve_access_check(s);
+    (void)sve_access_check(s);
     return true;
 }
 
@@ -5174,7 +5174,7 @@ static bool trans_PRF_rr(DisasContext *s, arg_PRF_rr *a, uint32_t insn)
         return false;
     }
     /* Prefetch is a nop within QEMU.  */
-    sve_access_check(s);
+    (void)sve_access_check(s);
     return true;
 }
 
-- 
2.17.1
