Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C756C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:46:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F02BA20707
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=lse.epita.fr header.i=@lse.epita.fr header.b="O51UEbZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F02BA20707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lse.epita.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAtt5-0003Ug-9g
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 07:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <srs0=n7r+=ce=lse.epita.fr=cesar.belley@cri.epita.fr>)
 id 1kAtpL-0004h8-DK
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:42:51 -0400
Received: from gate-2.cri.epita.net ([163.5.55.20]:47916
 helo=mail-2.srv.cri.epita.fr)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <srs0=n7r+=ce=lse.epita.fr=cesar.belley@cri.epita.fr>)
 id 1kAtpJ-00085n-CX
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:42:51 -0400
Received: from MattGorko-Laptop.home
 (lfbn-idf1-1-1395-83.w90-79.abo.wanadoo.fr [90.79.87.83])
 (Authenticated sender: cesar.belley)
 by mail-2.srv.cri.epita.fr (Postfix) with ESMTPSA id 7C56D412DC;
 Wed, 26 Aug 2020 13:42:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lse.epita.fr; s=cri;
 t=1598442167; bh=pXjOhnz/ejL0oC4wPTqjtOBcoqXZnfCQ63MGA0Z0KNY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=O51UEbZAfp2KOm3cEuur0IvJ05gJ8P9QdiwK96P9NM3MMbINLDF6fGXrmD+iDoYtr
 +XatVnQOOxcISQScBg/3bqnHgSuSXnzm8X/Y7b1rTFJYt5aGYepnlhq2QJ6xPzA5Am
 vaDx3ML5MQT724wNpZahrwh5sQAaAxKgODCA7zm8=
From: =?UTF-8?q?C=C3=A9sar=20Belley?= <cesar.belley@lse.epita.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 07/12] meson: Add U2F key to meson
Date: Wed, 26 Aug 2020 13:42:04 +0200
Message-Id: <20200826114209.28821-8-cesar.belley@lse.epita.fr>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200826114209.28821-1-cesar.belley@lse.epita.fr>
References: <20200826114209.28821-1-cesar.belley@lse.epita.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=163.5.55.20;
 envelope-from=srs0=n7r+=ce=lse.epita.fr=cesar.belley@cri.epita.fr;
 helo=mail-2.srv.cri.epita.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 07:42:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?q?C=C3=A9sar=20Belley?= <cesar.belley@lse.epita.fr>,
 kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: César Belley <cesar.belley@lse.epita.fr>
---
 configure          | 8 +++++++-
 hw/usb/Kconfig     | 5 +++++
 hw/usb/meson.build | 7 +++++++
 meson.build        | 7 +++++++
 meson_options.txt  | 1 +
 5 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index b1e11397a8..24137d49d6 100755
--- a/configure
+++ b/configure
@@ -495,6 +495,7 @@ trace_file="trace"
 spice=""
 rbd=""
 smartcard=""
+u2f="auto"
 libusb=""
 usb_redir=""
 opengl=""
@@ -1411,6 +1412,10 @@ for opt do
   ;;
   --enable-smartcard) smartcard="yes"
   ;;
+  --disable-u2f) u2f="disabled"
+  ;;
+  --enable-u2f) u2f="enabled"
+  ;;
   --disable-libusb) libusb="no"
   ;;
   --enable-libusb) libusb="yes"
@@ -1940,6 +1945,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   libiscsi        iscsi support
   libnfs          nfs support
   smartcard       smartcard support (libcacard)
+  u2f             U2F support (u2f-emu)
   libusb          libusb (for usb passthrough)
   live-block-migration   Block migration in the main migration stream
   usb-redir       usb network redirection support
@@ -8230,7 +8236,7 @@ NINJA=$PWD/ninjatool $meson setup \
         -Db_coverage=$(if test "$gcov" = yes; then echo true; else echo false; fi) \
 	-Dsdl=$sdl -Dsdl_image=$sdl_image \
 	-Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
