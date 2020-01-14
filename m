Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242C1C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:22:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E62F72072B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tWfMb97Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E62F72072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irO1H-0003hj-OJ
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 10:22:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37904)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1irNpe-0005HH-3E
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:10:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1irNpZ-0007XH-7a
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:10:13 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46697)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1irNpY-0007WE-WC
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:10:09 -0500
Received: by mail-wr1-x443.google.com with SMTP id z7so12472064wrl.13
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 07:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=s5gOoMgihpmFE4AT4VWG7sAvxuhwjZxcFhBeC583tSg=;
 b=tWfMb97ZW+U6SQbJcTa9WbfOzFnTId8lHoRjNJfntyyVxq0NbWeCOp7D4oBToBIbMT
 rXTy2KwSlHkUtGTVVITIoETAE+caHNtADl8B6bZuKuoftL4ZP+1D2gPwq5fVTXz3mjY+
 DQBuEXoH+KDvbv8ChP15SDooK3MVw5cMdObKuxS8Q7Te/DO7Z19wlE67TXF2/iRRURI+
 /mzbCMM3Vm1YBSMPZX/jhnSSmh5R2ERs3PJEUivxZSBVvFoDPkD/mVow8t6sER8l88ox
 hCpiAME0iJ8m9OvdbD6uAQyfyt/xSM6BqacaEPuC5IegXKYO3s8fpBOiJOV62++MExoY
 XoEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=s5gOoMgihpmFE4AT4VWG7sAvxuhwjZxcFhBeC583tSg=;
 b=tfZv744Gfx8Ed1gcnuCcGC1KShTMPVnonrm7eM/jQVZdhvFalVxvpJF4UHMNUImb6d
 QZ1mUcUnqX7SRgc2ihR38Q/gysJ3TmCCDP1+6v14YmEKdvYs+bbL6VaxqC/yxNdGwnfh
 kgiZE7FvmOPAzUGHAn9jIlqRxIGdtSkHdrfKDV14dOrJxe3zX3atxWFr7vYa6Sgw/3HG
 XjxcExkgfrLipWfYTUGxolfew5JjvR5R+XhL3Jnyv780NhH99AMRYXOGx6ocnVQhrJTb
 cMltYjFBPOBXKnQPYa0NqQreKFJyc7BxeYCx/HYkuaVs7fkdlFmDOGazVVbfLIl7efp0
 BErA==
X-Gm-Message-State: APjAAAUe8xXh3hqpEz+9mEMlAb8Qxa0lcZI6S8Y+mN2jpoZiXRpYbSkN
 yCV5fZJ8DgeNFzxtEM0WhmtKTg==
X-Google-Smtp-Source: APXvYqzQVTjIGfrT1jUk3nzPkjgvfwG/MjQi55+dzSoCpkD32uD/qoCczRA/rnhlyYKM8qqAc2QJ6Q==
X-Received: by 2002:a05:6000:118d:: with SMTP id
 g13mr27048661wrx.141.1579014607885; 
 Tue, 14 Jan 2020 07:10:07 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k8sm19845834wrl.3.2020.01.14.07.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 07:10:02 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DEBD61FF99;
 Tue, 14 Jan 2020 15:09:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 10/22] target/arm: explicitly encode regnum in our XML
Date: Tue, 14 Jan 2020 15:09:41 +0000
Message-Id: <20200114150953.27659-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200114150953.27659-1-alex.bennee@linaro.org>
References: <20200114150953.27659-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
index bd15587305..8a1b0db5ed 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -966,7 +966,7 @@ int arm_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 /* Dynamically generates for gdb stub an XML description of the sysregs from
  * the cp_regs hashtable. Returns the registered sysregs number.
  */
-int arm_gen_dynamic_sysreg_xml(CPUState *cpu);
+int arm_gen_dynamic_sysreg_xml(CPUState *cpu, int base_reg);
 
 /* Returns the dynamically generated XML for the gdb stub.
  * Returns a pointer to the XML contents for the specified XML file or NULL
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 1f68ab98c3..69c35462a6 100644
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
index f05bd2fc76..b35e9d21b4 100644
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


