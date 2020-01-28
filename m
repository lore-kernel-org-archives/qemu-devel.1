Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69242C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 14:14:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3896B2469C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 14:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="EJIiY3IF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3896B2469C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwRdE-0004bk-8H
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 09:14:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1iwRa5-0003BJ-LI
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 09:11:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1iwRa4-0005Sl-8K
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 09:11:05 -0500
Received: from mout.gmx.net ([212.227.15.19]:40255)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1iwRa3-0005SC-Ux
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 09:11:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1580220652;
 bh=/24CcQSAisqVsMOTbVgPxfxH8tCDghR0Bs9U0kK9Ef8=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=EJIiY3IFIrmomA/HB6g2SlTYlmIF0hybaj9XkIQ0E6tP4ZfvUneF346R86tUFlXcn
 qFkyfbF4/Lxa8w9nZJqJLEyht5KRISijzxYs7p1I3u1DEWH3ddWgPe3cQUqKZC4MEe
 Iw2SmlfPZN2EB/ozRyG08BXBIhrg0rNQ4LdHSq4Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([89.71.135.231]) by mail.gmx.com
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1M5fMe-1iup1C05X8-007Ce9; Tue, 28 Jan 2020 15:10:52 +0100
From: Kamil Rytarowski <n54@gmx.com>
To: rth@twiddle.net, ehabkost@redhat.com, philmd@redhat.com, slp@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, max@m00nbsd.net
Subject: [PATCH v2 2/4] Add the NetBSD Virtual Machine Monitor accelerator.
Date: Tue, 28 Jan 2020 15:09:43 +0100
Message-Id: <20200128140945.929-3-n54@gmx.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200128140945.929-1-n54@gmx.com>
References: <20200107124903.16505-1-n54@gmx.com>
 <20200128140945.929-1-n54@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iOxFGtDFHqGiT/EhkGdfgi5P1gRUyj9Swl5Wwz7WmQZR4rSBlGK
 1308s0DEpEs0jAn6zkIuf5Ud+EykHrfkdLKiUCAL49/bwQTc9SmEETnBRCAH8tKjd8QS1FW
 FB/OJzq5N7vqEyBcuHTZsm4g/epi2DiGCdMJM+cWkcw/EFjwSF7n6uhASGzq2d3j7dzTcvx
 82uL1vVpJgMPPyFDP6lpA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SFBYLXpqWcM=:MDfmyvTjOpGZXntBMZnWVx
 NWMthH8j688KkUlnJL8dE/faD7X1HqX7Pm8BVHqQ7zULd4Yh8NyBq8ISnD7NmWyOzJtnhzkMm
 4ElnPj2370tjs3ApznhxTzluvrNXWw72ygvAkJVpfsQyilv02aRiyMS/exiDQ3QZiY6zQSFSD
 urKLGadOUlodq5e3dc07XGk7MkNOKTgOy/nWrTnO2ed4k+yv4kLM95s8x0DQycvzo16JCxygL
 tWFbc+l7U42eWT8VTSghMaMYlFQMAy7snD+DRhn2D/UfUEs9hsPMfItlqVuIR9nSl8fR78Qhg
 +ySHnzQnUcmIgi/pM5oGViU+f6JCnodk5uiGVob4slOsmCmfwRn7EX0PlTCjxOosjyL7D9e0M
 u+Akf4wm4M0odfY8FqN3lnGGlmPlZSwmc2XO8sCZSOsy4JlEuUvxr+RAfTLSNna5P5MX/j16U
 aP/1XHPx9HSkKYVqZrCbD32kQWEs7U0knUT6ZfsXGq+SXgW48LsybpcZDTAw6gSLRoZZhL04B
 M89M+b5JjNQjl7ilsQudfF9/X15KO3b+m9yANONz1Ft/ZfLPtCRb+AxgAaEFlLvYE0Zl/VOUH
 ULg+yGUszjZwwnGuoCVLyLWASb2Bv8dN4ZDyxCW6MscvZi3HcObg/wgcHs49KgkioSZYbGsGe
 THR/JK+k2mhN3MN2bsVu0hsDA1oQXs0Z+/G6ElrSjCYpGcV8/NYIFPq1Fo4xyDnFIbHyA/37D
 HQSYGeuyrRyvxQ0czpceVagEKkDYdFk3h3TmFOLZ8+Q6/3Z6d4y5G0ucnteA02bK3K9cP1B6a
 r+LP2I4hoV9m7JELjRFE4LN3tjS1Y1PYzcnXMM3Q0o+GF+lLgwnfePVoA6cCh0A1f0Vz3m9hB
 ZF5z9BvS8g8BOB7UVxw43cVvwW1HxDca7lSKA0QgLPmZF5uEwIexCUPWhgpT/oEGB6uc4glU/
 K7grovmk6uGV/P9lGS6Jc4aFCpfloSn3FeNYVEqiUTuuQcDmFlEBDqgsBTP+tXTZd2icdIFiY
 BdjwagXuEkdE65HzeNKaS7MWLh/fechdbQilzwiKGdnKqzf/KehvfftVaFvPEcMt5zOmbmskQ
 ucxaq0yU6TfeiLpUTd3PoOldK4hRH6le7mt3nRGDVnphgMRtags1dbIQ6EQ+8hA0UzDVuRcfv
 XyGdEv3hg6htIYZ9EV0gCnCa5ThF1YRpIyzCDhvMtgqoJ0RYGIbewfQXVpTv7KMdMX3RA=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.19
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
=2D--
 configure       | 36 ++++++++++++++++++++++++++++++++++++
 qemu-options.hx | 16 ++++++++--------
 2 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/configure b/configure
index 0ce2c0354a..eb456a271e 100755
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
@@ -387,6 +399,7 @@ kvm=3D"no"
 hax=3D"no"
 hvf=3D"no"
 whpx=3D"no"
+nvmm=3D"no"
 rdma=3D""
 pvrdma=3D""
 gprof=3D"no"
@@ -1168,6 +1181,10 @@ for opt do
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
@@ -1768,6 +1785,7 @@ disabled with --disable-FEATURE, default is enabled =
if available:
   hax             HAX acceleration support
   hvf             Hypervisor.framework acceleration support
   whpx            Windows Hypervisor Platform acceleration support
+  nvmm            NetBSD Virtual Machine Monitor acceleration support
   rdma            Enable RDMA-based migration
   pvrdma          Enable PVRDMA support
   vde             support for vde network
@@ -2757,6 +2775,20 @@ if test "$whpx" !=3D "no" ; then
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
@@ -6495,6 +6527,7 @@ echo "KVM support       $kvm"
 echo "HAX support       $hax"
 echo "HVF support       $hvf"
 echo "WHPX support      $whpx"
+echo "NVMM support      $nvmm"
 echo "TCG support       $tcg"
 if test "$tcg" =3D "yes" ; then
     echo "TCG debug enabled $debug_tcg"
@@ -7771,6 +7804,9 @@ fi
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
index e9d6231438..4ddf7c91a0 100644
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
@@ -63,9 +63,9 @@ Supported machine properties are:
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
@@ -110,7 +110,7 @@ ETEXI

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
@@ -120,9 +120,9 @@ STEXI
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
2.24.1


