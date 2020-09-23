Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1255C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:17:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CDB921D91
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SD+75KZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CDB921D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL0uB-0000zJ-8A
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 05:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kL0oS-0001AU-U0
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:11:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59464
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kL0oL-0002MW-6b
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600852296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V81aGMEyPdzfrtL3EWwHxyepc+0BJyOn6VXUjGQ6+Vo=;
 b=SD+75KZ3YeehMsYsMSAN6JIOKKJzyIwRziwtM8nnpzXieKPafGuNTM9qMQDTllzrsyu1lg
 dHRcoHUfKV3sdYnbwUa8PkLl3jI+31gomuc8CjIAVUz2yrN6cnZz6UT8Pj0JgLa7e8EoEv
 et/rpmcQsjSHSZVg+kf8bD6QmaGQXCY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-atIk6GMgMQusmu1Tdlo0Ng-1; Wed, 23 Sep 2020 05:11:34 -0400
X-MC-Unique: atIk6GMgMQusmu1Tdlo0Ng-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 799AB801AE9;
 Wed, 23 Sep 2020 09:11:33 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1EBBF5D9CC;
 Wed, 23 Sep 2020 09:11:33 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/12] configure: convert accelerator variables to meson
 options
Date: Wed, 23 Sep 2020 05:11:21 -0400
Message-Id: <20200923091131.1591563-3-pbonzini@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 05:08:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Prepare for moving the tests to meson.  For now they only have
enabled/disabled as the possible values when meson is invoked,
but "auto" will be a possibility later, when configure will only
parse the command line options.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure         | 132 +++++++++++++++++++++++-----------------------
 meson_options.txt |  15 ++++++
 2 files changed, 82 insertions(+), 65 deletions(-)

diff --git a/configure b/configure
index a23364c30d..33bd3c4cb8 100755
--- a/configure
+++ b/configure
@@ -221,7 +221,7 @@ glob() {
 }
 
 supported_hax_target() {
-    test "$hax" = "yes" || return 1
+    test "$hax" = "enabled" || return 1
     glob "$1" "*-softmmu" || return 1
     case "${1%-softmmu}" in
         i386|x86_64)
@@ -232,7 +232,7 @@ supported_hax_target() {
 }
 
 supported_kvm_target() {
-    test "$kvm" = "yes" || return 1
+    test "$kvm" = "enabled" || return 1
     glob "$1" "*-softmmu" || return 1
     case "${1%-softmmu}:$cpu" in
         aarch64:aarch64 | \
@@ -248,7 +248,7 @@ supported_kvm_target() {
 }
 
 supported_xen_target() {
-    test "$xen" = "yes" || return 1
+    test "$xen" = "enabled" || return 1
     glob "$1" "*-softmmu" || return 1
     # Only i386 and x86_64 provide the xenpv machine.
     case "${1%-softmmu}" in
@@ -260,7 +260,7 @@ supported_xen_target() {
 }
 
 supported_hvf_target() {
-    test "$hvf" = "yes" || return 1
+    test "$hvf" = "enabled" || return 1
     glob "$1" "*-softmmu" || return 1
     case "${1%-softmmu}" in
         x86_64)
@@ -271,7 +271,7 @@ supported_hvf_target() {
 }
 
 supported_whpx_target() {
-    test "$whpx" = "yes" || return 1
+    test "$whpx" = "enabled" || return 1
     glob "$1" "*-softmmu" || return 1
     case "${1%-softmmu}" in
         i386|x86_64)
@@ -311,7 +311,7 @@ supported_target() {
         add_to deprecated_features $1
     fi
 
-    test "$tcg" = "yes" && return 0
+    test "$tcg" = "enabled" && return 0
     supported_kvm_target "$1" && return 0
     supported_xen_target "$1" && return 0
     supported_hax_target "$1" && return 0
@@ -414,14 +414,14 @@ vnc_png="auto"
 xkbcommon="auto"
 xen=""
 xen_ctrl_version=""
-xen_pci_passthrough=""
+xen_pci_passthrough="auto"
 linux_aio=""
 linux_io_uring=""
 cap_ng=""
 attr=""
 libattr=""
 xfs=""
-tcg="yes"
+tcg="enabled"
 membarrier=""
 vhost_net=""
 vhost_crypto=""
@@ -429,10 +429,10 @@ vhost_scsi=""
 vhost_vsock=""
 vhost_user=""
 vhost_user_fs=""
-kvm="no"
-hax="no"
-hvf="no"
-whpx="no"
+kvm="disabled"
+hax="disabled"
+hvf="disabled"
+whpx="disabled"
 rdma=""
 pvrdma=""
 gprof="no"
@@ -821,8 +821,8 @@ HOST_VARIANT_DIR=""
 case $targetos in
 MINGW32*)
   mingw32="yes"
-  hax="yes"
-  whpx=""
+  hax="enabled"
+  whpx="auto"
   vhost_user="no"
   audio_possible_drivers="dsound sdl"
   if check_include dsound.h; then
@@ -856,7 +856,7 @@ DragonFly)
 ;;
 NetBSD)
   bsd="yes"
