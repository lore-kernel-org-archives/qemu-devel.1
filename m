Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F34C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:46:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7D38214AE
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:46:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D38214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58957 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhwde-00048t-Lz
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 09:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41045)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hhwKf-0002Bv-7d
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:27:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hhwKd-0002Lf-Hy
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:26:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59552)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hhwKI-000204-BL; Mon, 01 Jul 2019 09:26:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2A5013082231;
 Mon,  1 Jul 2019 13:26:29 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BCEC66085B;
 Mon,  1 Jul 2019 13:26:24 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 15:25:04 +0200
Message-Id: <20190701132516.26392-16-philmd@redhat.com>
In-Reply-To: <20190701132516.26392-1-philmd@redhat.com>
References: <20190701132516.26392-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Mon, 01 Jul 2019 13:26:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 15/27] target/arm/vfp_helper: Extract
 vfp_set_fpscr_to_host()
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
Cc: Yang Zhong <yang.zhong@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jones <drjones@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>,
 Rob Bradford <robert.bradford@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The vfp_set_fpscr() helper contains code specific to the host
floating point implementation (here the SoftFloat library).
Extract this code to vfp_set_fpscr_to_host().

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/arm/vfp_helper.c | 127 +++++++++++++++++++++-------------------
 1 file changed, 66 insertions(+), 61 deletions(-)

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index d54e325324..b19a395b67 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -81,71 +81,11 @@ static inline int vfp_exceptbits_to_host(int target_b=
its)
     return host_bits;
 }
=20
-uint32_t HELPER(vfp_get_fpscr)(CPUARMState *env)
-{
-    uint32_t i, fpscr;
-
-    fpscr =3D env->vfp.xregs[ARM_VFP_FPSCR]
-            | (env->vfp.vec_len << 16)
-            | (env->vfp.vec_stride << 20);
-
-    i =3D get_float_exception_flags(&env->vfp.fp_status);
-    i |=3D get_float_exception_flags(&env->vfp.standard_fp_status);
-    /* FZ16 does not generate an input denormal exception.  */
-    i |=3D (get_float_exception_flags(&env->vfp.fp_status_f16)
-          & ~float_flag_input_denormal);
-    fpscr |=3D vfp_exceptbits_from_host(i);
-
-    i =3D env->vfp.qc[0] | env->vfp.qc[1] | env->vfp.qc[2] | env->vfp.qc=
[3];
-    fpscr |=3D i ? FPCR_QC : 0;
-
-    return fpscr;
-}
-
-uint32_t vfp_get_fpscr(CPUARMState *env)
-{
-    return HELPER(vfp_get_fpscr)(env);
-}
-
-void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
+static void vfp_set_fpscr_to_host(CPUARMState *env, uint32_t val)
 {
     int i;
     uint32_t changed =3D env->vfp.xregs[ARM_VFP_FPSCR];
=20
-    /* When ARMv8.2-FP16 is not supported, FZ16 is RES0.  */
-    if (!cpu_isar_feature(aa64_fp16, env_archcpu(env))) {
-        val &=3D ~FPCR_FZ16;
-    }
-
-    if (arm_feature(env, ARM_FEATURE_M)) {
-        /*
-         * M profile FPSCR is RES0 for the QC, STRIDE, FZ16, LEN bits
-         * and also for the trapped-exception-handling bits IxE.
-         */
-        val &=3D 0xf7c0009f;
-    }
-
-    /*
-     * We don't implement trapped exception handling, so the
-     * trap enable bits, IDE|IXE|UFE|OFE|DZE|IOE are all RAZ/WI (not RES=
0!)
-     *
-     * If we exclude the exception flags, IOC|DZC|OFC|UFC|IXC|IDC
-     * (which are stored in fp_status), and the other RES0 bits
-     * in between, then we clear all of the low 16 bits.
-     */
-    env->vfp.xregs[ARM_VFP_FPSCR] =3D val & 0xf7c80000;
-    env->vfp.vec_len =3D (val >> 16) & 7;
-    env->vfp.vec_stride =3D (val >> 20) & 3;
-
-    /*
-     * The bit we set within fpscr_q is arbitrary; the register as a
-     * whole being zero/non-zero is what counts.
-     */
-    env->vfp.qc[0] =3D val & FPCR_QC;
-    env->vfp.qc[1] =3D 0;
-    env->vfp.qc[2] =3D 0;
-    env->vfp.qc[3] =3D 0;
-
     changed ^=3D val;
     if (changed & (3 << 22)) {
         i =3D (val >> 22) & 3;
@@ -193,6 +133,71 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_=
t val)
     set_float_exception_flags(0, &env->vfp.standard_fp_status);
 }
=20
+uint32_t HELPER(vfp_get_fpscr)(CPUARMState *env)
+{
+    uint32_t i, fpscr;
+
+    fpscr =3D env->vfp.xregs[ARM_VFP_FPSCR]
+            | (env->vfp.vec_len << 16)
+            | (env->vfp.vec_stride << 20);
+
+    i =3D get_float_exception_flags(&env->vfp.fp_status);
+    i |=3D get_float_exception_flags(&env->vfp.standard_fp_status);
+    /* FZ16 does not generate an input denormal exception.  */
+    i |=3D (get_float_exception_flags(&env->vfp.fp_status_f16)
+          & ~float_flag_input_denormal);
+    fpscr |=3D vfp_exceptbits_from_host(i);
+
+    i =3D env->vfp.qc[0] | env->vfp.qc[1] | env->vfp.qc[2] | env->vfp.qc=
[3];
+    fpscr |=3D i ? FPCR_QC : 0;
+
+    return fpscr;
+}
+
+uint32_t vfp_get_fpscr(CPUARMState *env)
+{
+    return HELPER(vfp_get_fpscr)(env);
+}
+
+void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
+{
+    /* When ARMv8.2-FP16 is not supported, FZ16 is RES0.  */
+    if (!cpu_isar_feature(aa64_fp16, env_archcpu(env))) {
+        val &=3D ~FPCR_FZ16;
+    }
+
+    if (arm_feature(env, ARM_FEATURE_M)) {
+        /*
+         * M profile FPSCR is RES0 for the QC, STRIDE, FZ16, LEN bits
+         * and also for the trapped-exception-handling bits IxE.
+         */
+        val &=3D 0xf7c0009f;
+    }
+
+    /*
+     * We don't implement trapped exception handling, so the
+     * trap enable bits, IDE|IXE|UFE|OFE|DZE|IOE are all RAZ/WI (not RES=
0!)
+     *
+     * If we exclude the exception flags, IOC|DZC|OFC|UFC|IXC|IDC
+     * (which are stored in fp_status), and the other RES0 bits
+     * in between, then we clear all of the low 16 bits.
+     */
+    env->vfp.xregs[ARM_VFP_FPSCR] =3D val & 0xf7c80000;
+    env->vfp.vec_len =3D (val >> 16) & 7;
+    env->vfp.vec_stride =3D (val >> 20) & 3;
+
+    /*
+     * The bit we set within fpscr_q is arbitrary; the register as a
+     * whole being zero/non-zero is what counts.
+     */
+    env->vfp.qc[0] =3D val & FPCR_QC;
+    env->vfp.qc[1] =3D 0;
+    env->vfp.qc[2] =3D 0;
+    env->vfp.qc[3] =3D 0;
+
+    vfp_set_fpscr_to_host(env, val);
+}
+
 void vfp_set_fpscr(CPUARMState *env, uint32_t val)
 {
     HELPER(vfp_set_fpscr)(env, val);
--=20
2.20.1


