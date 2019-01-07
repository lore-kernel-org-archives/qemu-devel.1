Received: from eggs.gnu.org ([209.51.188.92]:45976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXoE-0004mG-QG
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXoD-0001Yv-30
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:26 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:37269)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggXoC-0001Xy-TC
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:25 -0500
Received: by mail-wm1-x32e.google.com with SMTP id g67so1518126wmd.2
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 08:31:24 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	j14sm46039759wrv.96.2019.01.07.08.31.22 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 07 Jan 2019 08:31:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  7 Jan 2019 16:30:42 +0000
Message-Id: <20190107163117.16269-3-peter.maydell@linaro.org>
In-Reply-To: <20190107163117.16269-1-peter.maydell@linaro.org>
References: <20190107163117.16269-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/37] target/arm: SVE brk[ab] merging does not
 have s bit
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

While brk[ab] zeroing has a flags setting option, the merging variant
does not.  Retain the same argument structure, to share expansion but
force the flag zero and do not decode bit 22.

Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181226215003.31438-1-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/sve.decode | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index e10b689454e..4f580a25e70 100644
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
2.19.2
