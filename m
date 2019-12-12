Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40BFC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:18:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 700772173E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZldoJaX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 700772173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOMW-0007jh-VO
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:18:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59138)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNy8-00035s-8Z
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNy5-0006DF-QY
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:23 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:43663)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNy5-0006BZ-IW
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:21 -0500
Received: by mail-wr1-x431.google.com with SMTP id d16so2588057wre.10
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bcmVb7Mje1ZL+Y95A04ro5C6kr06ir0SgoJ9qeN6MxI=;
 b=EZldoJaXud6IzCjmvTJcIAuLde7cPdO/I8szhhoxJ/KrQElHPOHPY8b14oPo8mv5Ug
 LLdqy1/9RuS6lYzGKz/lFO5JFUP0MP/F8yvfoxi0mqNMNzltkR3Zz0EQKXGhusODgK3t
 kIdI1O35ZvGiYm8pZP5Tmz4CB3ZlfXYK66jhTVyw9mFmuaZFbn65z4SEuhm73raBxDIQ
 rWdYNF3JZKfcgLIXRr7Yse7LZdaOo46M71y9+BQOhegU3lm1gvWsltsQ8Pp32oUedFzr
 mdyNDj/i1sGpYLiF2iB8uHhkhymHPUO/5L+uHEjJ9R3MmR6CbPZETdLITTiTYTaJkPsv
 aYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=bcmVb7Mje1ZL+Y95A04ro5C6kr06ir0SgoJ9qeN6MxI=;
 b=A/DBST8iZ3MnEAVZlZrctQ4c1W/tlwKMGM31IREARFl6K+2wBlAaFWF57NgaWfh27I
 z2LktrbnetN450Vq/mu6iva4p4hNOksVmyc9ttFCag5Txv3r9O9kyan4A7UgsSVCIxrx
 KycRfE6mpmN3VetlM1FT5bbgNg5+OxKiLRV5MO5IqfVk1wKOWf07ZWygiyyQ6A9ndw1m
 8B0Fi3PsqMQKwpMW9P15NqcpS6gqmMU1rtU9+uDW+79XHTJwjPTvxHH2IoFqNORHqEs8
 4RXbJ7MaIvQ2eGowyS1Nz/PmTvSnFk4Y124libt43g0HtGVpdQvlFXK9BeEjtbDkJPUM
 U6jQ==
X-Gm-Message-State: APjAAAXtjoP0yFqrzZZv80dcToC6qFlQ1v/sAQvx8WhLfLEPing/YuuV
 F1ch7v2Hpm3uaUXwYZLLAkowT4R9
X-Google-Smtp-Source: APXvYqzuXxo73lub0/SJYS+1megy59pIpXLg3j5KsbJp8+N4Ojx0IaUnBkivAmwlcsjPikagUgRQnQ==
X-Received: by 2002:adf:a141:: with SMTP id r1mr6256141wrr.285.1576155200323; 
 Thu, 12 Dec 2019 04:53:20 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:19 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 022/132] meson: add msi generation
Date: Thu, 12 Dec 2019 13:51:06 +0100
Message-Id: <1576155176-2464-23-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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
 Makefile                  | 18 ------------------
 qga/meson.build           | 25 +++++++++++++++++++++++++
 qga/vss-win32/meson.build |  2 +-
 3 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/Makefile b/Makefile
index 4f20bf7..328b3c3 100644
--- a/Makefile
+++ b/Makefile
@@ -394,23 +394,6 @@ qemu-img-cmds.h: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
 qemu-keymap$(EXESUF): LIBS += $(XKBCOMMON_LIBS)
 qemu-keymap$(EXESUF): QEMU_CFLAGS += $(XKBCOMMON_CFLAGS)
 
