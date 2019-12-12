Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C12C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:13:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DD912173E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYq9PWa+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD912173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOHQ-0000yn-Nv
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:13:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58989)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNy6-00034f-Ek
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNy4-0006BR-Rd
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:22 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:39014)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNy4-00069g-J1
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:20 -0500
Received: by mail-wm1-x332.google.com with SMTP id d5so2374588wmb.4
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ckq3xlyA0Y/TEyi6tdKF2WSmdCjFLbYMhdQ4Hgb8BiA=;
 b=RYq9PWa+gNxE9Dbr6CdIGcAKkCwawFY5ISYwq76pvTfjR636083CiKnp9/YeepIIlr
 6P0lyHx2OOKCIzv0xsNKgFaOH5/VWSgbT+xJFwBttK+QNxEfPcu7VpbgLSll1V4Nf01i
 qTSzQbS0yBS0QC12uwZy5xri9e3KSZvWln0uucpXmQRcnBVZwOd2kzfkTymFOGrv7loR
 k3ER0R44hO2mttDjrVEmrzSbTo6Kdo6hpWB2JDfykiUfOFur+xqEybNoCLO1ei7M6pnL
 MPQeMYMh3MF9qlw7q8dORgjmuOZ7XbUl5+DmWWtoTmRSMoLZ408XPvkdDfRI4Zj4kTUZ
 ID1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Ckq3xlyA0Y/TEyi6tdKF2WSmdCjFLbYMhdQ4Hgb8BiA=;
 b=QAHnqYj09/ouQRxS1/tITIdfiMccqyipBPfPzCg6cw3qycoaB8TBRpj+msdedABZE5
 TJj++ngKYvnL9Y80aX9apLmqfwUeDnAnsFvJsiepAgS6jkAyENXV2rJLCnLAFlSZMcwp
 rz9cjv2r51una+IlJGdJl45pp21aejr5j/Q8cuhQAMOwSFsNHqj5ZGeVeF6cfWqqDKAI
 e9FgYAdOOOmsWhrW/WQMaPMVvDKbNbXmIUtYlHqJ7efHnxLC0a8rP56W1SKKzO1EBk6Y
 JjT8bBgnmT0pI9QAMI9yVqWO/uvcCz3dLViryDYruz3kkx7rzVbgT7wg4LKsSM4YOK4m
 rGjA==
X-Gm-Message-State: APjAAAUZgoe/PlAAw6RXbFPAG962pkPhT+h9rmIayHsrTqLLi2pNrVz5
 8B02ivRhefuFSmmxHLkNfJcUEP0P
X-Google-Smtp-Source: APXvYqyNYBwi6vqcgBn3R7wcyB4OmeaK3tkCOFcIAoAjt83uSIIQIiaSV7QijADW9dI4gvCZlKJt1Q==
X-Received: by 2002:a05:600c:a:: with SMTP id g10mr6349562wmc.69.1576155199234; 
 Thu, 12 Dec 2019 04:53:19 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:18 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 021/132] meson: convert vss-win32
Date: Thu, 12 Dec 2019 13:51:05 +0100
Message-Id: <1576155176-2464-22-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                    |  1 -
 Makefile.objs               |  8 --------
 meson.build                 |  4 +++-
 qga/Makefile.objs           |  1 -
 qga/meson.build             |  6 ++++++
 qga/vss-win32/Makefile.objs | 23 -----------------------
 qga/vss-win32/meson.build   | 28 ++++++++++++++++++++++++++++
 7 files changed, 37 insertions(+), 34 deletions(-)
 delete mode 100644 qga/Makefile.objs
 delete mode 100644 qga/vss-win32/Makefile.objs
 create mode 100644 qga/vss-win32/meson.build

