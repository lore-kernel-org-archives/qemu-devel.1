Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196DDC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:20:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8B7C21655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOFArsLO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B7C21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOOS-00027z-NC
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:20:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35988)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyY-0003o3-6I
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyW-00075T-0L
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:50 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43556)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyV-00073X-Nb
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:47 -0500
Received: by mail-wr1-x443.google.com with SMTP id d16so2589403wre.10
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lVeh8PO8pVqZlHDbL8a5E5ENf9bW2CKnWUTvgh5HKS8=;
 b=KOFArsLOEL6Ai2FcLlwn6jazasZcgAn8rzhdEdv1SGExiF6xGrlSzJclKdbarCdkOt
 r8G07Fj7f6gNr/pYUD0aLWwfSHTIZ3x0dclDFlkHn25iXEIEJvDlsMNOJ0Gm/v6tTtnw
 itEPXzlwfzCRBYgHeiAoe7ZeYZT4rANxKvbzTa60GMLX7d34kYcGcL2ngNbtlTqffzZi
 kPVrGQfqY+uomKY1jJ3eRRFWFbK6I2CrWelZLyuUKUFz4wNno3EcMy+7/HhDd5iAB/WF
 /CZ8IH3EESsgMiYymbTXdbP9YzCL7OjxFx4b/nPKiwufwbpjY8xxFg1hFSF5VXJhgYse
 ebzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=lVeh8PO8pVqZlHDbL8a5E5ENf9bW2CKnWUTvgh5HKS8=;
 b=J9Q7RtNIpTFDydmrNcqKHQ0vW3dSBmQEwMAB8/3mVdQy9fGCv8wmdBbNcEt/uQ3bUb
 wldyW8S7Vft/gi5B4q37tIw0bzM28mbvbzVArXw83PyQO7EPt9DoRrQGbEAEPz1Rl8c8
 7QCDrQOWNyhifOrJtzHWJmwraDqlZAYhxs9q0MQi4AznJmIasprTYRF1Rkwj8clRkSP+
 Qk4lliu5+6hKuIjVj0j4npqlnu4QXcXFbCPj37dsCjhrnnYl6hsj/dp7IxeVcFd6mUcx
 prYwrX+b2DUjHMB8kwi2VqfewCbRlNvM4xGWv2dIwK2wLE3QwaVJP2k/Ll4Nx8BTR7Bu
 SXig==
X-Gm-Message-State: APjAAAUheD6W0ng/60tHSXC/mrI2b2zFsPnxl1MpNEWF9LXgHDlZINEU
 cVYaeKRUI3HjSQ5rIssaX6gQYGyt
X-Google-Smtp-Source: APXvYqzVuS92cN8pkzV05XwcF8cmngdJ6X8VJH1DeJ+OUF0mrjTxLMv7F7+WCOTpENlSAJjkipvUPw==
X-Received: by 2002:a5d:494b:: with SMTP id r11mr6272372wrs.184.1576155226166; 
 Thu, 12 Dec 2019 04:53:46 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:45 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 048/132] meson: convert ui directory to Meson
Date: Thu, 12 Dec 2019 13:51:32 +0100
Message-Id: <1576155176-2464-49-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile         |  4 +--
 Makefile.objs    |  7 ++++--
 Makefile.target  |  7 +++---
 configure        |  6 +++++
 meson.build      | 50 +++++++++++++++++++++++++++++++++++++
 ui/Makefile.objs | 69 ---------------------------------------------------
 ui/meson.build   | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ui/shader.c      |  6 ++---
 8 files changed, 143 insertions(+), 81 deletions(-)
 delete mode 100644 ui/Makefile.objs

diff --git a/Makefile b/Makefile
index c4cfca9..5bdd400 100644
--- a/Makefile
+++ b/Makefile
@@ -135,9 +135,7 @@ ifneq ($(wildcard config-host.mak),)
 include $(SRC_PATH)/Makefile.objs
 endif
 
-dummy := $(call unnest-vars,, \
-                common-obj-y \
-                common-obj-m)
+dummy := $(call unnest-vars,, common-obj-y)
 
 include $(SRC_PATH)/tests/Makefile.include
 
