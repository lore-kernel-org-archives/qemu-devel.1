Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484D4C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:03:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B3D22072C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B3D22072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCkuZ-0001uA-8Y
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 10:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42834)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <remi@remlab.net>) id 1jCkrb-0005b2-B7
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:00:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <remi@remlab.net>) id 1jCkrZ-00015j-PM
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:00:35 -0400
Received: from poy.remlab.net ([2001:41d0:2:5a1a::]:49726
 helo=ns207790.ip-94-23-215.eu) by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <remi@remlab.net>)
 id 1jCkrV-0000do-KU; Fri, 13 Mar 2020 10:00:29 -0400
Received: from basile.remlab.net (ip6-localhost [IPv6:::1])
 by ns207790.ip-94-23-215.eu (Postfix) with ESMTP id B2F3E5FD7F;
 Fri, 13 Mar 2020 15:00:24 +0100 (CET)
From: =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>
To: qemu-arm@nongnu.org
Subject: [PATCH 3/5] target/arm: MTE unprivileged system mode disassembly
Date: Fri, 13 Mar 2020 16:00:21 +0200
Message-Id: <20200313140023.83844-3-remi@remlab.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:41d0:2:5a1a::
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: R=C3=A9mi Denis-Courmont <remi.denis.courmont@huawei.com>

This adds the MTE instructions that conditionally available at EL0,
but undefined in Linux user mode.

Signed-off-by: R=C3=A9mi Denis-Courmont <remi.denis.courmont@huawei.com>
---
 target/arm/helper.c | 56 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ed56198623..dd64fcb4ef 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6837,6 +6837,18 @@ static const ARMCPRegInfo dcpodp_reg[] =3D {
       .accessfn =3D aa64_cacheop_poc_access, .writefn =3D dccvap_writefn=
 },
     REGINFO_SENTINEL
 };
+
+static const ARMCPRegInfo mte_dcpodp_reginfo[] =3D {
+    { .name =3D "DC_CGVADP", .state =3D ARM_CP_STATE_AA64,
+      .opc0 =3D 1, .opc1 =3D 3, .crn =3D 7, .crm =3D 13, .opc2 =3D 3,
+      .access =3D PL0_W, .type =3D ARM_CP_NO_RAW | ARM_CP_SUPPRESS_TB_EN=
D,
+      .accessfn =3D aa64_cacheop_poc_access, .writefn =3D dccvap_writefn=
 },
+    { .name =3D "DC_CGDVADP", .state =3D ARM_CP_STATE_AA64,
+      .opc0 =3D 1, .opc1 =3D 3, .crn =3D 7, .crm =3D 13, .opc2 =3D 5,
+      .access =3D PL0_W, .type =3D ARM_CP_NO_RAW | ARM_CP_SUPPRESS_TB_EN=
D,
+      .accessfn =3D aa64_cacheop_poc_access, .writefn =3D dccvap_writefn=
 },
+    REGINFO_SENTINEL
+};
 #endif /*CONFIG_USER_ONLY*/
=20
 static uint64_t tco_read(CPUARMState *env, const ARMCPRegInfo *ri)
