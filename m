Received: from eggs.gnu.org ([209.51.188.92]:34736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNfQ-0004y1-Ob
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNfN-0001Ph-P6
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:27 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36439)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGNfL-0001Na-Mv
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:25 -0400
Received: by mail-wr1-x442.google.com with SMTP id y13so26979473wrd.3
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 05:58:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Apr 2019 13:57:34 +0100
Message-Id: <20190416125744.27770-17-peter.maydell@linaro.org>
In-Reply-To: <20190416125744.27770-1-peter.maydell@linaro.org>
References: <20190416125744.27770-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 16/26] target/arm: Move NS TBFLAG from bit 19
 to bit 6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org

Move the NS TBFLAG down from bit 19 to bit 6, which has not
been used since commit c1e3781090b9d36c60 in 2015, when we
started passing the entire MMU index in the TB flags rather
than just a 'privilege level' bit.

This rearrangement is not strictly necessary, but means that
we can put M-profile-only bits next to each other rather
than scattered across the flag word.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 0e0cb6b2271..c436f628987 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3139,6 +3139,12 @@ FIELD(TBFLAG_ANY, BE_DATA, 23, 1)
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
@@ -3146,11 +3152,6 @@ FIELD(TBFLAG_A32, SCTLR_B, 16, 1)
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
