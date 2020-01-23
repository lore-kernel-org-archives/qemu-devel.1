Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B843AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:16:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C0E72467B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f2o5Jzm9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C0E72467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iucLB-0006lN-O6
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 08:16:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40701)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iub9E-0002aK-0R
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iub9C-0005Hz-Qz
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38883
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iub9C-0005He-Nv
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579780782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jl7rZha+anhl8HyEBbzyChMvC+XF+svndYlQbHY4vkk=;
 b=f2o5Jzm903miCeycIUbmFCkbjDyriBI2R7jVjIS3LFkHU8/FUlQdcGz7j/2GJOBPCYDB9/
 CLWFlFZlVLH35M0K6aPq41cCK5ARpwp2v2R1Ca/UCt7bo9fLkmT7VCHn/vBmM3kwtFVHTD
 DSzcc7ZU/6BlmUBN46rzOaiMvMZJR9M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-a4oQcipXMJCz4AreJZBvYA-1; Thu, 23 Jan 2020 06:59:40 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA409107ACC5
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 11:59:39 +0000 (UTC)
Received: from secure.mitica (ovpn-116-207.ams2.redhat.com [10.36.116.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A325D19C69;
 Thu, 23 Jan 2020 11:59:37 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 20/21] configure: Enable test and libs for zstd
Date: Thu, 23 Jan 2020 12:58:30 +0100
Message-Id: <20200123115831.36842-21-quintela@redhat.com>
In-Reply-To: <20200123115831.36842-1-quintela@redhat.com>
References: <20200123115831.36842-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: a4oQcipXMJCz4AreJZBvYA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 configure | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/configure b/configure
index 557e4382ea..56ddfd7f8a 100755
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
@@ -2408,6 +2415,24 @@ EOF
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
@@ -6555,6 +6580,7 @@ echo "lzo support       $lzo"
 echo "snappy support    $snappy"
 echo "bzip2 support     $bzip2"
 echo "lzfse support     $lzfse"
+echo "zstd support      $zstd"
 echo "NUMA host support $numa"
 echo "libxml2           $libxml2"
 echo "tcmalloc support  $tcmalloc"
@@ -7114,6 +7140,10 @@ if test "$lzfse" =3D "yes" ; then
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


