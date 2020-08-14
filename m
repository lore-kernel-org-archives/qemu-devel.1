Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458B7C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:37:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F974206B2
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AG/iqfgW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F974206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6W95-0004rI-BO
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 05:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6Vmq-0005el-OX
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:14:08 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44035
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6Vmm-0002uu-9z
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597396439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BARn5dtzeyJhpLfJXdqNX9DEb0TrtC4DXUmA184hA9s=;
 b=AG/iqfgWQM9tbwgjzhPVX1KF1Ng841JH9Wl7hi+Nso+sTYy8rv5ksX/24jKsfp0SaQfMeH
 fbwcrD9py4Q16ZwAKcCwevkN6yUmDucd0UfmizXt9xNKEO8NO0kztS9flatcIa9QPeyA9T
 YIZdjaICqUKtL+7mCTNfrIlSi7GUIic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-1BFjrkuJMbuv0nwNa4b21w-1; Fri, 14 Aug 2020 05:13:58 -0400
X-MC-Unique: 1BFjrkuJMbuv0nwNa4b21w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61A191005E5A
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:13:57 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1BEEF1002382;
 Fri, 14 Aug 2020 09:13:57 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 042/150] meson: add msi generation
Date: Fri, 14 Aug 2020 05:11:38 -0400
Message-Id: <20200814091326.16173-43-pbonzini@redhat.com>
In-Reply-To: <20200814091326.16173-1-pbonzini@redhat.com>
References: <20200814091326.16173-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 01:57:54
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                  | 18 ------------------
 qga/meson.build           | 25 +++++++++++++++++++++++++
 qga/vss-win32/meson.build |  3 ++-
 3 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/Makefile b/Makefile
index c71269ff22..f8e5ebaff9 100644
--- a/Makefile
+++ b/Makefile
@@ -441,23 +441,6 @@ qemu-img-cmds.h: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
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
@@ -473,7 +456,6 @@ clean: recurse-clean ninja-clean clean-ctlist
 # avoid old build problems by removing potentially incorrect old files
 	rm -f config.mak op-i386.h opc-i386.h gen-op-i386.h op-arm.h opc-arm.h gen-op-arm.h
 	rm -f qemu-options.def
-	rm -f *.msi
 	find . \( -name '*.so' -o -name '*.dll' -o -name '*.mo' -o -name '*.[oda]' \) -type f \
 		! -path ./roms/edk2/ArmPkg/Library/GccLto/liblto-aarch64.a \
 		! -path ./roms/edk2/ArmPkg/Library/GccLto/liblto-arm.a \
diff --git a/qga/meson.build b/qga/meson.build
index 948302e06d..2d33c09fe6 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -48,5 +48,30 @@ qga = executable('qemu-ga', qga_ss.sources(),
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
index 42c8d31a3d..1f39e05335 100644
--- a/qga/vss-win32/meson.build
+++ b/qga/vss-win32/meson.build
@@ -2,7 +2,8 @@ if add_languages('cpp', required: false)
   glib_static = dependency('glib-2.0', static: true)
   link_args = cc.get_supported_link_arguments(['-fstack-protector-all', '-fstack-protector-strong',
                                                '-Wl,--add-stdcall-alias', '-Wl,--enable-stdcall-fixup'])
-  shared_module('qga-vss', ['requester.cpp', 'provider.cpp', 'install.cpp'],
+
+  qga_vss = shared_module('qga-vss', ['requester.cpp', 'provider.cpp', 'install.cpp'],
                 name_prefix: '',
                 cpp_args: ['-Wno-unknown-pragmas', '-Wno-delete-non-virtual-dtor', '-Wno-non-virtual-dtor'],
                 link_args: link_args,
-- 
2.26.2



