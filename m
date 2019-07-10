Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B4AC74A21
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 16:24:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9997A2086D
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 16:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkGHA/9H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9997A2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlFOZ-0005yl-Sd
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 12:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55452)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hlFFB-00069m-Ao
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 12:15:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hlFEy-0007be-44
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 12:14:51 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52808)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hlFEv-0007SQ-3M
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 12:14:42 -0400
Received: by mail-wm1-x343.google.com with SMTP id s3so2906552wms.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 09:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=XBXetcnl+3lGp1Ju/vKIl3WrhNFDmrPMF1HfHg0o8HE=;
 b=IkGHA/9HP6BEp9aH4Y8PDBOrNS7AM27aLIT4/abDr1QqQvsbgO6Rcc27JDTHBNMsOe
 y7S5hUZH9jHt+sCJwYzD8niD3eqFWPMGEOMlJuV/L3jgJ/Qh6jYQjnPQTZcJPYRJWPKv
 wibbaiUbmL/cmcn6SKxzMdaa+cOwGYjqzrB93FxvLZRkfM5ZpLdHa66yRbet4loS9EMu
 n32wo7w1JfX6xqL2Of7dwPNTe7dj0XBjcL+BQ0S9A4Wn2OSq8aCjfXv3yckCPrT2psXd
 uOTZvCKEXjUdlQ5JzJ9wK8VoAzMRA3PYp0iqCMmJi4badaZMQ0BPyKENPtkAV2zrUQ8f
 iKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=XBXetcnl+3lGp1Ju/vKIl3WrhNFDmrPMF1HfHg0o8HE=;
 b=LPy5/cA/uYH+vp2BEPhsMk7Tl8L4h9OrQ4v6bRxaoTrF+XDuYKDYcawxdqpiAioWll
 i/krh50Vy6zHagcQmnsVlhmvPBo3TvkRxeoReXc3F11Go2dlseuqcg5yF0E/Bxd8IHug
 CnMi4ldE47B6cdplyUZuwYFvtQbI+h0fVz/AH8cO1RAeGB985tOJWgUcm4EjyguQciJ6
 HVqwMBoTSQjjr6keItVzLmeNVMOx/qO2dg4GTTqPot/GwaIWlgUig5iAUSY+siBQ7+8l
 TtHSJz8CgasNFE53xxCOLWozDfi79KWSm0jAK2TG/DOeNexvyE2Uyy2CotMIfryNigvN
 se8A==
X-Gm-Message-State: APjAAAUBtAWHxo4eSHu56L67CUInDqlXddxPMwNcdSTA5Stu1f/tZwNV
 AA1OMpIoN8mefufF8Wi51o5WzxkmnwY=
X-Google-Smtp-Source: APXvYqwsqFKrwZ5oM8X5aJmP2xFcfIrJr9Bs7g4yYwPXtru+8ZdCRjDYeNUYH5xROHjk2cottPrh2g==
X-Received: by 2002:a1c:9c4d:: with SMTP id f74mr5954441wme.156.1562775275172; 
 Wed, 10 Jul 2019 09:14:35 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id w14sm2573747wrk.44.2019.07.10.09.14.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jul 2019 09:14:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 10 Jul 2019 18:14:23 +0200
Message-Id: <1562775267-1222-5-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562775267-1222-1-git-send-email-pbonzini@redhat.com>
References: <1562775267-1222-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH 4/8] convert libqemuutil to meson
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 berrange@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This shows how to do some "computations" in meson.build using its array
and dictionary data structures, and also a basic usage of the sourceset
module for conditional compilation.

Overall the look of the meson.build code is quite good, however Meson
doesn't enjoy the same flexibility we have with Make in choosing
the include path.  In particular the tracing headers are using
$(build_root)/$(<D); for now my solution is to generate headers like
"trace/trace-audio.h" and have sixty one-line forwarding headers in the
source tree; for example "audio/trace.h" includes "trace/trace-audio.h".
I'm not sure if it's possible to instead add a one-line "generate
trace headers" directive to each subdirectory's meson.build file.
I suspect that it _is_ possible but you'd still have to change the
include directives to include the subdirectory name (and then I prefer
the forwarding headers).

The overall lines delta would be negative if it weren't for the forwarding
headers.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitignore                       |   8 +-
 Makefile                         | 172 ++++++---------------------------------
 Makefile.objs                    |  88 +-------------------
 audio/trace.h                    |   1 +
 chardev/trace.h                  |   1 +
 crypto/Makefile.objs             |   3 +-
 hw/9pfs/trace.h                  |   1 +
 hw/acpi/trace.h                  |   1 +
 hw/alpha/trace.h                 |   1 +
 hw/arm/trace.h                   |   1 +
 hw/audio/trace.h                 |   1 +
 hw/block/dataplane/trace.h       |   1 +
 hw/block/trace.h                 |   1 +
 hw/char/trace.h                  |   1 +
 hw/display/trace.h               |   1 +
 hw/dma/trace.h                   |   1 +
 hw/gpio/trace.h                  |   1 +
 hw/hppa/trace.h                  |   1 +
 hw/i2c/trace.h                   |   1 +
 hw/i386/trace.h                  |   1 +
 hw/i386/xen/trace.h              |   1 +
 hw/ide/trace.h                   |   1 +
 hw/input/trace.h                 |   1 +
 hw/intc/trace.h                  |   1 +
 hw/isa/trace.h                   |   1 +
 hw/mem/trace.h                   |   1 +
 hw/misc/macio/trace.h            |   1 +
 hw/misc/trace.h                  |   1 +
 hw/net/trace.h                   |   1 +
 hw/nvram/trace.h                 |   1 +
 hw/pci-host/trace.h              |   1 +
 hw/pci/trace.h                   |   1 +
 hw/ppc/trace.h                   |   1 +
 hw/rdma/trace.h                  |   1 +
 hw/rdma/vmw/trace.h              |   1 +
 hw/riscv/trace.h                 |   1 +
 hw/s390x/trace.h                 |   1 +
 hw/scsi/trace.h                  |   1 +
 hw/sd/trace.h                    |   1 +
 hw/sparc/trace.h                 |   1 +
 hw/sparc64/trace.h               |   1 +
 hw/timer/trace.h                 |   1 +
 hw/tpm/trace.h                   |   1 +
 hw/usb/trace.h                   |   1 +
 hw/vfio/trace.h                  |   1 +
 hw/virtio/trace.h                |   1 +
 hw/watchdog/trace.h              |   1 +
 hw/xen/trace.h                   |   1 +
 meson.build                      | 129 +++++++++++++++++++++++++++++
 migration/trace.h                |   1 +
 net/trace.h                      |   1 +
 qapi/Makefile.objs               |  20 -----
 qapi/meson.build                 |  54 ++++++++++++
 qapi/trace.h                     |   1 +
 qobject/Makefile.objs            |   3 -
 qobject/meson.build              |   3 +
 qom/trace.h                      |   1 +
 scripts/qapi-gen.py              |   2 +-
 scripts/tracetool.py             |   2 +-
 scripts/tracetool/backend/ust.py |   6 +-
 scripts/tracetool/format/c.py    |   5 +-
 stubs/Makefile.objs              |  43 ----------
 stubs/meson.build                |  45 ++++++++++
 target/arm/trace.h               |   1 +
 target/hppa/trace.h              |   1 +
 target/i386/trace.h              |   1 +
 target/mips/trace.h              |   1 +
 target/ppc/trace.h               |   1 +
 target/riscv/trace.h             |   1 +
 target/s390x/trace.h             |   1 +
 target/sparc/trace.h             |   1 +
 trace/Makefile.objs              |  51 ------------
 trace/meson.build                |  75 +++++++++++++++++
 ui/trace.h                       |   1 +
 util/Makefile.objs               |  59 --------------
 util/meson.build                 |  57 +++++++++++++
 util/trace.h                     |   1 +
 77 files changed, 455 insertions(+), 428 deletions(-)
 create mode 100644 audio/trace.h
 create mode 100644 chardev/trace.h
 create mode 100644 hw/9pfs/trace.h
 create mode 100644 hw/acpi/trace.h
 create mode 100644 hw/alpha/trace.h
 create mode 100644 hw/arm/trace.h
 create mode 100644 hw/audio/trace.h
 create mode 100644 hw/block/dataplane/trace.h
 create mode 100644 hw/block/trace.h
 create mode 100644 hw/char/trace.h
 create mode 100644 hw/display/trace.h
 create mode 100644 hw/dma/trace.h
 create mode 100644 hw/gpio/trace.h
 create mode 100644 hw/hppa/trace.h
 create mode 100644 hw/i2c/trace.h
 create mode 100644 hw/i386/trace.h
 create mode 100644 hw/i386/xen/trace.h
 create mode 100644 hw/ide/trace.h
 create mode 100644 hw/input/trace.h
 create mode 100644 hw/intc/trace.h
 create mode 100644 hw/isa/trace.h
 create mode 100644 hw/mem/trace.h
 create mode 100644 hw/misc/macio/trace.h
 create mode 100644 hw/misc/trace.h
 create mode 100644 hw/net/trace.h
 create mode 100644 hw/nvram/trace.h
 create mode 100644 hw/pci-host/trace.h
 create mode 100644 hw/pci/trace.h
 create mode 100644 hw/ppc/trace.h
 create mode 100644 hw/rdma/trace.h
 create mode 100644 hw/rdma/vmw/trace.h
 create mode 100644 hw/riscv/trace.h
 create mode 100644 hw/s390x/trace.h
 create mode 100644 hw/scsi/trace.h
 create mode 100644 hw/sd/trace.h
 create mode 100644 hw/sparc/trace.h
 create mode 100644 hw/sparc64/trace.h
 create mode 100644 hw/timer/trace.h
 create mode 100644 hw/tpm/trace.h
 create mode 100644 hw/usb/trace.h
 create mode 100644 hw/vfio/trace.h
 create mode 100644 hw/virtio/trace.h
 create mode 100644 hw/watchdog/trace.h
 create mode 100644 hw/xen/trace.h
 create mode 100644 migration/trace.h
 create mode 100644 net/trace.h
 create mode 100644 qapi/meson.build
 create mode 100644 qapi/trace.h
 delete mode 100644 qobject/Makefile.objs
 create mode 100644 qobject/meson.build
 create mode 100644 qom/trace.h
 delete mode 100644 stubs/Makefile.objs
 create mode 100644 stubs/meson.build
 create mode 100644 target/arm/trace.h
 create mode 100644 target/hppa/trace.h
 create mode 100644 target/i386/trace.h
 create mode 100644 target/mips/trace.h
 create mode 100644 target/ppc/trace.h
 create mode 100644 target/riscv/trace.h
 create mode 100644 target/s390x/trace.h
 create mode 100644 target/sparc/trace.h
 create mode 100644 trace/meson.build
 create mode 100644 ui/trace.h
 delete mode 100644 util/Makefile.objs
 create mode 100644 util/meson.build
 create mode 100644 util/trace.h

