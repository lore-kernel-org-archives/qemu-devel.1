Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86C1C43465
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 13:17:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 176C920EDD
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 13:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IeusRG+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 176C920EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJzDe-0006cu-3b
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 09:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJz3x-0006Dv-Om
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 09:07:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48164)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJz3k-00017z-GA
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 09:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600607235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nMcvdfqtOEgYHKIYCXXhjbXmnQPG05HL43eMK6zTKHg=;
 b=IeusRG+sCoH2F3sXMgXhVIi9hd0JRDT+N3UQG7cHv6Lno1wharTMJsQLbVsUnJ15WR5VND
 64ym4VNlSpRxBjfDByaPvDjeHa3mBr4shM64Wc2DVLsCv/bQRAhb0TEISOMUzRLT3OP1YP
 J2jC1d81mj3O3MVNghyDxhoeK8yTUcc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-pcbwSmyaMFmbkQFPCRO2Ng-1; Sun, 20 Sep 2020 09:07:11 -0400
X-MC-Unique: pcbwSmyaMFmbkQFPCRO2Ng-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABA3A186DD3E
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 13:07:10 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7A441610F3
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 13:07:10 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/9] configure: move accelerator logic to meson
Date: Sun, 20 Sep 2020 09:07:03 -0400
Message-Id: <20200920130708.1156310-5-pbonzini@redhat.com>
In-Reply-To: <20200920130708.1156310-1-pbonzini@redhat.com>
References: <20200920130708.1156310-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 07:54:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.501,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move to meson the code to detect the presence of accelerators, and
to define accelerator-specific config-target.h symbols.

The logic for now is duplicated in configure because it is still
in use to build the list of targets (which is in turn used to
create the config-target.mak files).  The next patches remove it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure   |  19 ----------
 meson.build | 104 ++++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 89 insertions(+), 34 deletions(-)

diff --git a/configure b/configure
index 00348c2342..ee5c4da54b 100755
--- a/configure
+++ b/configure
@@ -6852,7 +6852,6 @@ if test "$optreset" = "yes" ; then
   echo "HAVE_OPTRESET=y" >> $config_host_mak
 fi
 if test "$tcg" = "enabled"; then
-  echo "CONFIG_TCG=y" >> $config_host_mak
   if test "$tcg_interpreter" = "yes" ; then
     echo "CONFIG_TCG_INTERPRETER=y" >> $config_host_mak
   fi
@@ -7635,24 +7634,6 @@ if [ "$TARGET_SYSTBL_ABI" != "" ]; then
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
index a12ad1fbff..7a5eced5f0 100644
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
@@ -102,7 +124,7 @@ version_res = []
 coref = []
 iokit = []
 cocoa = not_found
-hvf = []
+hvf = not_found
 if targetos == 'windows'
   socket = cc.find_library('ws2_32')
   winmm = cc.find_library('winmm')
@@ -115,7 +137,6 @@ elif targetos == 'darwin'
   coref = dependency('appleframeworks', modules: 'CoreFoundation')
   iokit = dependency('appleframeworks', modules: 'IOKit')
   cocoa = dependency('appleframeworks', modules: 'Cocoa', required: get_option('cocoa'))
-  hvf = dependency('appleframeworks', modules: 'Hypervisor')
 elif targetos == 'sunos'
   socket = [cc.find_library('socket'),
             cc.find_library('nsl'),
@@ -126,6 +147,59 @@ elif targetos == 'haiku'
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
+  error('Xen PCI passthrough not available on this platform')
+endif
 if not cocoa.found() and get_option('cocoa').enabled()
   error('Cocoa not available on this platform')
 endif
@@ -645,17 +719,22 @@ kconfig_external_symbols = [
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
@@ -681,11 +760,6 @@ foreach target : target_dirs
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



