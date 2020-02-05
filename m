Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B00C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:23:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A70E20702
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dEEu/MiP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A70E20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izOOu-0001Ge-OT
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 12:23:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38024)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1izOIZ-0007oz-3A
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:17:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1izOIX-0006bA-HV
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:17:10 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:56070)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1izOIX-0006Sb-8V
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:17:09 -0500
Received: by mail-wm1-x343.google.com with SMTP id q9so3329482wmj.5
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 09:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/I6OIwC9O7gBmBxmwsnHNia3N483o9Dq1snlyanX/LU=;
 b=dEEu/MiPKJsyPVTZQoDim40dTLiFW1SovelJHcMsTZKLTJ6WZoOPAmND8IJ7jqGXIY
 5AOhTZIlGyW0fO4k8D7DAmYuA8vHNt9tz5STSh7/ln3ZIVBsUiCpZri8dhIAqxPshr3B
 G9ggj0VqKbHwkteeQeTCeNw4f3yODdsqzRmxKCKQNIDLMSgmdNuATCoJXYrW/9g9EIpG
 VQLNSR6XFRgbAFoayw/WGzlXOO4zOsQSebtXdSwZmyvs3eWbOerPKfKeaZmb1iQ94o+M
 eqc+h/f2y04veGBe9JQJX0ESdEYSC6eKmSg8VEuQgHTW2AnhQZBKTl4JuUE57esAKf3b
 U61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/I6OIwC9O7gBmBxmwsnHNia3N483o9Dq1snlyanX/LU=;
 b=mDSR5kcOW97YfQ/5uuWnA8FOCYy6ynaWaj90mugUXGoNVpbpNTU1Cv8GsMeJo4K2wz
 tv08O2vt8OlPOsGgtaJIW1ALmXRKqtsq6mkWFAa1K2a0OI5P8RalRyOeqkfwr46BGgmX
 p/lxmfQI3Z4Zt36xt1drDKsYQuylbHM01hi8+L3Ajur4v0OrdYUifgub1i78HqlEGFCJ
 iiJtY8/qHIKb57zjaG1w4RZqWZrEzsz074DCs76e/R1au1CF1/g8WgegKgZ3oBrOhFK4
 2F2x1/mim5YZXP7NwA7nr0WVypAoDFRWsJiANDbMYIb1j9Xdp1y/6X28BWT2m/F2zlhl
 8GTA==
X-Gm-Message-State: APjAAAVoOVWpaGOmMwfXwVF3mbvdDIKtCISLerKJI8G7/hjzco4ihzJR
 /O/NbuIz+RmzQSGsEywMpujmOg==
X-Google-Smtp-Source: APXvYqwLK2UXrfVF4hK5uDtyo68K8dCcPuK7LPGyJ+PUjZrtj/XotmqZ3xLZVcL/gw466GyR5aGCuA==
X-Received: by 2002:a1c:740a:: with SMTP id p10mr6718503wmc.65.1580923028216; 
 Wed, 05 Feb 2020 09:17:08 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d23sm649571wra.30.2020.02.05.09.17.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 09:17:02 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CE1271FF9B;
 Wed,  5 Feb 2020 17:10:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 11/22] target/arm: explicitly encode regnum in our XML
Date: Wed,  5 Feb 2020 17:10:20 +0000
Message-Id: <20200205171031.22582-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200205171031.22582-1-alex.bennee@linaro.org>
References: <20200205171031.22582-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: damien.hedde@greensocs.com, Peter Maydell <peter.maydell@linaro.org>,
 luis.machado@linaro.org, richard.henderson@linaro.org,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, alan.hayward@arm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is described as optional but I'm not convinced of the numbering
when multiple target fragments are sent.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

---
v2
  - post inc param->n in place so we don't get out count wrong
---
 target/arm/cpu.h     |  2 +-
 target/arm/gdbstub.c | 17 +++++++++++------
 target/arm/helper.c  |  2 +-
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d58cb505ee8..1520774c0a3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -973,7 +973,7 @@ int arm_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 /* Dynamically generates for gdb stub an XML description of the sysregs from
  * the cp_regs hashtable. Returns the registered sysregs number.
  */
