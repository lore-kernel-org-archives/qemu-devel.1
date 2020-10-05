Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C29BC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:38:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D226F20578
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLBT0IdU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D226F20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPM0R-0006Wn-VY
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 04:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPLmq-00081X-3T
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:24:00 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:40873)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPLmm-0007JB-Bt
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:23:59 -0400
Received: by mail-wr1-x432.google.com with SMTP id j2so8483745wrx.7
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 01:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yyAn2X5gNLEr4LrjnrhwbqSu3U/sDgUOjbCKHr97wSo=;
 b=JLBT0IdU02Z0gqMJcrZPlVl+RWAqkdopzgLLWp8qcKCzTo8sEd4KhtwjtylcrT1+SW
 738Vmn6M4hNvO8f8lJs+OP44JnLfs+FL+YjFNsT74LZ3yVZLj7ho95lx9KQ6bEgvnsNP
 KyTrKHACtcs4iGDTr1YhuWJY1tTn5rcN78d4/jZpKrpy8Dm+/xjNw7gVwXpvwo1bLlOk
 NIt13RsGNCmIcd8pQMA48YfVr7vObcjKGUH8ywK5+ELgrFlV/B9CjX9eokdHM4sDIky3
 lEyua4PtMhACkZPg1FKcNDkMP17NSo1cGTaa2e/mnTN2RxD4ZmGtMpWYLHSgcoT2ekNa
 xwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=yyAn2X5gNLEr4LrjnrhwbqSu3U/sDgUOjbCKHr97wSo=;
 b=NLTiDdt4qM7UEE+Au6fu90RJ3g1mNPJgOIAfe/5/njdN5sun9J6uhvbSq+pxveVTBY
 +ZKM8lD/nsoXxP96cuNppbML+vhDLfBjJ8pfggR53feUKqoLvO/FF3SLTSMtaOrdiriY
 kFNvS/ZlmA3kHjtR6GYkvqHhDv9A7lmOCkhzafoxHzpB1CgTn0rftF0hoxbcjx016nuZ
 GqCy/cv3AwOtUtmaDE76+01LSOr0vwdupUyhNRLhVjuHf5edoyKFpAuEIODjT1cVY71R
 zsDSOJwARigrpYnnVkGQTwAbM6GmidcO6EqkKpp+4UmwsYimxEaEJ8VGHM/pesLUjvNN
 bpuQ==
X-Gm-Message-State: AOAM532edjqM4A6yoHCiareQ+wWEVoko0J/IPb2I5kjwmg8d1ZmpKIbF
 7/ee7MXm7wegtTw597DLE9gDqtLrE2w=
X-Google-Smtp-Source: ABdhPJy4A58slc0PyiCivANm8UK2nW7UW9Ftke0kA3ZQauOeqn6ATlQX4XTRYHLuxMwpo9wEM6cCsg==
X-Received: by 2002:a5d:5486:: with SMTP id h6mr16640318wrv.415.1601886232794; 
 Mon, 05 Oct 2020 01:23:52 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:2e86:3d8b:8b70:920c])
 by smtp.gmail.com with ESMTPSA id z15sm11931434wrv.94.2020.10.05.01.23.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 01:23:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/19] configure: move accelerator logic to meson
Date: Mon,  5 Oct 2020 10:23:35 +0200
Message-Id: <20201005082349.354095-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201005082349.354095-1-pbonzini@redhat.com>
References: <20201005082349.354095-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x432.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move to meson the code to detect the presence of accelerators, and
to define accelerator-specific config-target.h symbols.

The logic for now is duplicated in configure because it is still
in use to build the list of targets (which is in turn used to
create the config-target.mak files).  The next patches remove it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure   |  19 ---------
 meson.build | 109 ++++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 94 insertions(+), 34 deletions(-)

diff --git a/configure b/configure
index 9dec87e186..9224ac47e6 100755
--- a/configure
+++ b/configure
@@ -6842,7 +6842,6 @@ if test "$optreset" = "yes" ; then
   echo "HAVE_OPTRESET=y" >> $config_host_mak
 fi
 if test "$tcg" = "enabled"; then
