Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57C3C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:40:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81A01206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MdoOuEnt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A01206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihv61-0003Rb-8o
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:40:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36179)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihus0-0000ZZ-1R
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihury-0002cY-KD
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:31 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42517
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihury-0002Zk-Bz
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rmNe3X0ZzfVBU65K14+bGrtLyTJ6nq2ofJAD52vy/qI=;
 b=MdoOuEnt+jCA52WCDBLzU18iQOWj1OjmPWk+t9qLA9d1vqumGfFVnBMJ8nu2jgJWSJhUpK
 GoyKHHlCjRXXtssVc8EwqOkoM98xsVpossJXUJv4x8ZHuYX/M8fRVEEuiLZY8fZlMhH1eM
 iuGIX+FNIpvyZa8TDvAXIlb5Y5+3G7E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-k-bcG04cN0mhMN5zXF5LVQ-1; Thu, 19 Dec 2019 07:25:24 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6E6B800D48
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 12:25:23 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-55.ams2.redhat.com
 [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD07560C18;
 Thu, 19 Dec 2019 12:25:21 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 123/132] meson: install edk2 json descriptors
Date: Thu, 19 Dec 2019 13:23:43 +0100
Message-Id: <1576758232-12439-32-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: k-bcG04cN0mhMN5zXF5LVQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 Makefile                        | 17 -----------------
 pc-bios/descriptors/meson.build | 14 ++++++++++++++
 pc-bios/meson.build             |  2 ++
 3 files changed, 16 insertions(+), 17 deletions(-)
 create mode 100644 pc-bios/descriptors/meson.build

diff --git a/Makefile b/Makefile
index b88110b..22f9883 100644
--- a/Makefile
+++ b/Makefile
@@ -222,13 +222,6 @@ ar      de     en-us  fi  fr-be  hr     it  lv  nl    =
     pl  ru     th \
 de-ch  es     fo  fr-ca  hu     ja  mk  pt  sl     tr \
 bepo    cz
=20
-ifdef INSTALL_BLOBS
-DESCS=3D50-edk2-i386-secure.json 50-edk2-x86_64-secure.json \
-60-edk2-aarch64.json 60-edk2-arm.json 60-edk2-i386.json 60-edk2-x86_64.jso=
n
-else
-DESCS=3D
-endif
-
 install-datadir:
 =09$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)"
=20
@@ -249,16 +242,6 @@ ifneq ($(vhost-user-json-y),)
 =09=09$(INSTALL_DATA) $$x "$(DESTDIR)$(qemu_datadir)/vhost-user/"; \
 =09done
 endif
-ifneq ($(DESCS),)
-=09$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/firmware"
-=09set -e; tmpf=3D$$(mktemp); trap 'rm -f -- "$$tmpf"' EXIT; \
-=09for x in $(DESCS); do \
-=09=09sed -e 's,@DATADIR@,$(qemu_datadir),' \
-=09=09=09"$(SRC_PATH)/pc-bios/descriptors/$$x" > "$$tmpf"; \
-=09=09$(INSTALL_DATA) "$$tmpf" \
-=09=09=09"$(DESTDIR)$(qemu_datadir)/firmware/$$x"; \
-=09done
-endif
 =09for s in $(ICON_SIZES); do \
 =09=09mkdir -p "$(DESTDIR)$(qemu_icondir)/hicolor/$${s}/apps"; \
 =09=09$(INSTALL_DATA) $(SRC_PATH)/ui/icons/qemu_$${s}.png \
diff --git a/pc-bios/descriptors/meson.build b/pc-bios/descriptors/meson.bu=
ild
new file mode 100644
index 0000000..7c715ba
--- /dev/null
+++ b/pc-bios/descriptors/meson.build
@@ -0,0 +1,14 @@
+foreach f: [
+  '50-edk2-i386-secure.json',
+  '50-edk2-x86_64-secure.json',
+  '60-edk2-aarch64.json',
+  '60-edk2-arm.json',
+  '60-edk2-i386.json',
+  '60-edk2-x86_64.json'
+]
+  configure_file(input: files(f),
+                 output: f,
+                 configuration: {'DATADIR': config_host['qemu_datadir']},
+                 install: install_blobs,
+                 install_dir: config_host['qemu_datadir'] / 'firmware')
+endforeach
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index dc7de21..75475a6 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -24,6 +24,8 @@ foreach f: fds
                 install_dir: config_host['qemu_datadir'])
 endforeach
=20
+subdir('descriptors')
+
 blobs =3D files(
   'QEMU,cgthree.bin',
   'QEMU,tcx.bin',
--=20
1.8.3.1