diff --git a/Makefile b/Makefile
index a78d5e0..4f20bf7 100644
--- a/Makefile
+++ b/Makefile
@@ -261,7 +261,6 @@ endif
 dummy := $(call unnest-vars,, \
                 authz-obj-y \
                 chardev-obj-y \
-                qga-vss-dll-obj-y \
                 block-obj-y \
                 block-obj-m \
                 crypto-obj-y \
diff --git a/Makefile.objs b/Makefile.objs
index 736bdaa..38e3604 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -94,11 +94,3 @@ version-obj-$(CONFIG_WIN32) += $(BUILD_DIR)/version.o
 ######################################################################
 # tracing
 util-obj-y +=  trace/
-
-######################################################################
-# guest agent
-
-# FIXME: a few definitions from qapi/qapi-types.o and
-# qapi/qapi-visit.o are needed by libqemuutil.a.  These should be
-# extracted into a QAPI schema module, or perhaps a separate schema.
-qga-vss-dll-obj-y = qga/
diff --git a/meson.build b/meson.build
index f65ad9d..7e772c1 100644
--- a/meson.build
+++ b/meson.build
@@ -9,12 +9,14 @@ add_project_arguments(config_host['CFLAGS'].split(),
                       language: ['c', 'objc'])
 add_project_arguments(config_host['QEMU_CFLAGS'].split(),
                       language: 'c')
+add_project_arguments(config_host['QEMU_CXXFLAGS'].split(),
+                      language: 'cpp')
 add_project_link_arguments(config_host['LDFLAGS'].split(),
                            language: ['c', 'cpp', 'objc'])
 add_project_link_arguments(config_host['QEMU_LDFLAGS'].split(),
                            language: ['c', 'cpp', 'objc'])
 add_project_arguments(config_host['QEMU_INCLUDES'].split(),
-                      language: 'c')
+                      language: ['c', 'cpp'])
 
 configure_file(input: files('scripts/ninjatool.py'),
                output: 'ninjatool',
diff --git a/qga/Makefile.objs b/qga/Makefile.objs
deleted file mode 100644
index 9ecf249..0000000
--- a/qga/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-qga-vss-dll-obj-$(CONFIG_QGA_VSS) += vss-win32/
diff --git a/qga/meson.build b/qga/meson.build
index 116102b..f0ec8cf 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -41,3 +41,9 @@ qga_ss = qga_ss.apply(config_host, strict: false)
 qga = executable('qemu-ga', qga_ss.sources(),
                  link_args: config_host['LIBS_QGA'].split(),
                  dependencies: [qemuutil, libudev])
+
+if host_machine.system() == 'windows'
+  if 'CONFIG_QGA_VSS' in config_host
+    subdir('vss-win32')
+  endif
+endif
diff --git a/qga/vss-win32/Makefile.objs b/qga/vss-win32/Makefile.objs
deleted file mode 100644
index fd3ba18..0000000
--- a/qga/vss-win32/Makefile.objs
+++ /dev/null
@@ -1,23 +0,0 @@
-# rules to build qga-vss.dll
-
-qga-vss-dll-obj-y += requester.o provider.o install.o
-
-obj-qga-vss-dll-obj-y = $(addprefix $(obj)/, $(qga-vss-dll-obj-y))
-$(obj-qga-vss-dll-obj-y): QEMU_CXXFLAGS := $(filter-out -fstack-protector-all -fstack-protector-strong, $(QEMU_CXXFLAGS)) -Wno-unknown-pragmas -Wno-delete-non-virtual-dtor
-
-$(obj)/qga-vss.dll: LDFLAGS = -shared -Wl,--add-stdcall-alias,--enable-stdcall-fixup -lglib-2.0 -lole32 -loleaut32 -lshlwapi -luuid -lintl -lws2_32 -static
-$(obj)/qga-vss.dll: $(obj-qga-vss-dll-obj-y) $(SRC_PATH)/$(obj)/qga-vss.def
-	$(call quiet-command,$(CXX) -o $@ $(qga-vss-dll-obj-y) $(SRC_PATH)/qga/vss-win32/qga-vss.def $(CXXFLAGS) $(LDFLAGS),"LINK","$(TARGET_DIR)$@")
-
-
-# rules to build qga-provider.tlb
-# Currently, only native build is supported because building .tlb
-# (TypeLibrary) from .idl requires WindowsSDK and MIDL (and cl.exe in VC++).
-MIDL=$(WIN_SDK)/Bin/midl
-
-$(obj)/qga-vss.tlb: $(SRC_PATH)/$(obj)/qga-vss.idl
-ifeq ($(WIN_SDK),"")
-	$(call quiet-command,cp $(dir $<)qga-vss.tlb $@,"COPY","$(TARGET_DIR)$@")
-else
-	$(call quiet-command,$(MIDL) -tlb $@ -I $(WIN_SDK)/Include $<,"MIDL","$(TARGET_DIR)$@")
-endif
diff --git a/qga/vss-win32/meson.build b/qga/vss-win32/meson.build
new file mode 100644
index 0000000..a7c865f
--- /dev/null
+++ b/qga/vss-win32/meson.build
@@ -0,0 +1,28 @@
+if add_languages('cpp', required: false)
+  glib_static = dependency('glib-2.0', static: true)
+  link_args = cc.get_supported_link_arguments(['-fstack-protector-all', '-fstack-protector-strong', '-Wl,--add-stdcall-alias', '-Wl,--enable-stdcall-fixup'])
+
+  shared_module('qga-vss', ['requester.cpp', 'provider.cpp', 'install.cpp'],
+                name_prefix: '',
+                cpp_args: ['-Wno-unknown-pragmas', '-Wno-delete-non-virtual-dtor', '-Wno-non-virtual-dtor'],
+                link_args: link_args,
+                vs_module_defs: 'qga-vss.def',
+                dependencies: glib_static)
+endif
+
+# rules to build qga-vss.tlb
+# Currently, only native build is supported because building .tlb
+# (TypeLibrary) from .idl requires WindowsSDK and MIDL (and cl.exe in VC++).
+midl = find_program('midl', required: false)
+if midl.found()
+  gen_tlb = custom_target('gen-tlb',
+                          input: 'qga-vss.idl',
+                          output: 'qga-vss.tlb',
+                          command: [midl, '-tlb', '-I' + config_host['WIN_SDK'],
+                                     '@INPUT@', '@OUTPUT@'])
+else
+  gen_tlb = custom_target('gen-tlb',
+                          input: 'qga-vss.tlb',
+                          output: 'qga-vss.tlb',
+                          command: ['cp', '@INPUT@', '@OUTPUT@'])
+endif
-- 
1.8.3.1