diff --git a/Makefile.objs b/Makefile.objs
index cea6f9a..1319ba2 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -55,6 +55,11 @@ common-obj-$(CONFIG_AUDIO_OSS) += audio-oss$(DSOSUF)
 common-obj-$(CONFIG_AUDIO_PA) += audio-pa$(DSOSUF)
 common-obj-$(CONFIG_AUDIO_SDL) += audio-sdl$(DSOSUF)
 
+common-obj-$(if $(CONFIG_CURSES),m) += ui-curses$(DSOSUF)
+common-obj-$(if $(CONFIG_GTK),m) += ui-gtk$(DSOSUF)
+common-obj-$(if $(CONFIG_SDL),m) += ui-sdl$(DSOSUF)
+common-obj-$(if $(CONFIG_SPICE),m) += ui-spice-app$(DSOSUF)
+
 common-obj-$(if $(CONFIG_CURL),m) += block-curl$(DSOSUF)
 common-obj-$(if $(CONFIG_GLUSTERFS),m) += block-gluster$(DSOSUF)
 common-obj-$(if $(CONFIG_LIBISCSI),m) += block-iscsi$(DSOSUF)
@@ -69,8 +74,6 @@ common-obj-y += hw/
 
 common-obj-y += replay/
 
-common-obj-y += ui/
-common-obj-m += ui/
 common-obj-y += bt-host.o bt-vhci.o
 bt-host.o-cflags := $(BLUEZ_CFLAGS)
 
diff --git a/Makefile.target b/Makefile.target
index 65f1312..265b596 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -166,11 +166,11 @@ LIBS := $(libs_softmmu) $(LIBS)
 LIBS := $(LIBS) @../block.syms @../qemu.syms
 ifneq ($(CONFIG_MODULES),y)
 LIBS := $(LIBS) $(ALSA_LIBS) $(OSS_LIBS) $(PULSE_LIBS) $(SDL_LIBS)
+LIBS := $(LIBS) $(GTK_LIBS) $(VTE_LIBS) $(X11_LIBS) $(CURSES_LIBS) $(ICONV_LIBS) $(GIO_LIBS)
 endif
-LIBS := $(LIBS) $(BRLAPI_LIBS) $(SDL_LIBS) $(SPICE_LIBS)
+LIBS := $(LIBS) $(BRLAPI_LIBS) $(SDL_LIBS) $(SPICE_LIBS) $(OPENGL_LIBS)
 LIBS := $(LIBS) $(COREAUDIO_LIBS) $(DSOUND_LIBS)
 
-
 # Hardware support
 ifeq ($(TARGET_NAME), sparc64)
 obj-y += hw/sparc64/
@@ -194,8 +194,7 @@ dummy := $(call fix-paths,../,, \
               io-obj-y \
               qom-obj-y)
 dummy := $(call unnest-vars,.., \
-               common-obj-y \
-	       common-obj-m)
+               common-obj-y)
 all-obj-y += $(common-obj-y)
 all-obj-y += $(qom-obj-y)
 all-obj-$(CONFIG_SOFTMMU) += $(authz-obj-y)
diff --git a/configure b/configure
index 0be0735..a18fe24 100755
--- a/configure
+++ b/configure
@@ -6620,12 +6620,18 @@ fi
 if test "$vnc_sasl" = "yes" ; then
   echo "CONFIG_VNC_SASL=y" >> $config_host_mak
 fi
+echo "SASL_CFLAGS=$vnc_sasl_cflags" >> $config_host_mak
+echo "SASL_LIBS=$vnc_sasl_libs" >> $config_host_mak
 if test "$vnc_jpeg" = "yes" ; then
   echo "CONFIG_VNC_JPEG=y" >> $config_host_mak
 fi
+echo "JPEG_CFLAGS=$vnc_jpeg_cflags" >> $config_host_mak
+echo "JPEG_LIBS=$vnc_jpeg_libs" >> $config_host_mak
 if test "$vnc_png" = "yes" ; then
   echo "CONFIG_VNC_PNG=y" >> $config_host_mak
 fi
