Received: from eggs.gnu.org ([209.51.188.92]:34511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9ew-0004yH-8r
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9et-0006oJ-J0
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:41 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40638)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9et-0006Sz-9G
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:39 -0400
Received: by mail-wm1-x341.google.com with SMTP id h11so154063wmb.5
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:00:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.00.55
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:00:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 18:00:07 +0100
Message-Id: <20190429170030.11323-20-peter.maydell@linaro.org>
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 19/42] target/arm: Move NS TBFLAG from bit 19 to
 bit 6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Move the NS TBFLAG down from bit 19 to bit 6, which has not
been used since commit c1e3781090b9d36c60 in 2015, when we
started passing the entire MMU index in the TB flags rather
than just a 'privilege level' bit.

This rearrangement is not strictly necessary, but means that
we can put M-profile-only bits next to each other rather
than scattered across the flag word.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190416125744.27770-17-peter.maydell@linaro.org
---
 target/arm/cpu.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index eb989d773af..0ea448034b3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3138,6 +3138,12 @@ FIELD(TBFLAG_ANY, BE_DATA, 23, 1)
 FIELD(TBFLAG_A32, THUMB, 0, 1)
 FIELD(TBFLAG_A32, VECLEN, 1, 3)
 FIELD(TBFLAG_A32, VECSTRIDE, 4, 2)
+/*
+ * Indicates whether cp register reads and writes by guest code should access
+ * the secure or nonsecure bank of banked registers; note that this is not
+ * the same thing as the current security state of the processor!
+ */
+FIELD(TBFLAG_A32, NS, 6, 1)
 FIELD(TBFLAG_A32, VFPEN, 7, 1)
 FIELD(TBFLAG_A32, CONDEXEC, 8, 8)
 FIELD(TBFLAG_A32, SCTLR_B, 16, 1)
@@ -3145,11 +3151,6 @@ FIELD(TBFLAG_A32, SCTLR_B, 16, 1)
  * checks on the other bits at runtime
  */
 FIELD(TBFLAG_A32, XSCALE_CPAR, 17, 2)
-/* Indicates whether cp register reads and writes by guest code should access
- * the secure or nonsecure bank of banked registers; note that this is not
- * the same thing as the current security state of the processor!
- */
-FIELD(TBFLAG_A32, NS, 19, 1)
 /* For M profile only, Handler (ie not Thread) mode */
 FIELD(TBFLAG_A32, HANDLER, 21, 1)
 /* For M profile only, whether we should generate stack-limit checks */
-- 
2.20.1
