Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEBDC18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:55:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25C2B20679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AXqD2tug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C2B20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDt1b-0003DT-87
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 12:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDsGa-00048r-2O
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:07:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDsGX-0007nz-T1
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:06:59 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:22709)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDsGX-0007mA-Ok
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584374817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dGhG21x/brBabH+9g/T50LsdW2AZT9lQa/ZmuQmYRQ4=;
 b=AXqD2tugI4Tsn2zG9QneSgw7jcj09LZbkgwZARX9KXNzAbPg7yPm8HdroyKmeCJ4WGbTgP
 yNbfFrd9+4E215dnxu0DUB2DVdicBZQxbeFEj9BVv9kjflYGHUfL0DkX/285ZokZnv7kJJ
 j7DFc9JcFlmqNXBAxSuL5Jwu506bmzg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-o5XWOx81NjCCbkZtuNet4Q-1; Mon, 16 Mar 2020 12:06:55 -0400
X-MC-Unique: o5XWOx81NjCCbkZtuNet4Q-1
Received: by mail-wr1-f69.google.com with SMTP id c6so9182040wrm.18
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 09:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=va3NBmW9VPeLqbh+njzNv2dIJgLWDq461h5IT9vGT6A=;
 b=B4IXl4fK0V0DkW5jI/uUDJ2f3zd6K7LsKvMUyUgTaVzcech9axy4wcqlwYlFXA28mf
 8JBsBUVx4YOzO+fcrP9sJS1PJsYQv/A/msif0IT+0+Hfx5p8ZvjT7enMiDEGwYKpdmSr
 wC/UyFBfaW8zAvGdR761W2COYWeauLpmvi973qRU5XfZMC2s49r+wfM2OaMmqDw/iFfD
 gXSxRctaFMaJlfjKEZnTwLHaTxJ1brHLNWlWO/3TKgj/6fy2LhIvSmv6KUVJ9+wuHKEt
 avXExhnREoq5/D+PUtXUEVsYmdmNRabh001WIYPY1m0jVBFWMHkQBo5WiQFmD34wg6U7
 qNTg==
X-Gm-Message-State: ANhLgQ0ZCKCYnBXGsvHqI8PFSgwPGP6mqE9HC8h5lBtYjAjyrIZX1JDi
 Qh9+25BIIY4zcUbB7ZFeoq/oVLLPOdLmVZq9HKyCreWKLZx85LfJfYdxcFSwwItQB+lJcjwITAQ
 WZiSHclEP/FPKunY=
X-Received: by 2002:adf:e28b:: with SMTP id v11mr59301wri.229.1584374813953;
 Mon, 16 Mar 2020 09:06:53 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsw+1a9QL9jAQlQpFFxDwzh9qiZwTfMeMpXHBQWjLbwXCSV+9K1X0BxvHZoZJuaTV1SZQZCVA==
X-Received: by 2002:adf:e28b:: with SMTP id v11mr59285wri.229.1584374813809;
 Mon, 16 Mar 2020 09:06:53 -0700 (PDT)
Received: from localhost.localdomain (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id b12sm483914wro.66.2020.03.16.09.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 09:06:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/19] target/arm: Restrict DC-CVAP instruction to TCG accel
Date: Mon, 16 Mar 2020 17:06:18 +0100
Message-Id: <20200316160634.3386-4-philmd@redhat.com>
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
X-Received-From: 63.128.21.74
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

Under KVM the 'Data or unified Cache line Clean by VA to PoP'
instruction will trap.

Fixes: 0d57b4999 ("Add support for DC CVAP & DC CVADP ins")
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/arm/helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index b61ee73d18..924deffd65 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6777,7 +6777,7 @@ static const ARMCPRegInfo rndr_reginfo[] =3D {
     REGINFO_SENTINEL
 };
=20
-#ifndef CONFIG_USER_ONLY
+#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
 static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *opaque,
                           uint64_t value)
 {
@@ -6820,9 +6820,9 @@ static const ARMCPRegInfo dcpodp_reg[] =3D {
       .accessfn =3D aa64_cacheop_poc_access, .writefn =3D dccvap_writefn }=
,
     REGINFO_SENTINEL
 };
-#endif /*CONFIG_USER_ONLY*/
+#endif /* !CONFIG_USER_ONLY && CONFIG_TCG */
=20
-#endif
+#endif /* TARGET_AARCH64 */
=20
 static CPAccessResult access_predinv(CPUARMState *env, const ARMCPRegInfo =
*ri,
                                      bool isread)
@@ -7929,7 +7929,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (cpu_isar_feature(aa64_rndr, cpu)) {
         define_arm_cp_regs(cpu, rndr_reginfo);
     }
-#ifndef CONFIG_USER_ONLY
+#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
     /* Data Cache clean instructions up to PoP */
     if (cpu_isar_feature(aa64_dcpop, cpu)) {
         define_one_arm_cp_reg(cpu, dcpop_reg);
@@ -7938,8 +7938,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             define_one_arm_cp_reg(cpu, dcpodp_reg);
         }
     }
-#endif /*CONFIG_USER_ONLY*/
-#endif
+#endif /* !CONFIG_USER_ONLY && CONFIG_TCG */
+#endif /* TARGET_AARCH64 */
=20
     if (cpu_isar_feature(any_predinv, cpu)) {
         define_arm_cp_regs(cpu, predinv_reginfo);
--=20
2.21.1