+echo "PNG_CFLAGS=$vnc_png_cflags" >> $config_host_mak
+echo "PNG_LIBS=$vnc_png_libs" >> $config_host_mak
 if test "$xfs" = "yes" ; then
   echo "CONFIG_XFS=y" >> $config_host_mak
 fi
diff --git a/meson.build b/meson.build
index 90a15ad..cb164e0 100644
--- a/meson.build
+++ b/meson.build
@@ -198,6 +198,56 @@ coreaudio = declare_dependency()
 if 'CONFIG_AUDIO_COREAUDIO' in config_host
   coreaudio = declare_dependency(link_args: config_host['COREAUDIO_LIBS'].split())
 endif
+opengl = declare_dependency()
+if 'CONFIG_OPENGL' in config_host
+  opengl = declare_dependency(link_args: config_host['OPENGL_LIBS'].split())
+else
+endif
+gtk = declare_dependency()
+if 'CONFIG_GTK' in config_host
+  gtk = declare_dependency(compile_args: config_host['GTK_CFLAGS'].split(),
+                              link_args: config_host['GTK_LIBS'].split())
+endif
+vte = declare_dependency()
+if 'CONFIG_VTE' in config_host
+  vte = declare_dependency(compile_args: config_host['VTE_CFLAGS'].split(),
+                           link_args: config_host['VTE_LIBS'].split())
+endif
+x11 = declare_dependency()
+if 'CONFIG_X11' in config_host
+  x11 = declare_dependency(compile_args: config_host['X11_CFLAGS'].split(),
+                           link_args: config_host['X11_LIBS'].split())
+endif
+curses = declare_dependency()
+if 'CONFIG_CURSES' in config_host
+  curses = declare_dependency(compile_args: config_host['CURSES_CFLAGS'].split(),
+                              link_args: config_host['CURSES_LIBS'].split())
+endif
+iconv = declare_dependency()
+if 'CONFIG_ICONV' in config_host
+  iconv = declare_dependency(compile_args: config_host['ICONV_CFLAGS'].split(),
+                             link_args: config_host['ICONV_LIBS'].split())
+endif
+gio = declare_dependency()
+if 'CONFIG_GIO' in config_host
+  gio = declare_dependency(compile_args: config_host['GIO_CFLAGS'].split(),
+                           link_args: config_host['GIO_LIBS'].split())
+endif
+png = declare_dependency()
+if 'CONFIG_VNC_PNG' in config_host
+  png = declare_dependency(compile_args: config_host['PNG_CFLAGS'].split(),
+                           link_args: config_host['PNG_LIBS'].split())
+endif
+jpeg = declare_dependency()
+if 'CONFIG_VNC_JPEG' in config_host
+  jpeg = declare_dependency(compile_args: config_host['JPEG_CFLAGS'].split(),
+                            link_args: config_host['JPEG_LIBS'].split())
+endif
+sasl = declare_dependency()
+if 'CONFIG_VNC_SASL' in config_host
+  sasl = declare_dependency(compile_args: config_host['SASL_CFLAGS'].split(),
+                            link_args: config_host['SASL_LIBS'].split())
+endif
 
 create_config = find_program('scripts/create_config')
 minikconf = find_program('scripts/minikconf.py')
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
deleted file mode 100644
index ba39080..0000000
--- a/ui/Makefile.objs
+++ /dev/null
@@ -1,69 +0,0 @@
-vnc-obj-y += vnc.o
-vnc-obj-y += vnc-enc-zlib.o vnc-enc-hextile.o
-vnc-obj-y += vnc-enc-tight.o vnc-palette.o
-vnc-obj-y += vnc-enc-zrle.o
-vnc-obj-y += vnc-auth-vencrypt.o
-vnc-obj-$(CONFIG_VNC_SASL) += vnc-auth-sasl.o
-vnc-obj-y += vnc-ws.o
-vnc-obj-y += vnc-jobs.o
-
-common-obj-y += keymaps.o console.o cursor.o qemu-pixman.o
-common-obj-y += input.o input-keymap.o input-legacy.o kbd-state.o
-common-obj-$(CONFIG_LINUX) += input-linux.o
-common-obj-$(CONFIG_SPICE) += spice-core.o spice-input.o spice-display.o
-common-obj-$(CONFIG_COCOA) += cocoa.o
-common-obj-$(CONFIG_VNC) += $(vnc-obj-y)
-common-obj-$(call lnot,$(CONFIG_VNC)) += vnc-stubs.o
-
-# ui-sdl module
-common-obj-$(CONFIG_SDL) += sdl.mo
-sdl.mo-objs := sdl2.o sdl2-input.o sdl2-2d.o
-ifeq ($(CONFIG_OPENGL),y)
-sdl.mo-objs += sdl2-gl.o
-endif
-sdl.mo-cflags := $(SDL_CFLAGS)
-sdl.mo-libs := $(SDL_LIBS)
-
-# ui-gtk module
-common-obj-$(CONFIG_GTK) += gtk.mo
-gtk.mo-objs := gtk.o
-gtk.mo-cflags := $(GTK_CFLAGS) $(VTE_CFLAGS)
-gtk.mo-libs := $(GTK_LIBS) $(VTE_LIBS)
-ifeq ($(CONFIG_OPENGL),y)
-gtk.mo-objs += gtk-egl.o
-gtk.mo-libs += $(OPENGL_LIBS)
-ifeq ($(CONFIG_GTK_GL),y)
-gtk.mo-objs += gtk-gl-area.o
-endif
-endif
-
-ifeq ($(CONFIG_X11),y)
-sdl.mo-objs += x_keymap.o
-gtk.mo-objs += x_keymap.o
-x_keymap.o-cflags := $(X11_CFLAGS)
-x_keymap.o-libs := $(X11_LIBS)
-endif
-
-common-obj-$(CONFIG_CURSES) += curses.mo
-curses.mo-objs := curses.o
-curses.mo-cflags := $(CURSES_CFLAGS) $(ICONV_CFLAGS)
-curses.mo-libs := $(CURSES_LIBS) $(ICONV_LIBS)
-
-ifeq ($(CONFIG_GIO)$(CONFIG_SPICE),yy)
-common-obj-$(if $(CONFIG_MODULES),m,y) += spice-app.mo
-endif
-spice-app.mo-objs := spice-app.o
-spice-app.mo-cflags := $(GIO_CFLAGS)
-spice-app.mo-libs := $(GIO_LIBS)
-
-common-obj-$(CONFIG_OPENGL) += shader.o
-common-obj-$(CONFIG_OPENGL) += console-gl.o
-common-obj-$(CONFIG_OPENGL) += egl-helpers.o
-common-obj-$(CONFIG_OPENGL) += egl-context.o
-common-obj-$(CONFIG_OPENGL_DMABUF) += egl-headless.o
-
-shader.o-libs += $(OPENGL_LIBS)
-console-gl.o-libs += $(OPENGL_LIBS)
-egl-helpers.o-libs += $(OPENGL_LIBS)
-egl-context.o-libs += $(OPENGL_LIBS)
-egl-headless.o-libs += $(OPENGL_LIBS)
diff --git a/ui/meson.build b/ui/meson.build
index 8157754..0867cdc 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -1,3 +1,76 @@
+softmmu_ss.add(files(
+  'console.c',
+  'cursor.c',
+  'input-keymap.c',
+  'input-legacy.c',
+  'input.c',
+  'kbd-state.c',
+  'keymaps.c',
+  'qemu-pixman.c',
+))
+softmmu_ss.add(pixman)
+
+softmmu_ss.add(when: 'CONFIG_LINUX', if_true: files('input-linux.c'))
+softmmu_ss.add(when: 'CONFIG_SPICE', if_true: files('spice-core.c', 'spice-input.c', 'spice-display.c'))
+softmmu_ss.add(when: [cocoa, 'CONFIG_COCOA'], if_true: files('cocoa.m'))
+
+vnc_ss = ss.source_set()
+vnc_ss.add(files(
+  'vnc.c',
+  'vnc-enc-zlib.c',
+  'vnc-enc-hextile.c',
+  'vnc-enc-tight.c',
+  'vnc-palette.c',
+  'vnc-enc-zrle.c',
+  'vnc-auth-vencrypt.c',
+  'vnc-ws.c',
+  'vnc-jobs.c',
+))
+vnc_ss.add(zlib)
+vnc_ss.add(when: 'CONFIG_VNC_SASL', if_true: [files('vnc-auth-sasl.c'), sasl])
+softmmu_ss.add_all(when: 'CONFIG_VNC', if_true: vnc_ss)
+softmmu_ss.add(when: 'CONFIG_VNC', if_false: files('vnc-stubs.c'))
+softmmu_ss.add(when: [opengl, 'CONFIG_OPENGL'], if_true: files('shader.c', 'console-gl.c', 'egl-helpers.c', 'egl-context.c'))
+softmmu_ss.add(when: [opengl, 'CONFIG_OPENGL_DMABUF'], if_true: files('egl-headless.c'))
+softmmu_ss.add(when: 'CONFIG_VNC_PNG', if_true: png)
+softmmu_ss.add(when: 'CONFIG_VNC_JPEG', if_true: jpeg)
+
+ui_modules = []
+
+if config_host.has_key('CONFIG_CURSES')
+  ui_modules += [['curses', files('curses.c'), [curses, iconv]]]
+endif
+
+if config_host.has_key('CONFIG_GTK') and config_host.has_key('CONFIG_VTE')
+  gtk_ss = ss.source_set()
+  gtk_ss.add(gtk, vte, files('gtk.c'))
+  gtk_ss.add(when: [x11, 'CONFIG_X11'], if_true: files('x_keymap.c'))
+  gtk_ss.add(when: [opengl, 'CONFIG_OPENGL'], if_true: files('gtk-egl.c'))
+  gtk_ss.add(when: [opengl, 'CONFIG_GTK_GL'], if_true: files('gtk-gl-area.c'))
+  gtk_ss = gtk_ss.apply(config_host, strict: false)
+  ui_modules += [['gtk', gtk_ss.sources(), gtk_ss.dependencies()]]
+endif
+
+if config_host.has_key('CONFIG_SDL')
+  sdl_ss = ss.source_set()
+  sdl_ss.add([sdl, pixman, glib], files(
+    'sdl2-2d.c',
+    'sdl2-input.c',
+    'sdl2.c',
+  ))
+  sdl_ss.add(when: [opengl, 'CONFIG_OPENGL'], if_true: files('sdl2-gl.c'))
+  sdl_ss.add(when: [x11, 'CONFIG_X11'], if_true: files('x_keymap.c'))
+  sdl_ss = sdl_ss.apply(config_host, strict: false)
+  ui_modules += [['sdl', sdl_ss.sources(), sdl_ss.dependencies()]]
+endif
+
+if config_host.has_key('CONFIG_SPICE') and config_host.has_key('CONFIG_GIO')
+  spice_ss = ss.source_set()
+  spice_ss.add(spice, gio, files('spice-app.c'))
+  spice_ss = spice_ss.apply(config_host, strict: false)
+  ui_modules += [['spice-app', spice_ss.sources(), spice_ss.dependencies()]]
+endif
+
 keymap_gen = find_program('keycodemapdb/tools/keymap-gen')
 
 keymaps = [
@@ -34,3 +107,5 @@ foreach e : keymaps
 endforeach
 
 subdir('shader')
+
+modules += {'ui': ui_modules}
diff --git a/ui/shader.c b/ui/shader.c
index d78829f..e8b8d32 100644
--- a/ui/shader.c
+++ b/ui/shader.c
@@ -27,9 +27,9 @@
 #include "qemu/osdep.h"
 #include "ui/shader.h"
 
-#include "shader/texture-blit-vert.h"
-#include "shader/texture-blit-flip-vert.h"
-#include "shader/texture-blit-frag.h"
+#include "ui/shader/texture-blit-vert.h"
+#include "ui/shader/texture-blit-flip-vert.h"
+#include "ui/shader/texture-blit-frag.h"
 
 struct QemuGLShader {
     GLint texture_blit_prog;
-- 
1.8.3.1



