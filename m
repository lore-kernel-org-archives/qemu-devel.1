Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437B5C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:53:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11EC220716
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B8zFn6/M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11EC220716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihvIy-0004Sr-M3
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:53:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35838)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihurw-0000Ui-RM
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihurv-0002PG-HT
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50286
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihurv-0002N6-B0
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Chk0PAaaVjz9FRUSm1XE8XtXZ4zZv3MPs/UVF4gbsq4=;
 b=B8zFn6/MnUaxY1AK0jqtLE/b1FzTVD0gk//GbMW4z9o8UvC1WmClm9Hu6vJWRR4M/cSa2i
 6AWzCLDr1zhbOyRQz4sBXL/Kq1mI3+ywFk4rO1wxkAGa20bSYgl8P37elITSBFbIIaN9u9
 m2TDPMw7/MrN8qOR1dOmFbiQLo3o224=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-3Qn_yAI8NuKjc-wEKQrVBg-1; Thu, 19 Dec 2019 07:25:20 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BCD8800D48
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 12:25:19 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-55.ams2.redhat.com
 [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E84660C18;
 Thu, 19 Dec 2019 12:25:18 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 121/132] meson: install edk2
Date: Thu, 19 Dec 2019 13:23:41 +0100
Message-Id: <1576758232-12439-30-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 3Qn_yAI8NuKjc-wEKQrVBg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 Makefile            | 7 -------
 pc-bios/meson.build | 8 ++++++--
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index d64e481..e961286 100644
--- a/Makefile
+++ b/Makefile
@@ -99,7 +99,6 @@ generated-files-y =3D config-host.h
=20
 generated-files-y +=3D .git-submodule-status
=20
-edk2-decompressed =3D $(basename $(wildcard pc-bios/edk2-*.fd.bz2))
 # Don't try to regenerate Makefile or configure
 # We don't generate any of them
 Makefile: ;
@@ -267,7 +266,6 @@ endif
 ICON_SIZES=3D16x16 24x24 32x32 48x48 64x64 128x128 256x256 512x512
=20
 install: all install-datadir install-localstatedir \
-=09$(if $(INSTALL_BLOBS),$(edk2-decompressed)) \
 =09recurse-install
 ifneq ($(vhost-user-json-y),)
 =09$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/vhost-user/"
@@ -280,11 +278,6 @@ ifneq ($(BLOBS),)
 =09=09$(INSTALL_DATA) $(SRC_PATH)/pc-bios/$$x "$(DESTDIR)$(qemu_datadir)";=
 \
 =09done
 endif
-ifdef INSTALL_BLOBS
-=09set -e; for x in $(edk2-decompressed); do \
-=09=09$(INSTALL_DATA) $$x "$(DESTDIR)$(qemu_datadir)"; \
-=09done
-endif
 ifneq ($(DESCS),)
 =09$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/firmware"
 =09set -e; tmpf=3D$$(mktemp); trap 'rm -f -- "$$tmpf"' EXIT; \
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index 5524b95..18201b0 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -11,11 +11,15 @@ fds =3D [
   'edk2-x86_64-secure-code.fd',
 ]
=20
-foreach f : fds
+install_blobs =3D 'INSTALL_BLOBS' in config_host
+
+foreach f: fds
   custom_target(f,
                 output: f,
                 input: '@0@.bz2'.format(f),
                 capture: true,
                 build_by_default: true,
-                command: [ bzip2, '-dc', '@INPUT0@' ])
+                command: [ bzip2, '-dc', '@INPUT0@' ],
+                install: install_blobs,
+                install_dir: config_host['qemu_datadir'])
 endforeach
--=20
1.8.3.1



