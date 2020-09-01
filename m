Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF24C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:20:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C142206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XW5vxZZC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C142206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD2Sa-0003JV-70
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 05:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kD2KY-0003ka-Mm
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:11:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49238)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kD2KV-0006sR-W9
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598951511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pH3w6LJvCAG1/nlkX1a54epExI22nXwFJso3ShzjTwQ=;
 b=XW5vxZZCR0nE2C+yn4C19tVQltxjm579d9T8lbivjyuDCsleHORHa+8uPHoliFa57vUdhC
 3gR9ar7jvw5/4mNply6gcE1+yrPC5gcsU8HHEVzZnlHVqsY56Y1FRFQlcr8GDXWYCRyosV
 RfmpwT/xqBG3G373z4Tk9Y2fUvZJ80Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354--zvGWfLHMQ-IuG0XdtU3yw-1; Tue, 01 Sep 2020 05:11:47 -0400
X-MC-Unique: -zvGWfLHMQ-IuG0XdtU3yw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FCBD10082E8
 for <qemu-devel@nongnu.org>; Tue,  1 Sep 2020 09:11:46 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3995678B45;
 Tue,  1 Sep 2020 09:11:46 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 23/24] build: fix recurse-all target
Date: Tue,  1 Sep 2020 05:11:31 -0400
Message-Id: <20200901091132.29601-24-pbonzini@redhat.com>
In-Reply-To: <20200901091132.29601-1-pbonzini@redhat.com>
References: <20200901091132.29601-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 23:17:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Miroslav Rezanina <mrezanin@redhat.com>, Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The missing "/all" suffix prevents the pc-bios/ parts of the build
from running.

In the meanwhile, -Wall has moved from QEMU_CFLAGS to CFLAGS.  Simplify
everything by not passing down CFLAGS, and add -Wall in the recursive
Makefiles.

Reported-by: Miroslav Rezanina <mrezanin@redhat.com>
Reviewed-by: Miroslav Rezanina <mrezanin@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Fixes: 5e6d1573b4 ("remove Makefile.target", 2020-08-21)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                   |  4 ++--
 pc-bios/optionrom/Makefile | 10 +++-------
 pc-bios/s390-ccw/Makefile  |  3 ++-
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index f187ddf47a..c1a93c66a0 100644
--- a/Makefile
+++ b/Makefile
@@ -186,10 +186,10 @@ ROM_DIRS_RULES=$(foreach t, all clean, $(addsuffix /$(t), $(ROM_DIRS)))
 # Only keep -O and -g cflags
 .PHONY: $(ROM_DIRS_RULES)
 $(ROM_DIRS_RULES):
-	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V="$(V)" TARGET_DIR="$(dir $@)" CFLAGS="$(filter -O% -g%,$(CFLAGS))" $(notdir $@),)
+	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V="$(V)" TARGET_DIR="$(dir $@)" $(notdir $@),)
 
 .PHONY: recurse-all recurse-clean
-recurse-all: $(ROM_DIRS)
+recurse-all: $(addsuffix /all, $(ROM_DIRS))
 recurse-clean: $(addsuffix /clean, $(ROM_DIRS))
 
 ######################################################################
diff --git a/pc-bios/optionrom/Makefile b/pc-bios/optionrom/Makefile
index 51cb6ca9d8..084fc10f05 100644
--- a/pc-bios/optionrom/Makefile
+++ b/pc-bios/optionrom/Makefile
@@ -8,15 +8,12 @@ all: multiboot.bin linuxboot.bin linuxboot_dma.bin kvmvapic.bin pvh.bin
 	@true
 
 include ../../config-host.mak
+CFLAGS = -O2 -g
 
 quiet-command = $(if $(V),$1,$(if $(2),@printf "  %-7s %s\n" $2 $3 && $1, @$1))
-cc-option = $(if $(shell $(CC) $1 -S -o /dev/null -xc /dev/null >/dev/null 2>&1 && echo OK), $1, $2)
+cc-option = $(if $(shell $(CC) $1 -c -o /dev/null -xc /dev/null >/dev/null 2>&1 && echo OK), $1, $2)
 
-# Compiling with no optimization creates ROMs that are too large
-ifeq ($(lastword $(filter -O%, -O0 $(CFLAGS))),-O0)
-override CFLAGS += -O2
-endif
-override CFLAGS += -march=i486
+override CFLAGS += -march=i486 -Wall
 
 # Flags for dependency generation
 override CPPFLAGS += -MMD -MP -MT $@ -MF $(@D)/$(*F).d
@@ -42,7 +39,6 @@ Wa = -Wa,
 override ASFLAGS += -32
 override CFLAGS += $(call cc-option, $(Wa)-32)
 
-
 LD_I386_EMULATION ?= elf_i386
 override LDFLAGS = -m $(LD_I386_EMULATION) -T $(SRC_DIR)/flat.lds
 override LDFLAGS += $(LDFLAGS_NOPIE)
diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index cc0f77baa6..3eb785048a 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -3,6 +3,7 @@ all: build-all
 	@true
 
 include ../../config-host.mak
+CFLAGS = -O2 -g
 
 quiet-command = $(if $(V),$1,$(if $(2),@printf "  %-7s %s\n" $2 $3 && $1, @$1))
 cc-option = $(if $(shell $(CC) $1 -S -o /dev/null -xc /dev/null > /dev/null \
@@ -28,7 +29,7 @@ QEMU_DGFLAGS = -MMD -MP -MT $@ -MF $(@D)/$(*F).d
 OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o \
 	  virtio.o virtio-scsi.o virtio-blkdev.o libc.o cio.o dasd-ipl.o
 
-QEMU_CFLAGS := $(filter -W%, $(QEMU_CFLAGS))
+QEMU_CFLAGS := -Wall $(filter -W%, $(QEMU_CFLAGS))
 QEMU_CFLAGS += -ffreestanding -fno-delete-null-pointer-checks -msoft-float
 QEMU_CFLAGS += -march=z900 -fPIE -fno-strict-aliasing
 QEMU_CFLAGS += -fno-asynchronous-unwind-tables
-- 
2.26.2



