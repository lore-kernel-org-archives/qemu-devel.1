Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C58FC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 17:42:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF4E8206D5
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 17:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fuxbgCFy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF4E8206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVfbb-0005wW-HG
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 12:41:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35003)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iVfQJ-0007OK-Mi
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 12:30:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iVfQH-00032t-GC
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 12:30:19 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40153)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iVfQH-00031w-8P
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 12:30:17 -0500
Received: by mail-wm1-x343.google.com with SMTP id f3so11274607wmc.5
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 09:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vnNRwr2vRwuzjjL8OmNZjy9dicnq34d5xs2bJ2LDUg0=;
 b=fuxbgCFyKWI/o2nlUOK0cC1cFLCFF3306lRsAgUhMHcImC98oVGMzHDeGobWKOXkQw
 qVQfthSOj3oVBuzZlkcVDgtvX8x/ung8if3eWs2VlsYghu9/I/IFPQC++jbCjcnjbxyT
 ojM61dOLRBUXu243b+/N1AvnwxtogDMGAUZ6hg6mjfhTp7yN/zFD7oUNnC9NEiCk8sPq
 /0m5zKqVOSRx8dUq5wE4w37HtKs4yuxRo+NNglVZviCAfGAnJg3QrgI2Xhkt8Bs4e6Oo
 kdDswltJQ5wf3G20wIuiUhedmxJBvPTaEo1PD944Xmip1nTdEPRKhyH6xU6q+ONehT6Z
 Gafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vnNRwr2vRwuzjjL8OmNZjy9dicnq34d5xs2bJ2LDUg0=;
 b=uZdVJF1XQymT7+Q9ROX8WuO8rN3zhoQ/xlW2G9HMq3PJGZezFluQXlNwauOjIxXpje
 aPmsN/ifF5SizYq5VHExhpBYxP0qWHK1Wijrxj9BcspSPDHDoADSOf1qDRdI76MLPg+t
 GGpCv4zQ59sGOR/rA3NKNK6O+stUPk+1Wy4rru6AJh12r9O7xxVEgBL2EXfT3/dyHrdB
 WC8vQjEWT3b7SPtgWGZ6JnAWBMb66MMsdgb8HlPa/UHVU2cwXeHUr81Sn/xZu2aJGEJN
 gWlM1WGQ91EPiOYWqA/XNX5Jbld77gCL+x6oz1pWDTiWQOgfU7xxbIwx/M/ecWJ4+x88
 dKIg==
X-Gm-Message-State: APjAAAUAyu0cOPbL5enGwMOp+ot1oZHUDEbVAjCv3fGEOjk1gt1THRGJ
 bnqe8gd5uys342cYNRGL7gsq5A==
X-Google-Smtp-Source: APXvYqyF4179dyk89DXUZH+4XvZ11uKfMGn2fM8/nepYhzV5EIHu1VHrGkgAW5SsQcozq8OgyV6fwQ==
X-Received: by 2002:a1c:5fc4:: with SMTP id
 t187mr16734558wmb.142.1573839016064; 
 Fri, 15 Nov 2019 09:30:16 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m25sm9279194wmi.46.2019.11.15.09.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 09:30:09 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F14AD1FF9A;
 Fri, 15 Nov 2019 17:30:01 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH  10/11] target/arm: explicitly encode regnum in our XML
Date: Fri, 15 Nov 2019 17:29:59 +0000
Message-Id: <20191115173000.21891-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191115173000.21891-1-alex.bennee@linaro.org>
References: <20191115173000.21891-1-alex.bennee@linaro.org>
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
---
 target/arm/cpu.h     |  2 +-
 target/arm/gdbstub.c | 16 ++++++++++------
 target/arm/helper.c  |  2 +-
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 97744496f2d..d5b6eeeb2f0 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -964,7 +964,7 @@ int arm_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 /* Dynamically generates for gdb stub an XML description of the sysregs from
  * the cp_regs hashtable. Returns the registered sysregs number.
  */
-int arm_gen_dynamic_sysreg_xml(CPUState *cpu);
+int arm_gen_dynamic_sysreg_xml(CPUState *cpu, int base_reg);
 
 /* Returns the dynamically generated XML for the gdb stub.
  * Returns a pointer to the XML contents for the specified XML file or NULL
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 1f68ab98c3b..ca2abedd8cf 100644
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
@@ -124,6 +126,7 @@ static void arm_register_sysreg_for_xml(gpointer key, gpointer value,
     ARMCPRegInfo *ri = value;
     RegisterSysregXmlParam *param = (RegisterSysregXmlParam *)p;
     GString *s = param->s;
+    int n = param->n;
     ARMCPU *cpu = ARM_CPU(param->cs);
     CPUARMState *env = &cpu->env;
     DynamicGDBXMLInfo *dyn_xml = &cpu->dyn_sysreg_xml;
@@ -131,7 +134,7 @@ static void arm_register_sysreg_for_xml(gpointer key, gpointer value,
     if (!(ri->type & (ARM_CP_NO_RAW | ARM_CP_NO_GDB))) {
         if (arm_feature(env, ARM_FEATURE_AARCH64)) {
             if (ri->state == ARM_CP_STATE_AA64) {
-                arm_gen_one_xml_sysreg_tag(s , dyn_xml, ri, ri_key, 64);
+                arm_gen_one_xml_sysreg_tag(s , dyn_xml, ri, ri_key, 64, n);
             }
         } else {
             if (ri->state == ARM_CP_STATE_AA32) {
@@ -140,20 +143,21 @@ static void arm_register_sysreg_for_xml(gpointer key, gpointer value,
                     return;
                 }
                 if (ri->type & ARM_CP_64BIT) {
-                    arm_gen_one_xml_sysreg_tag(s , dyn_xml, ri, ri_key, 64);
+                    arm_gen_one_xml_sysreg_tag(s , dyn_xml, ri, ri_key, 64, n);
                 } else {
-                    arm_gen_one_xml_sysreg_tag(s , dyn_xml, ri, ri_key, 32);
+                    arm_gen_one_xml_sysreg_tag(s , dyn_xml, ri, ri_key, 32, n);
                 }
             }
         }
     }
+    param->n++;
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
index 3234e6d08df..421e27e0f32 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6911,7 +6911,7 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
                                  19, "arm-vfp.xml", 0);
     }
     gdb_register_coprocessor(cs, arm_gdb_get_sysreg, arm_gdb_set_sysreg,
-                             arm_gen_dynamic_sysreg_xml(cs),
+                             arm_gen_dynamic_sysreg_xml(cs, cs->gdb_num_regs),
                              "system-registers.xml", 0);
 }
 
-- 
2.20.1


