Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD0BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 14:27:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F5832078E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 14:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F5832078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5VFt-0006pa-Af
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 10:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlmgr@proulx.com>) id 1k5VEr-0005jU-J3
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 10:26:53 -0400
Received: from havoc.proulx.com ([96.88.95.61]:47876)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlmgr@proulx.com>) id 1k5VEp-0002pi-Nd
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 10:26:53 -0400
Received: by havoc.proulx.com (Postfix, from userid 1027)
 id 4C0A06A8; Tue, 11 Aug 2020 08:26:46 -0600 (MDT)
Resent-From: Mailing List Manager <mlmgr@proulx.com>
Resent-Date: Tue, 11 Aug 2020 08:26:46 -0600
Resent-Message-ID: <20200811142646.aff3o2jiwcy2jebq@havoc.proulx.com>
Resent-To: qemu-devel@nongnu.org
Received: from eggs.gnu.org ([2001:470:142:3::10]:43888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamil@rugged.localdomain>)
 id 1k5TrR-0005Gi-S3
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 08:58:37 -0400
Received: from 89-79-191-25.dynamic.chello.pl ([89.79.191.25]:63220
 helo=rugged.localdomain) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kamil@rugged.localdomain>) id 1k5TrP-0000IZ-NJ
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 08:58:37 -0400
Received: by rugged.localdomain (Postfix, from userid 1000)
 id C0A50970BF; Tue, 11 Aug 2020 12:47:44 +0000 (UTC)
From: Kamil Rytarowski <n54@gmx.com>
To: rth@twiddle.net, ehabkost@redhat.com, slp@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, philmd@redhat.com, max@m00nbsd.net,
 jmcneill@invisible.ca
Subject: [PATCH v5 2/4] Add the NetBSD Virtual Machine Monitor accelerator.
Date: Tue, 11 Aug 2020 14:47:32 +0200
Message-Id: <20200811124734.17222-2-n54@gmx.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200811124734.17222-1-n54@gmx.com>
References: <20200206213232.1918-2-n54@gmx.com>
 <20200811124734.17222-1-n54@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=89.79.191.25;
 envelope-from=kamil@rugged.localdomain; helo=rugged.localdomain
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 08:50:12
X-ACL-Warn: Detected OS   = ???
X-Spam_action: reject
X-Bogosity: Spam, tests=bogofilter, spamicity=1.000000, version=1.2.4
X-CRM114-Status: UNSURE (   3.51  )
Received-SPF: pass client-ip=96.88.95.61; envelope-from=mlmgr@proulx.com;
 helo=havoc.proulx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 10:23:23
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 HK_RANDOM_ENVFROM=0.001, SPF_HELO_NONE=0.001,
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
Cc: Kamil Rytarowski <n54@gmx.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Maxime Villard <max@m00nbsd.net>

Introduces the configure support for the new NetBSD Virtual Machine Monitor that
allows for hypervisor acceleration from usermode components on the NetBSD
platform.

Signed-off-by: Maxime Villard <max@m00nbsd.net>
Signed-off-by: Kamil Rytarowski <n54@gmx.com>
Reviewed-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Jared McNeill <jmcneill@invisible.ca>
---
 configure       | 37 +++++++++++++++++++++++++++++++++++++
 qemu-options.hx | 10 +++++-----
 2 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index 2acc4d1465..fb9ffba2bf 100755
--- a/configure
+++ b/configure
@@ -246,6 +246,17 @@ supported_whpx_target() {
     return 1
 }
 
+supported_nvmm_target() {
+    test "$nvmm" = "yes" || return 1
+    glob "$1" "*-softmmu" || return 1
+    case "${1%-softmmu}" in
+        i386|x86_64)
+            return 0
+        ;;
+    esac
+    return 1
+}
+
 supported_target() {
     case "$1" in
         *-softmmu)
@@ -273,6 +284,7 @@ supported_target() {
     supported_hax_target "$1" && return 0
     supported_hvf_target "$1" && return 0
     supported_whpx_target "$1" && return 0
+    supported_nvmm_target "$1" && return 0
     print_error "TCG disabled, but hardware accelerator not available for '$target'"
     return 1
 }
@@ -395,6 +407,7 @@ kvm="no"
 hax="no"
 hvf="no"
 whpx="no"
+nvmm="no"
 rdma=""
 pvrdma=""
 gprof="no"
@@ -847,6 +860,7 @@ DragonFly)
 NetBSD)
   bsd="yes"
   hax="yes"
+  nvmm="yes"
   make="${MAKE-gmake}"
   audio_drv_list="oss try-sdl"
   audio_possible_drivers="oss sdl"
@@ -1233,6 +1247,10 @@ for opt do
   ;;
   --enable-whpx) whpx="yes"
   ;;
