Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D30C33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 09:10:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05B882467E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 09:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PCaejXQz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B882467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwMt5-0004mV-8R
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 04:10:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56690)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iwMp2-0005vr-5d
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 04:06:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iwMp0-00032G-Bm
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 04:06:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55846
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iwMoz-00031h-Rw
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 04:06:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580202369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kjg8R4UdaoSoMSC6zqKoCCwIvu14OyCAXYMpRWt8jgk=;
 b=PCaejXQz6H1scoNQTmgDkyU32BaT0ZbadFGeO+7Auv3aBbQNdrUnTCXTaSrYDXuEu/TPoE
 1hporPVxv2IFBhVRZMpIibVP5mxunnGjpzCFMEkRyDzs7XfZawhzS1tvPPpi7Z31xfJtLt
 1c3EM+8Hp6wYUt2F2JzmxGc3d9JIDfQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-xA0AK4OtMASpYUAgijdklw-1; Tue, 28 Jan 2020 04:06:08 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32F07A0CDD
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:06:07 +0000 (UTC)
Received: from secure.mitica (ovpn-116-64.ams2.redhat.com [10.36.116.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD15C1001B39;
 Tue, 28 Jan 2020 09:06:04 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 5/7] configure: Enable test and libs for zstd
Date: Tue, 28 Jan 2020 10:05:48 +0100
Message-Id: <20200128090550.5112-6-quintela@redhat.com>
In-Reply-To: <20200128090550.5112-1-quintela@redhat.com>
References: <20200128090550.5112-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: xA0AK4OtMASpYUAgijdklw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 configure | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/configure b/configure
index a72a5def57..7c1dca326f 100755
--- a/configure
+++ b/configure
@@ -448,6 +448,7 @@ lzo=3D""
 snappy=3D""
 bzip2=3D""
 lzfse=3D""
+zstd=3D""
 guest_agent=3D""
 guest_agent_with_vss=3D"no"
 guest_agent_ntddscsi=3D"no"
@@ -1343,6 +1344,10 @@ for opt do
   ;;
   --disable-lzfse) lzfse=3D"no"
   ;;
+  --disable-zstd) zstd=3D"no"
+  ;;
+  --enable-zstd) zstd=3D"yes"
+  ;;
   --enable-guest-agent) guest_agent=3D"yes"
   ;;
   --disable-guest-agent) guest_agent=3D"no"
@@ -1795,6 +1800,8 @@ disabled with --disable-FEATURE, default is enabled i=
f available:
                   (for reading bzip2-compressed dmg images)
   lzfse           support of lzfse compression library
                   (for reading lzfse-compressed dmg images)
+  zstd            support for zstd compression library
+                  (for migration compression)
   seccomp         seccomp support
   coroutine-pool  coroutine freelist (better performance)
   glusterfs       GlusterFS backend
@@ -2409,6 +2416,24 @@ EOF
     fi
 fi
=20
+##########################################
+# zstd check
+
+if test "$zstd" !=3D "no" ; then
+    if $pkg_config --exist libzstd ; then
+        zstd_cflags=3D"$($pkg_config --cflags libzstd)"
+        zstd_libs=3D"$($pkg_config --libs libzstd)"
+        LIBS=3D"$zstd_libs $LIBS"
+        QEMU_CFLAGS=3D"$QEMU_CFLAGS $zstd_cflags"
+        zstd=3D"yes"
+    else
+        if test "$zstd" =3D "yes" ; then
+            feature_not_found "libzstd" "Install libzstd devel"
+        fi
+        zstd=3D"no"
+    fi
+fi
+
 ##########################################
 # libseccomp check
=20
@@ -6578,6 +6603,7 @@ echo "lzo support       $lzo"
 echo "snappy support    $snappy"
 echo "bzip2 support     $bzip2"
 echo "lzfse support     $lzfse"
+echo "zstd support      $zstd"
 echo "NUMA host support $numa"
 echo "libxml2           $libxml2"
 echo "tcmalloc support  $tcmalloc"
@@ -7143,6 +7169,10 @@ if test "$lzfse" =3D "yes" ; then
   echo "LZFSE_LIBS=3D-llzfse" >> $config_host_mak
 fi
=20
+if test "$zstd" =3D "yes" ; then
+  echo "CONFIG_ZSTD=3Dy" >> $config_host_mak
+fi
+
 if test "$libiscsi" =3D "yes" ; then
   echo "CONFIG_LIBISCSI=3Dm" >> $config_host_mak
   echo "LIBISCSI_CFLAGS=3D$libiscsi_cflags" >> $config_host_mak
--=20
2.24.1


