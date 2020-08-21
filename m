Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A4FC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:25:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83CE620732
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fzYEivJz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83CE620732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k94EF-0002UZ-Hc
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 06:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94D6-0000ZJ-4U
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:23:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29100
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94D1-0001Qb-RX
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598005421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EMlbhp5fTK8J6EyIxi+TH4Gxywk6oqtzcXV/xxOWG0c=;
 b=fzYEivJzdIEqIDnPQwrOvkLbF7zb5bfuykEUS7cUjw+erHk5ymp3ZHfsogViuiTLkeoIz/
 RYJqtOAebrElzlW0H3WSRpeJjoMU6nMYVltIUnN5Fk2wgD2T07I4mNddGM6/GL7QQnLSbn
 +TLOIn9p117PF/DjelBwW0cGE0YCh0w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-mS45LNvUMf-25x-9C4p1mg-1; Fri, 21 Aug 2020 06:23:37 -0400
X-MC-Unique: mS45LNvUMf-25x-9C4p1mg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2336C873073
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 10:23:37 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A5DFE19C78;
 Fri, 21 Aug 2020 10:23:30 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v8 002/152] optionrom: simplify Makefile
Date: Fri, 21 Aug 2020 06:20:59 -0400
Message-Id: <20200821102329.29777-3-pbonzini@redhat.com>
In-Reply-To: <20200821102329.29777-1-pbonzini@redhat.com>
References: <20200821102329.29777-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 23:41:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
2.26.2



