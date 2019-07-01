Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85019C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:51:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E887214AE
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E887214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhwie-0008OW-M0
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 09:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40974)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hhwKb-00026L-Jv
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:26:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hhwKY-0002G4-J4
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:26:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48442)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hhwKD-0001wX-My; Mon, 01 Jul 2019 09:26:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4792730C5843;
 Mon,  1 Jul 2019 13:26:24 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A6616085B;
 Mon,  1 Jul 2019 13:26:21 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 15:25:03 +0200
Message-Id: <20190701132516.26392-15-philmd@redhat.com>
In-Reply-To: <20190701132516.26392-1-philmd@redhat.com>
References: <20190701132516.26392-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Mon, 01 Jul 2019 13:26:24 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 14/27] target/arm/vfp_helper: Move code
 around
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

To ease the review of the next commit,
move the vfp_exceptbits_to_host() function directly after
vfp_exceptbits_from_host().  Amusingly the diff shows we
are moving vfp_get_fpscr().

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/arm/vfp_helper.c | 52 ++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 121bdbd3af..d54e325324 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -55,32 +55,6 @@ static inline int vfp_exceptbits_from_host(int host_bi=
ts)
     return target_bits;
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
 /* Convert vfp exception flags to target form.  */
 static inline int vfp_exceptbits_to_host(int target_bits)
 {
@@ -107,6 +81,32 @@ static inline int vfp_exceptbits_to_host(int target_b=
its)
     return host_bits;
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
 void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
 {
     int i;
--=20
2.20.1


