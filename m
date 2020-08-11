Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FF4C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 13:26:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30B0620658
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 13:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="K7DEz6FR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30B0620658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5UIH-00036s-18
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 09:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n54@gmx.com>) id 1k5Tw2-00009H-VH
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 09:03:22 -0400
Received: from mout.gmx.net ([212.227.15.18]:53981)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n54@gmx.com>) id 1k5Tw0-0000wY-MH
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 09:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1597150993;
 bh=ZKmjV+nVw1aJ6gZD2QzOEI785zynAMn0St417dViqGo=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=K7DEz6FRRd0Tq/ninwHrZLaPLNnIPIlWmu3hS0ZPt+TmLy1EZL+paj9dp2gOyduOg
 t006qn60SMG6wB3k7lm6VuOjsNE/W163DeDYhZhpuwWEL9zqoiNsxS8si47N4UyPjZ
 pv2W4yAZkcGqA9njnXsA0n9mFxgrwEGf1czWIPFA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([89.79.191.25]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1Msq2E-1kyQ2L0Ehc-00tCye; Tue, 11 Aug 2020 15:03:13 +0200
From: Kamil Rytarowski <n54@gmx.com>
To: rth@twiddle.net, ehabkost@redhat.com, slp@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, philmd@redhat.com, max@m00nbsd.net,
 jmcneill@invisible.ca
Subject: [PATCH v5 2/4] Add the NetBSD Virtual Machine Monitor accelerator.
Date: Tue, 11 Aug 2020 15:01:51 +0200
Message-Id: <20200811130153.4948-2-n54@gmx.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200811130153.4948-1-n54@gmx.com>
References: <20200206213232.1918-2-n54@gmx.com>
 <20200811130153.4948-1-n54@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5BOdXnJPvmwV9SRxtIJqAsCk02FdnU78VuEDhPMPTzqvSqJE9m7
 aSv9Rao6GL44in2noDbfJ1NJYcKBVNst1EiwJmgLkI8EnYrgTj6+ar5Jfap1VSwZgVqYe8D
 LRfbmF+ZQrH+00iU04kh5i3evY6/UVTQK8+UvZ6i0PpsVQxVl7t1y6uLkFh4lsU1HiPHZjr
 3w/ko9rgAU5EV2i90l6TQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zTsCPHH0A/w=:gpbtEZcTVwURgt8FqFW8ZF
 ed+wTOvWEwUbRQEKsPpCZCejzfwlJjI/Ox5eW+z4h5+I3Nw9T6urBIUHfsLfcIdSz2Qr5mEu2
 UG+FocTsFj2CdpgWI6Wr546AvV/Fy8k1pwUQEG1sk21a/qOynMTLxoBFjjdhZPAPS9UGmWtOK
 fdRjSry2apP/dRFjaeHmV7AiePYT4LHgdISlC1PBCl8/lpfFT8/FP9uTVZHkKMv0ZNgGTl0i0
 +EPpa+JBpizxSiNLD9dqHfcVjBKh5GzrUKVEsu0v1cWjk+qG49T43fmSZD6PtOJP7zs2C8Oif
 msGKU1lXaqbNANogwDDRDVVhEkJC9CqnHNh9/ne0b++jsnsb6Ap1f3lJ/TljoA7W1kJndkd9l
 PN6vCib5POGsheWHP3TW7UgIyTDvsGyiHLgjgHI2+QO4XAWaRu68gfwhk3heqIZzZgIBSbDEZ
 NCk+63rnOc8v7GIKSVrBLETmxHkMN6D4V6fN1L/jQ6rbHvkMvIudBlPZ8Iwo613BsVD45oPsT
 zoXY3I6IKtbWtNjrDDUJfZZYD8UNI1cUcF8o78U8gAPGx1xCPxpCLPP+9f1EgIhfOKX8VN7wl
 D2Di5PwNSumx8EwOsvWZgFiFiAUglpPZLY+F5ReAosQwYQQ5S5/9z9uJLV9ARTscIOOyInBnH
 F5tCOEOS7KQzBJ8HVUqvh2qeBX3DIaUITT4KAp3eFHxzqFZ0TvNtoly5psg/bnr9Oi/Gbhw9F
 93Mkp49cN6Lz2KICteSfOHik8/mi5Pl+UUiyTp2dDrSipeA6F/IzJ+miRq4IAo1S9D+MxrbU4
 slGZB3bLXXmEcCf+8rO6EClMSnB4fH8K5AdVOL3GFzc1VsIGnMfj7H5vgPJRQh8XmQjhFTvXI
 QNNtW6ddgFvUTtNpTKk5n5Wn7Ym++3/KFy0ST4beoy6nKbPVonT1U/a+ZAtIWv06pN5ycRROt
 lVwqBl6AdTGg1vWHaTEUy+JYDiRBcqJx/FtzaxoCzn5sfUDyV7cAByXghxh2UUdniiwU87pYa
 NqZVQehKqEFLFl0KMzT6kQZtEO7UdBKi9cqpMKX0uiy8norRpyNX+MUyIJEBdLbGvt4eUybMw
 n4GxhIfdy51U1rKt82sb+AdjUJLBfNExRfclrGUE+ocGJYoDuO772KsB9ocY6gjmZ/WstNi5j
 xLIOZ/E4zQ/B+o0qGN0FSf8FlySnShu3b/Njoqrcz9W87LjIOgwSDcZ1HNQiA92BAFQ4BrlA7
 x2AgQ/fpF40454+z4UOYF+dqGaG2YFzNnLAHyVrPr6U6Hs79Jk8KcIB+yqOz5z6iCs/aKODV+
 edftvSuawVn2l25skbTKtHoqfuN4e1czrCVbLZIgp3QFOkBuzAU4DwLHkw6h8cgfc8t/n+iJE
 ZH4ejKxE9Dqf2podvTefRWcXbGzBBIf8U/9j0v6So8FEzWOTtCeszZhZ++636Q1wAk4E0DqL3
 7eYzrZYv9D7OA2jw6AcqWHuI/LjJqCR+TAT2Rl4+KqR3uubOBHmjYi/7Uhq8lpkg8FN1rOuX4
 mAkF5TSaFjKNjnT08viIzykQ=
Received-SPF: pass client-ip=212.227.15.18; envelope-from=n54@gmx.com;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 09:02:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 11 Aug 2020 09:13:33 -0400
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
 qemu-options.hx | 10 +++++-----
 2 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index 2acc4d1465..fb9ffba2bf 100755
=2D-- a/configure
+++ b/configure
@@ -246,6 +246,17 @@ supported_whpx_target() {
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
@@ -273,6 +284,7 @@ supported_target() {
     supported_hax_target "$1" && return 0
     supported_hvf_target "$1" && return 0
     supported_whpx_target "$1" && return 0
+    supported_nvmm_target "$1" && return 0
     print_error "TCG disabled, but hardware accelerator not available for=
 '$target'"
     return 1
 }
@@ -395,6 +407,7 @@ kvm=3D"no"
 hax=3D"no"
 hvf=3D"no"
 whpx=3D"no"
+nvmm=3D"no"
 rdma=3D""
 pvrdma=3D""
 gprof=3D"no"
@@ -847,6 +860,7 @@ DragonFly)
 NetBSD)
   bsd=3D"yes"
   hax=3D"yes"