-int arm_gen_dynamic_sysreg_xml(CPUState *cpu);
+int arm_gen_dynamic_sysreg_xml(CPUState *cpu, int base_reg);
 
 /* Returns the dynamically generated XML for the gdb stub.
  * Returns a pointer to the XML contents for the specified XML file or NULL
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 1f68ab98c3b..69c35462a63 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -24,6 +24,7 @@
 typedef struct RegisterSysregXmlParam {
     CPUState *cs;
     GString *s;
+    int n;
 } RegisterSysregXmlParam;
 
 /* Old gdb always expect FPA registers.  Newer (xml-aware) gdb only expect
@@ -108,10 +109,11 @@ int arm_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 
 static void arm_gen_one_xml_sysreg_tag(GString *s, DynamicGDBXMLInfo *dyn_xml,
                                        ARMCPRegInfo *ri, uint32_t ri_key,
-                                       int bitsize)
+                                       int bitsize, int regnum)
 {
     g_string_append_printf(s, "<reg name=\"%s\"", ri->name);
     g_string_append_printf(s, " bitsize=\"%d\"", bitsize);
+    g_string_append_printf(s, " regnum=\"%d\"", regnum);
     g_string_append_printf(s, " group=\"cp_regs\"/>");
     dyn_xml->data.cpregs.keys[dyn_xml->num] = ri_key;
     dyn_xml->num++;
@@ -131,7 +133,8 @@ static void arm_register_sysreg_for_xml(gpointer key, gpointer value,
     if (!(ri->type & (ARM_CP_NO_RAW | ARM_CP_NO_GDB))) {
         if (arm_feature(env, ARM_FEATURE_AARCH64)) {
             if (ri->state == ARM_CP_STATE_AA64) {
-                arm_gen_one_xml_sysreg_tag(s , dyn_xml, ri, ri_key, 64);
+                arm_gen_one_xml_sysreg_tag(s , dyn_xml, ri, ri_key, 64,
+                                           param->n++);
             }
         } else {
             if (ri->state == ARM_CP_STATE_AA32) {
@@ -140,20 +143,22 @@ static void arm_register_sysreg_for_xml(gpointer key, gpointer value,
                     return;
                 }
                 if (ri->type & ARM_CP_64BIT) {
-                    arm_gen_one_xml_sysreg_tag(s , dyn_xml, ri, ri_key, 64);
+                    arm_gen_one_xml_sysreg_tag(s , dyn_xml, ri, ri_key, 64,
+                                               param->n++);
                 } else {
-                    arm_gen_one_xml_sysreg_tag(s , dyn_xml, ri, ri_key, 32);
+                    arm_gen_one_xml_sysreg_tag(s , dyn_xml, ri, ri_key, 32,
+                                               param->n++);
                 }
             }
         }
     }
 }
 
-int arm_gen_dynamic_sysreg_xml(CPUState *cs)
+int arm_gen_dynamic_sysreg_xml(CPUState *cs, int base_reg)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     GString *s = g_string_new(NULL);
-    RegisterSysregXmlParam param = {cs, s};
+    RegisterSysregXmlParam param = {cs, s, base_reg};
 
     cpu->dyn_sysreg_xml.num = 0;
     cpu->dyn_sysreg_xml.data.cpregs.keys = g_new(uint32_t, g_hash_table_size(cpu->cp_regs));
diff --git a/target/arm/helper.c b/target/arm/helper.c
index f05bd2fc769..b35e9d21b4a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7141,7 +7141,7 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
                                  19, "arm-vfp.xml", 0);
     }
     gdb_register_coprocessor(cs, arm_gdb_get_sysreg, arm_gdb_set_sysreg,
-                             arm_gen_dynamic_sysreg_xml(cs),
+                             arm_gen_dynamic_sysreg_xml(cs, cs->gdb_num_regs),
                              "system-registers.xml", 0);
 }
 
-- 
2.20.1


