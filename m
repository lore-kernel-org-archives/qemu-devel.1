Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6707CC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:05:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FF802077B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qOZbbRXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF802077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOAA-0000Fu-O7
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:05:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58320)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNy3-0002zD-7V
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNxu-0005s9-PB
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:18 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:52961)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNxu-0005py-7s
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:10 -0500
Received: by mail-wm1-x334.google.com with SMTP id p9so2246491wmc.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=GaOZdgw6eB4TDQUscAG/JJNky2YD1YyNEQ4e9fXgYaQ=;
 b=qOZbbRXrr9pyMnmKV391ZoGn6FjxgBzHNX9KiT0esXou3iC3F9P7VmVpQAv/RY8FBs
 pQLitqsaOskirQ0WG0VFG2VDvJAjO17JnZZiJO7I83ROWtEp/1xzv63AgJGdOV4FmV3y
 9u59YznFZt9O9NL1z4WQVV101UgzP14+9zI32Bub1aJbGALBLA/v3Nwc6C6OvfSaKpEt
 5KWUECZ1DrtQk1QfnleB/wzgYIvgmFJH7C3RmDVLZzHWAQIeYmN13Sv2AfRMaCb5ECXf
 w8oGOpA5oorIabOXZ9N5AnMmaePcLqH7yaDyUf0/L4k1JUDu93usvBnVMH68u6hZphN0
 dFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=GaOZdgw6eB4TDQUscAG/JJNky2YD1YyNEQ4e9fXgYaQ=;
 b=KVRMmCs3wzye5Nmo/sQmyX5LgRQbFZSOGiOSwmqB4+SoweFeZV+pp9u5AYqNGMuKPO
 k4LB/AO5rQb2cKIbFG+9P++0zWoFXaVXNJUBjZYyYao21c9LwGwuWuH80UxckUgLtAyj
 oDTXshS5Mmayw4VoAtrcMIBvm7nfzwz2reWbTEweAlInqIDvLZfrEvsxqsYRH/P9AoT2
 iOc8mAj+tPWNe8i0pVy43Ap6wslw8O/MEs02QtfZx4/OKtGU7HYcTYkPAr2YX/uDqKCO
 5581qtI69DEj2Fthpbt4l2XizdWvn4WvpxubGL+Ucv+QcEjQov6mSuW3I2DSHMG0WD99
 NT0w==
X-Gm-Message-State: APjAAAVzYUAjjeE1EJNo1+s7c8jB3aIIt6vg5ifW6hKv11Ea+sEM/Qtl
 AC5sy6Cr/mk1kfV2AwajpYm8jWFz
X-Google-Smtp-Source: APXvYqwUicu3u0X+rhcrgQsU2M30dU4VdtoViAOQYSRFf5TPYuo+S3V5ssHmPIfxLiaZD7CPACC1qA==
X-Received: by 2002:a1c:48c1:: with SMTP id v184mr6701700wma.5.1576155187201; 
 Thu, 12 Dec 2019 04:53:07 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:06 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 009/132] libqemuutil: convert to meson
Date: Thu, 12 Dec 2019 13:50:53 +0100
Message-Id: <1576155176-2464-10-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
 Makefile                                  | 182 ++++++------------------------
 Makefile.objs                             |  93 +--------------
 Makefile.target                           |   8 +-
 accel/kvm/trace.h                         |   1 +
 accel/tcg/trace.h                         |   1 +
 audio/trace.h                             |   1 +
 authz/trace.h                             |   1 +
 balloon.c                                 |   2 +-
 block/trace.h                             |   1 +
 chardev/trace.h                           |   1 +
 configure                                 |   8 ++
 crypto/Makefile.objs                      |   5 -
 crypto/meson.build                        |   9 ++
 crypto/trace.h                            |   1 +
 dma-helpers.c                             |   2 +-
 docs/devel/tracing.txt                    |   2 +-
 exec.c                                    |   2 +-
 gdbstub.c                                 |   2 +-
 hw/9pfs/trace.h                           |   1 +
 hw/acpi/trace.h                           |   1 +
 hw/alpha/trace.h                          |   1 +
 hw/arm/trace.h                            |   1 +
 hw/audio/trace.h                          |   1 +
 hw/block/dataplane/trace.h                |   1 +
 hw/block/trace.h                          |   1 +
 hw/char/trace.h                           |   1 +
 hw/core/cpu.c                             |   2 +-
 hw/display/trace.h                        |   1 +
 hw/dma/trace.h                            |   1 +
 hw/gpio/trace.h                           |   1 +
 hw/hppa/trace.h                           |   1 +
 hw/i2c/trace.h                            |   1 +
 hw/i386/trace.h                           |   1 +
 hw/i386/xen/trace.h                       |   1 +
 hw/ide/trace.h                            |   1 +
 hw/input/trace.h                          |   1 +
 hw/intc/trace.h                           |   1 +
 hw/isa/trace.h                            |   1 +
 hw/mem/trace.h                            |   1 +
 hw/mips/trace.h                           |   1 +
 hw/misc/macio/trace.h                     |   1 +
 hw/misc/trace.h                           |   1 +
 hw/net/trace.h                            |   1 +
 hw/nvram/trace.h                          |   1 +
 hw/pci-host/trace.h                       |   1 +
 hw/pci/trace.h                            |   1 +
 hw/ppc/trace.h                            |   1 +
 hw/rdma/trace.h                           |   1 +
 hw/rdma/vmw/trace.h                       |   1 +
 hw/riscv/trace.h                          |   1 +
 hw/s390x/trace.h                          |   1 +
 hw/scsi/trace.h                           |   1 +
 hw/sd/trace.h                             |   1 +
 hw/sparc/trace.h                          |   1 +
 hw/sparc64/trace.h                        |   1 +
 hw/timer/trace.h                          |   1 +
 hw/tpm/trace.h                            |   1 +
 hw/usb/trace.h                            |   1 +
 hw/vfio/trace.h                           |   1 +
 hw/virtio/trace.h                         |   1 +
 hw/watchdog/trace.h                       |   1 +
 hw/xen/trace.h                            |   1 +
 include/exec/cpu_ldst_template.h          |   2 +-
 include/exec/cpu_ldst_useronly_template.h |   2 +-
 io/trace.h                                |   1 +
 ioport.c                                  |   2 +-
 job-qmp.c                                 |   2 +-
 job.c                                     |   2 +-
 linux-user/trace.h                        |   1 +
 memory.c                                  |   2 +-
 meson.build                               | 161 ++++++++++++++++++++++++++
 migration/trace.h                         |   1 +
 monitor/trace.h                           |   1 +
 nbd/trace.h                               |   1 +
 net/trace.h                               |   1 +
 qapi/Makefile.objs                        |  21 ----
 qapi/meson.build                          |  89 +++++++++++++++
 qapi/trace.h                              |   1 +
 qobject/Makefile.objs                     |   3 -
 qobject/meson.build                       |   3 +
 qom/trace.h                               |   1 +
 rules.mak                                 |   2 +-
 scripts/qapi-gen.py                       |   2 +-
 scripts/tracetool.py                      |   2 +-
 scripts/tracetool/backend/dtrace.py       |   2 +-
 scripts/tracetool/backend/ust.py          |   6 +-
 scripts/tracetool/format/c.py             |   5 +-
 scripts/tracetool/format/tcg_h.py         |   2 +-
 scripts/tracetool/format/tcg_helper_c.py  |   2 +-
 scsi/trace.h                              |   1 +
 stubs/Makefile.objs                       |  43 -------
 stubs/meson.build                         |  45 ++++++++
 target/arm/trace.h                        |   1 +
 target/hppa/trace.h                       |   1 +
 target/i386/trace.h                       |   1 +
 target/mips/trace.h                       |   1 +
 target/ppc/trace.h                        |   1 +
 target/riscv/trace.h                      |   1 +
 target/s390x/trace.h                      |   1 +
 target/sparc/trace.h                      |   1 +
 trace/Makefile.objs                       |  51 ---------
 trace/control-target.c                    |   2 +-
 trace/control.c                           |   2 +-
 trace/meson.build                         |  82 ++++++++++++++
 ui/trace.h                                |   1 +
 util/Makefile.objs                        |  57 ----------
 util/meson.build                          |  57 ++++++++++
 util/trace.h                              |   1 +
 vl.c                                      |   2 +-
 109 files changed, 585 insertions(+), 454 deletions(-)
 create mode 100644 accel/kvm/trace.h
 create mode 100644 accel/tcg/trace.h
 create mode 100644 audio/trace.h
 create mode 100644 authz/trace.h
 create mode 100644 block/trace.h
 create mode 100644 chardev/trace.h
 create mode 100644 crypto/meson.build
 create mode 100644 crypto/trace.h
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
 create mode 100644 hw/mips/trace.h
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
 create mode 100644 io/trace.h
 create mode 100644 linux-user/trace.h
 create mode 100644 migration/trace.h
 create mode 100644 monitor/trace.h
 create mode 100644 nbd/trace.h
 create mode 100644 net/trace.h
 create mode 100644 qapi/meson.build
 create mode 100644 qapi/trace.h
 delete mode 100644 qobject/Makefile.objs
 create mode 100644 qobject/meson.build
 create mode 100644 qom/trace.h
 mode change 100644 => 100755 scripts/tracetool/backend/dtrace.py
 create mode 100644 scsi/trace.h
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