+  --disable-nvmm) nvmm="no"
+  ;;
+  --enable-nvmm) nvmm="yes"
+  ;;
   --disable-tcg-interpreter) tcg_interpreter="no"
   ;;
   --enable-tcg-interpreter) tcg_interpreter="yes"
@@ -1879,6 +1897,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   hax             HAX acceleration support
   hvf             Hypervisor.framework acceleration support
   whpx            Windows Hypervisor Platform acceleration support
+  nvmm            NetBSD Virtual Machine Monitor acceleration support
   rdma            Enable RDMA-based migration
   pvrdma          Enable PVRDMA support
   vde             support for vde network
@@ -2965,6 +2984,20 @@ if test "$whpx" != "no" ; then
     fi
 fi
 
+##########################################
+# NetBSD Virtual Machine Monitor (NVMM) accelerator check
+if test "$nvmm" != "no" ; then
+    if check_include "nvmm.h" ; then
+        nvmm="yes"
+	LIBS="-lnvmm $LIBS"
+    else
+        if test "$nvmm" = "yes"; then
+            feature_not_found "NVMM" "NVMM is not available"
+        fi
+        nvmm="no"
+    fi
+fi
+
 ##########################################
 # Sparse probe
 if test "$sparse" != "no" ; then
@@ -6934,6 +6967,7 @@ echo "KVM support       $kvm"
 echo "HAX support       $hax"
 echo "HVF support       $hvf"
 echo "WHPX support      $whpx"
+echo "NVMM support      $nvmm"
 echo "TCG support       $tcg"
 if test "$tcg" = "yes" ; then
     echo "TCG debug enabled $debug_tcg"
@@ -8332,6 +8366,9 @@ fi
 if test "$target_aligned_only" = "yes" ; then
   echo "TARGET_ALIGNED_ONLY=y" >> $config_target_mak
 fi
+if supported_nvmm_target $target; then
+    echo "CONFIG_NVMM=y" >> $config_target_mak
+fi
 if test "$target_bigendian" = "yes" ; then
   echo "TARGET_WORDS_BIGENDIAN=y" >> $config_target_mak
 fi
diff --git a/qemu-options.hx b/qemu-options.hx
index 708583b4ce..697accaa7e 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -26,7 +26,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "-machine [type=]name[,prop[=value][,...]]\n"
     "                selects emulated machine ('-machine help' for list)\n"
     "                property accel=accel1[:accel2[:...]] selects accelerator\n"
-    "                supported accelerators are kvm, xen, hax, hvf, whpx or tcg (default: tcg)\n"
+    "                supported accelerators are kvm, xen, hax, hvf, nvmm, whpx or tcg (default: tcg)\n"
     "                vmport=on|off|auto controls emulation of vmport (default: auto)\n"
     "                dump-guest-core=on|off include guest memory in a core dump (default=on)\n"
     "                mem-merge=on|off controls memory merge support (default: on)\n"
@@ -58,7 +58,7 @@ SRST
 
     ``accel=accels1[:accels2[:...]]``
         This is used to enable an accelerator. Depending on the target
-        architecture, kvm, xen, hax, hvf, whpx or tcg can be available.
+        architecture, kvm, xen, hax, hvf, nvmm, whpx or tcg can be available.
         By default, tcg is used. If there is more than one accelerator
         specified, the next one is used if the previous one fails to
         initialize.
@@ -119,7 +119,7 @@ ERST
 
 DEF("accel", HAS_ARG, QEMU_OPTION_accel,
     "-accel [accel=]accelerator[,prop[=value][,...]]\n"
-    "                select accelerator (kvm, xen, hax, hvf, whpx or tcg; use 'help' for a list)\n"
+    "                select accelerator (kvm, xen, hax, hvf, nvmm, whpx or tcg; use 'help' for a list)\n"
     "                igd-passthru=on|off (enable Xen integrated Intel graphics passthrough, default=off)\n"
     "                kernel-irqchip=on|off|split controls accelerated irqchip support (default=on)\n"
     "                kvm-shadow-mem=size of KVM shadow MMU in bytes\n"
@@ -128,8 +128,8 @@ DEF("accel", HAS_ARG, QEMU_OPTION_accel,
 SRST
 ``-accel name[,prop=value[,...]]``
     This is used to enable an accelerator. Depending on the target
-    architecture, kvm, xen, hax, hvf, whpx or tcg can be available. By
-    default, tcg is used. If there is more than one accelerator
+    architecture, kvm, xen, hax, hvf, nvmm whpx or tcg can be available.
+    By default, tcg is used. If there is more than one accelerator
     specified, the next one is used if the previous one fails to
     initialize.
 
-- 
2.24.1



