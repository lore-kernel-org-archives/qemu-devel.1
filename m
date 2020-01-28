Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA2FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:29:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 908DC20716
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pdyIFjbB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908DC20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVbq-0003Q3-P2
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:29:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59622)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV54-0007st-RK
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV53-0001eb-49
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:18 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:36267)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV52-0001WH-Np
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:16 -0500
Received: by mail-wm1-x32b.google.com with SMTP id p17so3577144wma.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=o3TXGYGmV/MwP/W8uOvf4xhCM1C9M0jbEjzBD/qYMIs=;
 b=pdyIFjbBQDuaVMcefWHqyKtrmAvD+3hbC2uvjuXkc35MStGMIEbTnf7BT8m2nUarCa
 Z75czulP0HgXe+QSyyUo4aO7kNpJJmrapG/h40WXU/o1A3Bjv4PdzJIJX01U323GDfOX
 u78YCp0DhNS7V0VwDg7o+6CpZVQN2pS3+u4MdD0f5Xh4mq3GX7TZS73LMZSaeD8TuuNW
 6xhqf75kI25eP0Bw6KHDYGdDTV8KHAMuA5zFOpsz+aDpd5Swaq1/9oVeF/leiSAaKoYu
 mqrGMXZBhhHQHr52lQSphkGd0nxLSWUIYmxxIaucL2nfvEfq1hnbAYzTDaZBkMJDt6k+
 cBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=o3TXGYGmV/MwP/W8uOvf4xhCM1C9M0jbEjzBD/qYMIs=;
 b=SOdA0GLkeYjx+aFAoFa02Np7+nwaFgfwjbx1tM9EPSgQjCmk254WF+iZ/IQDalHHH/
 hVdzd/4/Ai5ko6gpjDvttLaUqdk0M6UEBVgXtMIxPRgwy7Yiw30w0S72K4oJF8PKAUmf
 zNNV4L+xsYduFOiF6bekdc7LNT9MgEnyeHNlYyqF4neotwmcKn34Tt9oZETqu1hHUDdG
 xdexKdXXhotwL+Lb+OYynBmq2Qi+5CqX9KPTm5GEQDBRBgLuVBZ0RkBwmCyq/Ox93K+P
 OV3/6r1veHqvpdFAom380zqIaNCg6Fn5wfocpocvV2Z/l60N407F5y/v/GgofFeWLE0c
 r3LQ==
X-Gm-Message-State: APjAAAXAe6q7f5sfn6tN+Xfb7+vxWOZzf2c7NvucyLgsCYWDUa1KKLc8
 lgRx8JkHV3nBDIv51THbEnd22uwG
X-Google-Smtp-Source: APXvYqxBVns92yuyHHHTnTeqVvl82kmMkoWvnWn0mG2imUZSVOcD98sQjH2jY/X02I2o+tM/z0hoCg==
X-Received: by 2002:a7b:c109:: with SMTP id w9mr6180827wmi.14.1580234113259;
 Tue, 28 Jan 2020 09:55:13 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:55:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 035/142] meson: generate hxtool files
Date: Tue, 28 Jan 2020 18:51:55 +0100
Message-Id: <20200128175342.9066-36-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
 Makefile        | 20 +-------------------
 Makefile.target |  6 ------
 meson.build     | 35 +++++++++++++++++++++++++++++++++++
 scripts/hxtool  |  2 +-
 4 files changed, 37 insertions(+), 26 deletions(-)
 mode change 100644 => 100755 scripts/hxtool

diff --git a/Makefile b/Makefile
index a1cddb8476..040bcad43a 100644
--- a/Makefile
+++ b/Makefile
@@ -106,7 +106,7 @@ include $(SRC_PATH)/rules.mak
 # lor is defined in rules.mak
 CONFIG_BLOCK := $(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS))
 
-generated-files-y = config-host.h qemu-options.def
+generated-files-y = config-host.h
 
 generated-files-y += module_block.h
 
@@ -244,8 +244,6 @@ all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) $(TOOLS) $(HELPERS-y) recurse-all mo
 
 config-host.h: config-host.h-timestamp
 config-host.h-timestamp: config-host.mak
-qemu-options.def: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
-	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$@")
 
 TARGET_DIRS_RULES := $(foreach t, all clean install, $(addsuffix /$(t), $(TARGET_DIRS)))
 
@@ -343,9 +341,6 @@ ifdef CONFIG_MPATH
 scsi/qemu-pr-helper$(EXESUF): LIBS += -ludev -lmultipath -lmpathpersist
 endif
 
