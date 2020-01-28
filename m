Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D330C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 17:55:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3991421739
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 17:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoL1lgah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3991421739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwV5N-0007gi-Ct
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 12:55:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57185)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV3n-0005kh-Lj
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV3m-0007LL-7W
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:53:59 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42876)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV3l-0007Fo-VY
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:53:58 -0500
Received: by mail-wr1-x444.google.com with SMTP id k11so2413997wrd.9
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=v7fP+V9ixvBHX58L9pfbBMpyNUVrGlItPTLd0Obr3k0=;
 b=BoL1lgahF/lhS3PwpFzVequl9uOTx1rqxrGLix5RU2vYzZfPCHDMjrdT9GC/aD0AP0
 LrsnuCPOQQwpd+AcqWFv2emQevs/KOv1HWWatq5cttz3f4CxpWmJ/MsMv+X3uVfNs/Ev
 wJUhr41qj4Ql8iOKaIVm9bHHu+4t7+2bLG7woITR8e6oa7dI3TlHFJmKZUy674JiW6dz
 0Y9BCkdlvz0zRoNfx03WQ3wKycf91iFVJzcav8ZsImFhtRVi6iA6RDxNNJDiGUGyfwyS
 qgy4bTpFkYKcOg66SG5xSMdUgrKrPJ6u7r2M7GSH4AjpL5cbjDVDLNMkBBpNQSVqtv6T
 STyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=v7fP+V9ixvBHX58L9pfbBMpyNUVrGlItPTLd0Obr3k0=;
 b=ubThG8asSLEGRvDhIprGm9IKVh0MQJCKAQmTPutrOUDr5UlJeYWjt9fOe7JuT28roK
 0DI0DrChGWjoMcm34hje3zoGF8vzUAj8ynWlr2YD0zzUo5wHOGh2nYoSig4er8YGBqxv
 fbzm69FgGdbLAjFth5RJMFKq4RQcWpK6+e2DZuJJ/OwmtcU79QdPwb/gtEV/RQAC8JD8
 AY4s9+dVJVDxHIQBnbKCIP/Ekcog7DwZP8ARJGUO2JRWTOqIMTiFT6lTclh6mmV49M2T
 PyqXlcAXlsiBtMXj3Y01aA+Wd+XGWkr3aiGNZAaCu+yyMPo1N4HsXEK2N1ozA+JmtjPU
 6O5w==
X-Gm-Message-State: APjAAAWprpU+mJzQQ6I3dvy+y6SFMGUJiatVld1ieZHde6ptbDwS1itZ
 aS2Snh8bvGO2yVM8bMSSoQ+sOxS1
X-Google-Smtp-Source: APXvYqx7+JDUBgRIRAqx9jXuaF/WlEqWtQMCBODqVDGDnWfO8D0uAM7+RAPMheVYfKchdOgtPpctEA==
X-Received: by 2002:adf:edd0:: with SMTP id v16mr29337586wro.310.1580234034537; 
 Tue, 28 Jan 2020 09:53:54 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.53.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:53:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 002/142] optionrom: simplify Makefile
Date: Tue, 28 Jan 2020 18:51:22 +0100
Message-Id: <20200128175342.9066-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Make it independent from the rules.mak, and clean up to use pattern rules.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 pc-bios/optionrom/Makefile | 67 +++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 26 deletions(-)

diff --git a/pc-bios/optionrom/Makefile b/pc-bios/optionrom/Makefile
index e33a24da0d..51cb6ca9d8 100644
--- a/pc-bios/optionrom/Makefile
+++ b/pc-bios/optionrom/Makefile
@@ -1,13 +1,16 @@
-all: build-all
+CURRENT_MAKEFILE := $(realpath $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST)))
+SRC_DIR := $(dir $(CURRENT_MAKEFILE))
+TOPSRC_DIR := $(SRC_DIR)/../..
+VPATH = $(SRC_DIR)
+
+all: multiboot.bin linuxboot.bin linuxboot_dma.bin kvmvapic.bin pvh.bin
 # Dummy command so that make thinks it has done something
 	@true
 
 include ../../config-host.mak
-include $(SRC_PATH)/rules.mak
-
-$(call set-vpath, $(SRC_PATH)/pc-bios/optionrom)
 
-.PHONY : all clean build-all
+quiet-command = $(if $(V),$1,$(if $(2),@printf "  %-7s %s\n" $2 $3 && $1, @$1))
+cc-option = $(if $(shell $(CC) $1 -S -o /dev/null -xc /dev/null >/dev/null 2>&1 && echo OK), $1, $2)
 
 # Compiling with no optimization creates ROMs that are too large
 ifeq ($(lastword $(filter -O%, -O0 $(CFLAGS))),-O0)
@@ -15,48 +18,60 @@ override CFLAGS += -O2
 endif
 override CFLAGS += -march=i486
 
