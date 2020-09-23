Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5342FC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:20:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D38E6206C3
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UO8ZcUCr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D38E6206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL0x5-0004Wg-VD
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 05:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kL0oW-0001Bt-Fn
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:11:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20534)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kL0oP-0002Ml-DM
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600852297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=csQxNiFZcnC9TBP3b4tvHjusdp7fACDXz4/V7nvvILU=;
 b=UO8ZcUCrqEqJIMRRlwu+rxf15oPD/c7TS0MdTq7vCEfwXZlk3s+unKpJF4Ymce3rWY2VkX
 uMm6rQKNNs/cuMuqOrCiprTu3iFJbjc88DR6NUEm7lDPnK0ZGN/oL6kUu93Go4AkARxYhq
 9brGTM2BGHW4AGEbBgjslp481cQxIVI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-7wHGC4N5MKC1zuZ_z7hQhA-1; Wed, 23 Sep 2020 05:11:35 -0400
X-MC-Unique: 7wHGC4N5MKC1zuZ_z7hQhA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89EBC1005E76;
 Wed, 23 Sep 2020 09:11:34 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2F0805D9CC;
 Wed, 23 Sep 2020 09:11:34 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/12] configure: move accelerator logic to meson
Date: Wed, 23 Sep 2020 05:11:23 -0400
Message-Id: <20200923091131.1591563-5-pbonzini@redhat.com>
In-Reply-To: <20200923091131.1591563-1-pbonzini@redhat.com>
References: <20200923091131.1591563-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: richard.henderson@linaro.org
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
---
 configure   |  19 ---------
 meson.build | 108 ++++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 93 insertions(+), 34 deletions(-)

diff --git a/configure b/configure
index 04cc25f7c8..5df58c4b89 100755
--- a/configure
+++ b/configure
@@ -6863,7 +6863,6 @@ if test "$optreset" = "yes" ; then
   echo "HAVE_OPTRESET=y" >> $config_host_mak
 fi
 if test "$tcg" = "enabled"; then
-  echo "CONFIG_TCG=y" >> $config_host_mak
   if test "$tcg_interpreter" = "yes" ; then
     echo "CONFIG_TCG_INTERPRETER=y" >> $config_host_mak
   fi
@@ -7645,24 +7644,6 @@ if [ "$TARGET_SYSTBL_ABI" != "" ]; then
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
index 02593bc787..641378c1d9 100644
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
@@ -127,6 +148,63 @@ elif targetos == 'haiku'
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
@@ -640,17 +718,22 @@ kconfig_external_symbols = [
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
+    if sym == 'CONFIG_TCG' or target in accelerator_targets[sym]
+      config_target += { sym: 'y' }
+      config_all += { sym: 'y' }
+      if sym == 'CONFIG_XEN' and have_xen_pci_passthrough
+        config_target += { 'CONFIG_XEN_PCI_PASSTHROUGH': 'y' }
+      endif
+    endif
+    have_accel = true
+  endforeach
+  assert(have_accel)
+
   foreach k, v: disassemblers
     if config_host['ARCH'].startswith(k) or config_target['TARGET_BASE_ARCH'].startswith(k)
       foreach sym: v
@@ -676,11 +759,6 @@ foreach target : target_dirs
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