-  hax="yes"
+  hax="enabled"
   make="${MAKE-gmake}"
   audio_drv_list="oss try-sdl"
   audio_possible_drivers="oss sdl"
@@ -873,8 +873,8 @@ OpenBSD)
 Darwin)
   bsd="yes"
   darwin="yes"
-  hax="yes"
-  hvf=""
+  hax="enabled"
+  hvf="auto"
   if [ "$cpu" = "x86_64" ] ; then
     QEMU_CFLAGS="-arch x86_64 $QEMU_CFLAGS"
     QEMU_LDFLAGS="-arch x86_64 $QEMU_LDFLAGS"
@@ -910,7 +910,7 @@ Linux)
   audio_possible_drivers="oss alsa sdl pa"
   linux="yes"
   linux_user="yes"
-  kvm="yes"
+  kvm="enabled"
   QEMU_INCLUDES="-isystem ${source_path}/linux-headers -Ilinux-headers $QEMU_INCLUDES"
 ;;
 esac
@@ -1192,33 +1192,33 @@ for opt do
   ;;
   --enable-netmap) netmap="yes"
   ;;
-  --disable-xen) xen="no"
+  --disable-xen) xen="disabled"
   ;;
-  --enable-xen) xen="yes"
+  --enable-xen) xen="enabled"
   ;;
-  --disable-xen-pci-passthrough) xen_pci_passthrough="no"
+  --disable-xen-pci-passthrough) xen_pci_passthrough="disabled"
   ;;
-  --enable-xen-pci-passthrough) xen_pci_passthrough="yes"
+  --enable-xen-pci-passthrough) xen_pci_passthrough="enabled"
   ;;
   --disable-brlapi) brlapi="no"
   ;;
   --enable-brlapi) brlapi="yes"
   ;;
-  --disable-kvm) kvm="no"
+  --disable-kvm) kvm="disabled"
   ;;
-  --enable-kvm) kvm="yes"
+  --enable-kvm) kvm="enabled"
   ;;
-  --disable-hax) hax="no"
+  --disable-hax) hax="disabled"
   ;;
-  --enable-hax) hax="yes"
+  --enable-hax) hax="enabled"
   ;;
-  --disable-hvf) hvf="no"
+  --disable-hvf) hvf="disabled"
   ;;
-  --enable-hvf) hvf="yes"
+  --enable-hvf) hvf="enabled"
   ;;
-  --disable-whpx) whpx="no"
+  --disable-whpx) whpx="disabled"
   ;;
-  --enable-whpx) whpx="yes"
+  --enable-whpx) whpx="enabled"
   ;;
   --disable-tcg-interpreter) tcg_interpreter="no"
   ;;
@@ -1228,9 +1228,9 @@ for opt do
   ;;
   --enable-cap-ng) cap_ng="yes"
   ;;
-  --disable-tcg) tcg="no"
+  --disable-tcg) tcg="disabled"
   ;;
-  --enable-tcg) tcg="yes"
+  --enable-tcg) tcg="enabled"
   ;;
   --disable-malloc-trim) malloc_trim="disabled"
   ;;
@@ -1715,7 +1715,7 @@ if [ "$ARCH" = "unknown" ]; then
 fi
 
 if [ "$bsd_user" = "no" -a "$linux_user" = "no" -a "$softmmu" = "no" ] ; then
-  tcg="no"
+  tcg="disabled"
 fi
 
 default_target_list=""
@@ -2671,7 +2671,7 @@ fi
 ##########################################
 # xen probe
 
-if test "$xen" != "no" ; then
+if test "$xen" != "disabled" ; then
   # Check whether Xen library path is specified via --extra-ldflags to avoid
   # overriding this setting with pkg-config output. If not, try pkg-config
   # to obtain all needed flags.
@@ -2680,7 +2680,7 @@ if test "$xen" != "no" ; then
      $pkg_config --exists xencontrol ; then
     xen_ctrl_version="$(printf '%d%02d%02d' \
       $($pkg_config --modversion xencontrol | sed 's/\./ /g') )"
-    xen=yes
+    xen=enabled
     xen_pc="xencontrol xenstore xenguest xenforeignmemory xengnttab"
     xen_pc="$xen_pc xenevtchn xendevicemodel"
     if $pkg_config --exists xentoolcore; then
