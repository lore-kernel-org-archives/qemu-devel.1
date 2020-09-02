Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B8DC433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:15:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D54520767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XcqGuK8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D54520767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDScD-0005Di-DE
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 09:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDSMY-0006L5-L8
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:59:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52221
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDSMV-0007A6-A5
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599051578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NC21SpAiW8/7oxYwrnfmwYFmwNhzILdDrPwOW1B2HAw=;
 b=XcqGuK8IH4JKcc3kplDPFpg8rfkh2uPPARScphPv/+Scfcqb4DUwZghAOSOml0f4L/Pjza
 sJoz3PCCOC5l6hkUE1HnJrusjdBtS2u3fZh43e9VKidijSwiFKnXwGnO0nOe22uN0xBih3
 RjgWdSH8se7QHtagsE8xYMDgZCxvYeU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-JfGhojGBMv26BQ1PdPHJWA-1; Wed, 02 Sep 2020 08:59:36 -0400
X-MC-Unique: JfGhojGBMv26BQ1PdPHJWA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FA01871805
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2020 12:59:33 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D5E55D9CC
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2020 12:59:33 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 30/39] configure: move disassembler configuration to meson
Date: Wed,  2 Sep 2020 08:59:08 -0400
Message-Id: <20200902125917.26021-31-pbonzini@redhat.com>
In-Reply-To: <20200902125917.26021-1-pbonzini@redhat.com>
References: <20200902125917.26021-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:26:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitignore        |  1 -
 configure         | 87 -----------------------------------------------
 disas/meson.build |  4 +--
 meson.build       | 45 +++++++++++++++++++++++-
 4 files changed, 45 insertions(+), 92 deletions(-)

diff --git a/.gitignore b/.gitignore
index f3fbd87ce4..b6fdd34ddf 100644
--- a/.gitignore
+++ b/.gitignore
@@ -2,7 +2,6 @@
 /build/
 /.doctrees
 /config-devices.*
-/config-all-disas.*
 /config-host.*
 /config-target.*
 /config.status
diff --git a/configure b/configure
index eee310b310..8df41b2f8b 100755
--- a/configure
+++ b/configure
@@ -7907,93 +7907,6 @@ if test "$target_bsd_user" = "yes" ; then
   echo "CONFIG_BSD_USER=y" >> $config_target_mak
 fi
 
-
-# generate QEMU_CFLAGS/QEMU_LDFLAGS for targets
-
-disas_config() {
-  echo "CONFIG_${1}_DIS=y" >> $config_target_mak
-  echo "CONFIG_${1}_DIS=y" >> config-all-disas.mak
-}
-
-for i in $ARCH $TARGET_BASE_ARCH ; do
-  case "$i" in
-  alpha)
-    disas_config "ALPHA"
-  ;;
-  aarch64)
-    if test -n "${cxx}"; then
-      disas_config "ARM_A64"
-    fi
-  ;;
-  arm)
-    disas_config "ARM"
-    if test -n "${cxx}"; then
-      disas_config "ARM_A64"
-    fi
-  ;;
-  avr)
-    disas_config "AVR"
-  ;;
-  cris)
-    disas_config "CRIS"
-  ;;
-  hppa)
-    disas_config "HPPA"
-  ;;
-  i386|x86_64|x32)
-    disas_config "I386"
-  ;;
-  lm32)
-    disas_config "LM32"
-  ;;
-  m68k)
-    disas_config "M68K"
-  ;;
-  microblaze*)
-    disas_config "MICROBLAZE"
-  ;;
-  mips*)
-    disas_config "MIPS"
-    if test -n "${cxx}"; then
-      disas_config "NANOMIPS"
-    fi
-  ;;
-  moxie*)
-    disas_config "MOXIE"
-  ;;
-  nios2)
-    disas_config "NIOS2"
-  ;;
-  or1k)
-    disas_config "OPENRISC"
-  ;;
-  ppc*)
-    disas_config "PPC"
-  ;;
-  riscv*)
-    disas_config "RISCV"
-  ;;
-  rx)
-    disas_config "RX"
-  ;;
-  s390*)
-    disas_config "S390"
-  ;;
-  sh4)
-    disas_config "SH4"
-  ;;
-  sparc*)
-    disas_config "SPARC"
-  ;;
-  xtensa*)
-    disas_config "XTENSA"
-  ;;
-  esac
-done
-if test "$tcg_interpreter" = "yes" ; then
-  disas_config "TCI"
-fi
-
 done # for target in $targets
 
 if [ "$fdt" = "git" ]; then
