Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1E6C33C9E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:17:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D2E12075A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="boeZ7RnJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D2E12075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioU87-0007cA-QJ
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 10:17:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45596)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ioTfR-0003qH-IS
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:47:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ioTfQ-0003Gx-D4
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:47:41 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59339
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ioTfQ-0003GI-93
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:47:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578322058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=76QUkWYOLa6ZTHBrJ+P7vEqVqCl6nodbEBjqoDX9400=;
 b=boeZ7RnJtuLp8SeULvxtKtVNWjP56w/oHLE/V5yyb0kEqpQaICsZGX5Ytc+7UXFJyTP2jH
 Ys9ioLGfrNKuPsgG6JnqSEKao+aotvDqT7LkBjMluClzYJ5oc3cxlY/83B8mu59GulCOOj
 MehzlKCdVrw9MHrz/XcU6Hj1SD4y6mw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-uIpFkNKWOpiLI7CROrPe5A-1; Mon, 06 Jan 2020 09:47:35 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9145492A7F5;
 Mon,  6 Jan 2020 14:47:34 +0000 (UTC)
Received: from localhost (ovpn-112-48.ams2.redhat.com [10.36.112.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE2ED7C3EA;
 Mon,  6 Jan 2020 14:47:30 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 6/9] configure: add GDBUS_CODEGEN
Date: Mon,  6 Jan 2020 18:46:19 +0400
Message-Id: <20200106144622.1520994-7-marcandre.lureau@redhat.com>
In-Reply-To: <20200106144622.1520994-1-marcandre.lureau@redhat.com>
References: <20200106144622.1520994-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: uIpFkNKWOpiLI7CROrPe5A-1
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
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
index 747d3b4120..0ce2c0354a 100755
--- a/configure
+++ b/configure
@@ -3701,10 +3701,16 @@ if $pkg_config --atleast-version=3D$glib_req_ver gi=
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
@@ -6904,6 +6910,7 @@ if test "$gio" =3D "yes" ; then
     echo "CONFIG_GIO=3Dy" >> $config_host_mak
     echo "GIO_CFLAGS=3D$gio_cflags" >> $config_host_mak
     echo "GIO_LIBS=3D$gio_libs" >> $config_host_mak
+    echo "GDBUS_CODEGEN=3D$gdbus_codegen" >> $config_host_mak
 fi
 echo "CONFIG_TLS_PRIORITY=3D\"$tls_priority\"" >> $config_host_mak
 if test "$gnutls" =3D "yes" ; then
--=20
2.25.0.rc1.1.gb0343b22ed


