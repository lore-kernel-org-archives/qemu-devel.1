Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA39DC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:08:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7148A20730
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="cUySjoBh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7148A20730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izfxS-0007pt-Fx
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 07:08:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1izfnt-0001eV-Dg
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:58:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1izfnq-0008AP-UP
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:58:41 -0500
Received: from mout.gmx.net ([212.227.17.20]:60429)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1izfnq-00080b-Kc
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:58:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1580990305;
 bh=ZNzSTgefsmT4t6kYtxFfI2fVCTMCQzFdLp9kloQNlvY=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=cUySjoBhBFLZVZp1KnLaQOX6i1NupNV+DeNXVL4uiwhci0f6iZcrcG+tVeJd1anGY
 VxM+FLQ0J14Whih53DEBQj3i5SkOtPrhii2o1ggbZ/1plqE+jomgKfuAWqGfjkLSS5
 WuodLQGi0VyjkCCyB12mcJ7Bw6byebAlKjIQI2a8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([89.71.135.231]) by mail.gmx.com
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1M59C8-1j0ljJ2ftU-0016lN; Thu, 06 Feb 2020 12:58:25 +0100
From: Kamil Rytarowski <n54@gmx.com>
To: rth@twiddle.net, ehabkost@redhat.com, slp@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, philmd@redhat.com, max@m00nbsd.net
Subject: [PATCH v3 2/4] Add the NetBSD Virtual Machine Monitor accelerator.
Date: Thu,  6 Feb 2020 12:57:29 +0100
Message-Id: <20200206115731.13552-3-n54@gmx.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200206115731.13552-1-n54@gmx.com>
References: <20200128140945.929-1-n54@gmx.com>
 <20200206115731.13552-1-n54@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Z/kpdlzIujssXysYlXQP+N1V9a/Emqjzxsv8gRXK0/xd3oGHX8Z
 xP7QEUN1X8Exo2sUejYVmFyCchLDLrLyMo0f7/hSKaIM9KROjhmKCKVS5w2wBqYbjCf4vLL
 9RUCAI68xkBsVjbzpi6wSn/TcPn8udxbcN8KDtvFq2LEzGR5JSQRtUe4gIpo4Urky34QVxx
 Kfz4r1xcFA06Ns9/OJtDQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F5QVnH42qEc=:No5OZfcNNRDh1P3SW4Y99R
 MxxzrsX7JOqswpw+FYvly95y7BaGu4COAR6iwjWM81IO3yV6NMyfHXnr+ttFpzW6uEQXVurn8
 DGagAfNQlBvlEUSoStleXp7BgrvvfKoyJf6gYdOb1aitUWKtBqtdzC14OXnwqqonRHmTrB0jW
 hXg25/ufDHXJyxTfsah3ohQeGYkeztyJ2pbWGItIT1O7sV4CoyQufdtnh1Ctu7u+Ab5txcCmt
 3NyNHsnNrjjgY6jidF4vZ7CWnH9smOSgkuQ+42o6Ih7iMHjtXF7/QVN/NlMEtpptdPlS5ObSZ
 JwTenniRaDHng8cT1QoAMlWd6ezGdoK+L0rV920gRb0SlgkLvpBo2XgZOziWzuQYDnRHn9MA7
 W2HMRpI/PXo9v5iykKmPDd2J3fr+ky866meqY6DNmrkQeqUJjNBl/SiVdzanz5ocxSK8C9iRO
 mWoHZr5Rz6CaGhn0uoWmHPxnVTtEDbRmwRxzgk1/7qJeZehQLZEIap3TDI1rxyfhqPun2fQeg
 PFSuzTFPQ7X0Wmq/iLwIwj/cSXaetlf7DmbFV4LyM9fZjDQxPuMyrp3ZXmsNQtGxFdaB2hW3F
 cz+9Eecfb3KyPav6T10mknmoC0JghkgVEgQ0l+TwlfpLibxaLOE6xVyDRwotOlOmQC7skCcnE
 wrpUvtkI9HkhjvGcY3MYukPJHCHeyvx3pq5Yxraaef6JvzjU4cjD+T26x7YIBloksQ2y4s2Db
 Djjihbnch4V3zwULmp7fgBXTTUNtbJVeXSMMlscVyFeEn2AX4ZgGYYh3DXaloHZ94aM28dPMY
 lpFdNbtvEL8h1pQq5dJz5acaprEUFhxmtMsX+8eG+hhEU+Kqx58gqdFjD12M+3++jPvlT/2r2
 qowLwpEN1cynquAVzMOpgugpUbv5Dnd7w3XvWuOnWgtOxI0FlelATs28+LtC5fLUrdR+pkw/B
 aV83IgK99CNqINRWPIYHyNXwjEoyYPYNdYA2Y8tTMqIet931McqLVp6Skb0mL0aKqYDd0i83U
 CX8Zm1fNrEW+tfWrHi2xLa3qzickMHNEoDFYxUMMc+KhOkWPr4qMeOa9NKQX7nwSdnVBFpeQQ
 QyQlpOhyEEqepkp6KcI5/EQ6wIJ2tMLPAp3wYK+XcE5PsPTJ4oMjUHXrAYAPJzG5l6FI7iFfe
 z+YO2U1bT9U2fFwVxRRrZ6j30V3ZsSaetF7wxDgqD4yLJkT/EYsYds4unwUa0y/LGq588=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.20
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