-qemu-img-cmds.h: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
-	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$@")
-
 module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
 	$(call quiet-command,$(PYTHON) $< $@ \
 	$(addprefix $(SRC_PATH)/,$(patsubst %.mo,%.c,$(block-obj-m))), \
@@ -363,7 +358,6 @@ clean: recurse-clean
 	rm -f $(edk2-decompressed)
 	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) TAGS cscope.* *.pod *~ */*~
 	rm -f fsdev/*.pod scsi/*.pod
-	rm -f qemu-img-cmds.h
 	rm -f $(foreach f,$(generated-files-y),$(f) $(f)-timestamp)
 	rm -f config-all-devices.mak
 
@@ -639,18 +633,6 @@ $(MANUAL_BUILDDIR)/specs/index.html: $(call manual-deps,specs)
 $(MANUAL_BUILDDIR)/interop/qemu-ga.8: $(call manual-deps,interop)
 	$(call build-manual,interop,man)
 
-qemu-options.texi: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
-	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","$@")
-
-qemu-monitor.texi: $(SRC_PATH)/hmp-commands.hx $(SRC_PATH)/scripts/hxtool
-	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","$@")
-
-qemu-monitor-info.texi: $(SRC_PATH)/hmp-commands-info.hx $(SRC_PATH)/scripts/hxtool
-	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","$@")
-
-qemu-img-cmds.texi: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
-	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","$@")
-
 docs/interop/qemu-qmp-qapi.texi: qapi/qapi-doc.texi
 	@cp -p $< $@
 
diff --git a/Makefile.target b/Makefile.target
index 7ffb46ef73..d94fa687bf 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -212,12 +212,6 @@ endif
 gdbstub-xml.c: $(TARGET_XML_FILES) $(SRC_PATH)/scripts/feature_to_c.sh
 	$(call quiet-command,rm -f $@ && $(SHELL) $(SRC_PATH)/scripts/feature_to_c.sh $@ $(TARGET_XML_FILES),"GEN","$(TARGET_DIR)$@")
 
-hmp-commands.h: $(SRC_PATH)/hmp-commands.hx $(SRC_PATH)/scripts/hxtool
-	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$(TARGET_DIR)$@")
-
-hmp-commands-info.h: $(SRC_PATH)/hmp-commands-info.hx $(SRC_PATH)/scripts/hxtool
-	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$(TARGET_DIR)$@")
-
 clean: clean-target
 	rm -f *.a *~ $(PROGS)
 	rm -f $(shell find . -name '*.[od]')
diff --git a/meson.build b/meson.build
index c0122a1ab9..08e37fd677 100644
--- a/meson.build
+++ b/meson.build
@@ -117,6 +117,7 @@ have_block = have_system or have_tools
 
 # Generators
 
+hxtool = find_program('scripts/hxtool')
 shaderinclude = find_program('scripts/shaderinclude.pl')
 qapi_gen = find_program('scripts/qapi-gen.py')
 qapi_gen_depends = [ meson.source_root() / 'scripts/qapi/__init__.py',
@@ -137,6 +138,40 @@ qapi_gen_depends = [ meson.source_root() / 'scripts/qapi/__init__.py',
                      meson.source_root() / 'scripts/qapi/doc.py',
 ]
 
+hxdep = []
+hx_headers = [
+  ['qemu-options.hx', 'qemu-options.def'],
+  ['qemu-img-cmds.hx', 'qemu-img-cmds.h'],
+]
+if have_system
+  hx_headers += [
+    ['hmp-commands.hx', 'hmp-commands.h'],
+    ['hmp-commands-info.hx', 'hmp-commands-info.h'],
+  ]
+endif
+foreach d : hx_headers
+  custom_target(d[1],
+                input: files(d[0]),
+                output: d[1],
+                capture: true,
+                build_by_default: true, # to be removed when added to a target
+                command: [hxtool, '-h', '@INPUT0@'])
+endforeach
+
+foreach d : [
+  ['qemu-options.hx', 'qemu-options.texi'],
+  ['hmp-commands.hx', 'qemu-monitor.texi'],
+  ['hmp-commands-info.hx', 'qemu-monitor-info.texi'],
+  ['qemu-img-cmds.hx', 'qemu-img-cmds.texi'],
+]
+  custom_target(d[1],
+                input: files(d[0]),
+                output: d[1],
+                capture: true,
+                build_by_default: true, # to be removed when added to a target
+                command: [hxtool, '-t', '@INPUT0@'])
+endforeach
+
 # Collect sourcesets.
 
 util_ss = ss.source_set()
diff --git a/scripts/hxtool b/scripts/hxtool
old mode 100644
new mode 100755
index 7d7c4289e3..27cbab59bf
--- a/scripts/hxtool
+++ b/scripts/hxtool
@@ -64,6 +64,6 @@ case "$1" in
 "-h") hxtoh ;;
 "-t") hxtotexi ;;
 *) exit 1 ;;
-esac
+esac < "$2"
 
 exit 0
-- 
2.21.0



