Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81924C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:58:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F72E20716
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WCiY7KuU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F72E20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihvO9-0003t4-4g
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:58:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihusC-0000kc-Ar
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihusA-00030G-Iv
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:43 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44251
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihus8-0002xr-MF
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t7UDH8pkl4r3jOup0r+QeLxo6bRKR2Bxv6cfZ6kMSKk=;
 b=WCiY7KuUg9Em+K4SBoA+w2qLn4cPk0PuE5nKmF7TDHnCD3XexiMbjUZM96Oq7/rb4Yyuoq
 2cyytYzG4ZfT3sOhRTLXOACRuTOFB+X4KXpDy6cIxrkyccFqHfNbRKPo9zwniEbgNO047o
 9Qvl58IYyh0yVZ9yUZSsIfViMGS38Ws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-qgR8pb5gPQaNywiR3xrQ5A-1; Thu, 19 Dec 2019 07:25:38 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA05D1005516
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 12:25:37 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-55.ams2.redhat.com
 [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4396460C18;
 Thu, 19 Dec 2019 12:25:35 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 128/132] meson: replace pc-bios/keymaps/Makefile
Date: Thu, 19 Dec 2019 13:23:48 +0100
Message-Id: <1576758232-12439-37-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: qgR8pb5gPQaNywiR3xrQ5A-1
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
 meson.build                 | 13 ++++---
 pc-bios/keymaps/Makefile    | 56 ---------------------------
 pc-bios/keymaps/meson.build | 94 +++++++++++++++++++++++++++--------------=
----
 3 files changed, 65 insertions(+), 98 deletions(-)
 delete mode 100644 pc-bios/keymaps/Makefile

diff --git a/meson.build b/meson.build
index 9a5b9d9..884aa6c 100644
--- a/meson.build
+++ b/meson.build
@@ -897,6 +897,14 @@ if 'CONFIG_GUEST_AGENT' in config_host
   subdir('qga')
 endif
