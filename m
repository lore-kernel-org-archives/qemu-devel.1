Received: from eggs.gnu.org ([208.118.235.92]:56902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gcH4P-0007ec-Ma
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 16:50:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gcH4M-0006nu-Ef
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 16:50:29 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:35506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gcH4M-0006d8-6c
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 16:50:26 -0500
Received: by mail-pl1-x642.google.com with SMTP id p8so7961190plo.2
	for <qemu-devel@nongnu.org>; Wed, 26 Dec 2018 13:50:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 27 Dec 2018 08:50:03 +1100
Message-Id: <20181226215003.31438-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH] target/arm: SVE brk[ab] merging does not have
 s bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

While brk[ab] zeroing has a flags setting option, the merging variant
does not.  Retain the same argument structure, to share expansion but
force the flag zero and do not decode bit 22.

Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

The xml from which Alex and I extracted risu test cases does not call
out bit 22 as a field, so we did not test this illegal encoding.


r~

---
 target/arm/sve.decode | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index e10b689454..4f580a25e7 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -99,6 +99,7 @@
 
 # Two operand with governing predicate, flags setting
 @pd_pg_pn_s     ........ . s:1 ...... .. pg:4 . rn:4 . rd:4     &rpr_s
+@pd_pg_pn_s0    ........ . .   ...... .. pg:4 . rn:4 . rd:4     &rpr_s s=0
 
 # Three operand with unused vector element size
 @rd_rn_rm_e0    ........ ... rm:5 ... ... rn:5 rd:5             &rrr_esz esz=0
@@ -667,8 +668,8 @@ BRKPB           00100101 0. 00 .... 11 .... 0 .... 1 ....       @pd_pg_pn_pm_s
 # SVE partition break condition
 BRKA_z          00100101 0. 01000001 .... 0 .... 0 ....         @pd_pg_pn_s
 BRKB_z          00100101 1. 01000001 .... 0 .... 0 ....         @pd_pg_pn_s
-BRKA_m          00100101 0. 01000001 .... 0 .... 1 ....         @pd_pg_pn_s
-BRKB_m          00100101 1. 01000001 .... 0 .... 1 ....         @pd_pg_pn_s
+BRKA_m          00100101 00 01000001 .... 0 .... 1 ....         @pd_pg_pn_s0
+BRKB_m          00100101 10 01000001 .... 0 .... 1 ....         @pd_pg_pn_s0
 
 # SVE propagate break to next partition
 BRKN            00100101 0. 01100001 .... 0 .... 0 ....         @pd_pg_pn_s
-- 
2.17.2