diff --git a/.gitignore b/.gitignore
index fd6e6c3..026dded 100644
--- a/.gitignore
+++ b/.gitignore
@@ -141,16 +141,10 @@ docker-src.*
 *~
 *.ast_raw
 *.depend_raw
-trace.h
+/trace/trace-*.h
 trace.c
-trace-ust.h
-trace-ust.h
 trace-dtrace.h
 trace-dtrace.dtrace
-trace-root.h
-trace-root.c
-trace-ust-root.h
-trace-ust-root.h
 trace-ust-all.h
 trace-ust-all.c
 trace-dtrace-root.h
diff --git a/Makefile b/Makefile
index 7636cec..ddc7d27 100644
--- a/Makefile
+++ b/Makefile
@@ -115,24 +115,6 @@ FULL_VERSION := $(if $(QEMU_PKGVERSION),$(VERSION) ($(QEMU_PKGVERSION)),$(VERSIO
 
 generated-files-y = qemu-version.h config-host.h qemu-options.def
 
-GENERATED_QAPI_FILES = qapi/qapi-builtin-types.h qapi/qapi-builtin-types.c
-GENERATED_QAPI_FILES += qapi/qapi-types.h qapi/qapi-types.c
-GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-types-%.h)
-GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-types-%.c)
-GENERATED_QAPI_FILES += qapi/qapi-builtin-visit.h qapi/qapi-builtin-visit.c
-GENERATED_QAPI_FILES += qapi/qapi-visit.h qapi/qapi-visit.c
-GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-visit-%.h)
-GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-visit-%.c)
-GENERATED_QAPI_FILES += qapi/qapi-commands.h qapi/qapi-commands.c
-GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-commands-%.h)
-GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-commands-%.c)
-GENERATED_QAPI_FILES += qapi/qapi-emit-events.h qapi/qapi-emit-events.c
-GENERATED_QAPI_FILES += qapi/qapi-events.h qapi/qapi-events.c
-GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-events-%.h)
-GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-events-%.c)
-GENERATED_QAPI_FILES += qapi/qapi-introspect.c qapi/qapi-introspect.h
-GENERATED_QAPI_FILES += qapi/qapi-doc.texi
-
 generated-files-y += $(GENERATED_QAPI_FILES)
 
 generated-files-y += trace/generated-tcg-tracers.h
@@ -141,132 +123,50 @@ generated-files-y += trace/generated-helpers-wrappers.h
 generated-files-y += trace/generated-helpers.h
 generated-files-y += trace/generated-helpers.c
 
-generated-files-$(CONFIG_TRACE_UST) += trace-ust-all.h
-generated-files-$(CONFIG_TRACE_UST) += trace-ust-all.c
-
 generated-files-y += module_block.h
 
-TRACE_HEADERS = trace-root.h $(trace-events-subdirs:%=%/trace.h)
-TRACE_SOURCES = trace-root.c $(trace-events-subdirs:%=%/trace.c)
-TRACE_DTRACE =
-ifdef CONFIG_TRACE_DTRACE
-TRACE_HEADERS += trace-dtrace-root.h $(trace-events-subdirs:%=%/trace-dtrace.h)
-TRACE_DTRACE += trace-dtrace-root.dtrace $(trace-events-subdirs:%=%/trace-dtrace.dtrace)
-endif
-ifdef CONFIG_TRACE_UST
-TRACE_HEADERS += trace-ust-root.h $(trace-events-subdirs:%=%/trace-ust.h)
-endif
-
-generated-files-y += $(TRACE_HEADERS)
-generated-files-y += $(TRACE_SOURCES)
-generated-files-y += $(BUILD_DIR)/trace-events-all
 generated-files-y += .git-submodule-status
 
-trace-group-name = $(shell dirname $1 | sed -e 's/[^a-zA-Z0-9]/_/g')
-
 tracetool-y = $(SRC_PATH)/scripts/tracetool.py
 tracetool-y += $(shell find $(SRC_PATH)/scripts/tracetool -name "*.py")
 
