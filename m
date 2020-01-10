Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AA5C33CA2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 11:28:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE9962072E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 11:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SNL5n9ON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE9962072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipsSi-00070L-Sy
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 06:28:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ipsS7-0006ac-8x
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 06:27:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ipsS4-0000L1-Ar
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 06:27:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26109
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ipsS3-0000FD-Vn
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 06:27:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578655658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=E1PNe4XGS4NALUJ3FR71TuCVODSuM+zRPdHpdZ6tAqE=;
 b=SNL5n9ONAtUlAeiFBEY6zkI5JUmn8AArvGCKt9LeVpk4xuSLaDoygI1Lx09W4fwy0UDJmS
 fTy0GDHWcwjaHb0jCgPlMLlCNu3CiPyuiQLyoawBoCBxoyZbzGC/ZMbBKEvAeUHkUymAoz
 kpWnCUMeDIhGhD3corq5M3s1zP95YqE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-aO3ZOi1dNx-3Td8vP-LnOA-1; Fri, 10 Jan 2020 06:27:35 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 635FE10120A9;
 Fri, 10 Jan 2020 11:27:34 +0000 (UTC)
Received: from localhost (ovpn-112-24.ams2.redhat.com [10.36.112.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 392645DA32;
 Fri, 10 Jan 2020 11:27:29 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] configure: check for gdbus-codegen presence
Date: Fri, 10 Jan 2020 15:27:25 +0400
Message-Id: <20200110112725.689401-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: aO3ZOi1dNx-3Td8vP-LnOA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some distros ship gdbus-codegen separately for gio headers/pc...

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 configure | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configure b/configure
index 0ce2c0354a..28ee2a254f 100755
--- a/configure
+++ b/configure
@@ -3702,6 +3702,9 @@ if $pkg_config --atleast-version=3D$glib_req_ver gio-=
2.0; then
     gio_cflags=3D$($pkg_config --cflags gio-2.0)
     gio_libs=3D$($pkg_config --libs gio-2.0)
     gdbus_codegen=3D$($pkg_config --variable=3Dgdbus_codegen gio-2.0)
+    if [ ! -x "$gdbus_codegen" ]; then
+        gdbus_codegen=3D
+    fi
 else
     gio=3Dno
 fi
--=20
2.25.0.rc1.20.g2443f3f80d.dirty