-  echo "CONFIG_TCG=y" >> $config_host_mak
   if test "$tcg_interpreter" = "yes" ; then
     echo "CONFIG_TCG_INTERPRETER=y" >> $config_host_mak
   fi
@@ -7622,24 +7621,6 @@ if [ "$TARGET_SYSTBL_ABI" != "" ]; then
     echo "TARGET_SYSTBL=$TARGET_SYSTBL" >> $config_target_mak
 fi
 
-if supported_xen_target $target; then
-    echo "CONFIG_XEN=y" >> $config_target_mak
-    if test "$xen_pci_passthrough" = enabled; then
-        echo "CONFIG_XEN_PCI_PASSTHROUGH=y" >> "$config_target_mak"
-    fi
-fi
-if supported_kvm_target $target; then
-    echo "CONFIG_KVM=y" >> $config_target_mak
-fi
-if supported_hax_target $target; then
-    echo "CONFIG_HAX=y" >> $config_target_mak
-fi
-if supported_hvf_target $target; then
-    echo "CONFIG_HVF=y" >> $config_target_mak
-fi
-if supported_whpx_target $target; then
-    echo "CONFIG_WHPX=y" >> $config_target_mak
-fi
 if test "$target_aligned_only" = "yes" ; then
   echo "TARGET_ALIGNED_ONLY=y" >> $config_target_mak
 fi
diff --git a/meson.build b/meson.build
index 41e5763e75..43ce1272b9 100644
--- a/meson.build
+++ b/meson.build
@@ -50,6 +50,28 @@ configure_file(input: files('scripts/ninjatool.py'),
                output: 'ninjatool',
                configuration: config_host)
 
+if cpu in ['x86', 'x86_64']
+  kvm_targets = ['i386-softmmu', 'x86_64-softmmu']
+elif cpu == 'aarch64'
+  kvm_targets = ['aarch64-softmmu']
+elif cpu == 's390x'
+  kvm_targets = ['s390x-softmmu']
+elif cpu in ['ppc', 'ppc64']
+  kvm_targets = ['ppc-softmmu', 'ppc64-softmmu']
+else
+  kvm_targets = []
+endif
+
+accelerator_targets = { 'CONFIG_KVM': kvm_targets }
+if cpu in ['x86', 'x86_64']
+  accelerator_targets += {
+    'CONFIG_HAX': ['i386-softmmu', 'x86_64-softmmu'],
+    'CONFIG_XEN': ['i386-softmmu', 'x86_64-softmmu'],
+    'CONFIG_HVF': ['x86_64-softmmu'],
+    'CONFIG_WHPX': ['i386-softmmu', 'x86_64-softmmu'],
+  }
+endif
+
 ##################
 # Compiler flags #
 ##################
@@ -103,7 +125,7 @@ version_res = []
 coref = []
 iokit = []
 cocoa = not_found
-hvf = []
+hvf = not_found
 if targetos == 'windows'
   socket = cc.find_library('ws2_32')
   winmm = cc.find_library('winmm')
@@ -116,7 +138,6 @@ elif targetos == 'darwin'
   coref = dependency('appleframeworks', modules: 'CoreFoundation')
   iokit = dependency('appleframeworks', modules: 'IOKit')
   cocoa = dependency('appleframeworks', modules: 'Cocoa', required: get_option('cocoa'))
-  hvf = dependency('appleframeworks', modules: 'Hypervisor')
 elif targetos == 'sunos'
   socket = [cc.find_library('socket'),
             cc.find_library('nsl'),
@@ -127,6 +148,64 @@ elif targetos == 'haiku'
             cc.find_library('bsd')]
 endif
 
