Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B117C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:15:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D439C214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZYTIlZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D439C214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVOA-0008D2-TJ
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:15:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV5f-0000Vp-SY
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV5e-00032Z-7o
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:55 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:40189)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV5e-00030R-12
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:54 -0500
Received: by mail-wm1-x334.google.com with SMTP id t14so3544581wmi.5
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CYKONMFARrcCkVvZNHZVDgh8vUwSygDif3NbrQDQoaQ=;
 b=NZYTIlZ3n0Bj3qDH91EHdYKzoElkrTWjMfS4ApdnSousFSdYXZ2HLMkXdlTnDTg67V
 uWZYnmsuLffKicRSlcDHYTAI3Wl4x+ZXBy5m3I9c0qplcPr+mkAEU4twz8gWvHqiKYIu
 RcAnzFhtjp5UjEYQ9ozXLBFhVl0LWKtXd8eUKKXATm9bJT4PkqXudTLF097HhL4eH3Fx
 bWkQ3aEZ3SDPQvX0hCyMOIrB0OFJpNAOtZmMcvjSc3pi+Tlr5HVBDBKrLkoPgRypWzEi
 4Bz/2H63UhLWlAYuXbRMG8h9vEaGl0eStRC5L3qVXaIWBV8L8aPq4VhkimwVLNWc0HhX
 M86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=CYKONMFARrcCkVvZNHZVDgh8vUwSygDif3NbrQDQoaQ=;
 b=pytjxk9bhMPCCWrNEgzvJ+alc1jsiZv1KKb3+LKS8Nenc2z8FvP+7hc1dO7WT4cpiq
 qmQptkZvWKjKVzOzXuHVRZuwwNCc470TkwGpqT7lLi8pQ5FLN5VGsgCU7LAeCsKv/9+i
 9Ywqgl7Uf6nBRelE6itxl+5J+6C+i5b3xsh9U0/GC97gAIsBrLWxEcu9ql2LCRPfsDBv
 UMi+1x13iwPIv+VE7ZouSuDTgOI7KxldcwzC1qFJx7B/lxT+sHjd69abUk5BvQBVzZsZ
 tMM2G3lYcvgJNrHGR41Ll9ahaVQ8Mk2t6cnVHjMzgUpVp77CLeR+edfy1/gfBmCvhAom
 j/NA==
X-Gm-Message-State: APjAAAXhvTiy7t9ALt7tO0Fxts/PDStKPxGEZXTWEEb4iDsdY+vqtsms
 o51OCpGe7kgibH0vAWsTIfJ4CNIX
X-Google-Smtp-Source: APXvYqwbUH0Fk6q7sBzgbyifiVsTPYzhPomCmGA+FVKxPGCGbJzyt9TUJ9bhyrfhYKfPFSt7hWzp4g==
X-Received: by 2002:a7b:c109:: with SMTP id w9mr6183046wmi.14.1580234152524;
 Tue, 28 Jan 2020 09:55:52 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.55.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:55:52 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 052/142] meson: convert chardev directory to Meson (emulator
 part)
Date: Tue, 28 Jan 2020 18:52:12 +0100
Message-Id: <20200128175342.9066-53-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.objs         |  1 -
 Makefile.target       |  2 ++
 chardev/Makefile.objs |  6 ------
 chardev/meson.build   |  4 ++++
 configure             |  2 ++
 meson.build           | 14 ++++++++++++++
 6 files changed, 22 insertions(+), 7 deletions(-)
 delete mode 100644 chardev/Makefile.objs

diff --git a/Makefile.objs b/Makefile.objs
index bad4cb450a..32822e3c7e 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -75,7 +75,6 @@ vl.o-cflags := $(GPROF_CFLAGS) $(SDL_CFLAGS)
 common-obj-$(CONFIG_TPM) += tpm.o
 
 common-obj-y += backends/
-common-obj-y += chardev/
 
 common-obj-$(CONFIG_SECCOMP) += qemu-seccomp.o
 qemu-seccomp.o-cflags := $(SECCOMP_CFLAGS)