Introduces the configure support for the new NetBSD Virtual Machine Monito=
r that
allows for hypervisor acceleration from usermode components on the NetBSD
platform.

Signed-off-by: Maxime Villard <max@m00nbsd.net>
Signed-off-by: Kamil Rytarowski <n54@gmx.com>
Reviewed-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
=2D--
 configure       | 37 +++++++++++++++++++++++++++++++++++++
 qemu-options.hx | 16 ++++++++--------
 2 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/configure b/configure
index 115dc38085..d4a837cf9d 100755
=2D-- a/configure
+++ b/configure
@@ -241,6 +241,17 @@ supported_whpx_target() {
     return 1
 }

+supported_nvmm_target() {
+    test "$nvmm" =3D "yes" || return 1
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
@@ -268,6 +279,7 @@ supported_target() {
     supported_hax_target "$1" && return 0
     supported_hvf_target "$1" && return 0
     supported_whpx_target "$1" && return 0
+    supported_nvmm_target "$1" && return 0
     print_error "TCG disabled, but hardware accelerator not available for=
 '$target'"
     return 1
 }
@@ -388,6 +400,7 @@ kvm=3D"no"
 hax=3D"no"
 hvf=3D"no"
 whpx=3D"no"
+nvmm=3D"no"
 rdma=3D""
 pvrdma=3D""
 gprof=3D"no"
@@ -823,6 +836,7 @@ DragonFly)
 NetBSD)
   bsd=3D"yes"
   hax=3D"yes"
+  nvmm=3D"yes"
   make=3D"${MAKE-gmake}"
   audio_drv_list=3D"oss try-sdl"
   audio_possible_drivers=3D"oss sdl"
@@ -1169,6 +1183,10 @@ for opt do
   ;;
   --enable-whpx) whpx=3D"yes"
   ;;
+  --disable-nvmm) nvmm=3D"no"
+  ;;
+  --enable-nvmm) nvmm=3D"yes"
+  ;;
   --disable-tcg-interpreter) tcg_interpreter=3D"no"
   ;;
   --enable-tcg-interpreter) tcg_interpreter=3D"yes"
@@ -1773,6 +1791,7 @@ disabled with --disable-FEATURE, default is enabled =
if available:
   hax             HAX acceleration support
   hvf             Hypervisor.framework acceleration support
   whpx            Windows Hypervisor Platform acceleration support
+  nvmm            NetBSD Virtual Machine Monitor acceleration support
   rdma            Enable RDMA-based migration
   pvrdma          Enable PVRDMA support
   vde             support for vde network
@@ -2764,6 +2783,20 @@ if test "$whpx" !=3D "no" ; then
     fi
 fi

+##########################################
+# NetBSD Virtual Machine Monitor (NVMM) accelerator check
+if test "$nvmm" !=3D "no" ; then
+    if check_include "nvmm.h" ; then
+        nvmm=3D"yes"
+	LIBS=3D"-lnvmm $LIBS"
+    else
+        if test "$nvmm" =3D "yes"; then
+            feature_not_found "NVMM" "NVMM is not available"
+        fi
+        nvmm=3D"no"
+    fi
+fi
+
 ##########################################
 # Sparse probe
 if test "$sparse" !=3D "no" ; then
