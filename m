Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8634C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 08:40:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADAF52073A
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 08:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AW/NP4dM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADAF52073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCfMn-0005Vo-S3
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 04:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kCfFf-0008LC-1N
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 04:33:19 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59985
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kCfFa-0006b6-1P
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 04:33:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598862793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hb6mji1t6o7RyM8/HLLvWch7l8WoCA0NUDV8RprI/SE=;
 b=AW/NP4dMldmUw4GqHnv5lEhEEWlj4cSPtA4bVGmbUdovx95ut4IzV9u11bFUtyd8MjH/VB
 hCUUlhHL83Aw3RiyMdiAgIeQ9p5ykD0R1sN0rNXSMp6nS7V5cvHh/7NH7c4tZHp6Y8ZGyQ
 4H3jiA1hH2RDaiZ0+u62rcW4IdLJi+g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-O1dQhoNoNmKXGVV9qUUnaQ-1; Mon, 31 Aug 2020 04:33:09 -0400
X-MC-Unique: O1dQhoNoNmKXGVV9qUUnaQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52C031007466;
 Mon, 31 Aug 2020 08:33:08 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-54.ams2.redhat.com
 [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DAD841002D59;
 Mon, 31 Aug 2020 08:33:06 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 57A4F31E88; Mon, 31 Aug 2020 10:33:02 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/18] meson: Add U2F key to meson
Date: Mon, 31 Aug 2020 10:32:54 +0200
Message-Id: <20200831083301.6357-12-kraxel@redhat.com>
In-Reply-To: <20200831083301.6357-1-kraxel@redhat.com>
References: <20200831083301.6357-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 03:06:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?C=C3=A9sar=20Belley?= <cesar.belley@lse.epita.fr>,
 Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: César Belley <cesar.belley@lse.epita.fr>

Signed-off-by: César Belley <cesar.belley@lse.epita.fr>
Message-id: 20200826114209.28821-8-cesar.belley@lse.epita.fr

[ fixes suggested by paolo ]

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure          | 8 +++++++-
 meson_options.txt  | 1 +
 hw/usb/Kconfig     | 5 +++++
 hw/usb/meson.build | 7 +++++++
 meson.build        | 7 +++++++
 5 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 6ecaff429b1b..8dc981684bb9 100755
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
@@ -1415,6 +1416,10 @@ for opt do
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
@@ -1945,6 +1950,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   libiscsi        iscsi support
   libnfs          nfs support
   smartcard       smartcard support (libcacard)
+  u2f             U2F support (u2f-emu)
   libusb          libusb (for usb passthrough)
   live-block-migration   Block migration in the main migration stream
   usb-redir       usb network redirection support
@@ -8229,7 +8235,7 @@ NINJA=${ninja:-$PWD/ninjatool} $meson setup \
         -Db_coverage=$(if test "$gcov" = yes; then echo true; else echo false; fi) \
 	-Dsdl=$sdl -Dsdl_image=$sdl_image \
 	-Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
-	-Dgettext=$gettext -Dxkbcommon=$xkbcommon \
+	-Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f\
         $cross_arg \
         "$PWD" "$source_path"
 
diff --git a/meson_options.txt b/meson_options.txt
index c55f9cd94cb2..aef2de652332 100644
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
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index 5e63dc75f815..3fc8fbe3c74c 100644
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
index 3c44a1b06954..a25109b88c91 100644
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
index 74f8ea0c2e11..1e7aee85e33a 100644
--- a/meson.build
+++ b/meson.build
@@ -377,6 +377,12 @@ if 'CONFIG_SMARTCARD' in config_host
   cacard = declare_dependency(compile_args: config_host['SMARTCARD_CFLAGS'].split(),
                               link_args: config_host['SMARTCARD_LIBS'].split())
 endif
+u2f = not_found
+if have_system
+  u2f = dependency('u2f-emu', required: get_option('u2f'),
+                   method: 'pkg-config',
+                   static: enable_static)
+endif
 usbredir = not_found
 if 'CONFIG_USB_REDIR' in config_host
   usbredir = declare_dependency(compile_args: config_host['USB_REDIR_CFLAGS'].split(),
@@ -1375,6 +1381,7 @@ summary_info += {'spice support':     config_host.has_key('CONFIG_SPICE')}
 summary_info += {'rbd support':       config_host.has_key('CONFIG_RBD')}
 summary_info += {'xfsctl support':    config_host.has_key('CONFIG_XFS')}
 summary_info += {'smartcard support': config_host.has_key('CONFIG_SMARTCARD')}
+summary_info += {'U2F support':       u2f.found()}
 summary_info += {'libusb':            config_host.has_key('CONFIG_USB_LIBUSB')}
 summary_info += {'usb net redir':     config_host.has_key('CONFIG_USB_REDIR')}
 summary_info += {'OpenGL support':    config_host.has_key('CONFIG_OPENGL')}
-- 
2.27.0


