Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736C6C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:33:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A4D920679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="svhVWCHG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A4D920679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuXu-0000MW-DD
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53051)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtXs-0003sW-8P
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:28:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtXq-0002fN-Ho
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:28:56 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50261)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jDtXp-0002XG-JT
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:28:54 -0400
Received: by mail-wm1-x342.google.com with SMTP id z13so2550054wml.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 10:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Rf/LMvxII2heeNzCF6U3r1/xn5UIkwc7L0VgJUldqH8=;
 b=svhVWCHGR8twC23DwKqhWUWsC5Fwxk9kUMcyb3gsJ/9E469eDvQA5aW0EaL8gMK9lA
 3oT9H8MtVQY/C8JS3+dbvZy726y3jPRqByRdoG8CaRfBryheqQYwT78jC5rwZ5Ayd/rV
 ktlnMREt2+/poFGyTkJZ2q0n6PavTEeszv3PccVrO6tAiunQFI6BImtbEtZ2iG3zQgN2
 ZueReaYDJqGQEy69Y/9ANmseVvysLi2m0gijzFcQYBFIMe5R6urB2v65HtQ+GYDsjl+d
 xuLL1N0P4eaR+3paItwiaNVr2OovTqEax18m2S0ZyBqrkJO/OJGDZUBk5tYEE7dgvEO5
 IJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Rf/LMvxII2heeNzCF6U3r1/xn5UIkwc7L0VgJUldqH8=;
 b=Cj+PZi9Fcs6u+Z2A0pn1DyunaVil/5LneCMkfBS3FZwT4guCf0xsO8mpfXwzwPaEi6
 5AiiOhj5NvHUtbfO9LiXif23U5aUcdL73Rq5TzshlxnkqbhekGY4jfIKmHajCEhtSX/r
 SlY8YzJyYDaVMn3Vzg1fsuQrKfVU+8fAFn7E6WdfQTA0+WNVMclT+m/UW9yPEqWlG7uh
 wMC/5bvR4gUF0VBVuaUHf1qy4OJm/SejDq/3k147MyW0xDCltW3hoYtt1bWcSG/WwNv3
 Ji3iKpcChPEa8Jl//Sj7falMFetsYrPY+ruvaUC02FRXo69ZQpv3wOgAH9n4YlSQZUam
 WvuA==
X-Gm-Message-State: ANhLgQ1A5/oJPK0zjbzW8zllqA+8lOhsMo/lJuJenRvZCctLZyV7gReY
 I6srx7KMU1j9HcSDQA9Q7dFWnA==
X-Google-Smtp-Source: ADFU+vtOPkrwmUwL9yr9TObk2KPDCiru4aZHcVIdEQvPw2w0DwWcH314P1iR7FJG7fbYleiB1ptkgA==
X-Received: by 2002:a1c:b4c6:: with SMTP id d189mr180321wmf.132.1584379732510; 
 Mon, 16 Mar 2020 10:28:52 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b187sm456863wmb.42.2020.03.16.10.28.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 10:28:46 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E0B951FF9F;
 Mon, 16 Mar 2020 17:21:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 16/28] target/arm: explicitly encode regnum in our XML
Date: Mon, 16 Mar 2020 17:21:43 +0000
Message-Id: <20200316172155.971-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316172155.971-1-alex.bennee@linaro.org>
References: <20200316172155.971-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
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
index 0ab82c987c3..fbfd73a7b5b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -980,7 +980,7 @@ int arm_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
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
index b0e2a85b005..90135731353 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7973,7 +7973,7 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
                                  19, "arm-vfp.xml", 0);
     }
     gdb_register_coprocessor(cs, arm_gdb_get_sysreg, arm_gdb_set_sysreg,
-                             arm_gen_dynamic_sysreg_xml(cs),
+                             arm_gen_dynamic_sysreg_xml(cs, cs->gdb_num_regs),
                              "system-registers.xml", 0);
 }
 
-- 
2.20.1


