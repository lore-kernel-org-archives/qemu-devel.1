Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92879ECE58C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 12:12:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67C6721721
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 12:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67C6721721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHRsT-00035H-AN
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 08:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47835)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iHRpv-0000zX-MP
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 08:10:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iHRpu-0003cA-J8
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 08:09:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36440)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1iHRps-0003ZT-5D; Mon, 07 Oct 2019 08:09:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 57B843086E27;
 Mon,  7 Oct 2019 12:09:55 +0000 (UTC)
Received: from localhost (unknown [10.36.118.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 211ED60A9D;
 Mon,  7 Oct 2019 12:09:47 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/16] configure: permit use of io_uring
Date: Mon,  7 Oct 2019 13:09:22 +0100
Message-Id: <20191007120937.5862-2-stefanha@redhat.com>
In-Reply-To: <20191007120937.5862-1-stefanha@redhat.com>
References: <20191007120937.5862-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Mon, 07 Oct 2019 12:09:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: oleksandr@redhat.com, Kevin Wolf <kwolf@redhat.com>,
 Maxim Levitsky <maximlevitsky@gmail.com>, qemu-block@nongnu.org,
 Julia Suvorova <jusual@mail.ru>, Julia Suvorova <jusual@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aarushi Mehta <mehta.aaru20@gmail.com>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Reviewed-by: Maxim Levitsky <maximlevitsky@gmail.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 configure | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/configure b/configure
index 8f8446f52b..3ac597c547 100755
--- a/configure
+++ b/configure
@@ -370,6 +370,7 @@ xen=3D""
 xen_ctrl_version=3D""
 xen_pci_passthrough=3D""
 linux_aio=3D""
+linux_io_uring=3D""
 cap_ng=3D""
 attr=3D""
 libattr=3D""
@@ -1249,6 +1250,10 @@ for opt do
   ;;
   --enable-linux-aio) linux_aio=3D"yes"
   ;;
+  --disable-linux-io-uring) linux_io_uring=3D"no"
+  ;;
+  --enable-linux-io-uring) linux_io_uring=3D"yes"
+  ;;
   --disable-attr) attr=3D"no"
   ;;
   --enable-attr) attr=3D"yes"
@@ -1755,6 +1760,7 @@ disabled with --disable-FEATURE, default is enabled=
 if available:
   vde             support for vde network
   netmap          support for netmap network
   linux-aio       Linux AIO support
+  linux-io-uring  Linux io_uring support
   cap-ng          libcap-ng support
   attr            attr and xattr support
   vhost-net       vhost-net kernel acceleration support
@@ -3941,6 +3947,21 @@ EOF
     linux_aio=3Dno
   fi
 fi
+##########################################
+# linux-io-uring probe
+
+if test "$linux_io_uring" !=3D "no" ; then
+  if $pkg_config liburing; then
+    linux_io_uring_cflags=3D$($pkg_config --cflags liburing)
+    linux_io_uring_libs=3D$($pkg_config --libs liburing)
+    linux_io_uring=3Dyes
+  else
+    if test "$linux_io_uring" =3D "yes" ; then
+      feature_not_found "linux io_uring" "Install liburing devel"
+    fi
+    linux_io_uring=3Dno
+  fi
+fi
=20
 ##########################################
 # TPM emulation is only on POSIX
@@ -6350,6 +6371,7 @@ echo "PIE               $pie"
 echo "vde support       $vde"
 echo "netmap support    $netmap"
 echo "Linux AIO support $linux_aio"
+echo "Linux io_uring support $linux_io_uring"
 echo "ATTR/XATTR support $attr"
 echo "Install blobs     $blobs"
 echo "KVM support       $kvm"
@@ -6837,6 +6859,11 @@ fi
 if test "$linux_aio" =3D "yes" ; then
   echo "CONFIG_LINUX_AIO=3Dy" >> $config_host_mak
 fi
+if test "$linux_io_uring" =3D "yes" ; then
+  echo "CONFIG_LINUX_IO_URING=3Dy" >> $config_host_mak
+  echo "LINUX_IO_URING_CFLAGS=3D$linux_io_uring_cflags" >> $config_host_=
mak
+  echo "LINUX_IO_URING_LIBS=3D$linux_io_uring_libs" >> $config_host_mak
+fi
 if test "$attr" =3D "yes" ; then
   echo "CONFIG_ATTR=3Dy" >> $config_host_mak
 fi
--=20
2.21.0


