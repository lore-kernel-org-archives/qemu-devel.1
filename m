Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F05BC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:02:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3D25204FD
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIVL0f18"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D25204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7geX-0001v5-Ua
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHD-0004gv-0s
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:19 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36938)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHB-0006Ax-2o
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:18 -0400
Received: by mail-wm1-x342.google.com with SMTP id k8so14101540wma.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=u9LHgiiPmGa38g/Fb0syP3eiMwtEunpU2hIQUxxiPH0=;
 b=OIVL0f18QpUOgr0A6If5b2CfwkNvJoG9OnnILoaukT59HaivT27sqN7bypVB7+iZev
 atOEnSF/UtjBsswWOg789UnVkvVEw93Wce+FeMRU+jTIcc0b8nBsL52oO6gOWepCQUX+
 1WMTwxHqxXBH7U7o5IJQ7g4M3B3IGbYextKBbByxPab1wtwCRBB9zB9YRKRM2CKCkNFS
 UDbGLpV4bX1kx1G+g+eZQtbCBFsgN6Dnfge8lyscjgD8iLUHwibJdHfkgBpwe5or0P4k
 HriHAfqq8Lw2fE7uPZHFvJHi85yuVf+vUw6ON95NdnLwLBi4saC0rHnFJBU5oXaAPTqO
 u/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=u9LHgiiPmGa38g/Fb0syP3eiMwtEunpU2hIQUxxiPH0=;
 b=h4+pA/0ssMCbY40nqskGcqPqFmNq01xd53W1CeMKXJxAoIv/1rUNZ3BKiAsxcJ/Wld
 8JJu0fQo9jLRgEO/llxTwZcTnNtW51IUPfjz+XzjjXRyIi8I59NM6i34afwPXEoN8mRK
 VaptHkBdeXYuTAyxSSDvo0IA1N/6/XCdC7n7wu3OGfB9SZHZW/uKs11GZa0jITd9yiFq
 PsYBSV3LbjZxbwldTdEEqoy79BEXO6E4iWc1rHgWGb4pY/K7v3acUDm2EaojsjhLZdSZ
 uJgE0fLHFhL/BnPvV6KO+kXGEO/lEFM8LcaUIwbqBhoh4FcfVYFcyTp56fKn9JgtmzAa
 VWlQ==
X-Gm-Message-State: AOAM531PapXAf0jO3ggCaJ/gi2OYiTEwJIgPWLny0awGFgfsL9d5TESE
 PW2NIFkGJsqxevH7h5eOfgR5cRGmH5c=
X-Google-Smtp-Source: ABdhPJy85zju38mu4V6ZHHXGDKyPUSDpHQGD0UhEOd07aTgTiTuZSIFRSjhmm4wTWaMP0K76v4T74w==
X-Received: by 2002:a7b:cf22:: with SMTP id m2mr15386543wmg.46.1597675095520; 
 Mon, 17 Aug 2020 07:38:15 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 051/150] meson: handle edk2 bios and descriptors
Date: Mon, 17 Aug 2020 16:35:44 +0200
Message-Id: <20200817143723.343284-52-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                        | 29 -----------------------------
 meson.build                     |  1 +
 pc-bios/descriptors/meson.build | 14 ++++++++++++++
 pc-bios/meson.build             | 27 +++++++++++++++++++++++++++
 4 files changed, 42 insertions(+), 29 deletions(-)
 create mode 100644 pc-bios/descriptors/meson.build
 create mode 100644 pc-bios/meson.build

diff --git a/Makefile b/Makefile
index ca331b13dc..68ad75d210 100644
--- a/Makefile
+++ b/Makefile
@@ -116,10 +116,6 @@ generated-files-y += module_block.h
 
 generated-files-y += .git-submodule-status
 
-edk2-decompressed = $(basename $(wildcard pc-bios/edk2-*.fd.bz2))
-pc-bios/edk2-%.fd: pc-bios/edk2-%.fd.bz2
-	$(call quiet-command,bzip2 -d -c $< > $@,"BUNZIP2",$<)
-
 # Don't try to regenerate Makefile or configure
 # We don't generate any of them
 Makefile: ;
@@ -263,9 +259,6 @@ $(SOFTMMU_ALL_RULES): $(chardev-obj-y)
 $(SOFTMMU_ALL_RULES): $(crypto-obj-y)
 $(SOFTMMU_ALL_RULES): $(io-obj-y)
 $(SOFTMMU_ALL_RULES): config-all-devices.mak
-ifdef DECOMPRESS_EDK2_BLOBS
-$(SOFTMMU_ALL_RULES): $(edk2-decompressed)
-endif
 
 SOFTMMU_FUZZ_RULES=$(filter %-softmmu/fuzz, $(TARGET_DIRS_RULES))
 $(SOFTMMU_FUZZ_RULES): $(authz-obj-y)
