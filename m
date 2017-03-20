Received: from eggs.gnu.org ([2001:4830:134:3::10]:41184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qp-0001oB-2p
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qk-00052e-8N
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40051
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qk-000520-2n
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:38 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8WLD028679
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:37 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29amb5t7c6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:37 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 19:09:36 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:08:14 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-51-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 50/81] tcg/aarch64: Fix addsub2 for 0+C
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

When al == xzr, we cannot use addi/subi because that encodes xsp.
Force a zero into the temp register for that (rare) case.

Signed-off-by: Richard Henderson <rth@twiddle.net>
Message-Id: <20161207180727.6286-2-rth@twiddle.net>
(cherry picked from commit b1eb20da625897244e9621dabcf63d899deca54d)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tcg/aarch64/tcg-target.inc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 1939d35..6c68681 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -965,6 +965,15 @@ static inline void tcg_out_addsub2(TCGContext *s, int ext, TCGReg rl,
             insn = I3401_SUBSI;
             bl = -bl;
         }
+        if (unlikely(al == TCG_REG_XZR)) {
+            /* ??? We want to allow al to be zero for the benefit of
+               negation via subtraction.  However, that leaves open the
+               possibility of adding 0+const in the low part, and the
+               immediate add instructions encode XSP not XZR.  Don't try
+               anything more elaborate here than loading another zero.  */
+            al = TCG_REG_TMP;
+            tcg_out_movi(s, ext, al, 0);
+        }
         tcg_out_insn_3401(s, insn, ext, rl, al, bl);
     } else {
         tcg_out_insn_3502(s, sub ? I3502_SUBS : I3502_ADDS, ext, rl, al, bl);
-- 
2.7.4