@@ -6543,6 +6576,7 @@ echo "KVM support       $kvm"
 echo "HAX support       $hax"
 echo "HVF support       $hvf"
 echo "WHPX support      $whpx"
+echo "NVMM support      $nvmm"
 echo "TCG support       $tcg"
 if test "$tcg" =3D "yes" ; then
     echo "TCG debug enabled $debug_tcg"
@@ -7828,6 +7862,9 @@ fi
 if test "$target_aligned_only" =3D "yes" ; then
   echo "TARGET_ALIGNED_ONLY=3Dy" >> $config_target_mak
 fi
+if supported_nvmm_target $target; then
+    echo "CONFIG_NVMM=3Dy" >> $config_target_mak
+fi
 if test "$target_bigendian" =3D "yes" ; then
   echo "TARGET_WORDS_BIGENDIAN=3Dy" >> $config_target_mak
 fi
diff --git a/qemu-options.hx b/qemu-options.hx
index 224a8e8712..10c046c916 100644
=2D-- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -31,7 +31,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "-machine [type=3D]name[,prop[=3Dvalue][,...]]\n"
     "                selects emulated machine ('-machine help' for list)\=
n"
     "                property accel=3Daccel1[:accel2[:...]] selects accel=
erator\n"
-    "                supported accelerators are kvm, xen, hax, hvf, whpx =
or tcg (default: tcg)\n"
+    "                supported accelerators are kvm, xen, hax, hvf, nvmm,=
 whpx or tcg (default: tcg)\n"
     "                vmport=3Don|off|auto controls emulation of vmport (d=
efault: auto)\n"
     "                dump-guest-core=3Don|off include guest memory in a c=
ore dump (default=3Don)\n"
     "                mem-merge=3Don|off controls memory merge support (de=
fault: on)\n"
@@ -64,9 +64,9 @@ Supported machine properties are:
 @table @option
 @item accel=3D@var{accels1}[:@var{accels2}[:...]]
 This is used to enable an accelerator. Depending on the target architectu=
re,
-kvm, xen, hax, hvf, whpx or tcg can be available. By default, tcg is used=
. If there is
-more than one accelerator specified, the next one is used if the previous=
 one
-fails to initialize.
+kvm, xen, hax, hvf, nvmm, whpx or tcg can be available. By default, tcg i=
s used.
+If there is more than one accelerator specified, the next one is used if =
the
+previous one fails to initialize.
 @item vmport=3Don|off|auto
 Enables emulation of VMWare IO port, for vmmouse etc. auto says to select=
 the
 value based on accel. For accel=3Dxen the default is off otherwise the de=
fault
@@ -114,7 +114,7 @@ ETEXI

 DEF("accel", HAS_ARG, QEMU_OPTION_accel,
     "-accel [accel=3D]accelerator[,prop[=3Dvalue][,...]]\n"
-    "                select accelerator (kvm, xen, hax, hvf, whpx or tcg;=
 use 'help' for a list)\n"
+    "                select accelerator (kvm, xen, hax, hvf, nvmm, whpx o=
r tcg; use 'help' for a list)\n"
     "                igd-passthru=3Don|off (enable Xen integrated Intel g=
raphics passthrough, default=3Doff)\n"
     "                kernel-irqchip=3Don|off|split controls accelerated i=
rqchip support (default=3Don)\n"
     "                kvm-shadow-mem=3Dsize of KVM shadow MMU in bytes\n"
@@ -124,9 +124,9 @@ STEXI
 @item -accel @var{name}[,prop=3D@var{value}[,...]]
 @findex -accel
 This is used to enable an accelerator. Depending on the target architectu=
re,
-kvm, xen, hax, hvf, whpx or tcg can be available. By default, tcg is used=
. If there is
-more than one accelerator specified, the next one is used if the previous=
 one
-fails to initialize.
+kvm, xen, hax, hvf, nvmm, whpx or tcg can be available. By default, tcg i=
s used.
+If there is more than one accelerator specified, the next one is used if =
the
+previous one fails to initialize.
 @table @option
 @item igd-passthru=3Don|off
 When Xen is in use, this option controls whether Intel integrated graphic=
s
=2D-
2.25.0

