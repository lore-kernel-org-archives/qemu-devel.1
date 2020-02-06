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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF9AC35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:53:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 174DA214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="OpfoNEp9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174DA214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izp5N-0004VW-2S
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 16:53:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37793)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1izomP-0008Ih-4j
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:33:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1izomN-0006KC-Dh
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:33:45 -0500
Received: from mout.gmx.net ([212.227.17.21]:49185)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1izomN-0006Dh-3d
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:33:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1581024807;
 bh=Kf6PjNDz9KTNSeBVYDQemDGF/lneulLD8So5cZYZOpo=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=OpfoNEp9NGeurnIi62MflxEGOMU86AOmr/1Zm853LSuxPdAxKDk9y1aGhuzcwmWFu
 OmJ8SjMgL24EMcx/bXdr7HuKGifj9k7WvNYhyYhIu/8ztXTYpvj8p2YGHZcTF8TaaN
 7FxMlpfGKArx/McjJH8ZpXTIiZDk7TxLIegTZb9s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([89.71.135.231]) by mail.gmx.com
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MG9kC-1ijNIh26DE-00GYV8; Thu, 06 Feb 2020 22:33:27 +0100
From: Kamil Rytarowski <n54@gmx.com>
To: rth@twiddle.net, ehabkost@redhat.com, slp@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, philmd@redhat.com, max@m00nbsd.net,
 jmcneill@invisible.ca
Subject: [PATCH v4 2/4] Add the NetBSD Virtual Machine Monitor accelerator.
Date: Thu,  6 Feb 2020 22:32:30 +0100
Message-Id: <20200206213232.1918-3-n54@gmx.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200206213232.1918-1-n54@gmx.com>
References: <20200206115731.13552-1-n54@gmx.com>
 <20200206213232.1918-1-n54@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C3Q726RK79xZjNh0XEi7RUkmSHG5tZojxZ72Eb0D5wxGuyjZ8de
 gYC4Kx3jGjwu3ITNzNRscbHS3MZt4f9q+Lks08yVlO0mbBHz4kCeMG/1YLFHbXCt7PbDUGD
 d2/4Kz9Be2lZhVzR6A5JURlgBUf10n+fmZ0jIXVyrPDnZyUO7oxCCzprjuB+NJihePz2V5s
 YK9s4tSfkVIJoh7w/yNkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iSZgP7mTPZw=:yAlYi7gdKrl8stbkGHuo1D
 FlAC3S+qGBG+oDEBUPR3AkaEoae/JeCHDwbePuAwuH57hgGiTqcR1VSlnANL0JF/ZVsXLWzrS
 xNELEsS53xMsv2Zrr2y9DE9RNvLw0DzOW46UtAr2TsMvDVX4VFR7/QO/SQUhePMQCQIDxzBpL
 QnxBA5jmcAmTkLv9Kdel2JemOp/gF/wOMKxGjy1jub/P34U2KIqPaJjM8VC4Vlj4dvVQzvP50
 hkVexL/tkK5+87s0PQCZYev+bjx2vJGiWzdoVnts9crLP5OBZip1LbcoZ7rBIxtb7DTFF6kPV
 pb6hz49edwU5POtK0KZVbIoQnk8nr8hNwmsCjwX7aNz7684BA+gqzGu2m1APcADHTyn/KObpB
 7TeAxSzNMS8enyZG3YqK+utd2MlhyIIJKPw0A03edgNCUYNkQuTl956w6FUe8Auhc5aOEAbJh
 BjwlarHfxYfRHCzYtLnR1vGbqqyjp323sZ0iBh3Zr40PHVWSKR5CB+goo5qSv7XnAA3vOcwyT
 JiixYBfc6klf8wVuhvZO7JwPDCj/ad5jEBRlolvSI1vdAuckWMSSp1tTCxRGv5Fw1nTfFcsuR
 iYHE6p+tAqdhvjKmHcR8ZfFhCuysVbHJyWmviIcUKaoSewXjqkaAgKu7kegxeo4oAbPabx3oU
 uYeOjDdda3CEIVxXUOPRDU28RM0mZnAHo8RVSv7V1YRDvVsdsNsh9wBXCrOzuEm+VPpqqG5hX
 Mfi+Kz92K/ahmnb6KAWhGflKnBcINM2PaC3hiQi+2ziOfvWNRlDNJ7/joH1i+warpg3cptatP
 BWgWxaX7aYME5NMxFEl0WLnjOIziLUkYomtFxSIux4wfBoYpvYGgk8T3nl5K9THTgoIsYWnvn
 jxlHPWWO1/W+OfBowkdXSDcSPIoDcU/RcbUgYp7jCd+MeZfHA2oTvA7QBxmkuewDX2GMlWzQg
 bN3RiKt+aPaCAyi6h8bZfJVeVPScMS/GKVQ7qyq0w55HXayFb+fyd6ALLsWhQhXSGvVRBKVaO
 06kiDK6ZDRFqwFODzxgwXipr4teIoLbbIN0/c1RSC407Rq/Paye1ZaFgpW2j1K2cSX9kQ/E33
 36NNwhLBJa6+wurPtvB+0xADPjDKjKdcQbpKTUv4lmIYbtSQiihAXF3vJsMaRw7HZGZ9FcwPR
 TqZTis1f0NNmfrhraUoP5R8fN4hCcdROxk+keIBLUF0XguqXB6f5bvWciWMDD3l2psa+w=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.21
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
Tested-by: Jared McNeill <jmcneill@invisible.ca>
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


