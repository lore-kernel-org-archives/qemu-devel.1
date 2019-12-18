Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6ED1C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 02:10:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B183F21582
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 02:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLfoi1yT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B183F21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihOnX-0005Yd-Kx
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 21:10:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52790)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ihOet-00038z-N0
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 21:01:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ihOes-0005wK-Hd
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 21:01:51 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42585
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ihOes-0005vb-Df
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 21:01:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576634510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b2vemv0zRpYDz/uUdckp1sNwESkzjwYs9euWZf0G7CM=;
 b=RLfoi1yT1XEqKX9K2iKqFTsQfDvnKYXWp3TwMnS1Mvn3TQNVYqcwMPi8nnv6gqNUMfQ7TE
 qGeAJOpLoBDBbMjLJH9lMaLRb6EH7Z1c9D1RDT5f6AScGhR5nVic/vAi87NCuncDQsNoxr
 3Uz/N0/OnR0/UF06muvFQvLW5J2EXmA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-TJbZOpZnOUOg9uRxdwQerA-1; Tue, 17 Dec 2019 21:01:47 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D112100550E
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 02:01:46 +0000 (UTC)
Received: from secure.mitica (ovpn-116-32.ams2.redhat.com [10.36.116.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0E6CD19C58;
 Wed, 18 Dec 2019 02:01:43 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/10] configure: Enable test and libs for zstd
Date: Wed, 18 Dec 2019 03:01:18 +0100
Message-Id: <20191218020119.3776-10-quintela@redhat.com>
In-Reply-To: <20191218020119.3776-1-quintela@redhat.com>
References: <20191218020119.3776-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: TJbZOpZnOUOg9uRxdwQerA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 configure | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/configure b/configure
index 84b413dbfc..a8f3027c67 100755
--- a/configure
+++ b/configure
@@ -447,6 +447,7 @@ lzo=3D""
 snappy=3D""
 bzip2=3D""
 lzfse=3D""
+zstd=3D""
 guest_agent=3D""
 guest_agent_with_vss=3D"no"
 guest_agent_ntddscsi=3D"no"
@@ -1341,6 +1342,10 @@ for opt do
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
@@ -1788,6 +1793,8 @@ disabled with --disable-FEATURE, default is enabled i=
f available:
                   (for reading bzip2-compressed dmg images)
   lzfse           support of lzfse compression library
                   (for reading lzfse-compressed dmg images)
+  zstd            support for zstd compression library
+                  (for migration compression)
   seccomp         seccomp support
   coroutine-pool  coroutine freelist (better performance)
   glusterfs       GlusterFS backend
@@ -2401,6 +2408,24 @@ EOF
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
@@ -6535,6 +6560,7 @@ echo "lzo support       $lzo"
 echo "snappy support    $snappy"
 echo "bzip2 support     $bzip2"
 echo "lzfse support     $lzfse"
+echo "zstd support      $zstd"
 echo "NUMA host support $numa"
 echo "libxml2           $libxml2"
 echo "tcmalloc support  $tcmalloc"
@@ -7102,6 +7128,10 @@ if test "$lzfse" =3D "yes" ; then
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
2.23.0