@@ -2706,10 +2706,10 @@ int main(void) {
 EOF
     if ! compile_prog "" "$xen_libs" ; then
       # Xen not found
-      if test "$xen" = "yes" ; then
+      if test "$xen" = "enabled" ; then
         feature_not_found "xen" "Install xen devel"
       fi
-      xen=no
+      xen=disabled
 
     # Xen unstable
     elif
@@ -2735,7 +2735,7 @@ EOF
       then
       xen_stable_libs="-lxendevicemodel $xen_stable_libs -lxentoolcore"
       xen_ctrl_version=41100
-      xen=yes
+      xen=enabled
     elif
         cat > $TMPC <<EOF &&
 #undef XC_WANT_COMPAT_MAP_FOREIGN_API
@@ -2755,7 +2755,7 @@ EOF
       then
       xen_stable_libs="-lxendevicemodel $xen_stable_libs -lxentoolcore"
       xen_ctrl_version=41000
-      xen=yes
+      xen=enabled
     elif
         cat > $TMPC <<EOF &&
 #undef XC_WANT_COMPAT_DEVICEMODEL_API
@@ -2774,7 +2774,7 @@ EOF
       then
       xen_stable_libs="-lxendevicemodel $xen_stable_libs"
       xen_ctrl_version=40900
-      xen=yes
+      xen=enabled
     elif
         cat > $TMPC <<EOF &&
 /*
@@ -2827,7 +2827,7 @@ EOF
         compile_prog "" "$xen_libs $xen_stable_libs"
       then
       xen_ctrl_version=40800
-      xen=yes
+      xen=enabled
     elif
         cat > $TMPC <<EOF &&
 /*
@@ -2876,7 +2876,7 @@ EOF
         compile_prog "" "$xen_libs $xen_stable_libs"
       then
       xen_ctrl_version=40701
-      xen=yes
+      xen=enabled
 
     # Xen 4.6
     elif
@@ -2904,7 +2904,7 @@ EOF
         compile_prog "" "$xen_libs"
       then
       xen_ctrl_version=40600
-      xen=yes
+      xen=enabled
 
     # Xen 4.5
     elif
@@ -2931,7 +2931,7 @@ EOF
         compile_prog "" "$xen_libs"
       then
       xen_ctrl_version=40500
-      xen=yes
+      xen=enabled
 
     elif
         cat > $TMPC <<EOF &&
@@ -2956,17 +2956,17 @@ EOF
         compile_prog "" "$xen_libs"
       then
       xen_ctrl_version=40200
-      xen=yes
+      xen=enabled
 
     else
-      if test "$xen" = "yes" ; then
+      if test "$xen" = "enabled" ; then
         feature_not_found "xen (unsupported version)" \
                           "Install a supported xen (xen 4.2 or newer)"
       fi
-      xen=no
+      xen=disabled
     fi
 
-    if test "$xen" = yes; then
+    if test "$xen" = enabled; then
       if test $xen_ctrl_version -ge 40701  ; then
         xen_libs="$xen_libs $xen_stable_libs "
       fi
@@ -2974,31 +2974,31 @@ EOF
   fi
 fi
 
-if test "$xen_pci_passthrough" != "no"; then
-  if test "$xen" = "yes" && test "$linux" = "yes"; then
-    xen_pci_passthrough=yes
+if test "$xen_pci_passthrough" != "disabled"; then
+  if test "$xen" = "enabled" && test "$linux" = "yes"; then
+    xen_pci_passthrough=enabled
   else
-    if test "$xen_pci_passthrough" = "yes"; then
+    if test "$xen_pci_passthrough" = "enabled"; then
       error_exit "User requested feature Xen PCI Passthrough" \
           " but this feature requires /sys from Linux"
     fi
-    xen_pci_passthrough=no
+    xen_pci_passthrough=disabled
   fi
 fi
 
 ##########################################
 # Windows Hypervisor Platform accelerator (WHPX) check
-if test "$whpx" = "yes" && test "$ARCH" != "x86_64"; then
+if test "$whpx" = "enabled" && test "$ARCH" != "x86_64"; then
   error_exit "WHPX requires 64-bit host"
 fi
-if test "$whpx" != "no" && test "$ARCH" = "x86_64"; then
+if test "$whpx" != "disabled" && test "$ARCH" = "x86_64"; then
     if check_include "WinHvPlatform.h" && check_include "WinHvEmulation.h"; then
         whpx="yes"
     else
-        if test "$whpx" = "yes"; then
+        if test "$whpx" = "auto"; then
             feature_not_found "WinHvPlatform" "WinHvEmulation is not installed"
         fi
-        whpx="no"
+        whpx="disabled"
     fi
 fi
 
@@ -5826,18 +5826,18 @@ fi
 
 #################################################
 # Check to see if we have the Hypervisor framework
-if [ "$hvf" != "no" ] ; then
+if [ "$hvf" != "disabled" ] ; then
   cat > $TMPC << EOF
 #include <Hypervisor/hv.h>
 int main() { return 0;}
 EOF
   if ! compile_object ""; then
-    if test "$hvf" = "yes"; then
+    if test "$hvf" = "enabled"; then
 	error_exit "Hypervisor.framework not available"
     fi
-    hvf='no'
+    hvf='disabled'
   else
-    hvf='yes'
+    hvf='enabled'
   fi
 fi
 
@@ -6213,7 +6213,7 @@ if test "$mingw32" = "yes" ; then
 fi
 
 # Disable OpenBSD W^X if available
-if test "$tcg" = "yes" && test "$targetos" = "OpenBSD"; then
+if test "$tcg" = "enabled" && test "$targetos" = "OpenBSD"; then
     cat > $TMPC <<EOF
     int main(void) { return 0; }
 EOF
@@ -6764,7 +6764,7 @@ if test "$virglrenderer" = "yes" ; then
   echo "VIRGL_CFLAGS=$virgl_cflags" >> $config_host_mak
   echo "VIRGL_LIBS=$virgl_libs" >> $config_host_mak
 fi
-if test "$xen" = "yes" ; then
+if test "$xen" = "enabled" ; then
   echo "CONFIG_XEN_BACKEND=y" >> $config_host_mak
   echo "CONFIG_XEN_CTRL_INTERFACE_VERSION=$xen_ctrl_version" >> $config_host_mak
   echo "XEN_CFLAGS=$xen_cflags" >> $config_host_mak
@@ -6844,7 +6844,7 @@ fi
 if test "$optreset" = "yes" ; then
   echo "HAVE_OPTRESET=y" >> $config_host_mak
 fi
-if test "$tcg" = "yes"; then
+if test "$tcg" = "enabled"; then
   echo "CONFIG_TCG=y" >> $config_host_mak
   if test "$tcg_interpreter" = "yes" ; then
     echo "CONFIG_TCG_INTERPRETER=y" >> $config_host_mak
@@ -7629,7 +7629,7 @@ fi
 
 if supported_xen_target $target; then
     echo "CONFIG_XEN=y" >> $config_target_mak
-    if test "$xen_pci_passthrough" = yes; then
+    if test "$xen_pci_passthrough" = enabled; then
         echo "CONFIG_XEN_PCI_PASSTHROUGH=y" >> "$config_target_mak"
     fi
 fi
@@ -7873,6 +7873,8 @@ NINJA=${ninja:-$PWD/ninjatool} $meson setup \
         -Db_staticpic=$(if test "$pie" = yes; then echo true; else echo false; fi) \
         -Db_coverage=$(if test "$gcov" = yes; then echo true; else echo false; fi) \
 	-Dmalloc=$malloc -Dmalloc_trim=$malloc_trim \
+	-Dkvm=$kvm -Dhax=$hax -Dwhpx=$whpx -Dhvf=$hvf \
+	-Dxen=$xen -Dxen_pci_passthrough=$xen_pci_passthrough -Dtcg=$tcg \
 	-Dcocoa=$cocoa -Dmpath=$mpath -Dsdl=$sdl -Dsdl_image=$sdl_image \
 	-Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
 	-Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f\
diff --git a/meson_options.txt b/meson_options.txt
index 46ea1d889a..05adc7a179 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -11,6 +11,21 @@ option('malloc_trim', type : 'feature', value : 'auto',
 option('malloc', type : 'combo', choices : ['system', 'tcmalloc', 'jemalloc'],
        value: 'system', description: 'choose memory allocator to use')
 
+option('kvm', type: 'feature', value: 'auto',
+       description: 'KVM acceleration support')
+option('hax', type: 'feature', value: 'auto',
+       description: 'HAX acceleration support')
+option('whpx', type: 'feature', value: 'auto',
+       description: 'WHPX acceleration support')
+option('hvf', type: 'feature', value: 'auto',
+       description: 'HVF acceleration support')
+option('xen', type: 'feature', value: 'auto',
+       description: 'Xen backend support')
+option('xen_pci_passthrough', type: 'feature', value: 'auto',
+       description: 'Xen PCI passthrough support')
+option('tcg', type: 'feature', value: 'auto',
+       description: 'TCG support')
+
 option('cocoa', type : 'feature', value : 'auto',
        description: 'Cocoa user interface (macOS only)')
 option('mpath', type : 'feature', value : 'auto',
-- 
2.26.2