diff --git a/Makefile.target b/Makefile.target
index 779a88bf8d..d98e956e42 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -104,6 +104,7 @@ all: $(PROGS) stap
 	@true
 
 obj-y += $(LIBQEMU)
+
 obj-y += trace/
 
 #########################################################
@@ -168,6 +169,7 @@ LIBS := $(LIBS) @../block.syms @../qemu.syms
 ifneq ($(CONFIG_MODULES),y)
 LIBS := $(LIBS)
 endif
+LIBS := $(LIBS) $(BRLAPI_LIBS) $(SDL_LIBS) $(SPICE_LIBS)
 
 # Hardware support
 ifeq ($(TARGET_NAME), sparc64)
diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
deleted file mode 100644
index 8049d82077..0000000000
--- a/chardev/Makefile.objs
+++ /dev/null
@@ -1,6 +0,0 @@
-common-obj-y += msmouse.o wctablet.o testdev.o
-common-obj-$(CONFIG_BRLAPI) += baum.o
-baum.o-cflags := $(SDL_CFLAGS)
-baum.o-libs := $(BRLAPI_LIBS)
-
-common-obj-$(CONFIG_SPICE) += spice.o
diff --git a/chardev/meson.build b/chardev/meson.build
index a2e671ddfc..6d5792cde6 100644
--- a/chardev/meson.build
+++ b/chardev/meson.build
@@ -30,3 +30,7 @@ libchardev = static_library('chardev', chardev_ss.sources(),
                             build_by_default: false)
 
 chardev = declare_dependency(link_whole: libchardev)
+
+softmmu_ss.add(files('msmouse.c', 'wctablet.c', 'testdev.c'))
+softmmu_ss.add(when: ['CONFIG_SDL', 'CONFIG_BRLAPI', sdl, brlapi], if_true: files('baum.c'))
+softmmu_ss.add(when: ['CONFIG_SPICE', spice], if_true: files('spice.c'))
diff --git a/configure b/configure
index a9919d5c58..1dd48e4f8b 100755
--- a/configure
+++ b/configure
@@ -7083,6 +7083,8 @@ if test "$zlib" != "no" ; then
 fi
 if test "$spice" = "yes" ; then
   echo "CONFIG_SPICE=y" >> $config_host_mak
+  echo "SPICE_CFLAGS=$spice_cflags" >> $config_host_mak
+  echo "SPICE_LIBS=$spice_libs" >> $config_host_mak
 fi
 
 if test "$smartcard" = "yes" ; then
diff --git a/meson.build b/meson.build
index d4f4ccbee7..4c42df980f 100644
--- a/meson.build
+++ b/meson.build
@@ -111,6 +111,11 @@ if 'CONFIG_XKBCOMMON' in config_host
   xkbcommon = declare_dependency(compile_args: config_host['XKBCOMMON_CFLAGS'].split(),
                                  link_args: config_host['XKBCOMMON_LIBS'].split())
 endif
+spice = declare_dependency()
+if 'CONFIG_SPICE' in config_host
+  spice = declare_dependency(compile_args: config_host['SPICE_CFLAGS'].split(),
+                             link_args: config_host['SPICE_LIBS'].split())
+endif
 rt = cc.find_library('rt', required: false)
 libmpathpersist = declare_dependency()
 if config_host.has_key('CONFIG_MPATH')
@@ -140,6 +145,15 @@ libudev = declare_dependency()
 if 'CONFIG_LIBUDEV' in config_host
   libudev = declare_dependency(link_args: config_host['LIBUDEV_LIBS'].split())
 endif
+brlapi = declare_dependency()
+if 'CONFIG_BRLAPI' in config_host
+  brlapi = declare_dependency(link_args: config_host['BRLAPI_LIBS'].split())
+endif
+sdl = declare_dependency()
+if 'CONFIG_SDL' in config_host
+  sdl = declare_dependency(compile_args: config_host['SDL_CFLAGS'].split(),
+                           link_args: config_host['SDL_LIBS'].split())
+endif
 rbd = declare_dependency()
 if 'CONFIG_RBD' in config_host
   rbd = declare_dependency(link_args: config_host['RBD_LIBS'].split())
-- 
2.21.0