+  nvmm=3D"yes"
   make=3D"${MAKE-gmake}"
   audio_drv_list=3D"oss try-sdl"
   audio_possible_drivers=3D"oss sdl"
@@ -1233,6 +1247,10 @@ for opt do
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
@@ -1879,6 +1897,7 @@ disabled with --disable-FEATURE, default is enabled =
if available:
   hax             HAX acceleration support
   hvf             Hypervisor.framework acceleration support
   whpx            Windows Hypervisor Platform acceleration support
+  nvmm            NetBSD Virtual Machine Monitor acceleration support
   rdma            Enable RDMA-based migration
   pvrdma          Enable PVRDMA support
   vde             support for vde network
@@ -2965,6 +2984,20 @@ if test "$whpx" !=3D "no" ; then
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
@@ -6934,6 +6967,7 @@ echo "KVM support       $kvm"
 echo "HAX support       $hax"
 echo "HVF support       $hvf"
 echo "WHPX support      $whpx"
+echo "NVMM support      $nvmm"
 echo "TCG support       $tcg"
 if test "$tcg" =3D "yes" ; then
     echo "TCG debug enabled $debug_tcg"
@@ -8332,6 +8366,9 @@ fi
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
index 708583b4ce..697accaa7e 100644
=2D-- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -26,7 +26,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
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
@@ -58,7 +58,7 @@ SRST

     ``accel=3Daccels1[:accels2[:...]]``
         This is used to enable an accelerator. Depending on the target
-        architecture, kvm, xen, hax, hvf, whpx or tcg can be available.
+        architecture, kvm, xen, hax, hvf, nvmm, whpx or tcg can be availa=
ble.
         By default, tcg is used. If there is more than one accelerator
         specified, the next one is used if the previous one fails to
         initialize.
@@ -119,7 +119,7 @@ ERST

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
@@ -128,8 +128,8 @@ DEF("accel", HAS_ARG, QEMU_OPTION_accel,
 SRST
 ``-accel name[,prop=3Dvalue[,...]]``
     This is used to enable an accelerator. Depending on the target
-    architecture, kvm, xen, hax, hvf, whpx or tcg can be available. By
-    default, tcg is used. If there is more than one accelerator
+    architecture, kvm, xen, hax, hvf, nvmm whpx or tcg can be available.
+    By default, tcg is used. If there is more than one accelerator
     specified, the next one is used if the previous one fails to
     initialize.

=2D-
2.28.0


