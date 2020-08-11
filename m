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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711EDC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 14:15:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FB4C206C3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 14:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="iuROyKxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB4C206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5V48-0005ZL-T1
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 10:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n54@gmx.com>) id 1k5V0j-0003FZ-8n
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 10:12:17 -0400
Received: from mout.gmx.net ([212.227.17.21]:55195)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n54@gmx.com>) id 1k5V0h-00010I-7K
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 10:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1597155118;
 bh=ZKmjV+nVw1aJ6gZD2QzOEI785zynAMn0St417dViqGo=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iuROyKxoEcRyXQr8DcU4KbZuhSElkuMRVgcSe1YK9tequ8thuAx4vniTMmxsBdq4g
 WyOgH5QjqrVD9RIpMvJfaU1YyCsQhRlnv2YRTaJp7Huo2Pcg92bYmNCKWSxQVq2dZO
 eClQP3kEJcxsyOE9U+9u/2FDmqz6u9ngq+P5gYvw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([89.79.191.25]) by mail.gmx.com
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MfYPY-1kcNz41Atc-00g0TP; Tue, 11 Aug 2020 16:11:58 +0200
From: Kamil Rytarowski <n54@gmx.com>
To: rth@twiddle.net, ehabkost@redhat.com, slp@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, philmd@redhat.com, max@m00nbsd.net,
 jmcneill@invisible.ca
Subject: [PATCH v5 2/4] Add the NetBSD Virtual Machine Monitor accelerator.
Date: Tue, 11 Aug 2020 16:10:47 +0200
Message-Id: <20200811141049.15824-2-n54@gmx.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200811141049.15824-1-n54@gmx.com>
References: <20200811141049.15824-1-n54@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EBF400qziPdeoWj0QFP6WVI9R5fNOKzwzKBrXgrUIxATGfVGPYR
 G9A7FjxVbr1YVeepdsha67beeslF5MMlD09Z8QGvabhGtvpGwijY35IFfTS2BF/8BYI3RwS
 M8IA7NBxv5cWmNVjJ/KMKO/XhK7QsnOaXjLyM+JAjxz0d+mfJrOtIH1u5xti8Yt5ENx6+PN
 5JF3Si9eyNPFYBv3MvtNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gUK/rav6dm8=:vufDX0i0Nod1+maNXyhLkk
 RWFccA/EVmDnJxYvkXZSR11QtI+gsGfWPwyGXrrD8pMBoXMbK9oHJK8H980dGTgSTOTD7TEJO
 YcS+ag9tei+wcxdnBFnfd+Xv8TPoe1MlXC0LKvZMBk9OMzs2dpO6W84mn7l9GSNu6Ui9d3gOJ
 Om22Bq3QYpMxVcwUGJeA+Yy/NcOMukw+RK+te77sbZ7x/cWUPtbO8l8bSjzo308qqNR+yB1Oi
 2tenXU5hjG9t+XX+Z7BPHDdlIhsRSLg38Jnq8YcSYVm9Q0nGXnkryQBNYrfLPwGXMXLta/zIX
 rm3mEkuTW484tLi4LZry80aqJpAMlkC+EvFE+sNInK8cNTpXvXmRnA3ehA+aDB+uumVKQWgqM
 wzjmPSKnUi1hTSLGTqmTLtEgINgTv/euMh6g+mRyx+4VFrVM2yP4ZOM/9vWOs0y+EizJStv6J
 PILJFl8/rw1fMmQXNjF8HnK7rMK0KAMcueSJMjHfuKdcE3L43xmfXCGjIZ1e7g5cAFddazuAT
 GHPba1oNu+lXWeFsRXwGzFa4TNdK+3V8Uq74TQ36qFZ0i0Hk/C/jVAnUI/INC6hHWIWFsXYtf
 v1ZqAQ/JO4+E5aNpB8nj9aPZlINfttKsWjkjYKmP1Li8gaADEHZZKRYDwNhBxo7WY7BtMRfFD
 XhoNCim+gT4Kihd+sjLw15qwfy8EthzQGS3tMcOOYZVBcjdBhk+lAMA/OUxCOk4fvm3b7xDQB
 9hZPr90CFNvwVuAKruvQfrl4gyZQoXMFaVvh6ZjR2diQFkhit+eeazae3wmD3rfxeG6Q80KC+
 4//djuf+pbx0fvZTytCR1C6gp5/YaJx3WUZPt61WY+jVlc9NcK0Yqsf67H9P2OKrTHuVIuk/7
 l80gbmwlz2Gmbw5mTw68ziUZ4E3bw+hVtz+C1kaE6/0ox3QQhsRCyh38P8Xyvb8wNdgi/jjbx
 TEKCp4CLvJ218+o7o4Ki6E/lSUYA59aAH831sUZ0JrESFbTIuukigZa02DIAgtxyXkbUXkDHP
 NPhmSBRimZm6jMvb20/zDtJgp7j/j11x3XYsXA47jXJhyo8SlxbxDJjEsjTTcXW/AVZA0nmok
 piyeXJ59fczfnZJTKqClQDsnG8NxLAKW6dp7mV/1kCpaivH4wSqSNLDb1zmaLKxyMCDzvOJl6
 +PW8CsW9ei9iWnHTIfCgCCnPv31KTnjigYRVpKC1onTk57EhSsbYmVnWcaUciSy5/fv9GRGIA
 9wko4sWepKTlGiTgL
Received-SPF: pass client-ip=212.227.17.21; envelope-from=n54@gmx.com;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 10:12:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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


