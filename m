Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4D4C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:26:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A435320674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zf0DNZHi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A435320674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtVK-0007YP-RE
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53561)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDsGe-0004Ap-Ag
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:07:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDsGd-0008DL-1G
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:07:04 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:39869)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDsGc-0008CR-T8
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584374822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j2NQUGK1oGWALaGzXfEtj8AM5490glkq1or09z6B8W8=;
 b=Zf0DNZHiVI4eFg98LAkhJz0J9cbICvHiZpIgeiQ5fXtSrrichYZ+Lcyzg1fRnNtlk7QRdS
 8Dt9TK/Sn0RkecrD1tTwHNf/rLpZybQ4Q8RSOQCJncrGDnDjIJ2FkI6Zmn9EybnAcIky65
 uAPpaqoDm5uZvQGAv3vPJDY0AVn517I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-iZVhGtFkMxiy6byJlrL-qg-1; Mon, 16 Mar 2020 12:07:01 -0400
X-MC-Unique: iZVhGtFkMxiy6byJlrL-qg-1
Received: by mail-wr1-f72.google.com with SMTP id v6so9173910wrg.22
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 09:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=x1weIqYNF3Fo5tV0WZvC7V944GYiMwvqowZHCwqs/e8=;
 b=rXzFifaKD0RQWuCwEmemOHWYgq8aQOmn/tlatIwMzKTNYa4dqoDggH1OUdJJs3tquB
 02g5kO1fX7E7Edid19wha/SK43PJE320k/qO/iborihh2az1yrpRccdC5orqGKqEWn8l
 704/azvHKZAtTuSVnMT8jKWOwvif2+NrjCCBzsFMIHdIEkfdupF/PA578hBYDldErPIi
 1Ef4VjT2ZjxnIDMi74JOfmBFr+2+YONI32hIbVFFBo3Rh0NoJ54+2Mt88W3VKdRgxCGQ
 zTiw1y5QMuZ2WRlS9em/HJOgw6pg7vv9qK4hkhaHEks2+ocGIeModriCaEpLBslMoyka
 Zjzg==
X-Gm-Message-State: ANhLgQ129fPiIgcAFGnC9yat1db4yeoeLhHHCbgojgcMXaxGEFOeUxp4
 dfG8+JHZpgBUvvgwud56CJCL+rc++gJ8RgpjWoFtj1ymvLuC7YzumaKAeo2nTV1LSCG66CudeJQ
 j0dyaljUTthotmLk=
X-Received: by 2002:a1c:6385:: with SMTP id
 x127mr28120927wmb.141.1584374819495; 
 Mon, 16 Mar 2020 09:06:59 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsfX0n8OJNrHnrM7slMemare5ZJPKg4uT9S5KNvko7zVE1qXAD/IK5hEDswewh2HAjGFyl3Zg==
X-Received: by 2002:a1c:6385:: with SMTP id
 x127mr28120897wmb.141.1584374819229; 
 Mon, 16 Mar 2020 09:06:59 -0700 (PDT)
Received: from localhost.localdomain (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id y5sm166058wmi.34.2020.03.16.09.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 09:06:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 04/19] target/arm: Restric the Address Translate operations
 to TCG accel
Date: Mon, 16 Mar 2020 17:06:19 +0100
Message-Id: <20200316160634.3386-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316160634.3386-1-philmd@redhat.com>
References: <20200316160634.3386-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Under KVM the ATS instruction will trap.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/arm/helper.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 924deffd65..a5280c091b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3322,7 +3322,7 @@ static void par_write(CPUARMState *env, const ARMCPRe=
gInfo *ri, uint64_t value)
     }
 }
=20
-#ifndef CONFIG_USER_ONLY
+#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
 /* get_phys_addr() isn't present for user-mode-only targets */