-# Drop -fstack-protector and the like
-QEMU_CFLAGS := $(filter -W%, $(QEMU_CFLAGS)) $(CFLAGS_NOPIE) -ffreestanding
-QEMU_CFLAGS += $(call cc-option, $(QEMU_CFLAGS), -fno-stack-protector)
-QEMU_CFLAGS += $(call cc-option, $(QEMU_CFLAGS), -m16)
-ifeq ($(filter -m16, $(QEMU_CFLAGS)),)
+# Flags for dependency generation
+override CPPFLAGS += -MMD -MP -MT $@ -MF $(@D)/$(*F).d
+
+override CFLAGS += $(filter -W%, $(QEMU_CFLAGS))
+override CFLAGS += $(CFLAGS_NOPIE) -ffreestanding -I$(TOPSRC_DIR)/include
+override CFLAGS += $(call cc-option, -fno-stack-protector)
+override CFLAGS += $(call cc-option, -m16)
+
+ifeq ($(filter -m16, $(CFLAGS)),)
 # Attempt to work around compilers that lack -m16 (GCC <= 4.8, clang <= ??)
 # On GCC we add -fno-toplevel-reorder to keep the order of asm blocks with
 # respect to the rest of the code.  clang does not have -fno-toplevel-reorder,
 # but it places all asm blocks at the beginning and we're relying on it for
 # the option ROM header.  So just force clang not to use the integrated
 # assembler, which doesn't support .code16gcc.
-QEMU_CFLAGS += $(call cc-option, $(QEMU_CFLAGS), -fno-toplevel-reorder)
-QEMU_CFLAGS += $(call cc-option, $(QEMU_CFLAGS), -no-integrated-as)
-QEMU_CFLAGS += -m32 -include $(SRC_PATH)/pc-bios/optionrom/code16gcc.h
+override CFLAGS += $(call cc-option, -fno-toplevel-reorder)
+override CFLAGS += $(call cc-option, -no-integrated-as)
+override CFLAGS += -m32 -include $(SRC_DIR)/code16gcc.h
 endif
 
-QEMU_INCLUDES += -I$(SRC_PATH)
-
 Wa = -Wa,
-ASFLAGS += -32
-QEMU_CFLAGS += $(call cc-c-option, $(QEMU_CFLAGS), $(Wa)-32)
+override ASFLAGS += -32
+override CFLAGS += $(call cc-option, $(Wa)-32)
 
-build-all: multiboot.bin linuxboot.bin linuxboot_dma.bin kvmvapic.bin pvh.bin
 
-# suppress auto-removal of intermediate files
-.SECONDARY:
+LD_I386_EMULATION ?= elf_i386
+override LDFLAGS = -m $(LD_I386_EMULATION) -T $(SRC_DIR)/flat.lds
+override LDFLAGS += $(LDFLAGS_NOPIE)
 
+all: multiboot.bin linuxboot.bin linuxboot_dma.bin kvmvapic.bin pvh.bin
+
+pvh.img: pvh.o pvh_main.o
 
 %.o: %.S
-	$(call quiet-command,$(CPP) $(QEMU_INCLUDES) $(QEMU_DGFLAGS) -c -o - $< | $(AS) $(ASFLAGS) -o $@,"AS","$(TARGET_DIR)$@")
+	$(call quiet-command,$(CPP) $(CPPFLAGS) -c -o - $< | $(AS) $(ASFLAGS) -o $@,"AS","$@")
 
-pvh.img: pvh.o pvh_main.o
-	$(call quiet-command,$(LD) $(LDFLAGS_NOPIE) -m $(LD_I386_EMULATION) -T $(SRC_PATH)/pc-bios/optionrom/flat.lds -s -o $@ $^,"BUILD","$(TARGET_DIR)$@")
+%.o: %.c
+	$(call quiet-command,$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@,"CC","$@")
 
 %.img: %.o
-	$(call quiet-command,$(LD) $(LDFLAGS_NOPIE) -m $(LD_I386_EMULATION) -T $(SRC_PATH)/pc-bios/optionrom/flat.lds -s -o $@ $<,"BUILD","$(TARGET_DIR)$@")
+	$(call quiet-command,$(LD) $(LDFLAGS) -s -o $@ $^,"BUILD","$@")
 
 %.raw: %.img
-	$(call quiet-command,$(OBJCOPY) -O binary -j .text $< $@,"BUILD","$(TARGET_DIR)$@")
+	$(call quiet-command,$(OBJCOPY) -O binary -j .text $< $@,"BUILD","$@")
 
 %.bin: %.raw
-	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/signrom.py $< $@,"SIGN","$(TARGET_DIR)$@")
+	$(call quiet-command,$(PYTHON) $(TOPSRC_DIR)/scripts/signrom.py $< $@,"SIGN","$@")
+
+include $(wildcard *.d)
 
 clean:
 	rm -f *.o *.d *.raw *.img *.bin *~
+
+# suppress auto-removal of intermediate files
+.SECONDARY:
+
+.PHONY: all clean
-- 
2.21.0