@@ -373,7 +366,6 @@ clean: recurse-clean ninja-clean clean-ctlist
 		! -path ./roms/edk2/ArmPkg/Library/GccLto/liblto-arm.a \
 		! -path ./roms/edk2/BaseTools/Source/Python/UPT/Dll/sqlite3.dll \
 		-exec rm {} +
-	rm -f $(edk2-decompressed)
 	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) TAGS cscope.* *.pod *~ */*~
 	rm -f fsdev/*.pod scsi/*.pod
 	rm -f $(foreach f,$(generated-files-y),$(f) $(f)-timestamp)
@@ -450,13 +442,8 @@ edk2-licenses.txt \
 hppa-firmware.img \
 opensbi-riscv32-sifive_u-fw_jump.bin opensbi-riscv32-virt-fw_jump.bin \
 opensbi-riscv64-sifive_u-fw_jump.bin opensbi-riscv64-virt-fw_jump.bin
-
-
-DESCS=50-edk2-i386-secure.json 50-edk2-x86_64-secure.json \
-60-edk2-aarch64.json 60-edk2-arm.json 60-edk2-i386.json 60-edk2-x86_64.json
 else
 BLOBS=
-DESCS=
 endif
 
 # Note that we manually filter-out the non-Sphinx documentation which
@@ -533,7 +520,6 @@ install-includedir:
 export DESTDIR
 install: all $(if $(BUILD_DOCS),install-doc) \
 	install-datadir install-localstatedir install-includedir \
-	$(if $(INSTALL_BLOBS),$(edk2-decompressed)) \
 	recurse-install
 ifneq ($(TOOLS),)
 	$(call install-prog,$(TOOLS),$(DESTDIR)$(bindir))
@@ -556,21 +542,6 @@ ifneq ($(BLOBS),)
 	set -e; for x in $(BLOBS); do \
 		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/$$x "$(DESTDIR)$(qemu_datadir)"; \
 	done
-endif
-ifdef INSTALL_BLOBS
-	set -e; for x in $(edk2-decompressed); do \
-		$(INSTALL_DATA) $$x "$(DESTDIR)$(qemu_datadir)"; \
-	done
-endif
-ifneq ($(DESCS),)
-	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/firmware"
-	set -e; tmpf=$$(mktemp); trap 'rm -f -- "$$tmpf"' EXIT; \
-	for x in $(DESCS); do \
-		sed -e 's,@DATADIR@,$(qemu_datadir),' \
-			"$(SRC_PATH)/pc-bios/descriptors/$$x" > "$$tmpf"; \
-		$(INSTALL_DATA) "$$tmpf" \
-			"$(DESTDIR)$(qemu_datadir)/firmware/$$x"; \
-	done
 endif
 	for s in $(ICON_SIZES); do \
 		mkdir -p "$(DESTDIR)$(qemu_icondir)/hicolor/$${s}/apps"; \
diff --git a/meson.build b/meson.build
index 131ba26c1d..bb9e918e4c 100644
--- a/meson.build
+++ b/meson.build
@@ -379,6 +379,7 @@ if have_tools
 endif
 
 subdir('tools')
+subdir('pc-bios')
 
 summary_info = {}
 summary_info += {'Install prefix':    config_host['prefix']}
diff --git a/pc-bios/descriptors/meson.build b/pc-bios/descriptors/meson.build
new file mode 100644
index 0000000000..7c715bace8
--- /dev/null
+++ b/pc-bios/descriptors/meson.build
@@ -0,0 +1,14 @@
+foreach f: [
+  '50-edk2-i386-secure.json',
+  '50-edk2-x86_64-secure.json',
+  '60-edk2-aarch64.json',
+  '60-edk2-arm.json',
+  '60-edk2-i386.json',
+  '60-edk2-x86_64.json'
+]
+  configure_file(input: files(f),
+                 output: f,
+                 configuration: {'DATADIR': config_host['qemu_datadir']},
+                 install: install_blobs,
+                 install_dir: config_host['qemu_datadir'] / 'firmware')
+endforeach
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
new file mode 100644
index 0000000000..6e3bfe3ca4
--- /dev/null
+++ b/pc-bios/meson.build
@@ -0,0 +1,27 @@
+bzip2 = find_program('bzip2')
+
+install_blobs = 'INSTALL_BLOBS' in config_host
+if 'DECOMPRESS_EDK2_BLOBS' in config_host
+  fds = [
+    'edk2-aarch64-code.fd',
+    'edk2-arm-code.fd',
+    'edk2-arm-vars.fd',
+    'edk2-i386-code.fd',
+    'edk2-i386-secure-code.fd',
+    'edk2-i386-vars.fd',
+    'edk2-x86_64-code.fd',
+    'edk2-x86_64-secure-code.fd',
+  ]
+
+  foreach f : fds
+    custom_target(f,
+                  output: f,
+                  input: '@0@.bz2'.format(f),
+                  capture: true,
+                  install: install_blobs,
+                  install_dir: config_host['qemu_datadir'],
+                  command: [ bzip2, '-dc', '@INPUT0@' ])
+  endforeach
+endif
+
+subdir('descriptors')
-- 
2.26.2



