Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF29CA9EBC
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:22:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B66C21906
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rh874hEM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B66C21906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNdzz-0007ZF-OT
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35028)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdjF-0008Kd-8T
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdjD-0007wo-Kb
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:40 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:42758)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iNdjD-0007vp-E0
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:39 -0400
Received: by mail-wr1-x42b.google.com with SMTP id r1so16440046wrs.9
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=+JOO2G3l+Owud+ib4UJhK6+M5ZCzXyr8Z3fX/8cawQs=;
 b=Rh874hEMImHvCUinKoY58uOhIlpd26RjpBkxfheZuwKpM7dEtH8f6ktJmq6Xv14gD7
 6huDg7GTW/mj9TZ+0cMnTsWUj5wuyLNcJLn4hZaM3bgyD69ZS5ZsCpvLwnypKKU1YyyZ
 xsjdCUTMv/gr2RFkrmgaIb4nK+nT0+IQrqtcu83ullhTFt6V9zVOs9KXP2VDd22Io1oU
 pZDvJMM9Phpqkr4prL5DRshdvSErS9pz0VF3UgUvI/HXILt9CxuEhNuiqw9vIHEVuHgX
 9pWMua2Iy1PMFb+zchLWIfOCBJtyM+0+GF/ax/ct+JELVA6y2p38Zsj9Tu5eITMc6Cvg
 o5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=+JOO2G3l+Owud+ib4UJhK6+M5ZCzXyr8Z3fX/8cawQs=;
 b=Yehds99ke23d6SgnddzacbD74QEDZsXgMvcRXBlLkCC5l/X+43k9o4plRH/N7LDBET
 Ma8JOrU4gDIY8ksGtKNMaK04Ku5zdWIvfpcB5Cjc8yHoPJTCshI/yfID99RVgDNPnNfN
 KQMLEju1JBIlM+/8moYgk0b/CoJ1x0yBYWpefs8xz8XOXMB8CNlebtueRtZJegQfJQys
 v8VeSSArqYjLdpFPg4yX/yfT9NIC9XKtqYl5XLrVi2atXQKqzsA3zlJ9PIbnI29fcud6
 OVwzLYznkTsOXYQn+vOSWmlWrgFFj97qlpy7RBTs9ntF6NO8saVEE26F1SFKZdwsuT2s
 sklw==
X-Gm-Message-State: APjAAAWbs9/Yu4oPvSSNLF7aVhuRVtv3/0Kzvz5R6bYjkHfVqJ4m4Uee
 GzbUszSL1cE9ozBTmTaa9VzaHIyb
X-Google-Smtp-Source: APXvYqzt9naXrU4jurylrKsbn6tkRyYlh2bRY9+UxwaVgjItDeVISU16xFjBNZvP+rsy6aA6jHJcfg==
X-Received: by 2002:a5d:638c:: with SMTP id p12mr3756502wru.136.1571925878013; 
 Thu, 24 Oct 2019 07:04:38 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b7sm10610155wrn.53.2019.10.24.07.04.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Oct 2019 07:04:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 37/39] target/i386: move FERR handling to target/i386
Date: Thu, 24 Oct 2019 16:03:53 +0200
Message-Id: <1571925835-31930-38-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
References: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move it out of pc.c since it is strictly tied to TCG.  This is
almost exclusively code movement, the next patch will implement
IGNNE.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c             | 17 +++--------------
 hw/i386/pc_piix.c        |  2 +-
 hw/i386/pc_q35.c         |  2 +-
 include/hw/i386/pc.h     |  1 -
 target/i386/cpu.h        |  3 ++-
 target/i386/fpu_helper.c | 26 +++++++++++++++++++++++++-
 6 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 5fce60c..66d865b 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -381,23 +381,12 @@ static uint64_t ioport80_read(void *opaque, hwaddr addr, unsigned size)
 }
 
 /* MSDOS compatibility mode FPU exception support */