-ifdef QEMU_GA_MSI_ENABLED
-QEMU_GA_MSI=qemu-ga-$(ARCH).msi
-
-msi: $(QEMU_GA_MSI)
-
-$(QEMU_GA_MSI): qga/qemu-ga.exe $(QGA_VSS_PROVIDER)
-
-$(QEMU_GA_MSI): config-host.mak
-
-$(QEMU_GA_MSI):  $(SRC_PATH)/qga/installer/qemu-ga.wxs
-	$(call quiet-command,QEMU_GA_VERSION="$(QEMU_GA_VERSION)" QEMU_GA_MANUFACTURER="$(QEMU_GA_MANUFACTURER)" QEMU_GA_DISTRO="$(QEMU_GA_DISTRO)" BUILD_DIR="$(BUILD_DIR)" \
-	wixl -o $@ $(QEMU_GA_MSI_ARCH) $(QEMU_GA_MSI_WITH_VSS) $(QEMU_GA_MSI_MINGW_DLL_PATH) $<,"WIXL","$@")
-else
-msi:
-	@echo "MSI build not configured or dependency resolution failed (reconfigure with --enable-guest-agent-msi option)"
-endif
-
 ifneq ($(EXESUF),)
 .PHONY: qga/qemu-ga
 qga/qemu-ga: qga/qemu-ga$(EXESUF) $(QGA_VSS_PROVIDER) $(QEMU_GA_MSI)
@@ -425,7 +408,6 @@ clean: recurse-clean
 # avoid old build problems by removing potentially incorrect old files
 	rm -f config.mak op-i386.h opc-i386.h gen-op-i386.h op-arm.h opc-arm.h gen-op-arm.h
 	rm -f qemu-options.def
-	rm -f *.msi
 	find . \( -name '*.so' -o -name '*.dll' -o -name '*.mo' -o -name '*.[oda]' \) -type f \
 		! -path ./roms/edk2/ArmPkg/Library/GccLto/liblto-aarch64.a \
 		! -path ./roms/edk2/ArmPkg/Library/GccLto/liblto-arm.a \
diff --git a/qga/meson.build b/qga/meson.build
index f0ec8cf..e0e5344 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -45,5 +45,30 @@ qga = executable('qemu-ga', qga_ss.sources(),
 if host_machine.system() == 'windows'
   if 'CONFIG_QGA_VSS' in config_host
     subdir('vss-win32')
+  else
+    gen_tlb = []
+  endif
+
+  wixl = find_program('wixl', required: false)
+  if wixl.found()
+    deps = [gen_tlb, qga]
+    if 'QEMU_GA_MSI_WITH_VSS' in config_host
+      deps += qga_vss
+    endif
+    qga_msi = custom_target('QGA MSI',
+                            input: files('installer/qemu-ga.wxs'),
+                            output: 'qemu-ga-@0@.msi'.format(config_host['ARCH']),
+                            depends: deps,
+                            command: [
+                              'QEMU_GA_VERSION=' + config_host['QEMU_GA_VERSION'],
+                              'QEMU_GA_MANUFACTURER=' + config_host['QEMU_GA_MANUFACTURER'],
+                              'QEMU_GA_DISTRO=' + config_host['QEMU_GA_DISTRO'],
+                              'BUILD_DIR=' + meson.build_root(),
+                              wixl, '-o', '@OUTPUT0@', '@INPUT0@',
+                              config_host['QEMU_GA_MSI_ARCH'].split(),
+                              config_host['QEMU_GA_MSI_WITH_VSS'].split(),
+                              config_host['QEMU_GA_MSI_MINGW_DLL_PATH'].split(),
+                            ])
+    alias_target('msi', qga_msi)
   endif
 endif
diff --git a/qga/vss-win32/meson.build b/qga/vss-win32/meson.build
index a7c865f..147a680 100644
--- a/qga/vss-win32/meson.build
+++ b/qga/vss-win32/meson.build
@@ -2,7 +2,7 @@ if add_languages('cpp', required: false)
   glib_static = dependency('glib-2.0', static: true)
   link_args = cc.get_supported_link_arguments(['-fstack-protector-all', '-fstack-protector-strong', '-Wl,--add-stdcall-alias', '-Wl,--enable-stdcall-fixup'])
 
-  shared_module('qga-vss', ['requester.cpp', 'provider.cpp', 'install.cpp'],
+  qga_vss = shared_module('qga-vss', ['requester.cpp', 'provider.cpp', 'install.cpp'],
                 name_prefix: '',
                 cpp_args: ['-Wno-unknown-pragmas', '-Wno-delete-non-virtual-dtor', '-Wno-non-virtual-dtor'],
                 link_args: link_args,
-- 
1.8.3.1