diff --git a/disas/meson.build b/disas/meson.build
index 0527d69128..bde8280c73 100644
--- a/disas/meson.build
+++ b/disas/meson.build
@@ -22,6 +22,4 @@ common_ss.add(when: 'CONFIG_SH4_DIS', if_true: files('sh4.c'))
 common_ss.add(when: 'CONFIG_SPARC_DIS', if_true: files('sparc.c'))
 common_ss.add(when: 'CONFIG_XTENSA_DIS', if_true: files('xtensa.c'))
 
-# TODO: As long as the TCG interpreter and its generated code depend
-# on the QEMU target, we cannot compile the disassembler here.
-#common_ss.add(when: 'CONFIG_TCI_DIS', if_true: files('tci.c'))
+specific_ss.add(when: 'CONFIG_TCG_INTERPRETER', if_true: files('tci.c'))
diff --git a/meson.build b/meson.build
index 037ccd3f4c..84a3e610e7 100644
--- a/meson.build
+++ b/meson.build
@@ -14,7 +14,6 @@ ss = import('sourceset')
 sh = find_program('sh')
 cc = meson.get_compiler('c')
 config_host = keyval.load(meson.current_build_dir() / 'config-host.mak')
-config_all_disas = keyval.load(meson.current_build_dir() / 'config-all-disas.mak')
 enable_modules = 'CONFIG_MODULES' in config_host
 enable_static = 'CONFIG_STATIC' in config_host
 build_docs = 'BUILD_DOCS' in config_host
@@ -456,10 +455,44 @@ genh += configure_file(output: 'config-host.h', configuration: config_host_data)
 
 minikconf = find_program('scripts/minikconf.py')
 config_all_devices = {}
+config_all_disas = {}
 config_devices_mak_list = []
 config_devices_h = {}
 config_target_h = {}
 config_target_mak = {}
+
+disassemblers = {
+  'alpha' : ['CONFIG_ALPHA_DIS'],
+  'arm' : ['CONFIG_ARM_DIS'],
+  'avr' : ['CONFIG_AVR_DIS'],
+  'cris' : ['CONFIG_CRIS_DIS'],
+  'hppa' : ['CONFIG_HPPA_DIS'],
+  'i386' : ['CONFIG_I386_DIS'],
+  'x86_64' : ['CONFIG_I386_DIS'],
+  'x32' : ['CONFIG_I386_DIS'],
+  'lm32' : ['CONFIG_LM32_DIS'],
+  'm68k' : ['CONFIG_M68K_DIS'],
+  'microblaze' : ['CONFIG_MICROBLAZE_DIS'],
+  'mips' : ['CONFIG_MIPS_DIS'],
+  'moxie' : ['CONFIG_MOXIE_DIS'],
+  'nios2' : ['CONFIG_NIOS2_DIS'],
+  'or1k' : ['CONFIG_OPENRISC_DIS'],
+  'ppc' : ['CONFIG_PPC_DIS'],
+  'riscv' : ['CONFIG_RISCV_DIS'],
+  'rx' : ['CONFIG_RX_DIS'],
+  's390' : ['CONFIG_S390_DIS'],
+  'sh4' : ['CONFIG_SH4_DIS'],
+  'sparc' : ['CONFIG_SPARC_DIS'],
+  'xtensa' : ['CONFIG_XTENSA_DIS'],
+}
+if link_language == 'cpp'
+  disassemblers += {
+    'aarch64' : [ 'CONFIG_ARM_A64_DIS'],
+    'arm' : [ 'CONFIG_ARM_DIS', 'CONFIG_ARM_A64_DIS'],
+    'mips' : [ 'CONFIG_MIPS_DIS', 'CONFIG_NANOMIPS_DIS'],
+  }
+endif
+
 kconfig_external_symbols = [
   'CONFIG_KVM',
   'CONFIG_XEN',
@@ -475,9 +508,19 @@ kconfig_external_symbols = [
   'CONFIG_PVRDMA',
 ]
 ignored = ['TARGET_XML_FILES', 'TARGET_ABI_DIR', 'TARGET_DIRS']
+
 foreach target : target_dirs
   config_target = keyval.load(meson.current_build_dir() / target / 'config-target.mak')
 
+  foreach k, v: disassemblers
+    if config_host['ARCH'].startswith(k) or config_target['TARGET_BASE_ARCH'].startswith(k)
+      foreach sym: v
+        config_target += { sym: 'y' }
+        config_all_disas += { sym: 'y' }
+      endforeach
+    endif
+  endforeach
+
   config_target_data = configuration_data()
   foreach k, v: config_target
     if not k.startswith('TARGET_') and not k.startswith('CONFIG_')
-- 
2.26.2