+accelerators = []
+if not get_option('kvm').disabled() and targetos == 'linux'
+  accelerators += 'CONFIG_KVM'
+endif
+if not get_option('xen').disabled() and 'CONFIG_XEN_BACKEND' in config_host
+  accelerators += 'CONFIG_XEN'
+  have_xen_pci_passthrough = not get_option('xen_pci_passthrough').disabled() and targetos == 'linux'
+else
+  have_xen_pci_passthrough = false
+endif
+if not get_option('whpx').disabled() and targetos == 'windows'
+  if get_option('whpx').enabled() and cpu != 'x86_64'
+    error('WHPX requires 64-bit host')
+  elif cc.has_header('WinHvPlatform.h', required: get_option('whpx')) and \
+       cc.has_header('WinHvEmulation.h', required: get_option('whpx'))
+    accelerators += 'CONFIG_WHPX'
+  endif
+endif
+if not get_option('hvf').disabled()
+  hvf = dependency('appleframeworks', modules: 'Hypervisor',
+                   required: get_option('hvf'))
+  if hvf.found()
+    accelerators += 'CONFIG_HVF'
+  endif
+endif
+if not get_option('hax').disabled()
+  if get_option('hax').enabled() or targetos in ['windows', 'darwin', 'netbsd']
+    accelerators += 'CONFIG_HAX'
+  endif
+endif
+if not get_option('tcg').disabled()
+  if cpu not in supported_cpus
+    if 'CONFIG_TCG_INTERPRETER' in config_host
+      warning('Unsupported CPU @0@, will use TCG with TCI (experimental)'.format(cpu))
+    else
+      error('Unsupported CPU @0@, try --enable-tcg-interpreter'.format(cpu))
+    endif
+  endif
+  accelerators += 'CONFIG_TCG'
+  config_host += { 'CONFIG_TCG': 'y' }
+endif
+
+if 'CONFIG_KVM' not in accelerators and get_option('kvm').enabled()
+  error('KVM not available on this platform')
+endif
+if 'CONFIG_HVF' not in accelerators and get_option('hvf').enabled()
+  error('HVF not available on this platform')
+endif
+if 'CONFIG_WHPX' not in accelerators and get_option('whpx').enabled()
+  error('WHPX not available on this platform')
+endif
+if not have_xen_pci_passthrough and get_option('xen_pci_passthrough').enabled()
+  if 'CONFIG_XEN' in accelerators
+    error('Xen PCI passthrough not available on this platform')
+  else
+    error('Xen PCI passthrough requested but Xen not enabled')
+  endif
+endif
 if not cocoa.found() and get_option('cocoa').enabled()
   error('Cocoa not available on this platform')
 endif
@@ -641,17 +720,22 @@ kconfig_external_symbols = [
 ]
 ignored = ['TARGET_XML_FILES', 'TARGET_ABI_DIR', 'TARGET_DIRS']
 
-accel_symbols = [
-  'CONFIG_KVM',
-  'CONFIG_HAX',
-  'CONFIG_HVF',
-  'CONFIG_TCG',
-  'CONFIG_WHPX'
-]
-
 foreach target : target_dirs
   config_target = keyval.load(meson.current_build_dir() / target / 'config-target.mak')
 
+  have_accel = false
+  foreach sym: accelerators
+    if sym == 'CONFIG_TCG' or target in accelerator_targets.get(sym, [])
+      config_target += { sym: 'y' }
+      config_all += { sym: 'y' }
+      if sym == 'CONFIG_XEN' and have_xen_pci_passthrough
+        config_target += { 'CONFIG_XEN_PCI_PASSTHROUGH': 'y' }
+      endif
+      have_accel = true
+    endif
+  endforeach
+  assert(have_accel)
+
   foreach k, v: disassemblers
     if config_host['ARCH'].startswith(k) or config_target['TARGET_BASE_ARCH'].startswith(k)
       foreach sym: v
@@ -677,11 +761,6 @@ foreach target : target_dirs
       config_target_data.set(k, v)
     endif
   endforeach
-  foreach sym: accel_symbols
-    if config_target.has_key(sym)
-      config_all += { sym: 'y' }
-    endif
-  endforeach
   config_target_h += {target: configure_file(output: target + '-config-target.h',
                                                configuration: config_target_data)}
 
-- 
2.26.2



