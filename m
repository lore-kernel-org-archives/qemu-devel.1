Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF92C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 08:15:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 589C820776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 08:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DeqyUOxz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589C820776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBZY3-0005KG-FI
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 04:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kBZRb-0000oU-2S
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 04:09:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33094
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kBZRT-0003Sd-Pq
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 04:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598602138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9roSgM66IiBIQZjYMh8WgmO1UZqEEROPpB96xe/qOl0=;
 b=DeqyUOxzlYLz9sApYf4fS1aXgZsriTPN9JnQSmMvXBovGabjRLhKFAeLLnpg7bDgqYs5hY
 ZitlX0Mrd9nEc7eIBQzkbPS69QkD6XHCmrADx6WiSxR+r/PDt9Qh+n/yCysJZIuDjuc2dF
 t5zBmdziNCKzpIWdDKMem3CwH06gnUM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-s1DfeJhiOg2tS8svtcAm0g-1; Fri, 28 Aug 2020 04:08:57 -0400
X-MC-Unique: s1DfeJhiOg2tS8svtcAm0g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14BAA425D3;
 Fri, 28 Aug 2020 08:08:56 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-54.ams2.redhat.com
 [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3126E5C1C2;
 Fri, 28 Aug 2020 08:08:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 539DE31E67; Fri, 28 Aug 2020 10:08:46 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/18] meson: Add U2F key to meson
Date: Fri, 28 Aug 2020 10:08:38 +0200
Message-Id: <20200828080845.28287-12-kraxel@redhat.com>
In-Reply-To: <20200828080845.28287-1-kraxel@redhat.com>
References: <20200828080845.28287-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 04:08:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
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
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure          | 8 +++++++-
 meson_options.txt  | 1 +
 hw/usb/Kconfig     | 5 +++++
 hw/usb/meson.build | 7 +++++++
 meson.build        | 7 +++++++
 5 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index b1e11397a827..24137d49d6f4 100755
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
index f0fe5f8799e0..ae90fdbfe306 100644
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
-- 
2.27.0