-static qemu_irq ferr_irq;
-
-void pc_register_ferr_irq(qemu_irq irq)
-{
-    ferr_irq = irq;
-}
-
-/* XXX: add IGNNE support */
-void cpu_set_ferr(CPUX86State *s)
-{
-    qemu_irq_raise(ferr_irq);
-}
-
 static void ioportF0_write(void *opaque, hwaddr addr, uint64_t data,
                            unsigned size)
 {
-    qemu_irq_lower(ferr_irq);
+    if (tcg_enabled()) {
+        cpu_clear_ferr();
+    }
 }
 
 static uint64_t ioportF0_read(void *opaque, hwaddr addr, unsigned size)
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 3a4a64a..431d657 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -213,7 +213,7 @@ static void pc_init1(MachineState *machine,
         ioapic_init_gsi(gsi_state, "i440fx");
     }
 
-    pc_register_ferr_irq(x86ms->gsi[13]);
+    x86_register_ferr_irq(x86ms->gsi[13]);
 
     pc_vga_init(isa_bus, pcmc->pci_enabled ? pci_bus : NULL);
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index def3bc2..c9cdac8 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -261,7 +261,7 @@ static void pc_q35_init(MachineState *machine)
         ioapic_init_gsi(gsi_state, "q35");
     }
 
-    pc_register_ferr_irq(x86ms->gsi[13]);
+    x86_register_ferr_irq(x86ms->gsi[13]);
 
     assert(pcms->vmport != ON_OFF_AUTO__MAX);
     if (pcms->vmport == ON_OFF_AUTO_AUTO) {
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 5923318..f040a72 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -176,7 +176,6 @@ void vmmouse_set_data(const uint32_t *data);
 extern int fd_bootchk;
 
 bool pc_machine_is_smm_enabled(PCMachineState *pcms);
-void pc_register_ferr_irq(qemu_irq irq);
 void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
 
 void pc_hot_add_cpu(MachineState *ms, const int64_t id, Error **errp);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index b772e82..01e052b 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1761,7 +1761,8 @@ int cpu_x86_support_mca_broadcast(CPUX86State *env);
 
 int cpu_get_pic_interrupt(CPUX86State *s);
 /* MSDOS compatibility mode FPU exception support */
-void cpu_set_ferr(CPUX86State *s);
+void x86_register_ferr_irq(qemu_irq irq);
+void cpu_clear_ferr(void);
 /* mpx_helper.c */
 void cpu_sync_bndcs_hflags(CPUX86State *env);
 
diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index 005f1f6..4db0059 100644
--- a/target/i386/fpu_helper.c
+++ b/target/i386/fpu_helper.c
@@ -26,6 +26,10 @@
 #include "exec/cpu_ldst.h"
 #include "fpu/softfloat.h"
 
+#ifdef CONFIG_SOFTMMU
+#include "hw/irq.h"
+#endif
+
 #define FPU_RC_MASK         0xc00
 #define FPU_RC_NEAR         0x000
 #define FPU_RC_DOWN         0x400
@@ -58,6 +62,26 @@
 #define floatx80_l2e make_floatx80(0x3fff, 0xb8aa3b295c17f0bcLL)
 #define floatx80_l2t make_floatx80(0x4000, 0xd49a784bcd1b8afeLL)
 
+#if !defined(CONFIG_USER_ONLY)
+static qemu_irq ferr_irq;
+
+void x86_register_ferr_irq(qemu_irq irq)
+{
+    ferr_irq = irq;
+}
+
+void cpu_clear_ferr(void)
+{
+    qemu_irq_lower(ferr_irq);
+}
+
+static void cpu_set_ferr(void)
+{
+    qemu_irq_raise(ferr_irq);
+}
+#endif
+
+
 static inline void fpush(CPUX86State *env)
 {
     env->fpstt = (env->fpstt - 1) & 7;
@@ -137,7 +161,7 @@ static void fpu_raise_exception(CPUX86State *env, uintptr_t retaddr)
     }
 #if !defined(CONFIG_USER_ONLY)
     else {
-        cpu_set_ferr(env);
+        cpu_set_ferr();
     }
 #endif
 }
-- 
1.8.3.1