=20
 static CPAccessResult ats_access(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -3631,7 +3631,7 @@ static void ats_write64(CPUARMState *env, const ARMCP=
RegInfo *ri,
=20
     env->cp15.par_el[1] =3D do_ats_write(env, value, access_type, mmu_idx)=
;
 }
-#endif
+#endif /* !CONFIG_USER_ONLY && CONFIG_TCG */
=20
 static const ARMCPRegInfo vapa_cp_reginfo[] =3D {
     { .name =3D "PAR", .cp =3D 15, .crn =3D 7, .crm =3D 4, .opc1 =3D 0, .o=
pc2 =3D 0,
@@ -3639,7 +3639,7 @@ static const ARMCPRegInfo vapa_cp_reginfo[] =3D {
       .bank_fieldoffsets =3D { offsetoflow32(CPUARMState, cp15.par_s),
                              offsetoflow32(CPUARMState, cp15.par_ns) },
       .writefn =3D par_write },
-#ifndef CONFIG_USER_ONLY
+#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
     /* This underdecoding is safe because the reginfo is NO_RAW. */
     { .name =3D "ATS", .cp =3D 15, .crn =3D 7, .crm =3D 8, .opc1 =3D 0, .o=
pc2 =3D CP_ANY,
       .access =3D PL1_W, .accessfn =3D ats_access,
@@ -4880,7 +4880,8 @@ static const ARMCPRegInfo v8_cp_reginfo[] =3D {
       .opc0 =3D 1, .opc1 =3D 4, .crn =3D 8, .crm =3D 7, .opc2 =3D 6,
       .access =3D PL2_W, .type =3D ARM_CP_NO_RAW,
       .writefn =3D tlbi_aa64_alle1is_write },
-#ifndef CONFIG_USER_ONLY
+
+#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
     /* 64 bit address translation operations */
     { .name =3D "AT_S1E1R", .state =3D ARM_CP_STATE_AA64,
       .opc0 =3D 1, .opc1 =3D 0, .crn =3D 7, .crm =3D 8, .opc2 =3D 0,
@@ -4929,7 +4930,8 @@ static const ARMCPRegInfo v8_cp_reginfo[] =3D {
       .access =3D PL1_RW, .resetvalue =3D 0,
       .fieldoffset =3D offsetof(CPUARMState, cp15.par_el[1]),
       .writefn =3D par_write },
-#endif
+#endif /* !CONFIG_USER_ONLY && CONFIG_TCG */
+
     /* TLB invalidate last level of translation table walk */
     { .name =3D "TLBIMVALIS", .cp =3D 15, .opc1 =3D 0, .crn =3D 8, .crm =
=3D 3, .opc2 =3D 5,
       .type =3D ARM_CP_NO_RAW, .access =3D PL1_W, .accessfn =3D access_ttl=
b,
@@ -5536,7 +5538,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] =3D {
       .opc0 =3D 1, .opc1 =3D 4, .crn =3D 8, .crm =3D 3, .opc2 =3D 5,
       .access =3D PL2_W, .type =3D ARM_CP_NO_RAW,
       .writefn =3D tlbi_aa64_vae2is_write },
-#ifndef CONFIG_USER_ONLY
+#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
     /* Unlike the other EL2-related AT operations, these must
      * UNDEF from EL3 if EL2 is not implemented, which is why we
      * define them here rather than with the rest of the AT ops.
@@ -6992,7 +6994,7 @@ static const ARMCPRegInfo vhe_reginfo[] =3D {
     REGINFO_SENTINEL
 };
=20
-#ifndef CONFIG_USER_ONLY
+#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
 static const ARMCPRegInfo ats1e1_reginfo[] =3D {
     { .name =3D "AT_S1E1R", .state =3D ARM_CP_STATE_AA64,
       .opc0 =3D 1, .opc1 =3D 0, .crn =3D 7, .crm =3D 9, .opc2 =3D 0,
@@ -7894,14 +7896,14 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (cpu_isar_feature(aa64_pan, cpu)) {
         define_one_arm_cp_reg(cpu, &pan_reginfo);
     }
-#ifndef CONFIG_USER_ONLY
+#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
     if (cpu_isar_feature(aa64_ats1e1, cpu)) {
         define_arm_cp_regs(cpu, ats1e1_reginfo);
     }
     if (cpu_isar_feature(aa32_ats1e1, cpu)) {
         define_arm_cp_regs(cpu, ats1cp_reginfo);
     }
-#endif
+#endif /* !CONFIG_USER_ONLY && CONFIG_TCG */
     if (cpu_isar_feature(aa64_uao, cpu)) {
         define_one_arm_cp_reg(cpu, &uao_reginfo);
     }
--=20
2.21.1


