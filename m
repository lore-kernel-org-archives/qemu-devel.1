Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A40C55178
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 22:27:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94F0A206CA
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 22:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ip8ug9Ag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94F0A206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kanj0-0007RQ-FM
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 17:27:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kanbi-0007JT-Cm
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 17:19:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43526)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kanbe-00042t-K9
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 17:19:50 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0A5M1qMd195386
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2020 17:19:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=HVSP1d8lBR6r44e7qCm+7Nlwa3cn/04VGXvkKmzSp1s=;
 b=Ip8ug9Aga65Yh2Da3m/m1nlwnhqeO3/dUDhk3URbkaQ7eM9rRr7kov9ZM/Lkb3VsCMIM
 ELAMqRQpBBCWXMXEYzwtOgaehNSydHeqK/TRS4ow8WmJNC786JKBgc5+xB7JBiP2Z3r9
 pBTjsN9bIcVFOd+6vE9T5s3Rd1MS8ZBQHe9TdE+FR11/ZpkRjHWwvLgj/tRHiOmhydcN
 /bd9BEZ4DoZcuTIFCSYAn1PMs+O2714NALeeBIF3k7p8S4puvKDo1snCe1CC1LKPneh3
 Yaa2kWFU+j1+6llJyXv3Px2+H2gu3Fprhn6LvAiVViZQd72/Jifc5PGzaar8smmDdlm+ 9w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34mfajqg98-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 17:19:45 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A5M5Em8017955
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2020 17:19:45 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34mfajqg8y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Nov 2020 17:19:45 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A5MC1EJ017617;
 Thu, 5 Nov 2020 22:19:44 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma01dal.us.ibm.com with ESMTP id 34h0s801va-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Nov 2020 22:19:44 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0A5MJhNK5767806
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Nov 2020 22:19:43 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 242AC6A051;
 Thu,  5 Nov 2020 22:19:43 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF1FD6A047;
 Thu,  5 Nov 2020 22:19:42 +0000 (GMT)
Received: from Buonos-Thinkpad-X1.ibm.com (unknown [9.65.222.173])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu,  5 Nov 2020 22:19:42 +0000 (GMT)
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
To: dbuono@linux.vnet.ibm.com, qemu-devel@nongnu.org
Subject: [PATCH v3 9/9] configure,meson: support Control-Flow Integrity
Date: Thu,  5 Nov 2020 17:19:05 -0500
Message-Id: <20201105221905.1350-10-dbuono@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201105221905.1350-1-dbuono@linux.vnet.ibm.com>
References: <20201105221905.1350-1-dbuono@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-05_15:2020-11-05,
 2020-11-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011050139
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 17:19:18
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds a flag to enable/disable control flow integrity checks
on indirect function calls.
This feature only allows indirect function calls at runtime to functions
with compatible signatures.

This feature is only provided by LLVM/Clang, and depends on link-time
optimization which is currently supported only with LLVM/Clang >= 6.0

We also add an option to enable a debugging version of cfi, with verbose
output in case of a CFI violation.

CFI on indirect function calls does not support calls to functions in
shared libraries (since they were not known at compile time), and such
calls are forbidden. QEMU relies on dlopen/dlsym when using modules,
so we make modules incompatible with CFI.

All the checks are performed in meson.build. configure is only used to
forward the flags to meson

Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>
---
 configure         | 21 ++++++++++++++++++++-
 meson.build       | 45 +++++++++++++++++++++++++++++++++++++++++++++
 meson_options.txt |  4 ++++
 3 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 7115655fe4..020c5a6aff 100755
--- a/configure
+++ b/configure
@@ -399,6 +399,8 @@ coroutine=""
 coroutine_pool=""
 debug_stack_usage="no"
 crypto_afalg="no"
+cfi="disabled"
+cfi_debug="disabled"
 seccomp=""
 glusterfs=""
 glusterfs_xlator_opt="no"
@@ -1179,6 +1181,16 @@ for opt do
   ;;
   --disable-safe-stack) safe_stack="no"
   ;;
+  --enable-cfi)
+      cfi="enabled";
+      lto="true";
+  ;;
+  --disable-cfi) cfi="disabled"
+  ;;
+  --enable-cfi-debug) cfi_debug="enabled"
+  ;;
+  --disable-cfi-debug) cfi_debug="disabled"
+  ;;
   --disable-curses) curses="disabled"
   ;;
   --enable-curses) curses="enabled"
@@ -1753,6 +1765,13 @@ disabled with --disable-FEATURE, default is enabled if available:
   sparse          sparse checker
   safe-stack      SafeStack Stack Smash Protection. Depends on
                   clang/llvm >= 3.7 and requires coroutine backend ucontext.
+  cfi             Enable Control-Flow Integrity for indirect function calls.
+                  In case of a cfi violation, QEMU is terminated with SIGILL
+                  Depends on lto and is incompatible with modules
+                  Automatically enables Link-Time Optimization (lto)
+  cfi-debug       In case of a cfi violation, a message containing the line that
+                  triggered the error is written to stderr. After the error,
+                  QEMU is still terminated with SIGILL
 
   gnutls          GNUTLS cryptography support
   nettle          nettle cryptography support
