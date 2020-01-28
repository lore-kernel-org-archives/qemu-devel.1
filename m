Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F6FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:16:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1B612173E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdY8R8D+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1B612173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWLy-0007Ru-4x
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:16:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV8m-0005Nq-MA
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:59:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV8i-00023l-E7
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:59:08 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:33899)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV8i-00021S-66
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:59:04 -0500
Received: by mail-wr1-x429.google.com with SMTP id t2so17109399wrr.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yy7Gqzyx6u9o/r8rV9GQ4YuOte+CzgW2uJJPbO/yvXI=;
 b=qdY8R8D+TGjvfI2bJOeNjVDuhXnVmfpgZAKCrWGaRwB21s/5d/QOcKgZ1BhQRaVMzB
 7tHo3v1jj/V4+uZSd7aT38Lxq1tURyzpqXCt8noE4TcrRDGe+WHJ6C8BlbhW5K1KwRDZ
 iZOFDmjobVgVqm2FDVXtyGmFY3ct+0inK4XZ34O7BH+C4VfolmEWz71BEqzatx/58Oz3
 MoO9wsAPdnc5rUH3TjPG/aHjo1v4CFJnRe6T92IXFznYhZswoP45ZF5w9ChtRBBjJ/0g
 QN51mBG2Rbi9ztR1QZDnqElSE3+paDk2eaEheGJRcyoV4s/UxMtvQqcNosfHLRrLjYwk
 lCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=yy7Gqzyx6u9o/r8rV9GQ4YuOte+CzgW2uJJPbO/yvXI=;
 b=U4Nx0CzD+Tgu5tn/KFtujDxB4hOlIMgkqLGUxe2/q+biMmQEVhPCX+0INbE4+ttPa4
 gbedIHHuGF4aT3B3MeLTss9yah7lPPBWZ+drWCHHM8DYPBALKAXJcV/5oVY5WgHr9/Tq
 vXfm+sfLpubLeDZXaRLJhv0L82epiWAdeIDoqLnCCEojYpAzDQK+SFllGX/Nyq86E+ln
 kxLhnwG6eWOzY1n/8lcXYeBe+EeUtqA8rieGiDDZiw4r7Ez5Q8pfq5V+zj7U6PrhnK2y
 kZRk8sX/HxFv2abNMC2Zi2tWe9GpE8fy4ayL/Fax7oRfvSx6P0DQji8MgZUpZfdyaFOD
 g9uw==
X-Gm-Message-State: APjAAAUVGUMmctcJMUVBhPp7Bt6mlca5vvZQnC31gYnzYXA9qPW42kMw
 QvkNCbOSAgvk/l5ews40HwbwYNWF
X-Google-Smtp-Source: APXvYqxSsjAPH7SL9VUOd1glL6ml/ZLaXlI2PteulEMzkzDnUewWaEKDVEyQKL/FmTSAF42SXr9r9A==
X-Received: by 2002:a5d:5403:: with SMTP id g3mr31441757wrv.302.1580234342872; 
 Tue, 28 Jan 2020 09:59:02 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.59.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:59:02 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 133/142] meson: convert pc-bios/keymaps/Makefile
Date: Tue, 28 Jan 2020 18:53:33 +0100
Message-Id: <20200128175342.9066-134-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 Makefile                    | 14 +---------
 meson.build                 | 11 ++++----
 pc-bios/keymaps/Makefile    | 56 -------------------------------------
 pc-bios/keymaps/meson.build | 53 +++++++++++++++++++++++++++++++++++
 pc-bios/meson.build         |  1 +
 5 files changed, 61 insertions(+), 74 deletions(-)
 delete mode 100644 pc-bios/keymaps/Makefile
 create mode 100644 pc-bios/keymaps/meson.build

diff --git a/Makefile b/Makefile
index 474aaeb1a9..24bacf6e3a 100644
--- a/Makefile
+++ b/Makefile
@@ -214,14 +214,6 @@ distclean: clean
 	rm -Rf .sdk
 	if test -f dtc/version_gen.h; then $(MAKE) $(DTC_MAKE_ARGS) clean; fi
 
-KEYMAPS=da     en-gb  et  fr     fr-ch  is  lt  no  pt-br  sv \
-ar      de     en-us  fi  fr-be  hr     it  lv  nl         pl  ru     th \
-de-ch  es     fo  fr-ca  hu     ja  mk  pt  sl     tr \
-bepo    cz
-
-install-datadir:
-	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)"
-
 install-localstatedir:
 ifdef CONFIG_POSIX
 ifeq ($(CONFIG_GUEST_AGENT),y)
@@ -229,14 +221,10 @@ ifeq ($(CONFIG_GUEST_AGENT),y)
 endif
 endif
 
-install: all install-datadir install-localstatedir
+install: all install-localstatedir
 ifdef CONFIG_GTK
 	$(MAKE) -C po $@
 endif
-	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/keymaps"
-	set -e; for x in $(KEYMAPS); do \
-		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/keymaps/$$x "$(DESTDIR)$(qemu_datadir)/keymaps"; \
-	done
 
 # Add a dependency on the generated files, so that they are always
 # rebuilt before other object files
