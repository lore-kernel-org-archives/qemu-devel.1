Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F013DC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:14:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAB2C2063A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1wMhSht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAB2C2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTSrx-0001KT-NC
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 12:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jTSkW-0001No-3c
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:10:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jTSiC-0004jv-4W
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:06:19 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:44112)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jTSiB-0004eS-LB; Tue, 28 Apr 2020 12:03:55 -0400
Received: by mail-lf1-x144.google.com with SMTP id d25so2418546lfi.11;
 Tue, 28 Apr 2020 09:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qx+l5p3S5NfNVmELJKcRzKnEh+5HV6ZDJ+IasaAkEMk=;
 b=E1wMhSht8CtHaPfrabgX0UUhuCDZEWk1WMhs5lDeUqFdM0OoKYLVYgprBA8HdIwq3j
 VxHdeAPqlpg6BBQealKd5NS+hTgyrqDoHX+6jqL3+dLrw7ao6kH5/tC1/6tt6eD0k71T
 k+czAzyELX/YvCqqa3TzSzoYRbalXw66HGd+lXxMkIiZ056Ad0Gush5PpdErkQm2gBow
 J+uZPEaXJAhguQQJhzy2SyxENCCIMCIfzYmkQ+zus8UVeegCI6KPAN2iu/r9W1eWVFOS
 F+EcAhJoQK5432FcOCa5lvRoLCigiPva8Xk3ZJXtNXXdM/8VOZynUznTSbEYKjt2KThb
 3C1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qx+l5p3S5NfNVmELJKcRzKnEh+5HV6ZDJ+IasaAkEMk=;
 b=JusfBJqguKukWV9P5Qxa0iP1mwzaKan+7SwdsO2ad1av4xznv2R0orQqeOO0Cy/cMZ
 dRlStZ/7r6jSEgkSzCDHvjqKqcpmYrvNkKWVBgFUi2OfyQiLvYuPRx1mhkibbGA870FX
 zSkTntrU5N7tzaj4ZpW+PdQ1hKJAWWJWsmC9Kj2Y32oFTyd7iVAyVCUZARwY2pimQXYZ
 ww+Cf94C4/8bbELrb8kJXFg+kWLlN88v4+asbejWfYwRpCmy8ex48k/W7LyB5fUgVSfo
 st1JHXw11mY2SlANAQ4jh5gH6H9blPbY/DdaorRI6Q4QN2JgLZH+tDLYxKSZWO6/K35B
 ZerQ==
X-Gm-Message-State: AGi0PuYXDylc2pHpkB3MSlvLF6LFcvqjxOGV6TlBlQxLzZO8xJaKhtC1
 rgkwCHlXpTuYjaEU2ZREAjIQUW4+o+Q=
X-Google-Smtp-Source: APiQypKZEjGnwozrapX4HKiEbxv9SfEkulroWbaFDr5S5fgPJhwPUbJeRD+3O3EjpO5GLWKAg5hcGA==
X-Received: by 2002:a05:6512:3f4:: with SMTP id
 n20mr19783875lfq.100.1588089833406; 
 Tue, 28 Apr 2020 09:03:53 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id b9sm16186195lfp.27.2020.04.28.09.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 09:03:52 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/1] target/arm: Drop access_el3_aa32ns()
Date: Tue, 28 Apr 2020 18:03:50 +0200
Message-Id: <20200428160350.10030-2-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200428160350.10030-1-edgar.iglesias@gmail.com>
References: <20200428160350.10030-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::144
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Calling access_el3_aa32ns() works for AArch32 only cores
but it does not handle 32-bit EL2 on top of 64-bit EL3
for mixed 32/64-bit cores.

Fold access_el3_aa32ns() into access_el3_aa32ns_aa64any()
and replace all direct uses of the aa32 only version with
access_el3_aa32ns_aa64any().

Fixes: 68e9c2fe65 ("target-arm: Add VTCR_EL2")
Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/arm/helper.c | 34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7e9ea5d20f..888f5f2314 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -504,29 +504,15 @@ void init_cpreg_list(ARMCPU *cpu)
 /*
  * Some registers are not accessible if EL3.NS=0 and EL3 is using AArch32 but
  * they are accessible when EL3 is using AArch64 regardless of EL3.NS.
- *
- * access_el3_aa32ns: Used to check AArch32 register views.
- * access_el3_aa32ns_aa64any: Used to check both AArch32/64 register views.
  */