-	-Dgettext=$gettext -Dxkbcommon=$xkbcommon \
+	-Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f\
         $cross_arg \
         "$PWD" "$source_path"
 
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index 5e63dc75f8..3fc8fbe3c7 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -96,6 +96,11 @@ config USB_STORAGE_MTP
     default y
     depends on USB
 
+config USB_U2F
+    bool
+    default y
+    depends on USB
+
 config IMX_USBPHY
     bool
     default y
diff --git a/hw/usb/meson.build b/hw/usb/meson.build
index 3c44a1b069..a25109b88c 100644
--- a/hw/usb/meson.build
+++ b/hw/usb/meson.build
@@ -50,6 +50,13 @@ if config_host.has_key('CONFIG_SMARTCARD')
   hw_usb_modules += {'smartcard': usbsmartcard_ss}
 endif
 
+# U2F
+softmmu_ss.add(when: 'CONFIG_USB_U2F', if_true: files('u2f.c'))
+softmmu_ss.add(when: ['CONFIG_LINUX', 'CONFIG_USB_U2F'], if_true: files('u2f-passthru.c'))
+if u2f.found()
+  softmmu_ss.add(when: 'CONFIG_USB_U2F', if_true: [u2f, files('u2f-emulated.c')])
+endif
+
 # usb redirect
 if config_host.has_key('CONFIG_USB_REDIR')
   usbredir_ss = ss.source_set()
diff --git a/meson.build b/meson.build
index f0fe5f8799..ae90fdbfe3 100644
--- a/meson.build
+++ b/meson.build
@@ -360,6 +360,11 @@ if 'CONFIG_SMARTCARD' in config_host
   cacard = declare_dependency(compile_args: config_host['SMARTCARD_CFLAGS'].split(),
                               link_args: config_host['SMARTCARD_LIBS'].split())
 endif
+u2f = dependency('u2f-emu', required: get_option('u2f'), static: enable_static,
+                 include_type: 'system')
+if u2f.found()
+  u2f = declare_dependency(dependencies: u2f)
+endif
 usbredir = not_found
 if 'CONFIG_USB_REDIR' in config_host
   usbredir = declare_dependency(compile_args: config_host['USB_REDIR_CFLAGS'].split(),
@@ -385,6 +390,7 @@ endif
 
 config_host_data.set('CONFIG_SDL', sdl.found())
 config_host_data.set('CONFIG_SDL_IMAGE', sdl_image.found())
+config_host_data.set('CONFIG_U2F', u2f.found())
 config_host_data.set('CONFIG_VNC', vnc.found())
 config_host_data.set('CONFIG_VNC_JPEG', jpeg.found())
 config_host_data.set('CONFIG_VNC_PNG', png.found())
@@ -1365,6 +1371,7 @@ summary_info += {'spice support':     config_host.has_key('CONFIG_SPICE')}
 summary_info += {'rbd support':       config_host.has_key('CONFIG_RBD')}
 summary_info += {'xfsctl support':    config_host.has_key('CONFIG_XFS')}
 summary_info += {'smartcard support': config_host.has_key('CONFIG_SMARTCARD')}
+summary_info += {'U2F support':       u2f.found()}
 summary_info += {'libusb':            config_host.has_key('CONFIG_USB_LIBUSB')}
 summary_info += {'usb net redir':     config_host.has_key('CONFIG_USB_REDIR')}
 summary_info += {'OpenGL support':    config_host.has_key('CONFIG_OPENGL')}
diff --git a/meson_options.txt b/meson_options.txt
index c55f9cd94c..aef2de6523 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -1,6 +1,7 @@
 option('gettext', type : 'boolean', value : true)
 option('sdl', type : 'feature', value : 'auto')
 option('sdl_image', type : 'feature', value : 'auto')
+option('u2f', type : 'feature', value : 'auto')
 option('vnc', type : 'feature', value : 'enabled')
 option('vnc_jpeg', type : 'feature', value : 'auto')
 option('vnc_png', type : 'feature', value : 'auto')
-- 
2.28.0


