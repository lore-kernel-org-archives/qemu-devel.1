Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F075AC2D0C0
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:53:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFC7D20716
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KpvlYOtg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFC7D20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihvIz-0004Xp-I5
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:53:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ihuyi-00017G-N5
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:32:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ihuyh-0005cD-Fv
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:32:28 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40893
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ihuyh-0005Xa-62
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:32:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YOh9YHEZJBhPYlgnaaZFcBlij8k8I6gf+3KGiXuLZWQ=;
 b=KpvlYOtgYG9HKuFGlQi0pD9K/vO7WH+ms9/p16fOX/DJYUcY4A7EB05PYVvX4Iidm0W9QG
 FPsW0Oe+YxiO+5yUcDUdXWQJwdKEyQ0+Wi+x4zyNI7DhtHUgDTQlGEx9+upuPkvqNHMHzs
 ngFpAcQ9+Jy6DNjkruBWIS2a7XVo4sg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-6AbODKUFMn66N9pmkgT2Zg-1; Thu, 19 Dec 2019 07:32:23 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 798EC1005513
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 12:32:22 +0000 (UTC)
Received: from localhost (ovpn-112-22.ams2.redhat.com [10.36.112.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D7084620DB;
 Thu, 19 Dec 2019 12:32:17 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 6/9] configure: add GDBUS_CODEGEN
Date: Thu, 19 Dec 2019 16:30:26 +0400
Message-Id: <20191219123029.200788-7-marcandre.lureau@redhat.com>
In-Reply-To: <20191219123029.200788-1-marcandre.lureau@redhat.com>
References: <20191219123029.200788-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 6AbODKUFMn66N9pmkgT2Zg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: berrange@redhat.com, quintela@redhat.com, mprivozn@redhat.com,
 dgilbert@redhat.com, pbonzini@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

gdbus-codegen generated code requires gio-unix on Unix, so add it to
GIO libs/cflags.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 configure | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configure b/configure
index 84b413dbfc..5610d9187f 100755
--- a/configure
+++ b/configure
@@ -3694,10 +3694,16 @@ if $pkg_config --atleast-version=3D$glib_req_ver gi=
o-2.0; then
     gio=3Dyes
     gio_cflags=3D$($pkg_config --cflags gio-2.0)
     gio_libs=3D$($pkg_config --libs gio-2.0)
+    gdbus_codegen=3D$($pkg_config --variable=3Dgdbus_codegen gio-2.0)
 else
     gio=3Dno
 fi
=20
+if $pkg_config --atleast-version=3D$glib_req_ver gio-unix-2.0; then
+    gio_cflags=3D"$gio_cflags $($pkg_config --cflags gio-unix-2.0)"
+    gio_libs=3D"$gio_libs $($pkg_config --libs gio-unix-2.0)"
+fi
+
 # Sanity check that the current size_t matches the
 # size that glib thinks it should be. This catches
 # problems on multi-arch where people try to build
@@ -6902,6 +6908,7 @@ if test "$gio" =3D "yes" ; then
     echo "CONFIG_GIO=3Dy" >> $config_host_mak
     echo "GIO_CFLAGS=3D$gio_cflags" >> $config_host_mak
     echo "GIO_LIBS=3D$gio_libs" >> $config_host_mak
+    echo "GDBUS_CODEGEN=3D$gdbus_codegen" >> $config_host_mak
 fi
 echo "CONFIG_TLS_PRIORITY=3D\"$tls_priority\"" >> $config_host_mak
 if test "$gnutls" =3D "yes" ; then
--=20
2.24.0.308.g228f53135a