-static CPAccessResult access_el3_aa32ns(CPUARMState *env,
-                                        const ARMCPRegInfo *ri,
-                                        bool isread)
-{
-    bool secure = arm_is_secure_below_el3(env);
-
-    assert(!arm_el_is_aa64(env, 3));
-    if (secure) {
-        return CP_ACCESS_TRAP_UNCATEGORIZED;
-    }
-    return CP_ACCESS_OK;
-}
-
 static CPAccessResult access_el3_aa32ns_aa64any(CPUARMState *env,
                                                 const ARMCPRegInfo *ri,
                                                 bool isread)
 {
-    if (!arm_el_is_aa64(env, 3)) {
-        return access_el3_aa32ns(env, ri, isread);
+    bool secure = arm_is_secure_below_el3(env);
+
+    if (!arm_el_is_aa64(env, 3) && secure) {
+        return CP_ACCESS_TRAP_UNCATEGORIZED;
     }
     return CP_ACCESS_OK;
 }
@@ -5223,7 +5209,7 @@ static const ARMCPRegInfo el3_no_el2_cp_reginfo[] = {
       .type = ARM_CP_CONST, .resetvalue = 0 },
     { .name = "VTTBR", .state = ARM_CP_STATE_AA32,
       .cp = 15, .opc1 = 6, .crm = 2,
-      .access = PL2_RW, .accessfn = access_el3_aa32ns,
+      .access = PL2_RW, .accessfn = access_el3_aa32ns_aa64any,
       .type = ARM_CP_CONST | ARM_CP_64BIT, .resetvalue = 0 },
     { .name = "VTTBR_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 1, .opc2 = 0,
@@ -5556,7 +5542,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
     { .name = "VTCR", .state = ARM_CP_STATE_AA32,
       .cp = 15, .opc1 = 4, .crn = 2, .crm = 1, .opc2 = 2,
       .type = ARM_CP_ALIAS,
-      .access = PL2_RW, .accessfn = access_el3_aa32ns,
+      .access = PL2_RW, .accessfn = access_el3_aa32ns_aa64any,
       .fieldoffset = offsetof(CPUARMState, cp15.vtcr_el2) },
     { .name = "VTCR_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 1, .opc2 = 2,
@@ -5568,7 +5554,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
     { .name = "VTTBR", .state = ARM_CP_STATE_AA32,
       .cp = 15, .opc1 = 6, .crm = 2,
       .type = ARM_CP_64BIT | ARM_CP_ALIAS,
-      .access = PL2_RW, .accessfn = access_el3_aa32ns,
+      .access = PL2_RW, .accessfn = access_el3_aa32ns_aa64any,
       .fieldoffset = offsetof(CPUARMState, cp15.vttbr_el2),
       .writefn = vttbr_write },
     { .name = "VTTBR_EL2", .state = ARM_CP_STATE_AA64,
@@ -5708,7 +5694,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.mdcr_el2), },
     { .name = "HPFAR", .state = ARM_CP_STATE_AA32,
       .cp = 15, .opc1 = 4, .crn = 6, .crm = 0, .opc2 = 4,
-      .access = PL2_RW, .accessfn = access_el3_aa32ns,
+      .access = PL2_RW, .accessfn = access_el3_aa32ns_aa64any,
       .fieldoffset = offsetof(CPUARMState, cp15.hpfar_el2) },
     { .name = "HPFAR_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 6, .crm = 0, .opc2 = 4,
@@ -7565,7 +7551,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         ARMCPRegInfo vpidr_regs[] = {
             { .name = "VPIDR", .state = ARM_CP_STATE_AA32,
               .cp = 15, .opc1 = 4, .crn = 0, .crm = 0, .opc2 = 0,
-              .access = PL2_RW, .accessfn = access_el3_aa32ns,
+              .access = PL2_RW, .accessfn = access_el3_aa32ns_aa64any,
               .resetvalue = cpu->midr, .type = ARM_CP_ALIAS,
               .fieldoffset = offsetoflow32(CPUARMState, cp15.vpidr_el2) },
             { .name = "VPIDR_EL2", .state = ARM_CP_STATE_AA64,
@@ -7574,7 +7560,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .fieldoffset = offsetof(CPUARMState, cp15.vpidr_el2) },
             { .name = "VMPIDR", .state = ARM_CP_STATE_AA32,
               .cp = 15, .opc1 = 4, .crn = 0, .crm = 0, .opc2 = 5,
-              .access = PL2_RW, .accessfn = access_el3_aa32ns,
+              .access = PL2_RW, .accessfn = access_el3_aa32ns_aa64any,
               .resetvalue = vmpidr_def, .type = ARM_CP_ALIAS,
               .fieldoffset = offsetoflow32(CPUARMState, cp15.vmpidr_el2) },
             { .name = "VMPIDR_EL2", .state = ARM_CP_STATE_AA64,
-- 
2.20.1


