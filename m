Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D095C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 21:15:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 236F82072D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 21:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G6wtScrA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 236F82072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9ENj-0002Yp-Cz
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 17:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k9EMi-0001Gj-2T
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 17:14:24 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36381
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k9EMg-0003s0-0O
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 17:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598044460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Biq2wVaI/+BfzdZFvQSuroZkZ/fSdB8i4ZYt7R7Vj4Q=;
 b=G6wtScrATTfQ7uam6FHnzzAUE9D64JRgBVarcV2o9x8U9DFn1L9zbZtCK1Qd7IU25gqRzA
 xD+i81/rpOn/XqQKN2xM/+4AJfcdNBaHBuZUVw3PADO5mPr6c3/gu1AIWR7EGvloI20ft3
 z6lUjRr6DldX4Bmu85SHtormInl0hPc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-hMRnKLSROJSzCZhOrr88Jw-1; Fri, 21 Aug 2020 17:14:19 -0400
X-MC-Unique: hMRnKLSROJSzCZhOrr88Jw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C74081F02F
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 21:14:18 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC54B5C1D0;
 Fri, 21 Aug 2020 21:14:14 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/6] meson: convert pc-bios/keymaps/Makefile
Date: Fri, 21 Aug 2020 17:14:10 -0400
Message-Id: <20200821211412.17321-5-pbonzini@redhat.com>
In-Reply-To: <20200821211412.17321-1-pbonzini@redhat.com>
References: <20200821211412.17321-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 01:00:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Note that sl and sv keymaps were not created by qemu-keymap.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                    |  8 ------
 meson.build                 | 11 ++++----
 pc-bios/keymaps/.gitignore  |  1 +
 pc-bios/keymaps/Makefile    | 56 -------------------------------------
 pc-bios/keymaps/meson.build | 56 +++++++++++++++++++++++++++++++++++++
 pc-bios/meson.build         |  1 +
 ui/meson.build              |  2 +-
 7 files changed, 65 insertions(+), 70 deletions(-)
 create mode 100644 pc-bios/keymaps/.gitignore
 delete mode 100644 pc-bios/keymaps/Makefile
 create mode 100644 pc-bios/keymaps/meson.build

diff --git a/Makefile b/Makefile
index 8373ddccc9..ef28ce0361 100644
--- a/Makefile
+++ b/Makefile
@@ -229,11 +229,6 @@ distclean: clean ninja-distclean
 	rm -f linux-headers/asm
 	rm -Rf .sdk
 
-KEYMAPS=da     en-gb  et  fr     fr-ch  is  lt  no  pt-br  sv \
-ar      de     en-us  fi  fr-be  hr     it  lv  nl         pl  ru     th \
-de-ch  es     fo  fr-ca  hu     ja  mk  pt  sl     tr \
-bepo    cz
-
 ifdef INSTALL_BLOBS
 BLOBS=bios.bin bios-256k.bin bios-microvm.bin sgabios.bin vgabios.bin vgabios-cirrus.bin \
 vgabios-stdvga.bin vgabios-vmware.bin vgabios-qxl.bin vgabios-virtio.bin \
@@ -298,9 +293,6 @@ endif
 	$(INSTALL_DATA) $(SRC_PATH)/ui/qemu.desktop \
 		"$(DESTDIR)$(qemu_desktopdir)/qemu.desktop"
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/keymaps"
-	set -e; for x in $(KEYMAPS); do \
-		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/keymaps/$$x "$(DESTDIR)$(qemu_datadir)/keymaps"; \
-	done
 
 ifdef CONFIG_WIN32
 
diff --git a/meson.build b/meson.build
index 808f50b07e..dd8016c9da 100644
--- a/meson.build
+++ b/meson.build
@@ -1062,6 +1062,12 @@ if 'CONFIG_GUEST_AGENT' in config_host
   subdir('qga')
 endif
 
+if 'CONFIG_XKBCOMMON' in config_host
+  # used for the update-keymaps target, so include rules even if !have_tools
+  qemu_keymap = executable('qemu-keymap', files('qemu-keymap.c', 'ui/input-keymap.c') + genh,
+                           dependencies: [qemuutil, xkbcommon], install: have_tools)
+endif
+
 if have_tools
   qemu_img = executable('qemu-img', [files('qemu-img.c'), hxdep],
              dependencies: [authz, block, crypto, io, qom, qemuutil], install: true)
@@ -1078,11 +1084,6 @@ if have_tools
   subdir('contrib/rdmacm-mux')
   subdir('contrib/elf2dmp')
 
-  if 'CONFIG_XKBCOMMON' in config_host
-    executable('qemu-keymap', files('qemu-keymap.c', 'ui/input-keymap.c'),
-               dependencies: [qemuutil, xkbcommon], install: true)
-  endif
-
   executable('qemu-edid', files('qemu-edid.c', 'hw/display/edid-generate.c'),
              dependencies: qemuutil,
              install: true)
diff --git a/pc-bios/keymaps/.gitignore b/pc-bios/keymaps/.gitignore
new file mode 100644
index 0000000000..f90738f4dc
--- /dev/null
+++ b/pc-bios/keymaps/.gitignore
@@ -0,0 +1 @@
+/*.stamp
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
index 0000000000..b737c82230
--- /dev/null
+++ b/pc-bios/keymaps/meson.build
@@ -0,0 +1,56 @@
+keymaps = {
+  'ar': '-l ar',
+  'bepo': '-l fr -v dvorak',
+  'cz': '-l cz',
+  'da': '-l dk',
+  'de': '-l de -v nodeadkeys',
+  'de-ch': '-l ch',
+  'en-gb': '-l gb',
+  'en-us': '-l us',
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
+  'th': '-l th',
+  'tr': '-l tr',
+}
+
+if meson.is_cross_build() or 'CONFIG_XKBCOMMON' not in config_host
+  native_qemu_keymap = find_program('qemu-keymap', required: false, disabler: true)
+else
+  native_qemu_keymap = qemu_keymap
+endif
+t = []
+foreach km, args: keymaps
+  t += custom_target(km,
+                     build_by_default: true,
+                     output: km,
+                     command: [native_qemu_keymap, '-f', '@OUTPUT@', args.split()],
+                     install_dir: config_host['qemu_datadir'] / 'keymaps')
+endforeach
+if t.length() > 0
+  alias_target('update-keymaps', t)
+else
+  # install from the source tree
+  install_data(keymaps.keys(), install_dir: config_host['qemu_datadir'] / 'keymaps')
+endif
+
+install_data(['sl', 'sv'], install_dir: config_host['qemu_datadir'] / 'keymaps')
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index 6e3bfe3ca4..b6389f5148 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -25,3 +25,4 @@ if 'DECOMPRESS_EDK2_BLOBS' in config_host
 endif
 
 subdir('descriptors')
+subdir('keymaps')
diff --git a/ui/meson.build b/ui/meson.build
index 6f74d30ea0..81fd393432 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -95,7 +95,7 @@ keymaps = [
   ['osx', 'qcode'],
 ]
 
-if have_system
+if have_system or 'CONFIG_XKBCOMMON' in config_host
   foreach e : keymaps
     output = 'input-keymap-@0@-to-@1@.c.inc'.format(e[0], e[1])
     genh += custom_target(output,
-- 
2.26.2



