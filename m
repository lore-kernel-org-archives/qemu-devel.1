Received: from eggs.gnu.org ([2001:4830:134:3::10]:59988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddVPo-00049b-65
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddVPn-0003pz-DS
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:52 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:33066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ddVPn-0003oc-8a
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:51 -0400
Received: by mail-pg0-x241.google.com with SMTP id u185so853984pgb.0
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 22:44:51 -0700 (PDT)
Received: from bigtime.twiddle.net (97-126-108-236.tukw.qwest.net.
	[97.126.108.236]) by smtp.gmail.com with ESMTPSA id
	o14sm1061063pfi.158.2017.08.03.22.44.49 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 03 Aug 2017 22:44:49 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  3 Aug 2017 22:44:25 -0700
Message-Id: <20170804054426.10590-23-rth@twiddle.net>
In-Reply-To: <20170804054426.10590-1-rth@twiddle.net>
References: <20170804054426.10590-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH for-2.11 22/23] tcg/ppc: Look for shifted
 constants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/ppc/tcg-target.inc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index bc14d2c9c6..4b32809217 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -598,6 +598,7 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
 {
     intptr_t tb_diff;
     int32_t high;
+    int lsb;
 
     tcg_debug_assert(TCG_TARGET_REG_BITS == 64 || type == TCG_TYPE_I32);
 
@@ -638,6 +639,14 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
         return;
     }
 
+    lsb = ctz64(arg);
+    high = arg >> lsb;
+    if (arg == (int16_t)arg) {
+        tcg_out32(s, ADDI | TAI(ret, 0, high));
+        tcg_out_shli64(s, ret, ret, lsb);
+        return;
+    }
+
     high = arg >> 31 >> 1;
     tcg_out_movi(s, TCG_TYPE_I32, ret, high);
     if (high) {
-- 
2.13.3