-%/trace.h: %/trace.h-timestamp
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-%/trace.h-timestamp: $(SRC_PATH)/%/trace-events $(tracetool-y) $(BUILD_DIR)/config-host.mak
-	$(call quiet-command,$(TRACETOOL) \
-		--group=$(call trace-group-name,$@) \
-		--format=h \
-		--backends=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(@:%-timestamp=%)")
-
-%/trace.c: %/trace.c-timestamp
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-%/trace.c-timestamp: $(SRC_PATH)/%/trace-events $(tracetool-y) $(BUILD_DIR)/config-host.mak
-	$(call quiet-command,$(TRACETOOL) \
-		--group=$(call trace-group-name,$@) \
-		--format=c \
-		--backends=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(@:%-timestamp=%)")
-
-%/trace-ust.h: %/trace-ust.h-timestamp
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-%/trace-ust.h-timestamp: $(SRC_PATH)/%/trace-events $(tracetool-y) $(BUILD_DIR)/config-host.mak
-	$(call quiet-command,$(TRACETOOL) \
-		--group=$(call trace-group-name,$@) \
-		--format=ust-events-h \
-		--backends=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(@:%-timestamp=%)")
-
-%/trace-dtrace.dtrace: %/trace-dtrace.dtrace-timestamp
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-%/trace-dtrace.dtrace-timestamp: $(SRC_PATH)/%/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
-	$(call quiet-command,$(TRACETOOL) \
-		--group=$(call trace-group-name,$@) \
-		--format=d \
-		--backends=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(@:%-timestamp=%)")
-
-%/trace-dtrace.h: %/trace-dtrace.dtrace $(tracetool-y)
-	$(call quiet-command,dtrace -o $@ -h -s $<, "GEN","$@")
-
-%/trace-dtrace.o: %/trace-dtrace.dtrace $(tracetool-y)
-
-
-trace-root.h: trace-root.h-timestamp
+trace/generated-helpers-wrappers.h: trace/generated-helpers-wrappers.h-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-trace-root.h-timestamp: $(SRC_PATH)/trace-events $(tracetool-y) $(BUILD_DIR)/config-host.mak
+trace/generated-helpers-wrappers.h-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
 		--group=root \
-		--format=h \
-		--backends=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(@:%-timestamp=%)")
+		--format=tcg-helper-wrapper-h \
+		--backend=$(TRACE_BACKENDS) \
+		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
 
-trace-root.c: trace-root.c-timestamp
+trace/generated-helpers.h: trace/generated-helpers.h-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-trace-root.c-timestamp: $(SRC_PATH)/trace-events $(tracetool-y) $(BUILD_DIR)/config-host.mak
+trace/generated-helpers.h-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
 		--group=root \
-		--format=c \
-		--backends=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(@:%-timestamp=%)")
+		--format=tcg-helper-h \
+		--backend=$(TRACE_BACKENDS) \
+		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
 
-trace-ust-root.h: trace-ust-root.h-timestamp
+trace/generated-helpers.c: trace/generated-helpers.c-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-trace-ust-root.h-timestamp: $(SRC_PATH)/trace-events $(tracetool-y) $(BUILD_DIR)/config-host.mak
+trace/generated-helpers.c-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
 		--group=root \
-		--format=ust-events-h \
-		--backends=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(@:%-timestamp=%)")
+		--format=tcg-helper-c \
+		--backend=$(TRACE_BACKENDS) \
+		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
 
-trace-ust-all.h: trace-ust-all.h-timestamp
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-trace-ust-all.h-timestamp: $(trace-events-files) $(tracetool-y) $(BUILD_DIR)/config-host.mak
-	$(call quiet-command,$(TRACETOOL) \
-		--group=all \
-		--format=ust-events-h \
-		--backends=$(TRACE_BACKENDS) \
-		$(trace-events-files) > $@,"GEN","$(@:%-timestamp=%)")
-
-trace-ust-all.c: trace-ust-all.c-timestamp
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-trace-ust-all.c-timestamp: $(trace-events-files) $(tracetool-y) $(BUILD_DIR)/config-host.mak
-	$(call quiet-command,$(TRACETOOL) \
-		--group=all \
-		--format=ust-events-c \
-		--backends=$(TRACE_BACKENDS) \
-		$(trace-events-files) > $@,"GEN","$(@:%-timestamp=%)")
+trace/generated-helpers.o: trace/generated-helpers.c
 
-trace-dtrace-root.dtrace: trace-dtrace-root.dtrace-timestamp
+trace/generated-tcg-tracers.h: trace/generated-tcg-tracers.h-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-trace-dtrace-root.dtrace-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
+trace/generated-tcg-tracers.h-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
 		--group=root \
-		--format=d \
-		--backends=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(@:%-timestamp=%)")
-
-trace-dtrace-root.h: trace-dtrace-root.dtrace
-	$(call quiet-command,dtrace -o $@ -h -s $<, "GEN","$@")
-
-trace-dtrace-root.o: trace-dtrace-root.dtrace
+		--format=tcg-h \
+		--backend=$(TRACE_BACKENDS) \
+		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
 
 KEYCODEMAP_GEN = $(SRC_PATH)/ui/keycodemapdb/tools/keymap-gen
 KEYCODEMAP_CSV = $(SRC_PATH)/ui/keycodemapdb/data/keymaps.csv
@@ -416,10 +316,8 @@ include $(SRC_PATH)/Makefile.objs
 endif
 
 dummy := $(call unnest-vars,, \
-                stub-obj-y \
                 authz-obj-y \
                 chardev-obj-y \
-                util-obj-y \
                 qga-obj-y \
                 elf2dmp-obj-y \
                 ivshmem-client-obj-y \
@@ -442,8 +340,7 @@ dummy := $(call unnest-vars,, \
                 ui-obj-y \
                 ui-obj-m \
                 audio-obj-y \
-                audio-obj-m \
-                trace-obj-y)
+                audio-obj-m)
 
 include $(SRC_PATH)/tests/Makefile.include
 
@@ -527,8 +424,7 @@ Makefile: $(version-obj-y)
 ######################################################################
 # Build libraries
 
-libqemuutil.a: $(util-obj-y) $(trace-obj-y) $(stub-obj-y)
-libvhost-user.a: $(libvhost-user-obj-y) $(util-obj-y) $(stub-obj-y)
+libvhost-user.a: $(libvhost-user-obj-y)
 
 ######################################################################
 
@@ -583,16 +479,6 @@ qga/qapi-generated/qapi-gen-timestamp: $(SRC_PATH)/qga/qapi-schema.json $(qapi-p
 		"GEN","$(@:%-timestamp=%)")
 	@>$@
 
-qapi-modules = $(SRC_PATH)/qapi/qapi-schema.json \
-               $(QAPI_MODULES:%=$(SRC_PATH)/qapi/%.json)
-
-$(GENERATED_QAPI_FILES): qapi-gen-timestamp ;
-qapi-gen-timestamp: $(qapi-modules) $(qapi-py)
-	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
-		-o "qapi" -b $<, \
-		"GEN","$(@:%-timestamp=%)")
-	@>$@
-
 QGALIB_GEN=$(addprefix qga/qapi-generated/, qga-qapi-types.h qga-qapi-visit.h qga-qapi-commands.h)
 $(qga-obj-y): $(QGALIB_GEN)
 
@@ -631,21 +517,21 @@ ivshmem-client$(EXESUF): $(ivshmem-client-obj-y) $(COMMON_LDADDS)
 ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $^)
 endif
-vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y) libvhost-user.a
+vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y) libvhost-user.a $(COMMON_LDADDS)
 	$(call LINK, $^)
-vhost-user-blk$(EXESUF): $(vhost-user-blk-obj-y) libvhost-user.a
+vhost-user-blk$(EXESUF): $(vhost-user-blk-obj-y) libvhost-user.a $(COMMON_LDADDS)
 	$(call LINK, $^)
 
 rdmacm-mux$(EXESUF): LIBS += "-libumad"
 rdmacm-mux$(EXESUF): $(rdmacm-mux-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $^)
 
-vhost-user-gpu$(EXESUF): $(vhost-user-gpu-obj-y) $(libvhost-user-obj-y) libqemuutil.a libqemustub.a
+vhost-user-gpu$(EXESUF): $(vhost-user-gpu-obj-y) $(libvhost-user-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $^)
 
 ifdef CONFIG_VHOST_USER_INPUT
 ifdef CONFIG_LINUX
-vhost-user-input$(EXESUF): $(vhost-user-input-obj-y) libvhost-user.a libqemuutil.a
+vhost-user-input$(EXESUF): $(vhost-user-input-obj-y) libvhost-user.a $(COMMON_LDADDS)
 	$(call LINK, $^)
 
 # build by default, do not install
@@ -1117,10 +1003,6 @@ Makefile: $(generated-files-y)
 endif
 endif
 
