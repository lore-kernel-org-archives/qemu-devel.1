Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADEEC33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:22:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2D832467E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3G0pjBG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D832467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35085 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVV2-00012s-2k
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:22:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58722)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV4g-0007K5-4g
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV4e-0000in-K6
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:53 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:46928)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV4e-0000bW-CG
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:52 -0500
Received: by mail-wr1-x435.google.com with SMTP id z7so17060526wrl.13
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TR04S3RnETVcTsLldX7hxngyg3RqyTsppUyzb3L86pY=;
 b=E3G0pjBG+sxVU0BEOjJUjmwlD96pFvZAqQr2BSGUQMBO9ULRKdAKARdb9f83CQLv2t
 98FmYECcmsAQ/A6Nc3tfBlKENGQieJ14xfUSZwv1a9/x3lsmU2fKGeHnmmKiIr3HI15R
 wygMIdNKDJ+m6DF0cEEzcP5zycrxfDF7mZG1maKx279hjMfsEf6l4PqqMjVdTlZUFcZ7
 Enkj9acEcKoLSFPbf8+ypyhRp1TnN2dZFIFNJ18Xtufr99Vi1Mmd/nISOBZYyN0xE61+
 4oTenOd4nK+/ZMK3YgPejVgy8Ph5X0ztR2Db/0VeVNWkBirokqmBLtfbly8rVpXa/crs
 4tVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=TR04S3RnETVcTsLldX7hxngyg3RqyTsppUyzb3L86pY=;
 b=Ptcw8cLXh7VMkNiiebn9sEf/J7sl9MZ7JQA6K4aNr4eRcy1BOeg121MExgRuJtodcZ
 5zDBQ3/o1rEl1rM6CzbsQ3w729SUgWkrOwz/BiTpXY22RdBXTsSLQLeapuRmmV9+25/K
 4BwXujMSNjM5bLK62X+LofUnCB5Blsvzcp7aD4EWAUv53/jHqF1r65aWq7GXUxZ8qNTe
 UEGYoEpTvaxtvixTYdZkkR0PKSt7Rb3R2LbqLwV6MnXOf1hQNPBuU/zntbcZ8n7fVY4y
 c/MQvuDi6GiEman5x/Fdj5961dyOXPZYRryhAkwXIdeUhvk0Seib8/KKYWarZYl6tmqT
 V0uA==
X-Gm-Message-State: APjAAAXH9CCsdfa5OaB1hFvGtM+V4PS84pjZLe2QfZXrl3Q3zLjbKdGG
 Y7oGwTLgHVrtk6cLbo36sdSpMQyP
X-Google-Smtp-Source: APXvYqy4JTATUTZZSveJGY+DrqVsJfA3e8lbgEnyzJB26WGbZlA1dTL0AjYXZOy27F+tNb8AV7NQoQ==
X-Received: by 2002:adf:8297:: with SMTP id 23mr28692517wrc.379.1580234089128; 
 Tue, 28 Jan 2020 09:54:49 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.54.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:54:48 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 025/142] meson: convert vss-win32
Date: Tue, 28 Jan 2020 18:51:45 +0100
Message-Id: <20200128175342.9066-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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
index ab007ff60f..5ddec3a5da 100644
--- a/Makefile
+++ b/Makefile
@@ -284,7 +284,6 @@ endif
 dummy := $(call unnest-vars,, \
                 authz-obj-y \
                 chardev-obj-y \
-                qga-vss-dll-obj-y \
                 block-obj-y \
                 block-obj-m \
                 crypto-obj-y \
diff --git a/Makefile.objs b/Makefile.objs
index 92321847d1..f1465a620e 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -93,11 +93,3 @@ version-obj-$(CONFIG_WIN32) += $(BUILD_DIR)/version.o
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
index 04e11460a0..8709847493 100644
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
index 9ecf2496da..0000000000
--- a/qga/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-qga-vss-dll-obj-$(CONFIG_QGA_VSS) += vss-win32/
diff --git a/qga/meson.build b/qga/meson.build
index 116102b865..f0ec8cf0d8 100644
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
index fd3ba1896b..0000000000
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
index 0000000000..a7c865ffde
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
2.21.0