diff --git a/Makefile b/Makefile
index 292da1f..6f97ae9 100644
--- a/Makefile
+++ b/Makefile
@@ -112,158 +112,60 @@ FULL_VERSION := $(if $(QEMU_PKGVERSION),$(VERSION) ($(QEMU_PKGVERSION)),$(VERSIO
 
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
-generated-files-y += $(GENERATED_QAPI_FILES)
-
 generated-files-y += trace/generated-tcg-tracers.h
 
 generated-files-y += trace/generated-helpers-wrappers.h
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
+	@mkdir -p $(dir $@)
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
+	@mkdir -p $(dir $@)
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
+	@mkdir -p $(dir $@)
 	$(call quiet-command,$(TRACETOOL) \
 		--group=root \
-		--format=ust-events-h \
-		--backends=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(@:%-timestamp=%)")
-
-trace-ust-all.h: trace-ust-all.h-timestamp
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-trace-ust-all.h-timestamp: $(trace-events-files) $(tracetool-y) $(BUILD_DIR)/config-host.mak
-	$(call quiet-command,$(TRACETOOL) \
-		--group=all \
-		--format=ust-events-h \
-		--backends=$(TRACE_BACKENDS) \
-		$(trace-events-files) > $@,"GEN","$(@:%-timestamp=%)")
+		--format=tcg-helper-c \
+		--backend=$(TRACE_BACKENDS) \
+		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
 
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
+	@mkdir -p $(dir $@)
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
@@ -409,10 +311,8 @@ include $(SRC_PATH)/Makefile.objs
 endif
 
 dummy := $(call unnest-vars,, \
-                stub-obj-y \
                 authz-obj-y \
                 chardev-obj-y \
-                util-obj-y \
                 qga-obj-y \
                 elf2dmp-obj-y \
                 ivshmem-client-obj-y \
@@ -430,8 +330,7 @@ dummy := $(call unnest-vars,, \
                 qom-obj-y \
                 io-obj-y \
                 common-obj-y \
-                common-obj-m \
-                trace-obj-y)
+                common-obj-m)
 
 include $(SRC_PATH)/tests/Makefile.include
 
@@ -531,8 +430,7 @@ Makefile: $(version-obj-y)
 ######################################################################
 # Build libraries
 
-libqemuutil.a: $(util-obj-y) $(trace-obj-y) $(stub-obj-y)
-libvhost-user.a: $(libvhost-user-obj-y) $(util-obj-y) $(stub-obj-y)
+libvhost-user.a: $(libvhost-user-obj-y)
 
 ######################################################################
 
@@ -587,16 +485,6 @@ qga/qapi-generated/qapi-gen-timestamp: $(SRC_PATH)/qga/qapi-schema.json $(qapi-p
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
 
@@ -634,21 +522,21 @@ ivshmem-client$(EXESUF): $(ivshmem-client-obj-y) $(COMMON_LDADDS)
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
@@ -900,7 +788,9 @@ endif
 	set -e; for x in $(KEYMAPS); do \
 		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/keymaps/$$x "$(DESTDIR)$(qemu_datadir)/keymaps"; \
 	done
-	$(INSTALL_DATA) $(BUILD_DIR)/trace-events-all "$(DESTDIR)$(qemu_datadir)/trace-events-all"
+	for d in $(TARGET_DIRS); do \
+	$(MAKE) $(SUBDIR_MAKEFLAGS) TARGET_DIR=$$d/ -C $$d $@ || exit 1 ; \
+        done
 
 .PHONY: ctags
 ctags:
@@ -1112,10 +1002,6 @@ Makefile: $(generated-files-y)
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
index aaf0cd5..f820829 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -1,8 +1,5 @@
 #######################################################################
-# Common libraries for tools and emulators
-stub-obj-y = stubs/
-util-obj-y = crypto/ util/ qobject/ qapi/
-
+# chardev-obj-y is code used by both qemu system emulation and some tests
 chardev-obj-y = chardev/
 
 #######################################################################
@@ -81,10 +78,6 @@ qemu-seccomp.o-libs := $(SECCOMP_LIBS)
 
 common-obj-$(CONFIG_FDT) += device_tree.o
 
-######################################################################
-# qapi
-
-common-obj-y += qapi/
 endif
 
 #######################################################################
@@ -126,87 +119,3 @@ vhost-user-input-obj-y = contrib/vhost-user-input/
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
-trace-events-subdirs += hw/mips
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
diff --git a/Makefile.target b/Makefile.target
index f4b44af..c5af974 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -57,7 +57,7 @@ endif
 tracetool-y = $(SRC_PATH)/scripts/tracetool.py
 tracetool-y += $(shell find $(SRC_PATH)/scripts/tracetool -name "*.py")
 
-$(QEMU_PROG).stp-installed: $(BUILD_DIR)/trace-events-all $(tracetool-y)
+$(QEMU_PROG).stp-installed: $(BUILD_DIR)/trace/trace-events-all $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
 		--group=all \
 		--format=stap \
@@ -67,7 +67,7 @@ $(QEMU_PROG).stp-installed: $(BUILD_DIR)/trace-events-all $(tracetool-y)
 		--target-type=$(TARGET_TYPE) \
 		$< > $@,"GEN","$(TARGET_DIR)$(QEMU_PROG).stp-installed")
 
-$(QEMU_PROG).stp: $(BUILD_DIR)/trace-events-all $(tracetool-y)
+$(QEMU_PROG).stp: $(BUILD_DIR)/trace/trace-events-all $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
 		--group=all \
 		--format=stap \
@@ -77,7 +77,7 @@ $(QEMU_PROG).stp: $(BUILD_DIR)/trace-events-all $(tracetool-y)
 		--target-type=$(TARGET_TYPE) \
 		$< > $@,"GEN","$(TARGET_DIR)$(QEMU_PROG).stp")
 
-$(QEMU_PROG)-simpletrace.stp: $(BUILD_DIR)/trace-events-all $(tracetool-y)
+$(QEMU_PROG)-simpletrace.stp: $(BUILD_DIR)/trace/trace-events-all $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
 		--group=all \
 		--format=simpletrace-stap \
@@ -85,7 +85,7 @@ $(QEMU_PROG)-simpletrace.stp: $(BUILD_DIR)/trace-events-all $(tracetool-y)
 		--probe-prefix=qemu.$(TARGET_TYPE).$(TARGET_NAME) \
 		$< > $@,"GEN","$(TARGET_DIR)$(QEMU_PROG)-simpletrace.stp")
 
-$(QEMU_PROG)-log.stp: $(BUILD_DIR)/trace-events-all $(tracetool-y)
+$(QEMU_PROG)-log.stp: $(BUILD_DIR)/trace/trace-events-all $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
 		--group=all \
 		--format=log-stap \
diff --git a/accel/kvm/trace.h b/accel/kvm/trace.h
new file mode 100644
index 0000000..67c935a
--- /dev/null
+++ b/accel/kvm/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-accel_kvm.h"
diff --git a/accel/tcg/trace.h b/accel/tcg/trace.h
new file mode 100644
index 0000000..db61fad
--- /dev/null
+++ b/accel/tcg/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-accel_tcg.h"
diff --git a/audio/trace.h b/audio/trace.h
new file mode 100644
index 0000000..4072a11
--- /dev/null
+++ b/audio/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-audio.h"
diff --git a/authz/trace.h b/authz/trace.h
new file mode 100644
index 0000000..3176c12
--- /dev/null
+++ b/authz/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-authz.h"
diff --git a/balloon.c b/balloon.c
index f104b42..db44eb7 100644
--- a/balloon.c
+++ b/balloon.c
@@ -28,7 +28,7 @@
 #include "qemu/atomic.h"
 #include "sysemu/kvm.h"
 #include "sysemu/balloon.h"
-#include "trace-root.h"
+#include "trace/trace-root.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qmp/qerror.h"
diff --git a/block/trace.h b/block/trace.h
new file mode 100644
index 0000000..3a436e6
--- /dev/null
+++ b/block/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-block.h"
diff --git a/chardev/trace.h b/chardev/trace.h
new file mode 100644
index 0000000..eb4f902
--- /dev/null
+++ b/chardev/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-chardev.h"
diff --git a/configure b/configure
index 5112683..c27d06f 100755
--- a/configure
+++ b/configure
@@ -6806,6 +6806,8 @@ fi
 echo "CONFIG_TLS_PRIORITY=\"$tls_priority\"" >> $config_host_mak
 if test "$gnutls" = "yes" ; then
   echo "CONFIG_GNUTLS=y" >> $config_host_mak
+  echo "GNUTLS_CFLAGS=$gnutls_cflags" >> $config_host_mak
+  echo "GNUTLS_LIBS=$gnutls_libs" >> $config_host_mak
 fi
 if test "$gcrypt" = "yes" ; then
   echo "CONFIG_GCRYPT=y" >> $config_host_mak
@@ -6816,6 +6818,8 @@ fi
 if test "$nettle" = "yes" ; then
   echo "CONFIG_NETTLE=y" >> $config_host_mak
   echo "CONFIG_NETTLE_VERSION_MAJOR=${nettle_version%%.*}" >> $config_host_mak
+  echo "NETTLE_CFLAGS=$nettle_cflags" >> $config_host_mak
+  echo "NETTLE_LIBS=$nettle_libs" >> $config_host_mak
 fi
 if test "$tasn1" = "yes" ; then
   echo "CONFIG_TASN1=y" >> $config_host_mak
@@ -7155,6 +7159,8 @@ if have_backend "log"; then
 fi
 if have_backend "ust"; then
   echo "CONFIG_TRACE_UST=y" >> $config_host_mak
+  echo "LTTNG_UST_LIBS=$lttng_ust_libs" >> $config_host_mak
+  echo "URCU_BP_LIBS=$urcu_bp_libs" >> $config_host_mak
 fi
 if have_backend "dtrace"; then
   echo "CONFIG_TRACE_DTRACE=y" >> $config_host_mak
@@ -7329,6 +7335,8 @@ echo "CFLAGS_NOPIE=$CFLAGS_NOPIE" >> $config_host_mak
 echo "QEMU_CFLAGS=$QEMU_CFLAGS" >> $config_host_mak
 echo "QEMU_CXXFLAGS=$QEMU_CXXFLAGS" >> $config_host_mak
 echo "QEMU_INCLUDES=$QEMU_INCLUDES" >> $config_host_mak
+echo "GLIB_CFLAGS=$glib_cflags" >> $config_host_mak
+echo "GLIB_LIBS=$glib_libs" >> $config_host_mak
 if test "$sparse" = "yes" ; then
   echo "CC           := REAL_CC=\"\$(CC)\" cgcc"       >> $config_host_mak
   echo "CPP          := REAL_CC=\"\$(CPP)\" cgcc"      >> $config_host_mak
diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
index d1d6283..3587f41 100644
--- a/crypto/Makefile.objs
+++ b/crypto/Makefile.objs
@@ -32,8 +32,3 @@ crypto-obj-y += xts.o
 crypto-obj-y += block.o
 crypto-obj-y += block-qcow.o
 crypto-obj-y += block-luks.o
-
-util-obj-$(CONFIG_GCRYPT) += random-gcrypt.o
-util-obj-$(if $(CONFIG_GCRYPT),n,$(CONFIG_GNUTLS)) += random-gnutls.o
-util-obj-$(if $(CONFIG_GCRYPT),n,$(if $(CONFIG_GNUTLS),n,y)) += random-platform.o
-util-obj-y += aes.o init.o
diff --git a/crypto/meson.build b/crypto/meson.build
new file mode 100644
index 0000000..7250ffc
--- /dev/null
+++ b/crypto/meson.build
@@ -0,0 +1,9 @@
+util_ss.add(files('aes.c'))
+util_ss.add(files('init.c'))
+if 'CONFIG_GCRYPT' in config_host
+  util_ss.add(files('random-gcrypt.c'))
+elif 'CONFIG_GNUTLS' in config_host
+  util_ss.add(files('random-gnutls.c'), gnutls)
+else
+  util_ss.add(files('random-platform.c'))
+endif
diff --git a/crypto/trace.h b/crypto/trace.h
new file mode 100644
index 0000000..a9af0f3
--- /dev/null
+++ b/crypto/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-crypto.h"
diff --git a/dma-helpers.c b/dma-helpers.c
index d3871dc..578304d 100644
--- a/dma-helpers.c
+++ b/dma-helpers.c
@@ -10,7 +10,7 @@
 #include "qemu/osdep.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/dma.h"
-#include "trace-root.h"
+#include "trace/trace-root.h"
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
 
diff --git a/docs/devel/tracing.txt b/docs/devel/tracing.txt
index 76e492a..f7f13f9 100644
--- a/docs/devel/tracing.txt
+++ b/docs/devel/tracing.txt
@@ -60,7 +60,7 @@ general. It is strongly preferred that all events be declared directly in
 the sub-directory that uses them. The only exception is where there are some
 shared trace events defined in the top level directory trace-events file.
 The top level directory generates trace files with a filename prefix of
-"trace-root" instead of just "trace". This is to avoid ambiguity between
+"trace/trace-root" instead of just "trace". This is to avoid ambiguity between
 a trace.h in the current directory, vs the top level directory.
 
 === Using trace events ===
diff --git a/exec.c b/exec.c
index 1df966d..107ae75 100644
--- a/exec.c
+++ b/exec.c
@@ -49,7 +49,7 @@
 #include "sysemu/hw_accel.h"
 #include "exec/address-spaces.h"
 #include "sysemu/xen-mapcache.h"
-#include "trace-root.h"
+#include "trace/trace-root.h"
 
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
 #include <linux/falloc.h>
diff --git a/gdbstub.c b/gdbstub.c
index b92ba59..be65d25 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -30,7 +30,7 @@
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
 #include "qemu/module.h"
-#include "trace-root.h"
+#include "trace/trace-root.h"
 #ifdef CONFIG_USER_ONLY
 #include "qemu.h"
 #else
diff --git a/hw/9pfs/trace.h b/hw/9pfs/trace.h
new file mode 100644
index 0000000..6104fe2
--- /dev/null
+++ b/hw/9pfs/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_9pfs.h"
diff --git a/hw/acpi/trace.h b/hw/acpi/trace.h
new file mode 100644
index 0000000..a7f7da7
--- /dev/null
+++ b/hw/acpi/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_acpi.h"
diff --git a/hw/alpha/trace.h b/hw/alpha/trace.h
new file mode 100644
index 0000000..20fe698
--- /dev/null
+++ b/hw/alpha/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_alpha.h"
diff --git a/hw/arm/trace.h b/hw/arm/trace.h
new file mode 100644
index 0000000..91337aa
--- /dev/null
+++ b/hw/arm/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_arm.h"
diff --git a/hw/audio/trace.h b/hw/audio/trace.h
new file mode 100644
index 0000000..5c7516a
--- /dev/null
+++ b/hw/audio/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_audio.h"
diff --git a/hw/block/dataplane/trace.h b/hw/block/dataplane/trace.h
new file mode 100644
index 0000000..240cc59
--- /dev/null
+++ b/hw/block/dataplane/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_block_dataplane.h"
diff --git a/hw/block/trace.h b/hw/block/trace.h
new file mode 100644
index 0000000..cde210a
--- /dev/null
+++ b/hw/block/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_block.h"
diff --git a/hw/char/trace.h b/hw/char/trace.h
new file mode 100644
index 0000000..c2df66a
--- /dev/null
+++ b/hw/char/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_char.h"
diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index 0035845..bbc115a 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -31,7 +31,7 @@
 #include "sysemu/tcg.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
-#include "trace-root.h"
+#include "trace/trace-root.h"
 
 CPUInterruptHandler cpu_interrupt_handler;
 
diff --git a/hw/display/trace.h b/hw/display/trace.h
new file mode 100644
index 0000000..4ed0e91
--- /dev/null
+++ b/hw/display/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_display.h"
diff --git a/hw/dma/trace.h b/hw/dma/trace.h
new file mode 100644
index 0000000..4bcb28b
--- /dev/null
+++ b/hw/dma/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_dma.h"
diff --git a/hw/gpio/trace.h b/hw/gpio/trace.h
new file mode 100644
index 0000000..8b13907
--- /dev/null
+++ b/hw/gpio/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_gpio.h"
diff --git a/hw/hppa/trace.h b/hw/hppa/trace.h
new file mode 100644
index 0000000..4e8b52d
--- /dev/null
+++ b/hw/hppa/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_hppa.h"
diff --git a/hw/i2c/trace.h b/hw/i2c/trace.h
new file mode 100644
index 0000000..4843a8d
--- /dev/null
+++ b/hw/i2c/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_i2c.h"
diff --git a/hw/i386/trace.h b/hw/i386/trace.h
new file mode 100644
index 0000000..37a9f67
--- /dev/null
+++ b/hw/i386/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_i386.h"
diff --git a/hw/i386/xen/trace.h b/hw/i386/xen/trace.h
new file mode 100644
index 0000000..a02bf75
--- /dev/null
+++ b/hw/i386/xen/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_i386_xen.h"
diff --git a/hw/ide/trace.h b/hw/ide/trace.h
new file mode 100644
index 0000000..e060e0a
--- /dev/null
+++ b/hw/ide/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_ide.h"
diff --git a/hw/input/trace.h b/hw/input/trace.h
new file mode 100644
index 0000000..d1cc5d9
--- /dev/null
+++ b/hw/input/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_input.h"
diff --git a/hw/intc/trace.h b/hw/intc/trace.h
new file mode 100644
index 0000000..02394ae
--- /dev/null
+++ b/hw/intc/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_intc.h"
diff --git a/hw/isa/trace.h b/hw/isa/trace.h
new file mode 100644
index 0000000..501205c
--- /dev/null
+++ b/hw/isa/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_isa.h"
diff --git a/hw/mem/trace.h b/hw/mem/trace.h
new file mode 100644
index 0000000..2f2c945
--- /dev/null
+++ b/hw/mem/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_mem.h"
diff --git a/hw/mips/trace.h b/hw/mips/trace.h
new file mode 100644
index 0000000..8d1fd7c
--- /dev/null
+++ b/hw/mips/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_mips.h"
diff --git a/hw/misc/macio/trace.h b/hw/misc/macio/trace.h
new file mode 100644
index 0000000..34a3cf1
--- /dev/null
+++ b/hw/misc/macio/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_misc_macio.h"
diff --git a/hw/misc/trace.h b/hw/misc/trace.h
new file mode 100644
index 0000000..1ab6923
--- /dev/null
+++ b/hw/misc/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_misc.h"
diff --git a/hw/net/trace.h b/hw/net/trace.h
new file mode 100644
index 0000000..93249af
--- /dev/null
+++ b/hw/net/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_net.h"
diff --git a/hw/nvram/trace.h b/hw/nvram/trace.h
new file mode 100644
index 0000000..88fa900
--- /dev/null
+++ b/hw/nvram/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_nvram.h"
diff --git a/hw/pci-host/trace.h b/hw/pci-host/trace.h
new file mode 100644
index 0000000..93ec814
--- /dev/null
+++ b/hw/pci-host/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_pci_host.h"
diff --git a/hw/pci/trace.h b/hw/pci/trace.h
new file mode 100644
index 0000000..3dd773e
--- /dev/null
+++ b/hw/pci/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_pci.h"
diff --git a/hw/ppc/trace.h b/hw/ppc/trace.h
new file mode 100644
index 0000000..87c4198
--- /dev/null
+++ b/hw/ppc/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_ppc.h"
diff --git a/hw/rdma/trace.h b/hw/rdma/trace.h
new file mode 100644
index 0000000..b3fa8eb
--- /dev/null
+++ b/hw/rdma/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_rdma.h"
diff --git a/hw/rdma/vmw/trace.h b/hw/rdma/vmw/trace.h
new file mode 100644
index 0000000..3ebc9fb
--- /dev/null
+++ b/hw/rdma/vmw/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_rdma_vmw.h"
diff --git a/hw/riscv/trace.h b/hw/riscv/trace.h
new file mode 100644
index 0000000..8c0e3ca
--- /dev/null
+++ b/hw/riscv/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_riscv.h"
diff --git a/hw/s390x/trace.h b/hw/s390x/trace.h
new file mode 100644
index 0000000..d6568b3
--- /dev/null
+++ b/hw/s390x/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_s390x.h"
diff --git a/hw/scsi/trace.h b/hw/scsi/trace.h
new file mode 100644
index 0000000..4ce2673
--- /dev/null
+++ b/hw/scsi/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_scsi.h"
diff --git a/hw/sd/trace.h b/hw/sd/trace.h
new file mode 100644
index 0000000..f3d0c58
--- /dev/null
+++ b/hw/sd/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_sd.h"
diff --git a/hw/sparc/trace.h b/hw/sparc/trace.h
new file mode 100644
index 0000000..625d60c
--- /dev/null
+++ b/hw/sparc/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_sparc.h"
diff --git a/hw/sparc64/trace.h b/hw/sparc64/trace.h
new file mode 100644
index 0000000..b6ef6e6
--- /dev/null
+++ b/hw/sparc64/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_sparc64.h"
diff --git a/hw/timer/trace.h b/hw/timer/trace.h
new file mode 100644
index 0000000..5f72c44
--- /dev/null
+++ b/hw/timer/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_timer.h"
diff --git a/hw/tpm/trace.h b/hw/tpm/trace.h
new file mode 100644
index 0000000..9827c12
--- /dev/null
+++ b/hw/tpm/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_tpm.h"
diff --git a/hw/usb/trace.h b/hw/usb/trace.h
new file mode 100644
index 0000000..f3962f2
--- /dev/null
+++ b/hw/usb/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_usb.h"
diff --git a/hw/vfio/trace.h b/hw/vfio/trace.h
new file mode 100644
index 0000000..5a343aa
--- /dev/null
+++ b/hw/vfio/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_vfio.h"
diff --git a/hw/virtio/trace.h b/hw/virtio/trace.h
new file mode 100644
index 0000000..5d70970
--- /dev/null
+++ b/hw/virtio/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_virtio.h"
diff --git a/hw/watchdog/trace.h b/hw/watchdog/trace.h
new file mode 100644
index 0000000..5d84957
--- /dev/null
+++ b/hw/watchdog/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_watchdog.h"
diff --git a/hw/xen/trace.h b/hw/xen/trace.h
new file mode 100644
index 0000000..adba31a
--- /dev/null
+++ b/hw/xen/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_xen.h"
diff --git a/include/exec/cpu_ldst_template.h b/include/exec/cpu_ldst_template.h
index af7e0b4..b45b4b9 100644
--- a/include/exec/cpu_ldst_template.h
+++ b/include/exec/cpu_ldst_template.h
@@ -25,7 +25,7 @@
  */
 
 #if !defined(SOFTMMU_CODE_ACCESS)
-#include "trace-root.h"
+#include "trace/trace-root.h"
 #endif
 
 #include "trace/mem.h"
diff --git a/include/exec/cpu_ldst_useronly_template.h b/include/exec/cpu_ldst_useronly_template.h
index 2378f29..3680021 100644
--- a/include/exec/cpu_ldst_useronly_template.h
+++ b/include/exec/cpu_ldst_useronly_template.h
@@ -24,7 +24,7 @@
  */
 
 #if !defined(CODE_ACCESS)
-#include "trace-root.h"
+#include "trace/trace-root.h"
 #endif
 
 #include "trace/mem.h"
diff --git a/io/trace.h b/io/trace.h
new file mode 100644
index 0000000..92d63a5
--- /dev/null
+++ b/io/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-io.h"
diff --git a/ioport.c b/ioport.c
index 04e360e..a799697 100644
--- a/ioport.c
+++ b/ioport.c
@@ -28,7 +28,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/ioport.h"
-#include "trace-root.h"
+#include "trace/trace-root.h"
 #include "exec/memory.h"
 #include "exec/address-spaces.h"
 
diff --git a/job-qmp.c b/job-qmp.c
index fbfed25..b4243b3 100644
--- a/job-qmp.c
+++ b/job-qmp.c
@@ -27,7 +27,7 @@
 #include "qemu/job.h"
 #include "qapi/qapi-commands-job.h"
 #include "qapi/error.h"
-#include "trace-root.h"
+#include "trace/trace-root.h"
 
 /* Get a job using its ID and acquire its AioContext */
 static Job *find_job(const char *id, AioContext **aio_context, Error **errp)
diff --git a/job.c b/job.c
index 28dd48f..b3090b2 100644
--- a/job.c
+++ b/job.c
@@ -29,7 +29,7 @@
 #include "qemu/id.h"
 #include "qemu/main-loop.h"
 #include "block/aio-wait.h"
-#include "trace-root.h"
+#include "trace/trace-root.h"
 #include "qapi/qapi-events-job.h"
 
 static QLIST_HEAD(, Job) jobs = QLIST_HEAD_INITIALIZER(jobs);
diff --git a/linux-user/trace.h b/linux-user/trace.h
new file mode 100644
index 0000000..05518e4
--- /dev/null
+++ b/linux-user/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-linux_user.h"
diff --git a/memory.c b/memory.c
index 7fd93b1..7793826 100644
--- a/memory.c
+++ b/memory.c
@@ -24,7 +24,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/qemu-print.h"
 #include "qom/object.h"
-#include "trace-root.h"
+#include "trace/trace-root.h"
 
 #include "exec/memory-internal.h"
 #include "exec/ram_addr.h"
diff --git a/meson.build b/meson.build
index 5491a6a..18b8710 100644
--- a/meson.build
+++ b/meson.build
@@ -1,6 +1,8 @@
 project('qemu', ['c', 'cpp'], meson_version: '>=0.52.999')
+cc = meson.get_compiler('c')
 
 kconfig = import('unstable-kconfig')
+ss = import('sourceset')
 config_host = kconfig.load(meson.current_build_dir() / 'config-host.mak')
 
 add_project_arguments(config_host['CFLAGS'].split(),
@@ -17,3 +19,162 @@ add_project_arguments(config_host['QEMU_INCLUDES'].split(),
 configure_file(input: files('scripts/ninjatool.py'),
                output: 'ninjatool',
                configuration: config_host)
+
+m = cc.find_library('m', required: false)
+util = cc.find_library('util', required: false)
+socket = []
+if host_machine.system() == 'windows'
+  socket = cc.find_library('ws2_32')
+endif
+glib = declare_dependency(compile_args: config_host['GLIB_CFLAGS'].split(),
+                          link_args: config_host['GLIB_LIBS'].split())
+lttng = declare_dependency()
+if 'CONFIG_TRACE_UST' in config_host
+  lttng = declare_dependency(link_args: config_host['LTTNG_UST_LIBS'].split())
+endif
+urcubp = declare_dependency()
+if 'CONFIG_TRACE_UST' in config_host
+  urcubp = declare_dependency(link_args: config_host['URCU_BP_LIBS'].split())
+endif
+nettle = declare_dependency()
+if 'CONFIG_NETTLE' in config_host
+  nettle = declare_dependency(compile_args: config_host['NETTLE_CFLAGS'].split(),
+                              link_args: config_host['NETTLE_LIBS'].split())
+endif
+gnutls = declare_dependency()
+if 'CONFIG_GNUTLS' in config_host
+  gnutls = declare_dependency(compile_args: config_host['GNUTLS_CFLAGS'].split(),
+                              link_args: config_host['GNUTLS_LIBS'].split())
+endif
+
+target_dirs = config_host['TARGET_DIRS'].split()
+have_user = false
+have_system = false
+foreach target : target_dirs
+  have_user = have_user or target.endswith('-user')
+  have_system = have_system or target.endswith('-softmmu')
+endforeach
+have_tools = 'CONFIG_TOOLS' in config_host
+have_block = have_system or have_tools
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
+util_ss = ss.source_set()
+stub_ss = ss.source_set()
+trace_ss = ss.source_set()
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
+    'hw/mips',
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
+genh = []
+subdir('qapi')
+subdir('qobject')
+subdir('stubs')
+subdir('trace')
+subdir('util')
+subdir('crypto')
+
+# Build targets from sourcesets
+
+stub_ss = stub_ss.apply(config_host, strict: false)
+
+util_ss.add_all(trace_ss)
+util_ss = util_ss.apply(config_host, strict: false)
+libqemuutil = static_library('qemuutil',
+                             sources: util_ss.sources() + stub_ss.sources() + genh,
+                             dependencies: [util_ss.dependencies(), m, glib, socket])
+qemuutil = declare_dependency(link_with: libqemuutil)
diff --git a/migration/trace.h b/migration/trace.h
new file mode 100644
index 0000000..e1a0f4f
--- /dev/null
+++ b/migration/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-migration.h"
diff --git a/monitor/trace.h b/monitor/trace.h
new file mode 100644
index 0000000..f216e31
--- /dev/null
+++ b/monitor/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-monitor.h"
diff --git a/nbd/trace.h b/nbd/trace.h
new file mode 100644
index 0000000..233d08f
--- /dev/null
+++ b/nbd/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-nbd.h"
diff --git a/net/trace.h b/net/trace.h
new file mode 100644
index 0000000..18d42c2
--- /dev/null
+++ b/net/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-net.h"
diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
index dd3f5e6..10ca4f6 100644
--- a/qapi/Makefile.objs
+++ b/qapi/Makefile.objs
@@ -1,25 +1,4 @@
-util-obj-y = qapi-visit-core.o qapi-dealloc-visitor.o qobject-input-visitor.o
-util-obj-y += qobject-output-visitor.o qmp-registry.o qmp-dispatch.o
-util-obj-y += string-input-visitor.o string-output-visitor.o
-util-obj-y += opts-visitor.o qapi-clone-visitor.o
-util-obj-y += qmp-event.o
-util-obj-y += qapi-util.o
-
-QAPI_COMMON_MODULES = audio authz block-core block char common crypto
-QAPI_COMMON_MODULES += dump error introspect job machine migration misc net
-QAPI_COMMON_MODULES += qdev qom rdma rocker run-state sockets tpm
-QAPI_COMMON_MODULES += trace transaction ui
 QAPI_TARGET_MODULES = machine-target misc-target
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
index 0000000..8431f26
--- /dev/null
+++ b/qapi/meson.build
@@ -0,0 +1,89 @@
+util_ss.add(files(
+  'opts-visitor.c',
+  'qapi-clone-visitor.c',
+  'qapi-dealloc-visitor.c',
+  'qapi-util.c',
+  'qapi-visit-core.c',
+  'qmp-dispatch.c',
+  'qmp-event.c',
+  'qmp-registry.c',
+  'qobject-input-visitor.c',
+  'qobject-output-visitor.c',
+  'string-input-visitor.c',
+  'string-output-visitor.c',
+))
+
+qapi_common_modules = [
+  'audio',
+  'authz',
+  'block-core',
+  'block',
+  'char',
+  'common',
+  'crypto',
+  'dump',
+  'error',
+  'introspect',
+  'job',
+  'machine',
+  'migration',
+  'misc',
+  'net',
+  'qdev',
+  'qom',
+  'rdma',
+  'rocker',
+  'run-state',
+  'sockets',
+  'tpm',
+  'trace',
+  'transaction',
+  'ui',
+]
+
+qapi_target_modules = [ 'machine-target', 'misc-target' ]
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
+  util_ss.add(qapi_files[i])
+  if qapi_util_outputs[i].endswith('.h')
+    genh += qapi_files[i]
+  endif
+  i = i + 1
+endforeach
diff --git a/qapi/trace.h b/qapi/trace.h
new file mode 100644
index 0000000..5c3fb67
--- /dev/null
+++ b/qapi/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-qapi.h"
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
index 0000000..bb63c06
--- /dev/null
+++ b/qobject/meson.build
@@ -0,0 +1,3 @@
+util_ss.add(files('qnull.c', 'qnum.c', 'qstring.c', 'qdict.c', 'qlist.c', 'qbool.c',
+  'qlit.c', 'qjson.c', 'qobject.c', 'json-lexer.c', 'json-streamer.c', 'json-parser.c',
+  'block-qdict.c'))
diff --git a/qom/trace.h b/qom/trace.h
new file mode 100644
index 0000000..f2895e6
--- /dev/null
+++ b/qom/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-qom.h"
diff --git a/rules.mak b/rules.mak
index e19ad19..fa9960c 100644
--- a/rules.mak
+++ b/rules.mak
@@ -32,7 +32,7 @@ QEMU_DGFLAGS += -MMD -MP -MT $@ -MF $(@D)/$(*F).d
 # dir, one absolute and the other relative to the compiler working
 # directory. These are the same for target-independent files, but
 # different for target-dependent ones.
-QEMU_LOCAL_INCLUDES = -iquote $(BUILD_DIR)/$(@D) -iquote $(@D)
+QEMU_LOCAL_INCLUDES = -iquote $(BUILD_DIR) -iquote $(BUILD_DIR)/$(@D) -iquote $(@D)
 
 WL_U := -Wl,-u,
 find-symbols = $(if $1, $(sort $(shell $(NM) -P -g $1 | $2)))
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
diff --git a/scripts/tracetool/backend/dtrace.py b/scripts/tracetool/backend/dtrace.py
old mode 100644
new mode 100755
index c2f3a4e..35b3c15
--- a/scripts/tracetool/backend/dtrace.py
+++ b/scripts/tracetool/backend/dtrace.py
@@ -39,7 +39,7 @@ def generate_h_begin(events, group):
     if group == "root":
         header = "trace-dtrace-root.h"
     else:
-        header = "trace-dtrace.h"
+        header = "trace-dtrace-%s.h" % group
 
     out('#include "%s"' % header,
         '')
diff --git a/scripts/tracetool/backend/ust.py b/scripts/tracetool/backend/ust.py
index 280cb7c..ba37b9f 100644
--- a/scripts/tracetool/backend/ust.py
+++ b/scripts/tracetool/backend/ust.py
@@ -20,11 +20,7 @@ PUBLIC = True
 
 
 def generate_h_begin(events, group):
-    if group == "root":
-        header = "trace-ust-root.h"
-    else:
-        header = "trace-ust.h"
-
+    header = 'trace-ust-' + group + '.h'
     out('#include <lttng/tracepoint.h>',
         '#include "%s"' % header,
         '',
diff --git a/scripts/tracetool/format/c.py b/scripts/tracetool/format/c.py
index 3120796..bd04798 100644
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
diff --git a/scripts/tracetool/format/tcg_h.py b/scripts/tracetool/format/tcg_h.py
index 1651cc3..21a2905 100644
--- a/scripts/tracetool/format/tcg_h.py
+++ b/scripts/tracetool/format/tcg_h.py
@@ -29,7 +29,7 @@ def vcpu_transform_args(args):
 
 def generate(events, backend, group):
     if group == "root":
-        header = "trace-root.h"
+        header = "trace/trace-root.h"
     else:
         header = "trace.h"
 
diff --git a/scripts/tracetool/format/tcg_helper_c.py b/scripts/tracetool/format/tcg_helper_c.py
index 1b3522a..1a14a29 100644
--- a/scripts/tracetool/format/tcg_helper_c.py
+++ b/scripts/tracetool/format/tcg_helper_c.py
@@ -42,7 +42,7 @@ def vcpu_transform_args(args, mode):
 
 def generate(events, backend, group):
     if group == "root":
-        header = "trace-root.h"
+        header = "trace/trace-root.h"
     else:
         header = "trace.h"
 
diff --git a/scsi/trace.h b/scsi/trace.h
new file mode 100644
index 0000000..3e4d89a
--- /dev/null
+++ b/scsi/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-scsi.h"
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
index 0000000..388b556
--- /dev/null
+++ b/stubs/meson.build
@@ -0,0 +1,45 @@
+stub_ss.add(files('bdrv-next-monitor-owned.c'))
+stub_ss.add(files('blk-commit-all.c'))
+stub_ss.add(files('blockdev-close-all-bdrv-states.c'))
+stub_ss.add(files('clock-warp.c'))
+stub_ss.add(files('cpu-get-clock.c'))
+stub_ss.add(files('cpu-get-icount.c'))
+stub_ss.add(files('dump.c'))
+stub_ss.add(files('error-printf.c'))
+stub_ss.add(files('fdset.c'))
+stub_ss.add(files('gdbstub.c'))
+stub_ss.add(files('get-vm-name.c'))
+stub_ss.add(files('iothread.c'))
+stub_ss.add(files('iothread-lock.c'))
+stub_ss.add(files('is-daemonized.c'))
+stub_ss.add(when: 'CONFIG_LINUX_AIO', if_true: files('linux-aio.c'))
+stub_ss.add(files('machine-init-done.c'))
+stub_ss.add(files('migr-blocker.c'))
+stub_ss.add(files('change-state-handler.c'))
+stub_ss.add(files('monitor.c'))
+stub_ss.add(files('notify-event.c'))
+stub_ss.add(files('qtest.c'))
+stub_ss.add(files('replay.c'))
+stub_ss.add(files('runstate-check.c'))
+stub_ss.add(files('set-fd-handler.c'))
+stub_ss.add(files('sysbus.c'))
+stub_ss.add(files('tpm.c'))
+stub_ss.add(files('trace-control.c'))
+stub_ss.add(files('uuid.c'))
+stub_ss.add(files('vm-stop.c'))
+stub_ss.add(files('vmstate.c'))
+stub_ss.add(files('fd-register.c'))
+stub_ss.add(files('qmp_memory_device.c'))
+stub_ss.add(files('target-monitor-defs.c'))
+stub_ss.add(files('target-get-monitor-def.c'))
+stub_ss.add(files('pc_madt_cpu_entry.c'))
+stub_ss.add(files('vmgenid.c'))
+stub_ss.add(files('xen-common.c'))
+stub_ss.add(files('xen-hvm.c'))
+stub_ss.add(files('pci-host-piix.c'))
+stub_ss.add(files('ram-block.c'))
+stub_ss.add(files('ramfb.c'))
+stub_ss.add(files('fw_cfg.c'))
+if have_system
+  stub_ss.add(files('semihost.c'))
+endif
diff --git a/target/arm/trace.h b/target/arm/trace.h
new file mode 100644
index 0000000..60372d8
--- /dev/null
+++ b/target/arm/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-target_arm.h"
diff --git a/target/hppa/trace.h b/target/hppa/trace.h
new file mode 100644
index 0000000..810cc09
--- /dev/null
+++ b/target/hppa/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-target_hppa.h"
diff --git a/target/i386/trace.h b/target/i386/trace.h
new file mode 100644
index 0000000..781e8ec
--- /dev/null
+++ b/target/i386/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-target_i386.h"
diff --git a/target/mips/trace.h b/target/mips/trace.h
new file mode 100644
index 0000000..f25b88c
--- /dev/null
+++ b/target/mips/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-target_mips.h"
diff --git a/target/ppc/trace.h b/target/ppc/trace.h
new file mode 100644
index 0000000..a9e8962
--- /dev/null
+++ b/target/ppc/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-target_ppc.h"
diff --git a/target/riscv/trace.h b/target/riscv/trace.h
new file mode 100644
index 0000000..03a89fc
--- /dev/null
+++ b/target/riscv/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-target_riscv.h"
diff --git a/target/s390x/trace.h b/target/s390x/trace.h
new file mode 100644
index 0000000..d7d59d4
--- /dev/null
+++ b/target/s390x/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-target_s390x.h"
diff --git a/target/sparc/trace.h b/target/sparc/trace.h
new file mode 100644
index 0000000..3b2f5a8
--- /dev/null
+++ b/target/sparc/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-target_sparc.h"
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
diff --git a/trace/control-target.c b/trace/control-target.c
index ceb55c7..e293eee 100644
--- a/trace/control-target.c
+++ b/trace/control-target.c
@@ -9,7 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "trace-root.h"
+#include "trace/trace-root.h"
 #include "trace/control.h"
 
 
diff --git a/trace/control.c b/trace/control.c
index 43fb786..16d66ef 100644
--- a/trace/control.c
+++ b/trace/control.c
@@ -27,7 +27,7 @@
 #include "qemu/error-report.h"
 #include "qemu/config-file.h"
 #include "monitor/monitor.h"
-#include "trace-root.h"
+#include "trace/trace-root.h"
 
 int trace_events_enabled_count;
 
diff --git a/trace/meson.build b/trace/meson.build
new file mode 100644
index 0000000..d0e5d17
--- /dev/null
+++ b/trace/meson.build
@@ -0,0 +1,82 @@
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
+  genh += trace_h
+  trace_c = custom_target(fmt.format('trace', 'c'),
+                          output: fmt.format('trace', 'c'),
+                          input: trace_events_file,
+                          command: [ tracetool, group, '--format=c', '@INPUT@' ],
+                          capture: true)
+  if 'CONFIG_TRACE_UST' in config_host
+    trace_ust_h = custom_target(fmt.format('trace-ust', 'h'),
+                                output: fmt.format('trace-ust', 'h'),
+                                input: trace_events_file,
+                                command: [ tracetool, group, '--format=ust-events-h', '@INPUT@' ],
+                                capture: true)
+    trace_ss.add(trace_ust_h, lttng, urcubp)
+    genh += trace_ust_h
+  endif
+  trace_ss.add(trace_h, trace_c)
+  if 'CONFIG_TRACE_DTRACE' in config_host
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
+    trace_ss.add(trace_dtrace_h, trace_dtrace_o)
+    genh += trace_dtrace_h
+  endif
+endforeach
+
+custom_target('trace-events-all',
+              output: 'trace-events-all',
+              input: trace_events_files,
+              command: [ 'cat', '@INPUT@' ],
+              capture: true,
+              install: true,
+              install_dir: config_host['qemu_datadir'])
+
+if 'CONFIG_TRACE_UST' in config_host
+  trace_ust_all_h = custom_target('trace-ust-all.h',
+                                  output: 'trace-ust-all.h',
+                                  input: trace_events_files,
+                                  command: [ tracetool, '--group=all', '--format=ust-events-h', '@INPUT@' ],
+                                  capture: true)
+  trace_ust_all_c = custom_target('trace-ust-all.c',
+                                  output: 'trace-ust-all.c',
+                                  input: trace_events_files,
+                                  command: [ tracetool, '--group=all', '--format=ust-events-c', '@INPUT@' ],
+                                  capture: true)
+  trace_ss.add(trace_ust_all_h, trace_ust_all_c)
+  genh += trace_ust_all_h
+endif
+
+trace_ss.add(when: 'CONFIG_TRACE_SIMPLE', if_true: files('simple.c'))
+trace_ss.add(when: 'CONFIG_TRACE_FTRACE', if_true: files('ftrace.c'))
+trace_ss.add(files('control.c'))
+trace_ss.add(files('qmp.c'))
diff --git a/ui/trace.h b/ui/trace.h
new file mode 100644
index 0000000..a89d769
--- /dev/null
+++ b/ui/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-ui.h"
diff --git a/util/Makefile.objs b/util/Makefile.objs
deleted file mode 100644
index ce928b1..0000000
--- a/util/Makefile.objs
+++ /dev/null
@@ -1,57 +0,0 @@
-util-obj-y = osdep.o cutils.o unicode.o qemu-timer-common.o
-util-obj-y += bufferiszero.o
-util-obj-y += lockcnt.o
-util-obj-y += aiocb.o async.o aio-wait.o thread-pool.o qemu-timer.o
-util-obj-y += main-loop.o
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
-util-obj-$(call lnot,$(CONFIG_INOTIFY1)) += filemonitor-stub.o
-util-obj-$(CONFIG_LINUX) += vfio-helpers.o
-util-obj-$(CONFIG_POSIX) += drm.o
-util-obj-y += guest-random.o
diff --git a/util/meson.build b/util/meson.build
new file mode 100644
index 0000000..9eaa41c
--- /dev/null
+++ b/util/meson.build
@@ -0,0 +1,57 @@
+util_ss.add(files('osdep.c', 'cutils.c', 'unicode.c', 'qemu-timer-common.c'))
+util_ss.add(files('bufferiszero.c'))
+util_ss.add(files('lockcnt.c'))
+util_ss.add(files('aiocb.c', 'async.c', 'aio-wait.c', 'thread-pool.c', 'qemu-timer.c'))
+util_ss.add(files('main-loop.c'))
+util_ss.add(when: 'CONFIG_ATOMIC64', if_false: files('atomic64.c'))
+util_ss.add(when: 'CONFIG_POSIX', if_true: files('aio-posix.c'))
+util_ss.add(when: 'CONFIG_POSIX', if_true: files('compatfd.c'))
+util_ss.add(when: 'CONFIG_POSIX', if_true: files('event_notifier-posix.c'))
+util_ss.add(when: 'CONFIG_POSIX', if_true: files('mmap-alloc.c'))
+util_ss.add(when: 'CONFIG_POSIX', if_true: files('oslib-posix.c'))
+util_ss.add(when: 'CONFIG_POSIX', if_true: [files('qemu-openpty.c'), util])
+util_ss.add(when: 'CONFIG_POSIX', if_true: files('qemu-thread-posix.c'))
+util_ss.add(when: 'CONFIG_POSIX', if_true: files('memfd.c'))
+util_ss.add(when: 'CONFIG_WIN32', if_true: files('aio-win32.c'))
+util_ss.add(when: 'CONFIG_WIN32', if_true: files('event_notifier-win32.c'))
+util_ss.add(when: 'CONFIG_WIN32', if_true: files('oslib-win32.c'))
+util_ss.add(when: 'CONFIG_WIN32', if_true: files('qemu-thread-win32.c'))
+util_ss.add(files('envlist.c', 'path.c', 'module.c'))
+util_ss.add(files('host-utils.c'))
+util_ss.add(files('bitmap.c', 'bitops.c', 'hbitmap.c'))
+util_ss.add(files('fifo8.c'))
+util_ss.add(files('cacheinfo.c'))
+util_ss.add(files('error.c', 'qemu-error.c'))
+util_ss.add(files('qemu-print.c'))
+util_ss.add(files('id.c'))
+util_ss.add(files('iov.c', 'qemu-config.c', 'qemu-sockets.c', 'uri.c', 'notify.c'))
+util_ss.add(files('qemu-option.c', 'qemu-progress.c'))
+util_ss.add(files('keyval.c'))
+util_ss.add(files('hexdump.c'))
+util_ss.add(files('crc32c.c'))
+util_ss.add(files('uuid.c'))
+util_ss.add(files('throttle.c'))
+util_ss.add(files('getauxval.c'))
+util_ss.add(files('readline.c'))
+util_ss.add(files('rcu.c'))
+util_ss.add(when: 'CONFIG_MEMBARRIER', if_true: files('sys_membarrier.c'))
+util_ss.add(files('qemu-coroutine.c', 'qemu-coroutine-lock.c', 'qemu-coroutine-io.c'))
+util_ss.add(files('qemu-coroutine-sleep.c'))
+util_ss.add(files('coroutine-@0@.c'.format(config_host['CONFIG_COROUTINE_BACKEND'])))
+util_ss.add(files('buffer.c'))
+util_ss.add(files('timed-average.c'))
+util_ss.add(files('base64.c'))
+util_ss.add(files('log.c'))
+util_ss.add(files('pagesize.c'))
+util_ss.add(files('qdist.c'))
+util_ss.add(files('qht.c'))
+util_ss.add(files('qsp.c'))
+util_ss.add(files('range.c'))
+util_ss.add(files('stats64.c'))
+util_ss.add(files('systemd.c'))
+util_ss.add(files('iova-tree.c'))
+util_ss.add(when: 'CONFIG_INOTIFY1', if_true: files('filemonitor-inotify.c'),
+                                      if_false: files('filemonitor-stub.c'))
+util_ss.add(when: 'CONFIG_LINUX', if_true: files('vfio-helpers.c'))
+util_ss.add(when: 'CONFIG_POSIX', if_true: files('drm.c'))
+util_ss.add(files('guest-random.c'))
diff --git a/util/trace.h b/util/trace.h
new file mode 100644
index 0000000..86ff7a3
--- /dev/null
+++ b/util/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-util.h"
diff --git a/vl.c b/vl.c
index 630f5c5..8c8a591 100644
--- a/vl.c
+++ b/vl.c
@@ -108,7 +108,7 @@ int main(int argc, char **argv)
 
 #include "disas/disas.h"
 
-#include "trace-root.h"
+#include "trace/trace-root.h"
 #include "trace/control.h"
 #include "qemu/queue.h"
 #include "sysemu/arch_init.h"
-- 
1.8.3.1



