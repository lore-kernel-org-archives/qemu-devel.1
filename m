Received: from eggs.gnu.org ([209.51.188.92]:49540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvydx-0005XA-9A
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvydw-0007Ae-6S
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:37 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:41296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gvydr-00076H-Hv
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:33 -0500
Received: by mail-lj1-x243.google.com with SMTP id z25so8553538ljk.8
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 22:12:22 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 18 Feb 2019 22:11:01 -0800
Message-Id: <20190219061111.10231-14-jcmvbkbc@gmail.com>
In-Reply-To: <20190219061111.10231-1-jcmvbkbc@gmail.com>
References: <20190219061111.10231-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 13/23] tests/tcg/xtensa: conditionalize and
 expand SR tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Make tests for specific special registers conditional on the presence of
the options that add these registers and test that the registers are not
accessible otherwise.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/test_sr.S | 133 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/tests/tcg/xtensa/test_sr.S b/tests/tcg/xtensa/test_sr.S
index 052f1e04a72c..e64653b8771e 100644
--- a/tests/tcg/xtensa/test_sr.S
+++ b/tests/tcg/xtensa/test_sr.S
@@ -42,50 +42,183 @@ test_end
     test_sr_mask    \sr, \conf, 7
 .endm
 
+#if XCHAL_HAVE_MAC16
 test_sr acchi, 1
 test_sr acclo, 1
+#else
+test_sr_mask /*acchi*/17, 0, 0
+test_sr_mask /*acclo*/16, 0, 0
+#endif
+
+#if XCHAL_HAVE_S32C1I && XCHAL_HW_VERSION >= 230000
+test_sr atomctl, 1
+#else
 test_sr_mask /*atomctl*/99, 0, 0
+#endif
+
+#if XCHAL_HAVE_BOOLEANS
+test_sr br, 1
+#else
 test_sr_mask /*br*/4, 0, 0
+#endif
+
 test_sr_mask /*cacheattr*/98, 0, 0
+
+#if XCHAL_HAVE_CCOUNT
 test_sr ccompare0, 1
 test_sr ccount, 1
+#else
+test_sr_mask /*ccompare0*/240, 0, 0
+test_sr_mask /*ccount*/234, 0, 0
+#endif
+
+#if XCHAL_HAVE_CP
 test_sr cpenable, 1
+#else
+test_sr_mask /*cpenable*/224, 0, 0
+#endif
+
+#if XCHAL_HAVE_DEBUG
+#if XCHAL_NUM_DBREAK
 test_sr dbreaka0, 1
 test_sr dbreakc0, 1
+#endif
 test_sr_mask debugcause, 1, 1
+#else
+test_sr_mask /*dbreaka0*/144, 0, 0
+test_sr_mask /*dbreakc0*/160, 0, 0
+test_sr_mask /*debugcause*/233, 0, 0
+#endif
+
 test_sr depc, 1
+
+#if XCHAL_HAVE_PTP_MMU
 test_sr dtlbcfg, 1
+#else
+test_sr_mask /*dtlbcfg*/92, 0, 0
+#endif
+
 test_sr epc1, 1
+
+#if XCHAL_NUM_INTLEVELS > 1
 test_sr epc2, 1
 test_sr eps2, 1
+#else
+test_sr_mask /*epc2*/178, 0, 0
+test_sr_mask /*eps2*/194, 0, 0
+#endif
+
 test_sr exccause, 1
 test_sr excsave1, 1
+
+#if XCHAL_NUM_INTLEVELS > 1
 test_sr excsave2, 1
+#else
+test_sr_mask /*excsave2*/210, 0, 0
+#endif
+
 test_sr excvaddr, 1
+
+#if XCHAL_HAVE_DEBUG
+#if XCHAL_NUM_IBREAK
 test_sr ibreaka0, 1
 test_sr ibreakenable, 1
+#endif
 test_sr icount, 1
 test_sr icountlevel, 1
+#else
+test_sr_mask /*ibreaka0*/128, 0, 0
+test_sr_mask /*ibreakenable*/96, 0, 0
+test_sr_mask /*icount*/236, 0, 0
+test_sr_mask /*icountlevel*/237, 0, 0
+#endif
+
 test_sr_mask /*intclear*/227, 0, 2
 test_sr_mask /*interrupt*/226, 0, 3
 test_sr intenable, 1
+
+#if XCHAL_HAVE_PTP_MMU
 test_sr itlbcfg, 1
+#else
+test_sr_mask /*itlbcfg*/91, 0, 0
+#endif
+
+#if XCHAL_HAVE_LOOPS
 test_sr lbeg, 1
 test_sr lcount, 1
 test_sr lend, 1
+#else
+test_sr_mask /*lbeg*/0, 0, 0
+test_sr_mask /*lcount*/2, 0, 0
+test_sr_mask /*lend*/1, 0, 0
+#endif
+
+#if XCHAL_HAVE_ABSOLUTE_LITERALS
 test_sr litbase, 1
+#else
+test_sr_mask /*litbase*/5, 0, 0
+#endif
+
+#if XCHAL_HAVE_MAC16
 test_sr m0, 1
+#else
+test_sr_mask /*m0*/32, 0, 0
+#endif
+
+#if XCHAL_HW_VERSION >= 250000
+test_sr_mask /*memctl*/97, 0, 7
+#else
 test_sr_mask /*memctl*/97, 0, 0
+#endif
+
+#if XCHAL_NUM_MISC_REGS
 test_sr misc0, 1
+#else
+test_sr_mask /*misc0*/244, 0, 0
+#endif
+
+#if XCHAL_HAVE_PREFETCH
+test_sr prefctl, 1
+#else
 test_sr_mask /*prefctl*/40, 0, 0
+#endif
+
+#if XCHAL_HAVE_PRID
 test_sr_mask /*prid*/235, 0, 1
+#else
+test_sr_mask /*prid*/235, 0, 0
+#endif
+
 test_sr ps, 1
+
+#if XCHAL_HAVE_PTP_MMU
 test_sr ptevaddr, 1
 test_sr rasid, 1
+#else
+test_sr_mask /*ptevaddr*/83, 0, 0
+test_sr_mask /*rasid*/90, 0, 0
+#endif
+
 test_sr sar, 1
+
+#if XCHAL_HAVE_S32C1I
 test_sr scompare1, 1
+#else
+test_sr_mask /*scompare1*/12, 0, 0
+#endif
+
+#if XCHAL_HAVE_VECBASE
 test_sr vecbase, 1
+#else
+test_sr_mask /*vecbase*/231, 0, 0
+#endif
+
+#if XCHAL_HAVE_WINDOWED
 test_sr windowbase, 1
 test_sr windowstart, 1
+#else
+test_sr_mask /*windowbase*/72, 0, 0
+test_sr_mask /*windowstart*/73, 0, 0
+#endif
 
 test_suite_end
-- 
2.11.0