=20
+# used for the update-keymaps target
+if xkbcommon.found()
+  qemu_keymap =3D executable('qemu-keymap', files('qemu-keymap.c', 'ui/inp=
ut-keymap.c'),
+                           dependencies: [qemuutil, xkbcommon], install: h=
ave_tools)
+else
+  qemu_keymap =3D disabler()
+endif
+
 if have_tools
   executable('qemu-img', [files('qemu-img.c'), hxdep], dependencies: [bloc=
k, qemuutil], install: true)
   if host_machine.system() =3D=3D 'linux' or host_machine.system() =3D=3D =
'sunos' or host_machine.system().endswith('bsd')
@@ -907,11 +915,6 @@ if have_tools
   subdir('contrib/rdmacm-mux')
   subdir('contrib/elf2dmp')
=20
-  if xkbcommon.found()
-    executable('qemu-keymap', files('qemu-keymap.c', 'ui/input-keymap.c'),
-               dependencies: [qemuutil, xkbcommon], install: true)
-  endif
-
   executable('qemu-edid', files('qemu-edid.c', 'hw/display/edid-generate.c=
'),
              dependencies: qemuutil)
=20
diff --git a/pc-bios/keymaps/Makefile b/pc-bios/keymaps/Makefile
deleted file mode 100644
index 76217b0..0000000
--- a/pc-bios/keymaps/Makefile
+++ /dev/null
@@ -1,56 +0,0 @@
-
-KEYMAP=09:=3D $(shell which qemu-keymap 2>/dev/null)
-
-MAPS=09:=3D ar bepo cz da de de-ch en-us en-gb es et fi fo \
-=09   fr fr-be fr-ca fr-ch \
-=09   hr hu is it ja lt lv mk nl no pl pt pt-br ru th tr
-
-ar=09: MAP_FLAGS :=3D=09-l ar
-bepo=09: MAP_FLAGS :=3D=09-l fr -v dvorak
-cz=09: MAP_FLAGS :=3D=09-l cz
-da=09: MAP_FLAGS :=3D=09-l dk
-de=09: MAP_FLAGS :=3D=09-l de -v nodeadkeys
-de-ch=09: MAP_FLAGS :=3D=09-l ch
-en-us=09: MAP_FLAGS :=3D=09-l us
-en-gb=09: MAP_FLAGS :=3D=09-l gb
-es=09: MAP_FLAGS :=3D=09-l es
-et=09: MAP_FLAGS :=3D=09-l et
-fi=09: MAP_FLAGS :=3D=09-l fi
-fo=09: MAP_FLAGS :=3D=09-l fo
-fr=09: MAP_FLAGS :=3D=09-l fr -v nodeadkeys
-fr-be=09: MAP_FLAGS :=3D=09-l be
-fr-ca=09: MAP_FLAGS :=3D=09-l ca -v fr
-fr-ch=09: MAP_FLAGS :=3D=09-l ch -v fr
-hr=09: MAP_FLAGS :=3D=09-l hr
-hu=09: MAP_FLAGS :=3D=09-l hu
-is=09: MAP_FLAGS :=3D=09-l is
-it=09: MAP_FLAGS :=3D=09-l it
-ja=09: MAP_FLAGS :=3D=09-l jp -m jp106
-lt=09: MAP_FLAGS :=3D=09-l lt
-lv=09: MAP_FLAGS :=3D=09-l lv
-mk=09: MAP_FLAGS :=3D=09-l mk
-nl=09: MAP_FLAGS :=3D=09-l nl
-no=09: MAP_FLAGS :=3D=09-l no
-pl=09: MAP_FLAGS :=3D=09-l pl
-pt=09: MAP_FLAGS :=3D=09-l pt
-pt-br=09: MAP_FLAGS :=3D=09-l br
-ru=09: MAP_FLAGS :=3D=09-l ru
-th=09: MAP_FLAGS :=3D=09-l th
-tr=09: MAP_FLAGS :=3D=09-l tr
-
-ifeq ($(KEYMAP),)
-
-all:
-=09@echo "nothing to do (qemu-keymap not found)"
-
-else
-
-all: $(MAPS)
-
-clean:
-=09rm -f $(MAPS)
-
-$(MAPS): $(KEYMAP) Makefile
-=09$(KEYMAP) -f $@ $(MAP_FLAGS)
-
-endif
diff --git a/pc-bios/keymaps/meson.build b/pc-bios/keymaps/meson.build
index 04c2a17..99cccd7 100644
--- a/pc-bios/keymaps/meson.build
+++ b/pc-bios/keymaps/meson.build
@@ -1,38 +1,58 @@
-keymaps =3D [
-  'ar',
-  'bepo',
-  'cz',
-  'da',
-  'de',
-  'de-ch',
-  'en-gb',
-  'en-us',
-  'es',
-  'et',
-  'fi',
-  'fo',
-  'fr',
-  'fr-be',
-  'fr-ca',
-  'fr-ch',
-  'hr',
-  'hu',
-  'is',
-  'it',
-  'ja',
-  'lt',
-  'lv',
-  'mk',
-  'nl',
-  'no',
-  'pl',
-  'pt',
-  'pt-br',
-  'ru',
-  'sl',
-  'sv',
-  'th',
-  'tr',
-]
+keymaps =3D {
+  'ar': '-l ar',
+  'bepo': '-l fr -v dvorak',
+  'cz': '-l cz',
+  'da': '-l dk',
+  'de': '-l de -v nodeadkeys',
+  'de-ch': '-l ch',
+  'en-gb': '-l us',
+  'en-us': '-l gb',
+  'es': '-l es',
+  'et': '-l et',
+  'fi': '-l fi',
+  'fo': '-l fo',
+  'fr': '-l fr -v nodeadkeys',
+  'fr-be': '-l be',
+  'fr-ca': '-l ca -v fr',
+  'fr-ch': '-l ch -v fr',
+  'hr': '-l hr',
+  'hu': '-l hu',
+  'is': '-l is',
+  'it': '-l it',
+  'ja': '-l jp -m jp106',
+  'lt': '-l lt',
+  'lv': '-l lv',
+  'mk': '-l mk',
+  'nl': '-l nl',
+  'no': '-l no',
+  'pl': '-l pl',
+  'pt': '-l pt',
+  'pt-br': '-l br',
+  'ru': '-l ru',
+  'sl': '',
+  'sv': '',
+  'th': '-l th',
+  'tr': '-l tr',
+}
=20
-install_data(keymaps, install_dir: config_host['qemu_datadir'] / 'keymaps'=
)
+install_data(keymaps.keys(), install_dir: config_host['qemu_datadir'] / 'k=
eymaps')
+
+if meson.is_cross_build()
+  native_qemu_keymap =3D find_program('qemu-keymap', required: false)
+  have_qemu_keymap =3D native_qemu_keymap.found()
+else
+  native_qemu_keymap =3D qemu_keymap
+  # disabler disables everything below
+  have_qemu_keymap =3D true
+endif
+if have_qemu_keymap
+  t =3D []
+  foreach km, args: keymaps
+    t +=3D custom_target(km,
+                       output: km,
+                       command: [qemu_keymap, '-f', '@OUTPUT@', args.split=
()])
+  endforeach
+  if t.length() > 0
+    alias_target('update-keymaps', t)
+  endif
+endif
--=20
1.8.3.1



