Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CFEC3B1BF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 02:52:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0740E20857
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 02:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0740E20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3WWE-0001Wj-5W
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 21:52:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44075)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j3WUg-0008My-71
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 21:50:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j3WUe-0000nz-MQ
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 21:50:46 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:40733)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1j3WUe-0000n2-GC; Sun, 16 Feb 2020 21:50:44 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 4A38E747E01;
 Mon, 17 Feb 2020 03:50:43 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2789F747DF8; Mon, 17 Feb 2020 03:50:43 +0100 (CET)
Message-Id: <01eddb5c1639ab2dfb744b3515f9b907afcbb056.1581904461.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1581904461.git.balaton@eik.bme.hu>
References: <cover.1581904461.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Mon, 17 Feb 2020 02:19:20 +0100
Subject: [RFC PATCH 2/2] target/ppc: Enable hardfloat for PPC
To: qemu-devel@nongnu.org
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 John Arbuckle <programmingkidx@gmail.com>, qemu-ppc@nongnu.org,
 Paul Clarke <pc@us.ibm.com>, Howard Spoelstra <hsp.cat7@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While other targets take advantage of using host FPU to do floating
point computations, this was disabled for PPC target because always
clearing exception flags before every FP op made it slightly slower
than emulating everyting with softfloat. To emulate some FPSCR bits,
clearing of fp_status may be necessary (unless these could be handled
e.g. using FP exceptions on host but there's no API for that in QEMU
yet) but preserving at least the inexact flag makes hardfloat usable
and faster than softfloat. Since most clients don't actually care
about this flag, we can gain some speed trading some emulation
accuracy.

This patch implements a simple way to keep the inexact flag set for
hardfloat while still allowing to revert to softfloat for workloads
that need more accurate albeit slower emulation. (Set hardfloat
property of CPU, i.e. -cpu name,hardfloat=false for that.) There are
still more places where flags are reset so there is place for further
improvement. Also having a conditional to test for the hardfloat flag
every time makes the softfloat case slower than before this patch so
some other way (like setting a function pointer once and use that
instead if possible) may be needed to avoid this otherwise this patch
only makes sense if the default is also set to enable hardfloat.

Because of the above this patch at the moment is mainly for testing
different workloads to evaluate how viable would this be in practice.
Thus, RFC and not ready for merge yet.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 fpu/softfloat.c                 | 14 +++++++-------
 target/ppc/fpu_helper.c         |  7 ++++++-
 target/ppc/translate_init.inc.c |  2 +-
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 301ce3b537..6d3f4af72a 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -216,15 +216,15 @@ GEN_INPUT_FLUSH3(float64_input_flush3, float64)
 #endif
 
 /*
- * Some targets clear the FP flags before most FP operations. This prevents
- * the use of hardfloat, since hardfloat relies on the inexact flag being
- * already set.
+ * Disable hardfloat for known problem cases.
+ * Additionally, some targets clear the FP flags before most FP operations.
+ * This prevents the use of hardfloat, since it relies on the inexact flag
+ * being already set and clearing it often may result in slower computations.
+ * Those targets could also be listed here.
  */
-#if defined(TARGET_PPC) || defined(__FAST_MATH__)
-# if defined(__FAST_MATH__)
-#  warning disabling hardfloat due to -ffast-math: hardfloat requires an exact \
+#if defined(__FAST_MATH__)
+# warning disabling hardfloat due to -ffast-math: hardfloat requires an exact \
     IEEE implementation
-# endif
 # define QEMU_NO_HARDFLOAT 1
 # define QEMU_SOFTFLOAT_ATTR QEMU_FLATTEN
 #else
diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index ae43b08eb5..33aa977970 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -659,7 +659,12 @@ void helper_float_check_status(CPUPPCState *env)
 
 void helper_reset_fpstatus(CPUPPCState *env)
 {
-    set_float_exception_flags(0, &env->fp_status);
+    if (env->hardfloat) {
+        /* hardfloat needs inexact flag already set, clear only others */
+        set_float_exception_flags(float_flag_inexact, &env->fp_status);
+    } else {
+        set_float_exception_flags(0, &env->fp_status);
+    }
 }
 
 static void float_invalid_op_addsub(CPUPPCState *env, bool set_fpcc,
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index d6e1d66bc8..caac0c2d11 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -10869,7 +10869,7 @@ static Property ppc_cpu_properties[] = {
                      false),
     DEFINE_PROP_BOOL("pre-3.0-migration", PowerPCCPU, pre_3_0_migration,
                      false),
-    DEFINE_PROP_BOOL("hardfloat", PowerPCCPU, hardfloat, false),
+    DEFINE_PROP_BOOL("hardfloat", PowerPCCPU, hardfloat, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.21.1