@@ -6856,10 +6868,44 @@ static void tco_write(CPUARMState *env, const ARM=
CPRegInfo *ri, uint64_t val)
 static const ARMCPRegInfo mte_reginfo[] =3D {
     { .name =3D "DC_GVA", .state =3D ARM_CP_STATE_AA64,
       .opc0 =3D 1, .opc1 =3D 3, .crn =3D 7, .crm =3D 4, .opc2 =3D 3,
-      .access =3D PL0_W, .type =3D ARM_CP_NOP },
+      .access =3D PL0_W, .type =3D ARM_CP_NOP,
+#ifndef CONFIG_USER_ONLY
+      .accessfn =3D aa64_zva_access,
+#endif
+    },
     { .name =3D "DC_GZVA", .state =3D ARM_CP_STATE_AA64,
       .opc0 =3D 1, .opc1 =3D 3, .crn =3D 7, .crm =3D 4, .opc2 =3D 4,
-      .access =3D PL0_W, .type =3D ARM_CP_DC_ZVA },
+      .access =3D PL0_W, .type =3D ARM_CP_DC_ZVA,
+#ifndef CONFIG_USER_ONLY
+      .accessfn =3D aa64_zva_access,
+#endif
+    },
+    { .name =3D "DC_CGVAC", .state =3D ARM_CP_STATE_AA64,
+      .opc0 =3D 1, .opc1 =3D 3, .crn =3D 7, .crm =3D 10, .opc2 =3D 3,
+      .access =3D PL0_W, .type =3D ARM_CP_NOP,
+      .accessfn =3D aa64_cacheop_poc_access },
+    { .name =3D "DC_CGDVAC", .state =3D ARM_CP_STATE_AA64,
+      .opc0 =3D 1, .opc1 =3D 3, .crn =3D 7, .crm =3D 10, .opc2 =3D 5,
+      .access =3D PL0_W, .type =3D ARM_CP_NOP,
+      .accessfn =3D aa64_cacheop_poc_access },
+#ifndef CONFIG_USER_ONLY
+    { .name =3D "DC_CGVAP", .state =3D ARM_CP_STATE_AA64,
+      .opc0 =3D 1, .opc1 =3D 3, .crn =3D 7, .crm =3D 12, .opc2 =3D 3,
+      .access =3D PL0_W, .type =3D ARM_CP_NO_RAW | ARM_CP_SUPPRESS_TB_EN=
D,
+      .accessfn =3D aa64_cacheop_poc_access, .writefn =3D dccvap_writefn=
 },
+    { .name =3D "DC_CGDVAP", .state =3D ARM_CP_STATE_AA64,
+      .opc0 =3D 1, .opc1 =3D 3, .crn =3D 7, .crm =3D 12, .opc2 =3D 5,
+      .access =3D PL0_W, .type =3D ARM_CP_NO_RAW | ARM_CP_SUPPRESS_TB_EN=
D,
+      .accessfn =3D aa64_cacheop_poc_access, .writefn =3D dccvap_writefn=
 },
+#endif
+    { .name =3D "DC_CIGVAC", .state =3D ARM_CP_STATE_AA64,
+      .opc0 =3D 1, .opc1 =3D 3, .crn =3D 7, .crm =3D 14, .opc2 =3D 3,
+      .access =3D PL0_W, .type =3D ARM_CP_NOP,
+      .accessfn =3D aa64_cacheop_poc_access },
+    { .name =3D "DC_CIGDVAC", .state =3D ARM_CP_STATE_AA64,
+      .opc0 =3D 1, .opc1 =3D 3, .crn =3D 7, .crm =3D 14, .opc2 =3D 5,
+      .access =3D PL0_W, .type =3D ARM_CP_NOP,
+      .accessfn =3D aa64_cacheop_poc_access },
     { .name =3D "TCO", .state =3D ARM_CP_STATE_AA64,
       .opc0 =3D 3, .opc1 =3D 3, .crn =3D 4, .crm =3D 2, .opc2 =3D 7,
       .access =3D PL0_RW, .type =3D ARM_CP_NO_RAW,
@@ -7985,6 +8031,12 @@ void register_cp_regs_for_features(ARMCPU *cpu)
 #endif /*CONFIG_USER_ONLY*/
     if (cpu_isar_feature(aa64_mte, cpu)) {
         define_arm_cp_regs(cpu, mte_reginfo);
+
+#ifndef CONFIG_USER_ONLY
+        if (cpu_isar_feature(aa64_dcpodp, cpu)) {
+            define_one_arm_cp_reg(cpu, mte_dcpodp_reginfo);
+        }
+#endif
     }
 #endif
=20
--=20
2.25.1


