Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7569C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 10:30:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B477B20838
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 10:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aez6PmbN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B477B20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU6Sc-0008RB-R8
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 06:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52874)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zltjiangshi@gmail.com>) id 1jU6MS-0006xU-QU
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:24:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <zltjiangshi@gmail.com>) id 1jU6MR-0006l3-R7
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:24:08 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:44201)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jU6MR-0006eX-DM
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:24:07 -0400
Received: by mail-pl1-x641.google.com with SMTP id h11so2077601plr.11
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 03:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=PP5ZBO5V+/qsHiEs8q8QJMOieeCuo90ei1MsjiyJ2Hg=;
 b=aez6PmbN8S7+sXSijL/ZA4GKOxUmbTmMuO5h8SS7bwqPeT73uM3EN1ng3U2nYlntMp
 wMgJTfpeqYIaDpC4Rb5RD/yt5VPZL1jj1RltMxcMdaT1OMMIsje5kVmhpOyCqcqE+ctW
 jnNZh0cPcEv/nNRVFQQJAd9oZSUdCoTf/yeSBNl2lR8twJ2QGC2EKUx+ptf9PPiNeuDT
 dB6eDe3kdh40PlKvAnS5v3PS7OGPos5u18Y7g7XK0Ze7JS+Dv0D60tDLc5OclvBGBQln
 iUw/+ANKP6/ktwxQGy5k1isoaajO8j9EXfSAz3C4eZ4pRbVBCXgye73zyxcKnobRIrGG
 UG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=PP5ZBO5V+/qsHiEs8q8QJMOieeCuo90ei1MsjiyJ2Hg=;
 b=oHlKXWuCM9IgJaJCjqP52V6D7ZxGOOuEd87AZ5Iqxxppx6uX6EKE1AfgLM5Q2zfqmC
 a4coMHpi2vE/DD9apRm5J1j5B9u6s5gKDav1jI3Ss4pGn13JAdq/nlyVdh6JFrUkjPG+
 h1qV/E3H1Kuis8rkn8KxCnzKKNVJsZSe3htx0h5pvh9k8AW0jer713jgSDn488359LJs
 ib12Igj6dcnf0jbN0b2g6iXfeJm52BHuRGb3JNZq0G8OmdNYX4FChTPPaVFNm6ypEdCm
 zmgIeDZ+WmpUF4D9Y7hzdwrot0nUw9LNBYoRF79ZaHOxp9w+gqDa1STZzrP+PBrKj9wR
 zYLg==
X-Gm-Message-State: AGi0PuYfqrU4Pnsh5cWAvwTpBI6JeN1ey24/pxbqHNMR408odY2M1Evm
 0QfDqyXng73DEwNcFU+ViYltHYjC070=
X-Google-Smtp-Source: APiQypKbam6Sivo32KrDY3z6IpcGw4Qw47sC1S4lTk5n1hW/vxOnYniXwem0nypd1a7AM1j71TOUtA==
X-Received: by 2002:a17:902:8eca:: with SMTP id
 x10mr3144285plo.60.1588242242779; 
 Thu, 30 Apr 2020 03:24:02 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id a15sm1397872pju.3.2020.04.30.03.24.00
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 30 Apr 2020 03:24:02 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH for-5.1 V2 2/7] hw/mips: Implement the kvm_type() hook in
 MachineClass
Date: Thu, 30 Apr 2020 18:22:30 +0800
Message-Id: <1588242155-23924-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1588242155-23924-1-git-send-email-chenhc@lemote.com>
References: <1588242155-23924-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MIPS has two types of KVM: TE & VZ, and TE is the default type. Now we
can't create a VZ guest in QEMU because it lacks the kvm_type() hook in
MachineClass. Besides, libvirt uses a null-machine to detect the kvm
capability, so by default it will return "KVM not supported" on a VZ
platform. Thus, null-machine also need the kvm_type() hook.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/core/Makefile.objs  |  2 +-
 hw/core/null-machine.c |  4 ++++
 hw/mips/Makefile.objs  |  2 +-
 hw/mips/common.c       | 29 +++++++++++++++++++++++++++++
 include/hw/mips/mips.h |  3 +++
 5 files changed, 38 insertions(+), 2 deletions(-)
 create mode 100644 hw/mips/common.c

diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index 6215e7c..7cfef1f 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -16,10 +16,10 @@ common-obj-$(CONFIG_SOFTMMU) += vm-change-state-handler.o
 common-obj-$(CONFIG_SOFTMMU) += qdev-properties-system.o
 common-obj-$(CONFIG_SOFTMMU) += sysbus.o
 common-obj-$(CONFIG_SOFTMMU) += machine.o
-common-obj-$(CONFIG_SOFTMMU) += null-machine.o
 common-obj-$(CONFIG_SOFTMMU) += loader.o
 common-obj-$(CONFIG_SOFTMMU) += machine-hmp-cmds.o
 common-obj-$(CONFIG_SOFTMMU) += numa.o
+obj-$(CONFIG_SOFTMMU) += null-machine.o
 obj-$(CONFIG_SOFTMMU) += machine-qmp-cmds.o
 
 common-obj-$(CONFIG_EMPTY_SLOT) += empty_slot.o
diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index cb47d9d..94a36f9 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -17,6 +17,7 @@
 #include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
 #include "hw/core/cpu.h"
+#include "hw/mips/mips.h"
 
 static void machine_none_init(MachineState *mch)
 {
@@ -50,6 +51,9 @@ static void machine_none_machine_init(MachineClass *mc)
     mc->max_cpus = 1;
     mc->default_ram_size = 0;
     mc->default_ram_id = "ram";
+#ifdef TARGET_MIPS
+    mc->kvm_type = mips_kvm_type;
+#endif
 }
 
 DEFINE_MACHINE("none", machine_none_machine_init)
diff --git a/hw/mips/Makefile.objs b/hw/mips/Makefile.objs
index 525809a..2f7795b 100644
--- a/hw/mips/Makefile.objs
+++ b/hw/mips/Makefile.objs
@@ -1,4 +1,4 @@
-obj-y += addr.o mips_int.o
+obj-y += addr.o common.o mips_int.o
 obj-$(CONFIG_R4K) += mips_r4k.o
 obj-$(CONFIG_MALTA) += gt64xxx_pci.o mips_malta.o
 obj-$(CONFIG_MIPSSIM) += mips_mipssim.o
diff --git a/hw/mips/common.c b/hw/mips/common.c
new file mode 100644
index 0000000..eb0c649
--- /dev/null
+++ b/hw/mips/common.c
@@ -0,0 +1,29 @@
+/*
+ * Common MIPS routines
+ *
+ * Copyright (c) 2020 Huacai Chen (chenhc@lemote.com)
+ * This code is licensed under the GNU GPL v2.
+ */
+
+#include <linux/kvm.h>
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "hw/boards.h"
+#include "hw/mips/mips.h"
+#include "sysemu/kvm_int.h"
+
+int mips_kvm_type(MachineState *machine, const char *vm_type)
+{
+    int r;
+    KVMState *s = KVM_STATE(machine->accelerator);;
+
+    r = kvm_check_extension(s, KVM_CAP_MIPS_VZ);
+    if (r > 0)
+        return KVM_VM_MIPS_VZ;
+
+    r = kvm_check_extension(s, KVM_CAP_MIPS_TE);
+    if (r > 0)
+        return KVM_VM_MIPS_TE;
+
+    return -1;
+}
diff --git a/include/hw/mips/mips.h b/include/hw/mips/mips.h
index 0af4c3d..2ac0580 100644
--- a/include/hw/mips/mips.h
+++ b/include/hw/mips/mips.h
@@ -20,4 +20,7 @@ void rc4030_dma_write(void *dma, uint8_t *buf, int len);
 
 DeviceState *rc4030_init(rc4030_dma **dmas, IOMMUMemoryRegion **dma_mr);
 
+/* common.c */
+int mips_kvm_type(MachineState *machine, const char *vm_type);
+
 #endif
-- 
2.7.0