diff --git a/meson.build b/meson.build
index cd6e41b6d0..2d042017bf 100644
--- a/meson.build
+++ b/meson.build
@@ -919,6 +919,12 @@ if 'CONFIG_GUEST_AGENT' in config_host
   subdir('qga')
 endif
 
+if 'CONFIG_XKBCOMMON' in config_host
+  # used for the update-keymaps target, so include rules even if !have_tools
+  qemu_keymap = executable('qemu-keymap', files('qemu-keymap.c', 'ui/input-keymap.c'),
+                           dependencies: [qemuutil, xkbcommon], install: have_tools)
+endif
+
 if have_tools
   qemu_img = executable('qemu-img', [files('qemu-img.c'), hxdep],
              dependencies: [authz, block, crypto, io, qom, qemuutil], install: true)
@@ -932,11 +938,6 @@ if have_tools
   subdir('contrib/rdmacm-mux')
   subdir('contrib/elf2dmp')
 
-  if 'CONFIG_XKBCOMMON' in config_host
-    executable('qemu-keymap', files('qemu-keymap.c', 'ui/input-keymap.c'),
-               dependencies: [qemuutil, xkbcommon], install: true)
-  endif
-
   executable('qemu-edid', files('qemu-edid.c', 'hw/display/edid-generate.c'),
              dependencies: qemuutil)
 
diff --git a/pc-bios/keymaps/Makefile b/pc-bios/keymaps/Makefile
deleted file mode 100644
index 76217b0689..0000000000
--- a/pc-bios/keymaps/Makefile
+++ /dev/null
@@ -1,56 +0,0 @@
-
-KEYMAP	:= $(shell which qemu-keymap 2>/dev/null)
-
-MAPS	:= ar bepo cz da de de-ch en-us en-gb es et fi fo \
-	   fr fr-be fr-ca fr-ch \
-	   hr hu is it ja lt lv mk nl no pl pt pt-br ru th tr
-
-ar	: MAP_FLAGS :=	-l ar
-bepo	: MAP_FLAGS :=	-l fr -v dvorak
-cz	: MAP_FLAGS :=	-l cz
-da	: MAP_FLAGS :=	-l dk
-de	: MAP_FLAGS :=	-l de -v nodeadkeys
-de-ch	: MAP_FLAGS :=	-l ch
-en-us	: MAP_FLAGS :=	-l us
-en-gb	: MAP_FLAGS :=	-l gb
-es	: MAP_FLAGS :=	-l es
-et	: MAP_FLAGS :=	-l et
-fi	: MAP_FLAGS :=	-l fi
-fo	: MAP_FLAGS :=	-l fo
-fr	: MAP_FLAGS :=	-l fr -v nodeadkeys
-fr-be	: MAP_FLAGS :=	-l be
-fr-ca	: MAP_FLAGS :=	-l ca -v fr
-fr-ch	: MAP_FLAGS :=	-l ch -v fr
-hr	: MAP_FLAGS :=	-l hr
-hu	: MAP_FLAGS :=	-l hu
-is	: MAP_FLAGS :=	-l is
-it	: MAP_FLAGS :=	-l it
-ja	: MAP_FLAGS :=	-l jp -m jp106
-lt	: MAP_FLAGS :=	-l lt
-lv	: MAP_FLAGS :=	-l lv
-mk	: MAP_FLAGS :=	-l mk
-nl	: MAP_FLAGS :=	-l nl
-no	: MAP_FLAGS :=	-l no
-pl	: MAP_FLAGS :=	-l pl
-pt	: MAP_FLAGS :=	-l pt
-pt-br	: MAP_FLAGS :=	-l br
-ru	: MAP_FLAGS :=	-l ru
-th	: MAP_FLAGS :=	-l th
-tr	: MAP_FLAGS :=	-l tr
-
-ifeq ($(KEYMAP),)
-
-all:
-	@echo "nothing to do (qemu-keymap not found)"
-
-else
-
-all: $(MAPS)
-
-clean:
-	rm -f $(MAPS)
-
-$(MAPS): $(KEYMAP) Makefile
-	$(KEYMAP) -f $@ $(MAP_FLAGS)
-
-endif
diff --git a/pc-bios/keymaps/meson.build b/pc-bios/keymaps/meson.build
new file mode 100644
index 0000000000..d8438d4669
--- /dev/null
+++ b/pc-bios/keymaps/meson.build
@@ -0,0 +1,53 @@
+keymaps = {
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
+
+install_data(keymaps.keys(), install_dir: config_host['qemu_datadir'] / 'keymaps')
+
+if meson.is_cross_build() or 'CONFIG_XKBCOMMON' in config_host
+  native_qemu_keymap = find_program('qemu-keymap', required: false, disabler: true)
+else
+  native_qemu_keymap = qemu_keymap
+endif
+t = []
+foreach km, args: keymaps
+  t += custom_target(km,
+                     output: km,
+                     command: [native_qemu_keymap, '-f', '@OUTPUT@', args.split()])
+endforeach
+if t.length() > 0
+  alias_target('update-keymaps', t)
+endif
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index e53a7ae521..4d99511a5c 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -26,6 +26,7 @@ if 'DECOMPRESS_EDK2_BLOBS' in config_host
 endif
 
 subdir('descriptors')
+subdir('keymaps')
 
 blobs = files(
   'QEMU,cgthree.bin',
-- 
2.21.0