@@ -6997,7 +7016,7 @@ NINJA=$ninja $meson setup \
         -Dcapstone=$capstone -Dslirp=$slirp -Dfdt=$fdt \
         -Diconv=$iconv -Dcurses=$curses -Dlibudev=$libudev\
         -Ddocs=$docs -Dsphinx_build=$sphinx_build -Dinstall_blobs=$blobs \
-        -Db_lto=$lto \
+        -Db_lto=$lto -Dcfi=$cfi -Dcfi_debug=$cfi_debug \
         $cross_arg \
         "$PWD" "$source_path"
 
diff --git a/meson.build b/meson.build
index 99c7ab1d38..49a301888e 100644
--- a/meson.build
+++ b/meson.build
@@ -751,6 +751,48 @@ statx_test = '''
 
 has_statx = cc.links(statx_test)
 
+if get_option('cfi').enabled()
+  cfi_flags=[]
+  # Check for dependency on LTO
+  if not get_option('b_lto')
+    error('Selected Control-Flow Integrity but LTO is disabled')
+  endif
+  if config_host.has_key('CONFIG_MODULES')
+    error('Selected Control-Flow Integrity is not compatible with modules')
+  endif
+  # Check for cfi flags. CFI requires LTO so we can't use
+  # get_supported_arguments, but need a more complex "compiles" which allows
+  # custom arguments
+  if cc.compiles('int main () { return 0; }', name: '-fsanitize=cfi-icall',
+                 args: ['-flto', '-fsanitize=cfi-icall'] )
+    cfi_flags += '-fsanitize=cfi-icall'
+  else
+    error('-fsanitize=cfi-icall is not supported by the compiler')
+  endif
+  if cc.compiles('int main () { return 0; }',
+                 name: '-fsanitize-cfi-icall-generalize-pointers',
+                 args: ['-flto', '-fsanitize=cfi-icall',
+                        '-fsanitize-cfi-icall-generalize-pointers'] )
+    cfi_flags += '-fsanitize-cfi-icall-generalize-pointers'
+  else
+    error('-fsanitize-cfi-icall-generalize-pointers is not supported by the compiler')
+  endif
+  if get_option('cfi_debug').enabled()
+    if cc.compiles('int main () { return 0; }',
+                   name: '-fno-sanitize-trap=cfi-icall',
+                   args: ['-flto', '-fsanitize=cfi-icall',
+                          '-fno-sanitize-trap=cfi-icall'] )
+      cfi_flags += '-fno-sanitize-trap=cfi-icall'
+    else
+      error('-fno-sanitize-trap=cfi-icall is not supported by the compiler')
+    endif
+  endif
+  add_project_arguments(cfi_flags, native: false, language: ['c', 'cpp',
+                                                             'objc'])
+  add_project_link_arguments(cfi_flags, native: false, language: ['c', 'cpp',
+                                                                  'objc'])
+endif
+
 #################
 # config-host.h #
 #################
@@ -784,6 +826,7 @@ config_host_data.set('CONFIG_KEYUTILS', keyutils.found())
 config_host_data.set('CONFIG_GETTID', has_gettid)
 config_host_data.set('CONFIG_MALLOC_TRIM', has_malloc_trim)
 config_host_data.set('CONFIG_STATX', has_statx)
+config_host_data.set('CONFIG_CFI', get_option('cfi').enabled())
 config_host_data.set('QEMU_VERSION', '"@0@"'.format(meson.project_version()))
 config_host_data.set('QEMU_VERSION_MAJOR', meson.project_version().split('.')[0])
 config_host_data.set('QEMU_VERSION_MINOR', meson.project_version().split('.')[1])
@@ -2136,6 +2179,8 @@ if targetos == 'windows'
   summary_info += {'QGA MSI support':   config_host.has_key('CONFIG_QGA_MSI')}
 endif
 summary_info += {'seccomp support':   config_host.has_key('CONFIG_SECCOMP')}
+summary_info += {'cfi support':       get_option('cfi').enabled()}
+summary_info += {'cfi debug support': get_option('cfi_debug').enabled()}
 summary_info += {'coroutine backend': config_host['CONFIG_COROUTINE_BACKEND']}
 summary_info += {'coroutine pool':    config_host['CONFIG_COROUTINE_POOL'] == '1'}
 summary_info += {'debug stack usage': config_host.has_key('CONFIG_DEBUG_STACK_USAGE')}
diff --git a/meson_options.txt b/meson_options.txt
index b4f1801875..582069c9ed 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -35,6 +35,10 @@ option('xen_pci_passthrough', type: 'feature', value: 'auto',
        description: 'Xen PCI passthrough support')
 option('tcg', type: 'feature', value: 'auto',
        description: 'TCG support')
+option('cfi', type: 'feature', value: 'auto',
+       description: 'Control-Flow Integrity (CFI)')
+option('cfi_debug', type: 'feature', value: 'auto',
+       description: 'Verbose errors in case of CFI violation')
 
 option('cocoa', type : 'feature', value : 'auto',
        description: 'Cocoa user interface (macOS only)')
-- 
2.17.1


