Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25591C4CECB
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 11:04:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E806E20693
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 11:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="dD38gU+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E806E20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8MuH-0002mD-RP
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 07:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33701)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1i8Mqz-0000X1-BQ
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:01:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luc.michel@greensocs.com>) id 1i8Mqu-0000MG-H0
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:01:33 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:60630)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luc.michel@greensocs.com>)
 id 1i8Mqn-0000JM-LQ; Thu, 12 Sep 2019 07:01:22 -0400
Received: from michell-laptop.bar.greensocs.com (tiramisu.bar.greensocs.com
 [172.16.11.100])
 by beetle.greensocs.com (Postfix) with ESMTPS id 140C396F52;
 Thu, 12 Sep 2019 11:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1568286079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=SoGtMzg2JWmal7gE8cNiZ3MQlpnmZ1oJXDY2sW1MAKQ=;
 b=dD38gU+LrqmHJ3h6WIoBZYd0DLISqDNCuZ22GOwPLTyo8c+svfyaRYqfs9a3SVz2BsbFw0
 WRb/EkY5HWXvaq6rQ1QwjbGxglPL+3t6W0Wmp+BPHoGsuHzdJm1nbGjpupUpSGw3aXLwwZ
 5a7EpojdbRG1L/fp4yKtmL5LcMb0h1U=
From: Luc Michel <luc.michel@greensocs.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Sep 2019 13:01:03 +0200
Message-Id: <20190912110103.1417887-1-luc.michel@greensocs.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1568286079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=SoGtMzg2JWmal7gE8cNiZ3MQlpnmZ1oJXDY2sW1MAKQ=;
 b=AGtfQn0/utmegaFxkDJCOmKATRu+cIP82ROdtzTle5cDpSLyFx8andpYMXxLZxsJgSYRQv
 cga7vF0zGAH64F447FqrQGDH0K8z6YirEvEP44RkC4ZZlBFnnImqeNuwWr45JuIL8Y0CBK
 1BmpB2BvTiNmszwQX3h/xfiir4mVtsM=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1568286079; a=rsa-sha256; cv=none;
 b=KCMuro2cm4jmnt4CRUQpA9VSNw3dsXR/AKnEkNQ3IqgkjPuYmXEjnApXhfGIXnBreyV+iL
 PWwAMgNekctRdXPjwv/8CNlUPdpZHnKYcLR2m5f3hSI3LWXVAuiwh3EC13xznekm09uOTI
 83IwtG5XUVta7iUx8vY8jIy7jckdYUk=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [PATCH] target/arm: fix CBAR register for AArch64 CPUs
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
Cc: Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For AArch64 CPUs with a CBAR register, we have two views for it:
  - in AArch64 state, the CBAR_EL1 register (S3_1_C15_C3_0), returns the
    full 64 bits CBAR value
  - in AArch32 state, the CBAR register (cp15, opc1=3D1, CRn=3D15, CRm=3D=
3, opc2=3D0)
    returns a 32 bits view such that:
      CBAR =3D CBAR_EL1[31:18] 0..0 CBAR_EL1[43:32]

This commit fixes the current implementation where:
  - CBAR_EL1 was returning the 32 bits view instead of the full 64 bits
    value,
  - CBAR was returning a truncated 32 bits version of the full 64 bits
    one, instead of the 32 bits view
  - CBAR was declared as cp15, opc1=3D4, CRn=3D15, CRm=3D0, opc2=3D0, whi=
ch is
    the CBAR register found in the ARMv7 Cortex-Ax CPUs, but not in
    ARMv8 CPUs.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
---
 target/arm/helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 507026c915..755aa18a2d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6740,12 +6740,12 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             ARMCPRegInfo cbar_reginfo[] =3D {
                 { .name =3D "CBAR",
                   .type =3D ARM_CP_CONST,
-                  .cp =3D 15, .crn =3D 15, .crm =3D 0, .opc1 =3D 4, .opc=
2 =3D 0,
-                  .access =3D PL1_R, .resetvalue =3D cpu->reset_cbar },
+                  .cp =3D 15, .crn =3D 15, .crm =3D 3, .opc1 =3D 1, .opc=
2 =3D 0,
+                  .access =3D PL1_R, .resetvalue =3D cbar32 },
                 { .name =3D "CBAR_EL1", .state =3D ARM_CP_STATE_AA64,
                   .type =3D ARM_CP_CONST,
                   .opc0 =3D 3, .opc1 =3D 1, .crn =3D 15, .crm =3D 3, .op=
c2 =3D 0,
-                  .access =3D PL1_R, .resetvalue =3D cbar32 },
+                  .access =3D PL1_R, .resetvalue =3D cpu->reset_cbar },
                 REGINFO_SENTINEL
             };
             /* We don't implement a r/w 64 bit CBAR currently */
--=20
2.23.0