-.SECONDARY: $(TRACE_HEADERS) $(TRACE_HEADERS:%=%-timestamp) \
-	$(TRACE_SOURCES) $(TRACE_SOURCES:%=%-timestamp) \
-	$(TRACE_DTRACE) $(TRACE_DTRACE:%=%-timestamp)
-
 # Include automatically generated dependency files
 # Dependencies in Makefile.objs files come from our recursive subdir rules
 -include $(wildcard *.d tests/*.d)
diff --git a/Makefile.objs b/Makefile.objs
index 658cfc9..29ffaa3 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -1,8 +1,5 @@
 #######################################################################
-# Common libraries for tools and emulators
-stub-obj-y = stubs/ util/ crypto/
-util-obj-y = util/ qobject/ qapi/
-
+# chardev-obj-y is code used by both qemu system emulation and some tests
 chardev-obj-y = chardev/
 
 #######################################################################
@@ -127,86 +124,3 @@ vhost-user-input-obj-y = contrib/vhost-user-input/
 vhost-user-gpu-obj-y = contrib/vhost-user-gpu/
 
 ######################################################################
-trace-events-subdirs =
-trace-events-subdirs += accel/kvm
-trace-events-subdirs += accel/tcg
-trace-events-subdirs += crypto
-trace-events-subdirs += monitor
-ifeq ($(CONFIG_USER_ONLY),y)
-trace-events-subdirs += linux-user
-endif
-ifeq ($(CONFIG_BLOCK),y)
-trace-events-subdirs += authz
-trace-events-subdirs += block
-trace-events-subdirs += io
-trace-events-subdirs += nbd
-trace-events-subdirs += scsi
-endif
-ifeq ($(CONFIG_SOFTMMU),y)
-trace-events-subdirs += chardev
-trace-events-subdirs += audio
-trace-events-subdirs += hw/9pfs
-trace-events-subdirs += hw/acpi
-trace-events-subdirs += hw/alpha
-trace-events-subdirs += hw/arm
-trace-events-subdirs += hw/audio
-trace-events-subdirs += hw/block
-trace-events-subdirs += hw/block/dataplane
-trace-events-subdirs += hw/char
-trace-events-subdirs += hw/dma
-trace-events-subdirs += hw/hppa
-trace-events-subdirs += hw/i2c
-trace-events-subdirs += hw/i386
-trace-events-subdirs += hw/i386/xen
-trace-events-subdirs += hw/ide
-trace-events-subdirs += hw/input
-trace-events-subdirs += hw/intc
-trace-events-subdirs += hw/isa
-trace-events-subdirs += hw/mem
-trace-events-subdirs += hw/misc
-trace-events-subdirs += hw/misc/macio
-trace-events-subdirs += hw/net
-trace-events-subdirs += hw/nvram
-trace-events-subdirs += hw/pci
-trace-events-subdirs += hw/pci-host
-trace-events-subdirs += hw/ppc
-trace-events-subdirs += hw/rdma
-trace-events-subdirs += hw/rdma/vmw
-trace-events-subdirs += hw/s390x
-trace-events-subdirs += hw/scsi
-trace-events-subdirs += hw/sd
-trace-events-subdirs += hw/sparc
-trace-events-subdirs += hw/sparc64
-trace-events-subdirs += hw/timer
-trace-events-subdirs += hw/tpm
-trace-events-subdirs += hw/usb
-trace-events-subdirs += hw/vfio
-trace-events-subdirs += hw/virtio
-trace-events-subdirs += hw/watchdog
-trace-events-subdirs += hw/xen
-trace-events-subdirs += hw/gpio
-trace-events-subdirs += hw/riscv
-trace-events-subdirs += migration
-trace-events-subdirs += net
-trace-events-subdirs += ui
-endif
-trace-events-subdirs += hw/display
-trace-events-subdirs += qapi
-trace-events-subdirs += qom
-trace-events-subdirs += target/arm
-trace-events-subdirs += target/hppa
-trace-events-subdirs += target/i386
-trace-events-subdirs += target/mips
-trace-events-subdirs += target/ppc
-trace-events-subdirs += target/riscv
-trace-events-subdirs += target/s390x
-trace-events-subdirs += target/sparc
-trace-events-subdirs += util
-
-trace-events-files = $(SRC_PATH)/trace-events $(trace-events-subdirs:%=$(SRC_PATH)/%/trace-events)
-
-trace-obj-y = trace-root.o
-trace-obj-y += $(trace-events-subdirs:%=%/trace.o)
-trace-obj-$(CONFIG_TRACE_UST) += trace-ust-all.o
-trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace-root.o
-trace-obj-$(CONFIG_TRACE_DTRACE) += $(trace-events-subdirs:%=%/trace-dtrace.o)
diff --git a/audio/trace.h b/audio/trace.h
new file mode 100644
index 0000000..f6a23d0
--- /dev/null
+++ b/audio/trace.h
@@ -0,0 +1 @@
+#include "trace-audio.h"
diff --git a/chardev/trace.h b/chardev/trace.h
new file mode 100644
index 0000000..a23cbd9
--- /dev/null
+++ b/chardev/trace.h
@@ -0,0 +1 @@
+#include "trace-chardev.h"
diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
index 7fe2fa9..3481529 100644
--- a/crypto/Makefile.objs
+++ b/crypto/Makefile.objs
@@ -26,6 +26,7 @@ crypto-obj-y += $(crypto-rng-obj-y)
 crypto-obj-y += pbkdf.o
 crypto-obj-$(CONFIG_NETTLE) += pbkdf-nettle.o
 crypto-obj-$(if $(CONFIG_NETTLE),n,$(CONFIG_GCRYPT)) += pbkdf-gcrypt.o
+crypto-obj-$(if $(CONFIG_NETTLE),n,$(if $(CONFIG_GCRYPT),n,y)) += pbkdf-stub.o
 crypto-obj-y += ivgen.o
 crypto-obj-y += ivgen-essiv.o
 crypto-obj-y += ivgen-plain.o
@@ -38,5 +39,3 @@ crypto-obj-y += block-luks.o
 
 # Let the userspace emulators avoid linking stuff they won't use.
 crypto-user-obj-y = aes.o $(crypto-rng-obj-y) init.o
-
-stub-obj-y += pbkdf-stub.o
diff --git a/hw/9pfs/trace.h b/hw/9pfs/trace.h
new file mode 100644
index 0000000..7a52216
--- /dev/null
+++ b/hw/9pfs/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_9pfs.h"
diff --git a/hw/acpi/trace.h b/hw/acpi/trace.h
new file mode 100644
index 0000000..9010bfb
--- /dev/null
+++ b/hw/acpi/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_acpi.h"
diff --git a/hw/alpha/trace.h b/hw/alpha/trace.h
new file mode 100644
index 0000000..538e214
--- /dev/null
+++ b/hw/alpha/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_alpha.h"
diff --git a/hw/arm/trace.h b/hw/arm/trace.h
new file mode 100644
index 0000000..9430035
--- /dev/null
+++ b/hw/arm/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_arm.h"
diff --git a/hw/audio/trace.h b/hw/audio/trace.h
new file mode 100644
index 0000000..f505dc8
--- /dev/null
+++ b/hw/audio/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_audio.h"
diff --git a/hw/block/dataplane/trace.h b/hw/block/dataplane/trace.h
new file mode 100644
index 0000000..eb93e4c
--- /dev/null
+++ b/hw/block/dataplane/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_block_dataplane.h"
diff --git a/hw/block/trace.h b/hw/block/trace.h
new file mode 100644
index 0000000..c968c14
--- /dev/null
+++ b/hw/block/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_block.h"
diff --git a/hw/char/trace.h b/hw/char/trace.h
new file mode 100644
index 0000000..253410d
--- /dev/null
+++ b/hw/char/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_char.h"
diff --git a/hw/display/trace.h b/hw/display/trace.h
new file mode 100644
index 0000000..c9f362f
--- /dev/null
+++ b/hw/display/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_display.h"
diff --git a/hw/dma/trace.h b/hw/dma/trace.h
new file mode 100644
index 0000000..b370b8d
--- /dev/null
+++ b/hw/dma/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_dma.h"
diff --git a/hw/gpio/trace.h b/hw/gpio/trace.h
new file mode 100644
index 0000000..8af38f3
--- /dev/null
+++ b/hw/gpio/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_gpio.h"
diff --git a/hw/hppa/trace.h b/hw/hppa/trace.h
new file mode 100644
index 0000000..120e4c1
--- /dev/null
+++ b/hw/hppa/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_hppa.h"
diff --git a/hw/i2c/trace.h b/hw/i2c/trace.h
new file mode 100644
index 0000000..98f2575
--- /dev/null
+++ b/hw/i2c/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_i2c.h"
diff --git a/hw/i386/trace.h b/hw/i386/trace.h
new file mode 100644
index 0000000..0b907d5
--- /dev/null
+++ b/hw/i386/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_i386.h"
diff --git a/hw/i386/xen/trace.h b/hw/i386/xen/trace.h
new file mode 100644
index 0000000..036826b
--- /dev/null
+++ b/hw/i386/xen/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_i386_xen.h"
diff --git a/hw/ide/trace.h b/hw/ide/trace.h
new file mode 100644
index 0000000..b005fdd
--- /dev/null
+++ b/hw/ide/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_ide.h"
diff --git a/hw/input/trace.h b/hw/input/trace.h
new file mode 100644
index 0000000..55c5fa9
--- /dev/null
+++ b/hw/input/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_input.h"
diff --git a/hw/intc/trace.h b/hw/intc/trace.h
new file mode 100644
index 0000000..440cca5
--- /dev/null
+++ b/hw/intc/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_intc.h"
diff --git a/hw/isa/trace.h b/hw/isa/trace.h
new file mode 100644
index 0000000..b92d71b
--- /dev/null
+++ b/hw/isa/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_isa.h"
diff --git a/hw/mem/trace.h b/hw/mem/trace.h
new file mode 100644
index 0000000..4458c51
--- /dev/null
+++ b/hw/mem/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_mem.h"
diff --git a/hw/misc/macio/trace.h b/hw/misc/macio/trace.h
new file mode 100644
index 0000000..d314b8d
--- /dev/null
+++ b/hw/misc/macio/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_misc_macio.h"
diff --git a/hw/misc/trace.h b/hw/misc/trace.h
new file mode 100644
index 0000000..9fdef8f
--- /dev/null
+++ b/hw/misc/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_misc.h"
diff --git a/hw/net/trace.h b/hw/net/trace.h
new file mode 100644
index 0000000..44d4a59
--- /dev/null
+++ b/hw/net/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_net.h"
diff --git a/hw/nvram/trace.h b/hw/nvram/trace.h
new file mode 100644
index 0000000..b2e7d101
--- /dev/null
+++ b/hw/nvram/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_nvram.h"
diff --git a/hw/pci-host/trace.h b/hw/pci-host/trace.h
new file mode 100644
index 0000000..6c65988
--- /dev/null
+++ b/hw/pci-host/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_pci_host.h"
diff --git a/hw/pci/trace.h b/hw/pci/trace.h
new file mode 100644
index 0000000..6b95442
--- /dev/null
+++ b/hw/pci/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_pci.h"
diff --git a/hw/ppc/trace.h b/hw/ppc/trace.h
new file mode 100644
index 0000000..f497373
--- /dev/null
+++ b/hw/ppc/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_ppc.h"
diff --git a/hw/rdma/trace.h b/hw/rdma/trace.h
new file mode 100644
index 0000000..d64d31e
--- /dev/null
+++ b/hw/rdma/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_rdma.h"
diff --git a/hw/rdma/vmw/trace.h b/hw/rdma/vmw/trace.h
new file mode 100644
index 0000000..cb46ab2
--- /dev/null
+++ b/hw/rdma/vmw/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_rdma_vmw.h"
diff --git a/hw/riscv/trace.h b/hw/riscv/trace.h
new file mode 100644
index 0000000..5536b81
--- /dev/null
+++ b/hw/riscv/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_riscv.h"
diff --git a/hw/s390x/trace.h b/hw/s390x/trace.h
new file mode 100644
index 0000000..14857bb5c
--- /dev/null
+++ b/hw/s390x/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_s390x.h"
diff --git a/hw/scsi/trace.h b/hw/scsi/trace.h
new file mode 100644
index 0000000..9cb69af
--- /dev/null
+++ b/hw/scsi/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_scsi.h"
diff --git a/hw/sd/trace.h b/hw/sd/trace.h
new file mode 100644
index 0000000..181323c
--- /dev/null
+++ b/hw/sd/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_sd.h"
diff --git a/hw/sparc/trace.h b/hw/sparc/trace.h
new file mode 100644
index 0000000..653a376
--- /dev/null
+++ b/hw/sparc/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_sparc.h"
diff --git a/hw/sparc64/trace.h b/hw/sparc64/trace.h
new file mode 100644
index 0000000..a32d812
--- /dev/null
+++ b/hw/sparc64/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_sparc64.h"
diff --git a/hw/timer/trace.h b/hw/timer/trace.h
new file mode 100644
index 0000000..8daed0f
--- /dev/null
+++ b/hw/timer/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_timer.h"
diff --git a/hw/tpm/trace.h b/hw/tpm/trace.h
new file mode 100644
index 0000000..0156b5c
--- /dev/null
+++ b/hw/tpm/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_tpm.h"
diff --git a/hw/usb/trace.h b/hw/usb/trace.h
new file mode 100644
index 0000000..083bbd4
--- /dev/null
+++ b/hw/usb/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_usb.h"
diff --git a/hw/vfio/trace.h b/hw/vfio/trace.h
new file mode 100644
index 0000000..4b47e88
--- /dev/null
+++ b/hw/vfio/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_vfio.h"
diff --git a/hw/virtio/trace.h b/hw/virtio/trace.h
new file mode 100644
index 0000000..1143dc8
--- /dev/null
+++ b/hw/virtio/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_virtio.h"
diff --git a/hw/watchdog/trace.h b/hw/watchdog/trace.h
new file mode 100644
index 0000000..6ec3ac2
--- /dev/null
+++ b/hw/watchdog/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_watchdog.h"
diff --git a/hw/xen/trace.h b/hw/xen/trace.h
new file mode 100644
index 0000000..9000076
--- /dev/null
+++ b/hw/xen/trace.h
@@ -0,0 +1 @@
+#include "trace-hw_xen.h"
diff --git a/meson.build b/meson.build
index 7615817..c625547 100644
--- a/meson.build
+++ b/meson.build
@@ -1,6 +1,7 @@
 project('qemu', 'c', meson_version: '>=0.50.999')
 
 kconfig = import('unstable-kconfig')
+ss = import('sourceset')
 config_host = kconfig.load(meson.current_build_dir() / 'config-host.mak')
 
 add_project_arguments(config_host['QEMU_CFLAGS'].split(),
@@ -11,3 +12,131 @@ add_project_arguments(config_host['QEMU_INCLUDES'].split(),
 configure_file(input: files('scripts/ninjatool.py'),
                output: 'ninjatool',
                configuration: config_host)
+
+slirp = declare_dependency(compile_args: config_host['SLIRP_CFLAGS'].split(),
+                           link_args: config_host['SLIRP_LIBS'].split())
+
+target_dirs = config_host['TARGET_DIRS'].split()
+have_user = false
+have_system = false
+foreach target : target_dirs
+  have_user = have_user or target.endswith('-user')
+  have_system = have_system or target.endswith('-softmmu')
+endforeach
+have_block = have_system or config_host['TOOLS'] != ''
+
+# Generators
+
+qapi_gen = find_program('scripts/qapi-gen.py')
+qapi_gen_depends = [ meson.source_root() / 'scripts/qapi/events.py',
+                     meson.source_root() / 'scripts/qapi/introspect.py',
+                     meson.source_root() / 'scripts/qapi/types.py',
+                     meson.source_root() / 'scripts/qapi/visit.py',
+                     meson.source_root() / 'scripts/qapi/common.py',
+                     meson.source_root() / 'scripts/qapi/doc.py',
+                     meson.source_root() / 'scripts/qapi-gen.py' ]
+
+# Collect sourcesets.
+
+util_obj = ss.source_set()
+stub_obj = ss.source_set()
+trace_obj = ss.source_set()
+
+# TODO: add each directory to the subdirs from its own meson.build, once
+# we have those
+trace_events_subdirs = [
+  'accel/kvm',
+  'accel/tcg',
+  'crypto',
+  'monitor',
+]
+if have_user
+  trace_events_subdirs += [ 'linux-user' ]
+endif
+if have_block
+  trace_events_subdirs += [
+    'authz',
+    'block',
+    'io',
+    'nbd',
+    'scsi',
+  ]
+endif
+if have_system
+  trace_events_subdirs += [
+    'chardev',
+    'audio',
+    'hw/9pfs',
+    'hw/acpi',
+    'hw/alpha',
+    'hw/arm',
+    'hw/audio',
+    'hw/block',
+    'hw/block/dataplane',
+    'hw/char',
+    'hw/dma',
+    'hw/hppa',
+    'hw/i2c',
+    'hw/i386',
+    'hw/i386/xen',
+    'hw/ide',
+    'hw/input',
+    'hw/intc',
+    'hw/isa',
+    'hw/mem',
+    'hw/misc',
+    'hw/misc/macio',
+    'hw/net',
+    'hw/nvram',
+    'hw/pci',
+    'hw/pci-host',
+    'hw/ppc',
+    'hw/rdma',
+    'hw/rdma/vmw',
+    'hw/s390x',
+    'hw/scsi',
+    'hw/sd',
+    'hw/sparc',
+    'hw/sparc64',
+    'hw/timer',
+    'hw/tpm',
+    'hw/usb',
+    'hw/vfio',
+    'hw/virtio',
+    'hw/watchdog',
+    'hw/xen',
+    'hw/gpio',
+    'hw/riscv',
+    'migration',
+    'net',
+    'ui',
+  ]
+endif
+trace_events_subdirs += [
+  'hw/display',
+  'qapi',
+  'qom',
+  'target/arm',
+  'target/hppa',
+  'target/i386',
+  'target/mips',
+  'target/ppc',
+  'target/riscv',
+  'target/s390x',
+  'target/sparc',
+  'util',
+]
+
+subdir('qapi')
+subdir('qobject')
+subdir('stubs')
+subdir('trace')
+subdir('util')
+
+# Build targets from sourcesets
+
+util_obj.add_all(stub_obj, trace_obj)
+util_obj = util_obj.apply(config_host, strict: false)
+libqemuutil = static_library('qemuutil',
+                             sources: util_obj.sources(),
+                             dependencies: util_obj.dependencies())
diff --git a/migration/trace.h b/migration/trace.h
new file mode 100644
index 0000000..ecd1cfb
--- /dev/null
+++ b/migration/trace.h
@@ -0,0 +1 @@
+#include "trace-migration.h"
diff --git a/net/trace.h b/net/trace.h
new file mode 100644
index 0000000..692ff35
--- /dev/null
+++ b/net/trace.h
@@ -0,0 +1 @@
+#include "trace-net.h"
diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
index 729e518..e4e49c5 100644
--- a/qapi/Makefile.objs
+++ b/qapi/Makefile.objs
@@ -1,24 +1,4 @@
-util-obj-y = qapi-visit-core.o qapi-dealloc-visitor.o qobject-input-visitor.o
-util-obj-y += qobject-output-visitor.o qmp-registry.o qmp-dispatch.o
-util-obj-y += string-input-visitor.o string-output-visitor.o
-util-obj-y += opts-visitor.o qapi-clone-visitor.o
-util-obj-y += qmp-event.o
-util-obj-y += qapi-util.o
-
-QAPI_COMMON_MODULES = audio authz block-core block char common crypto
-QAPI_COMMON_MODULES += introspect job migration misc net rdma rocker
-QAPI_COMMON_MODULES += run-state sockets tpm trace transaction ui
 QAPI_TARGET_MODULES = target
-QAPI_MODULES = $(QAPI_COMMON_MODULES) $(QAPI_TARGET_MODULES)
-
-util-obj-y += qapi-builtin-types.o
-util-obj-y += $(QAPI_COMMON_MODULES:%=qapi-types-%.o)
-util-obj-y += qapi-builtin-visit.o
-util-obj-y += $(QAPI_COMMON_MODULES:%=qapi-visit-%.o)
-util-obj-y += qapi-emit-events.o
-util-obj-y += $(QAPI_COMMON_MODULES:%=qapi-events-%.o)
-
-common-obj-y = $(QAPI_COMMON_MODULES:%=qapi-commands-%.o)
 
 obj-y = qapi-introspect.o
 obj-y += $(QAPI_TARGET_MODULES:%=qapi-types-%.o)
diff --git a/qapi/meson.build b/qapi/meson.build
new file mode 100644
index 0000000..78b63c8
--- /dev/null
+++ b/qapi/meson.build
@@ -0,0 +1,54 @@
+util_obj.add(files('qapi-visit-core.c', 'qapi-dealloc-visitor.c',
+  'qobject-input-visitor.c', 'qobject-output-visitor.c',
+  'qmp-registry.c', 'qmp-dispatch.c',
+  'string-input-visitor.c', 'string-output-visitor.c',
+  'opts-visitor.c', 'qapi-clone-visitor.c',
+  'qmp-event.c', 'qapi-util.c'))
+
+qapi_common_modules = [ 'audio', 'authz', 'block-core', 'block', 'char', 'common',
+  'crypto', 'introspect', 'job', 'migration', 'misc', 'net', 'rdma', 'rocker',
+  'run-state', 'sockets', 'tpm', 'trace', 'transaction', 'ui' ]
+
+qapi_target_modules = [ 'target' ]
+
+qapi_util_outputs = [
+  'qapi-builtin-types.c', 'qapi-builtin-visit.c',
+  'qapi-emit-events.c'
+]
+qapi_all_outputs = qapi_util_outputs
+qapi_inputs = []
+foreach module : qapi_common_modules + qapi_target_modules
+  qapi_module_outputs = [
+    'qapi-types-@0@.c'.format(module),
+    'qapi-types-@0@.h'.format(module),
+    'qapi-visit-@0@.c'.format(module),
+    'qapi-visit-@0@.h'.format(module),
+    'qapi-commands-@0@.c'.format(module),
+    'qapi-commands-@0@.h'.format(module),
+    'qapi-events-@0@.c'.format(module),
+    'qapi-events-@0@.h'.format(module),
+  ]
+  qapi_inputs += [ files(module + '.json') ]
+  qapi_all_outputs += qapi_module_outputs
+  if qapi_common_modules.contains(module)
+    qapi_util_outputs += qapi_module_outputs
+  endif
+endforeach
+
+qapi_all_outputs += [
+  'qapi-introspect.c', 'qapi-introspect.h',
+  'qapi-doc.texi'
+]
+
+qapi_files = custom_target('QAPI files',
+  output: qapi_all_outputs,
+  input: [ files('qapi-schema.json') ],
+  command: [ qapi_gen, '-o', 'qapi', '-b', '@INPUT0@' ],
+  depend_files: [ qapi_inputs, qapi_gen_depends ])
+
+# qapi_util_outputs must be at the beginning of qapi_all_outputs.
+i = 0
+foreach output : qapi_util_outputs
+  util_obj.add(qapi_files[i])
+  i = i + 1
+endforeach
diff --git a/qapi/trace.h b/qapi/trace.h
new file mode 100644
index 0000000..24fdeae
--- /dev/null
+++ b/qapi/trace.h
@@ -0,0 +1 @@
+#include "trace-qapi.h"
diff --git a/qobject/Makefile.objs b/qobject/Makefile.objs
deleted file mode 100644
index 7b12c9c..0000000
--- a/qobject/Makefile.objs
+++ /dev/null
@@ -1,3 +0,0 @@
-util-obj-y = qnull.o qnum.o qstring.o qdict.o qlist.o qbool.o qlit.o
-util-obj-y += qjson.o qobject.o json-lexer.o json-streamer.o json-parser.o
-util-obj-y += block-qdict.o
diff --git a/qobject/meson.build b/qobject/meson.build
new file mode 100644
index 0000000..71aab08
--- /dev/null
+++ b/qobject/meson.build
@@ -0,0 +1,3 @@
+util_obj.add(files('qnull.c', 'qnum.c', 'qstring.c', 'qdict.c', 'qlist.c', 'qbool.c',
+  'qlit.c', 'qjson.c', 'qobject.c', 'json-lexer.c', 'json-streamer.c', 'json-parser.c',
+  'block-qdict.c'))
diff --git a/qom/trace.h b/qom/trace.h
new file mode 100644
index 0000000..bcb532e
--- /dev/null
+++ b/qom/trace.h
@@ -0,0 +1 @@
+#include "trace-qom.h"
diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
index 3d98ca2..c15daac 100755
--- a/scripts/qapi-gen.py
+++ b/scripts/qapi-gen.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 # QAPI generator
 #
 # This work is licensed under the terms of the GNU GPL, version 2 or later.
diff --git a/scripts/tracetool.py b/scripts/tracetool.py
index 3beaa66..264cc9e 100755
--- a/scripts/tracetool.py
+++ b/scripts/tracetool.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 # -*- coding: utf-8 -*-
 
 """
diff --git a/scripts/tracetool/backend/ust.py b/scripts/tracetool/backend/ust.py
index 280cb7c..31d67e1 100644
--- a/scripts/tracetool/backend/ust.py
+++ b/scripts/tracetool/backend/ust.py
@@ -20,11 +20,7 @@ PUBLIC = True
 
 
 def generate_h_begin(events, group):
-    if group == "root":
-        header = "trace-ust-root.h"
-    else:
-        header = "trace-ust.h"
-
+    header = "trace-ust-' + group + '.h"
     out('#include <lttng/tracepoint.h>',
         '#include "%s"' % header,
         '',
diff --git a/scripts/tracetool/format/c.py b/scripts/tracetool/format/c.py
index 833c05a..2c45028 100644
--- a/scripts/tracetool/format/c.py
+++ b/scripts/tracetool/format/c.py
@@ -20,10 +20,7 @@ def generate(events, backend, group):
     active_events = [e for e in events
                      if "disable" not in e.properties]
 
-    if group == "root":
-        header = "trace-root.h"
-    else:
-        header = "trace.h"
+    header = "trace-" + group + ".h"
 
     out('/* This file is autogenerated by tracetool, do not edit. */',
         '',
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
deleted file mode 100644
index 9c7393b..0000000
--- a/stubs/Makefile.objs
+++ /dev/null
@@ -1,43 +0,0 @@
-stub-obj-y += bdrv-next-monitor-owned.o
-stub-obj-y += blk-commit-all.o
-stub-obj-y += blockdev-close-all-bdrv-states.o
-stub-obj-y += clock-warp.o
-stub-obj-y += cpu-get-clock.o
-stub-obj-y += cpu-get-icount.o
-stub-obj-y += dump.o
-stub-obj-y += error-printf.o
-stub-obj-y += fdset.o
-stub-obj-y += gdbstub.o
-stub-obj-y += get-vm-name.o
-stub-obj-y += iothread.o
-stub-obj-y += iothread-lock.o
-stub-obj-y += is-daemonized.o
-stub-obj-$(CONFIG_LINUX_AIO) += linux-aio.o
-stub-obj-y += machine-init-done.o
-stub-obj-y += migr-blocker.o
-stub-obj-y += change-state-handler.o
-stub-obj-y += monitor.o
-stub-obj-y += notify-event.o
-stub-obj-y += qtest.o
-stub-obj-y += replay.o
-stub-obj-y += runstate-check.o
-stub-obj-y += set-fd-handler.o
-stub-obj-y += sysbus.o
-stub-obj-y += tpm.o
-stub-obj-y += trace-control.o
-stub-obj-y += uuid.o
-stub-obj-y += vm-stop.o
-stub-obj-y += vmstate.o
-stub-obj-y += fd-register.o
-stub-obj-y += qmp_memory_device.o
-stub-obj-y += target-monitor-defs.o
-stub-obj-y += target-get-monitor-def.o
-stub-obj-y += pc_madt_cpu_entry.o
-stub-obj-y += vmgenid.o
-stub-obj-y += xen-common.o
-stub-obj-y += xen-hvm.o
-stub-obj-y += pci-host-piix.o
-stub-obj-y += ram-block.o
-stub-obj-y += ramfb.o
-stub-obj-y += fw_cfg.o
-stub-obj-$(CONFIG_SOFTMMU) += semihost.o
diff --git a/stubs/meson.build b/stubs/meson.build
new file mode 100644
index 0000000..655ef86
--- /dev/null
+++ b/stubs/meson.build
@@ -0,0 +1,45 @@
+stub_obj.add(files('bdrv-next-monitor-owned.c'))
+stub_obj.add(files('blk-commit-all.c'))
+stub_obj.add(files('blockdev-close-all-bdrv-states.c'))
+stub_obj.add(files('clock-warp.c'))
+stub_obj.add(files('cpu-get-clock.c'))
+stub_obj.add(files('cpu-get-icount.c'))
+stub_obj.add(files('dump.c'))
+stub_obj.add(files('error-printf.c'))
+stub_obj.add(files('fdset.c'))
+stub_obj.add(files('gdbstub.c'))
+stub_obj.add(files('get-vm-name.c'))
+stub_obj.add(files('iothread.c'))
+stub_obj.add(files('iothread-lock.c'))
+stub_obj.add(files('is-daemonized.c'))
+stub_obj.add(when: 'CONFIG_LINUX_AIO', if_true: files('linux-aio.c'))
+stub_obj.add(files('machine-init-done.c'))
+stub_obj.add(files('migr-blocker.c'))
+stub_obj.add(files('change-state-handler.c'))
+stub_obj.add(files('monitor.c'))
+stub_obj.add(files('notify-event.c'))
+stub_obj.add(files('qtest.c'))
+stub_obj.add(files('replay.c'))
+stub_obj.add(files('runstate-check.c'))
+stub_obj.add(files('set-fd-handler.c'))
+stub_obj.add(files('sysbus.c'))
+stub_obj.add(files('tpm.c'))
+stub_obj.add(files('trace-control.c'))
+stub_obj.add(files('uuid.c'))
+stub_obj.add(files('vm-stop.c'))
+stub_obj.add(files('vmstate.c'))
+stub_obj.add(files('fd-register.c'))
+stub_obj.add(files('qmp_memory_device.c'))
+stub_obj.add(files('target-monitor-defs.c'))
+stub_obj.add(files('target-get-monitor-def.c'))
+stub_obj.add(files('pc_madt_cpu_entry.c'))
+stub_obj.add(files('vmgenid.c'))
+stub_obj.add(files('xen-common.c'))
+stub_obj.add(files('xen-hvm.c'))
+stub_obj.add(files('pci-host-piix.c'))
+stub_obj.add(files('ram-block.c'))
+stub_obj.add(files('ramfb.c'))
+stub_obj.add(files('fw_cfg.c'))
+if have_system
+  stub_obj.add(files('semihost.c'))
+endif
diff --git a/target/arm/trace.h b/target/arm/trace.h
new file mode 100644
index 0000000..a8024c6
--- /dev/null
+++ b/target/arm/trace.h
@@ -0,0 +1 @@
+#include "trace-target_arm.h"
diff --git a/target/hppa/trace.h b/target/hppa/trace.h
new file mode 100644
index 0000000..43bf7c3
--- /dev/null
+++ b/target/hppa/trace.h
@@ -0,0 +1 @@
+#include "trace-target_hppa.h"
diff --git a/target/i386/trace.h b/target/i386/trace.h
new file mode 100644
index 0000000..27f23d5
--- /dev/null
+++ b/target/i386/trace.h
@@ -0,0 +1 @@
+#include "trace-target_i386.h"
diff --git a/target/mips/trace.h b/target/mips/trace.h
new file mode 100644
index 0000000..e467678
--- /dev/null
+++ b/target/mips/trace.h
@@ -0,0 +1 @@
+#include "trace-target_mips.h"
diff --git a/target/ppc/trace.h b/target/ppc/trace.h
new file mode 100644
index 0000000..035d92a
--- /dev/null
+++ b/target/ppc/trace.h
@@ -0,0 +1 @@
+#include "trace-target_ppc.h"
diff --git a/target/riscv/trace.h b/target/riscv/trace.h
new file mode 100644
index 0000000..1182c58
--- /dev/null
+++ b/target/riscv/trace.h
@@ -0,0 +1 @@
+#include "trace-target_riscv.h"
diff --git a/target/s390x/trace.h b/target/s390x/trace.h
new file mode 100644
index 0000000..84485e1
--- /dev/null
+++ b/target/s390x/trace.h
@@ -0,0 +1 @@
+#include "trace-target_s390x.h"
diff --git a/target/sparc/trace.h b/target/sparc/trace.h
new file mode 100644
index 0000000..9a932c8
--- /dev/null
+++ b/target/sparc/trace.h
@@ -0,0 +1 @@
+#include "trace-target_sparc.h"
diff --git a/trace/Makefile.objs b/trace/Makefile.objs
index c544509..a429474 100644
--- a/trace/Makefile.objs
+++ b/trace/Makefile.objs
@@ -1,59 +1,8 @@
 # -*- mode: makefile -*-
 
-$(BUILD_DIR)/trace-events-all: $(trace-events-files)
-	$(call quiet-command,cat $^ > $@)
-
 
 ##################################################
 # Translation level
 
-$(obj)/generated-helpers-wrappers.h: $(obj)/generated-helpers-wrappers.h-timestamp
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-$(obj)/generated-helpers-wrappers.h-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
-	$(call quiet-command,$(TRACETOOL) \
-		--group=root \
-		--format=tcg-helper-wrapper-h \
-		--backend=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
-
-$(obj)/generated-helpers.h: $(obj)/generated-helpers.h-timestamp
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-$(obj)/generated-helpers.h-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
-	$(call quiet-command,$(TRACETOOL) \
-		--group=root \
-		--format=tcg-helper-h \
-		--backend=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
-
-$(obj)/generated-helpers.c: $(obj)/generated-helpers.c-timestamp
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-$(obj)/generated-helpers.c-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
-	$(call quiet-command,$(TRACETOOL) \
-		--group=root \
-		--format=tcg-helper-c \
-		--backend=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
-
-$(obj)/generated-helpers.o: $(obj)/generated-helpers.c
-
 obj-y += generated-helpers.o
-
-
-$(obj)/generated-tcg-tracers.h: $(obj)/generated-tcg-tracers.h-timestamp
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-$(obj)/generated-tcg-tracers.h-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
-	$(call quiet-command,$(TRACETOOL) \
-		--group=root \
-		--format=tcg-h \
-		--backend=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
-
-
-######################################################################
-# Backend code
-
-util-obj-$(CONFIG_TRACE_SIMPLE) += simple.o
-util-obj-$(CONFIG_TRACE_FTRACE) += ftrace.o
-util-obj-y += control.o
 obj-y += control-target.o
-util-obj-y += qmp.o
diff --git a/trace/meson.build b/trace/meson.build
new file mode 100644
index 0000000..31831d4
--- /dev/null
+++ b/trace/meson.build
@@ -0,0 +1,75 @@
+# common options
+tracetool = [
+  find_program('scripts/tracetool.py'),
+   '--backend=' + config_host['TRACE_BACKENDS']
+]
+
+trace_events_files = []
+foreach dir : [ '.' ] + trace_events_subdirs
+  trace_events_file = meson.source_root() / dir / 'trace-events'
+  trace_events_files += [ trace_events_file ]
+  group_name = dir == '.' ? 'root' : dir.underscorify()
+  group = '--group=' + group_name
+  fmt = '@0@-' + group_name + '.@1@'
+
+  trace_h = custom_target(fmt.format('trace', 'h'),
+                          output: fmt.format('trace', 'h'),
+                          input: trace_events_file,
+                          command: [ tracetool, group, '--format=h', '@INPUT@' ],
+                          capture: true)
+  trace_c = custom_target(fmt.format('trace', 'c'),
+                          output: fmt.format('trace', 'c'),
+                          input: trace_events_file,
+                          command: [ tracetool, group, '--format=c', '@INPUT@' ],
+                          capture: true)
+  if config_host.has_key('CONFIG_TRACE_UST')
+    trace_ust_h = custom_target(fmt.format('trace-ust', 'h'),
+                                output: fmt.format('trace-ust', 'h'),
+                                input: trace_events_file,
+                                command: [ tracetool, group, '--format=ust-events-h', '@INPUT@' ],
+                                capture: true)
+  endif
+  trace_obj.add(trace_h, trace_c)
+  if config_host.has_key('CONFIG_TRACE_DTRACE')
+    trace_dtrace = custom_target(fmt.format('trace-dtrace', 'dtrace'),
+                                 output: fmt.format('trace-dtrace', 'dtrace'),
+                                 input: trace_events_file,
+                                 command: [ tracetool, group, '--format=d', '@INPUT@' ],
+                                 capture: true)
+    trace_dtrace_h = custom_target(fmt.format('trace-dtrace', 'h'),
+                                   output: fmt.format('trace-dtrace', 'h'),
+                                   input: trace_dtrace,
+                                   command: [ 'dtrace', '-o', '@OUTPUT@', '-h', '-s', '@INPUT@' ])
+    trace_dtrace_o = custom_target(fmt.format('trace-dtrace', 'o'),
+                                   output: fmt.format('trace-dtrace', 'o'),
+                                   input: trace_dtrace,
+                                   command: [ 'dtrace', '-o', '@OUTPUT@', '-G', '-s', '@INPUT@' ])
+
+    trace_obj.add(trace_dtrace_h, trace_dtrace_o)
+  endif
+endforeach
+
+custom_target('trace-events-all',
+              output: 'trace-events-all',
+              input: trace_events_files,
+              command: [ 'cat', '@INPUT@' ],
+              capture: true)
+
+if config_host.has_key('CONFIG_TRACE_UST')
+  trace_ust_all_h = custom_target(fmt.format('trace-ust', 'h'),
+                                  output: fmt.format('trace-ust', 'h'),
+                                  input: trace_events_files,
+                                  command: [ tracetool, '--group=all', '--format=ust-events-h', '@INPUT@' ],
+                                  capture: true)
+  trace_ust_all_c = custom_target(fmt.format('trace-ust', 'c'),
+                                  output: fmt.format('trace-ust', 'c'),
+                                  input: trace_events_files,
+                                  command: [ tracetool, '--group=all', '--format=ust-events-c', '@INPUT@' ],
+                                  capture: true)
+  trace_obj.add(trace_ust_all_h, trace_ust_all_c)
+endif
+
+trace_obj.add(when: 'CONFIG_TRACE_SIMPLE', if_true: files('simple.c'))
+trace_obj.add(when: 'CONFIG_TRACE_FTRACE', if_true: files('ftrace.c'))
+trace_obj.add(files('control.c'))
+trace_obj.add(files('qmp.c'))
diff --git a/ui/trace.h b/ui/trace.h
new file mode 100644
index 0000000..7c1cb62
--- /dev/null
+++ b/ui/trace.h
@@ -0,0 +1 @@
+#include "trace-ui.h"
diff --git a/util/Makefile.objs b/util/Makefile.objs
deleted file mode 100644
index 3817820..0000000
--- a/util/Makefile.objs
+++ /dev/null
@@ -1,59 +0,0 @@
-util-obj-y = osdep.o cutils.o unicode.o qemu-timer-common.o
-util-obj-y += bufferiszero.o
-util-obj-y += lockcnt.o
-util-obj-y += aiocb.o async.o aio-wait.o thread-pool.o qemu-timer.o
-util-obj-y += main-loop.o iohandler.o
-main-loop.o-cflags := $(SLIRP_CFLAGS)
-util-obj-$(call lnot,$(CONFIG_ATOMIC64)) += atomic64.o
-util-obj-$(CONFIG_POSIX) += aio-posix.o
-util-obj-$(CONFIG_POSIX) += compatfd.o
-util-obj-$(CONFIG_POSIX) += event_notifier-posix.o
-util-obj-$(CONFIG_POSIX) += mmap-alloc.o
-util-obj-$(CONFIG_POSIX) += oslib-posix.o
-util-obj-$(CONFIG_POSIX) += qemu-openpty.o
-util-obj-$(CONFIG_POSIX) += qemu-thread-posix.o
-util-obj-$(CONFIG_POSIX) += memfd.o
-util-obj-$(CONFIG_WIN32) += aio-win32.o
-util-obj-$(CONFIG_WIN32) += event_notifier-win32.o
-util-obj-$(CONFIG_WIN32) += oslib-win32.o
-util-obj-$(CONFIG_WIN32) += qemu-thread-win32.o
-util-obj-y += envlist.o path.o module.o
-util-obj-y += host-utils.o
-util-obj-y += bitmap.o bitops.o hbitmap.o
-util-obj-y += fifo8.o
-util-obj-y += cacheinfo.o
-util-obj-y += error.o qemu-error.o
-util-obj-y += qemu-print.o
-util-obj-y += id.o
-util-obj-y += iov.o qemu-config.o qemu-sockets.o uri.o notify.o
-util-obj-y += qemu-option.o qemu-progress.o
-util-obj-y += keyval.o
-util-obj-y += hexdump.o
-util-obj-y += crc32c.o
-util-obj-y += uuid.o
-util-obj-y += throttle.o
-util-obj-y += getauxval.o
-util-obj-y += readline.o
-util-obj-y += rcu.o
-util-obj-$(CONFIG_MEMBARRIER) += sys_membarrier.o
-util-obj-y += qemu-coroutine.o qemu-coroutine-lock.o qemu-coroutine-io.o
-util-obj-y += qemu-coroutine-sleep.o
-util-obj-y += coroutine-$(CONFIG_COROUTINE_BACKEND).o
-util-obj-y += buffer.o
-util-obj-y += timed-average.o
-util-obj-y += base64.o
-util-obj-y += log.o
-util-obj-y += pagesize.o
-util-obj-y += qdist.o
-util-obj-y += qht.o
-util-obj-y += qsp.o
-util-obj-y += range.o
-util-obj-y += stats64.o
-util-obj-y += systemd.o
-util-obj-y += iova-tree.o
-util-obj-$(CONFIG_INOTIFY1) += filemonitor-inotify.o
-util-obj-$(CONFIG_LINUX) += vfio-helpers.o
-util-obj-$(CONFIG_POSIX) += drm.o
-util-obj-y += guest-random.o
-
-stub-obj-y += filemonitor-stub.o
diff --git a/util/meson.build b/util/meson.build
new file mode 100644
index 0000000..efb1fbc
--- /dev/null
+++ b/util/meson.build
@@ -0,0 +1,57 @@
+util_obj.add(files('osdep.c', 'cutils.c', 'unicode.c', 'qemu-timer-common.c'))
+util_obj.add(files('bufferiszero.c'))
+util_obj.add(files('lockcnt.c'))
+util_obj.add(files('aiocb.c', 'async.c', 'aio-wait.c', 'thread-pool.c', 'qemu-timer.c'))
+util_obj.add(files('main-loop.c', 'iohandler.c'), slirp)
+util_obj.add(when: 'CONFIG_ATOMIC64', if_false: files('atomic64.c'))
+util_obj.add(when: 'CONFIG_POSIX', if_true: files('aio-posix.c'))
+util_obj.add(when: 'CONFIG_POSIX', if_true: files('compatfd.c'))
+util_obj.add(when: 'CONFIG_POSIX', if_true: files('event_notifier-posix.c'))
+util_obj.add(when: 'CONFIG_POSIX', if_true: files('mmap-alloc.c'))
+util_obj.add(when: 'CONFIG_POSIX', if_true: files('oslib-posix.c'))
+util_obj.add(when: 'CONFIG_POSIX', if_true: files('qemu-openpty.c'))
+util_obj.add(when: 'CONFIG_POSIX', if_true: files('qemu-thread-posix.c'))
+util_obj.add(when: 'CONFIG_POSIX', if_true: files('memfd.c'))
+util_obj.add(when: 'CONFIG_WIN32', if_true: files('aio-win32.c'))
+util_obj.add(when: 'CONFIG_WIN32', if_true: files('event_notifier-win32.c'))
+util_obj.add(when: 'CONFIG_WIN32', if_true: files('oslib-win32.c'))
+util_obj.add(when: 'CONFIG_WIN32', if_true: files('qemu-thread-win32.c'))
+util_obj.add(files('envlist.c', 'path.c', 'module.c'))
+util_obj.add(files('host-utils.c'))
+util_obj.add(files('bitmap.c', 'bitops.c', 'hbitmap.c'))
+util_obj.add(files('fifo8.c'))
+util_obj.add(files('cacheinfo.c'))
+util_obj.add(files('error.c', 'qemu-error.c'))
+util_obj.add(files('qemu-print.c'))
+util_obj.add(files('id.c'))
+util_obj.add(files('iov.c', 'qemu-config.c', 'qemu-sockets.c', 'uri.c', 'notify.c'))
+util_obj.add(files('qemu-option.c', 'qemu-progress.c'))
+util_obj.add(files('keyval.c'))
+util_obj.add(files('hexdump.c'))
+util_obj.add(files('crc32c.c'))
+util_obj.add(files('uuid.c'))
+util_obj.add(files('throttle.c'))
+util_obj.add(files('getauxval.c'))
+util_obj.add(files('readline.c'))
+util_obj.add(files('rcu.c'))
+util_obj.add(when: 'CONFIG_MEMBARRIER', if_true: files('sys_membarrier.c'))
+util_obj.add(files('qemu-coroutine.c', 'qemu-coroutine-lock.c', 'qemu-coroutine-io.c'))
+util_obj.add(files('qemu-coroutine-sleep.c'))
+util_obj.add(files('coroutine-@0@.c'.format(config_host['CONFIG_COROUTINE_BACKEND'])))
+util_obj.add(files('buffer.c'))
+util_obj.add(files('timed-average.c'))
+util_obj.add(files('base64.c'))
+util_obj.add(files('log.c'))
+util_obj.add(files('pagesize.c'))
+util_obj.add(files('qdist.c'))
+util_obj.add(files('qht.c'))
+util_obj.add(files('qsp.c'))
+util_obj.add(files('range.c'))
+util_obj.add(files('stats64.c'))
+util_obj.add(files('systemd.c'))
+util_obj.add(files('iova-tree.c'))
+util_obj.add(when: 'CONFIG_INOTIFY1', if_true: files('filemonitor-inotify.c'),
+                                      if_false: files('filemonitor-stub.c'))
+util_obj.add(when: 'CONFIG_LINUX', if_true: files('vfio-helpers.c'))
+util_obj.add(when: 'CONFIG_POSIX', if_true: files('drm.c'))
+util_obj.add(files('guest-random.c'))
diff --git a/util/trace.h b/util/trace.h
new file mode 100644
index 0000000..2507adc
--- /dev/null
+++ b/util/trace.h
@@ -0,0 +1 @@
+#include "trace-util.h"
-- 
1.8.3.1



