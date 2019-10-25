Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BFACA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 16:17:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18AD12070B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 16:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HE2CQURp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18AD12070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO2HY-0003je-Bi
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 12:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34675)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iO25O-0002fx-8u
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:05:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iO25N-0002wL-4v
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:05:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59288
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iO25N-0002w1-2E
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:05:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572019508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EMD2WYXu2zWCfMzZtaw/UlbSuO/pvt+p+GuSLnIDt3E=;
 b=HE2CQURpnqQQa4ujcKBPbHLykK42QAlHUZqoJQUNbRhMGntudGTeAMSVk7HyyCaZ7xPq94
 IHwcvNkctaC8qzjENZZ1gbBRJm8F9HrUp0kBN8XtWSyXmh94n5UI9pULljWVD6f+0XB8BD
 VOuUjuHBbZlm6+LPtVNGNa4/06/c/KU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-P_ocgEj2Pp-6ycRpRdajWw-1; Fri, 25 Oct 2019 12:05:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F31C1107AD31;
 Fri, 25 Oct 2019 16:05:03 +0000 (UTC)
Received: from localhost (ovpn-117-215.ams2.redhat.com [10.36.117.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 594315C1D4;
 Fri, 25 Oct 2019 16:04:55 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/15] configure: permit use of io_uring
Date: Fri, 25 Oct 2019 18:04:30 +0200
Message-Id: <20191025160444.31632-2-stefanha@redhat.com>
In-Reply-To: <20191025160444.31632-1-stefanha@redhat.com>
References: <20191025160444.31632-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: P_ocgEj2Pp-6ycRpRdajWw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Fam Zheng <fam@euphon.net>, oleksandr@redhat.com,
 Maxim Levitsky <maximlevitsky@gmail.com>, qemu-block@nongnu.org,
 Julia Suvorova <jusual@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
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
index 145fcabbb3..745429c925 100755
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
@@ -1250,6 +1251,10 @@ for opt do
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
@@ -1760,6 +1765,7 @@ disabled with --disable-FEATURE, default is enabled i=
f available:
   vde             support for vde network
   netmap          support for netmap network
   linux-aio       Linux AIO support
+  linux-io-uring  Linux io_uring support
   cap-ng          libcap-ng support
   attr            attr and xattr support
   vhost-net       vhost-net kernel acceleration support
@@ -3950,6 +3956,21 @@ EOF
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
@@ -6356,6 +6377,7 @@ echo "PIE               $pie"
 echo "vde support       $vde"
 echo "netmap support    $netmap"
 echo "Linux AIO support $linux_aio"
+echo "Linux io_uring support $linux_io_uring"
 echo "ATTR/XATTR support $attr"
 echo "Install blobs     $blobs"
 echo "KVM support       $kvm"
@@ -6844,6 +6866,11 @@ fi
 if test "$linux_aio" =3D "yes" ; then
   echo "CONFIG_LINUX_AIO=3Dy" >> $config_host_mak
 fi
+if test "$linux_io_uring" =3D "yes" ; then
+  echo "CONFIG_LINUX_IO_URING=3Dy" >> $config_host_mak
+  echo "LINUX_IO_URING_CFLAGS=3D$linux_io_uring_cflags" >> $config_host_ma=
k
+  echo "LINUX_IO_URING_LIBS=3D$linux_io_uring_libs" >> $config_host_mak
+fi
 if test "$attr" =3D "yes" ; then
   echo "CONFIG_ATTR=3Dy" >> $config_host_mak
 fi
--=20
2.21.0


