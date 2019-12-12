Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745ACC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:29:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F2CD214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RP8wCAUD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2CD214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOX6-00070D-2U
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:29:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35351)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyU-0003jA-Tb
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyT-0006zm-HP
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:46 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:40438)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyT-0006yG-AT
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:45 -0500
Received: by mail-wr1-x42f.google.com with SMTP id c14so2607415wrn.7
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9eDDgoqkpWvForG2LVxwX8yK7HcFvrW/oDMlrRGAHTA=;
 b=RP8wCAUDaQ0h5YwEWp95SUzIc6KrO50v2jCGwb+GPtK6kK9uHqA0gfcIGG3JvhXxuc
 AVsjQ7EwAwAycsZsKWeydhhcdsrQdt72L0rMzvODymCFSyIyZnEjNWxVFLinuIR41zUz
 dxo3zfSVTT/dqIy80Fy2FVHCMfFaHtY23Qtc8bd8t0G1T77GmYxIPyb0j6lcsB/OKkSE
 WH2+f0pZjlo61jwqeZCbvtGFFHOqKNGSl3Ob7osi5T7THMxAoLoyoSFFq3fu9yfnBplN
 /U6WFV0XFQ9vyXJtGg8DDfn2giM+R2VNUyrTFrZUs74lQIXLEjpDx5ps2ShACsK0E39Y
 hbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=9eDDgoqkpWvForG2LVxwX8yK7HcFvrW/oDMlrRGAHTA=;
 b=LLMTTROLdKjt2RGGPX5LoSZV/bycKr8AVDuH1CLpE6HN7ai04L/SCZ+sc+bzok3FM4
 DavJqrin5wpVWcGzS+e/MP1tNpmTSeckLE57zJ8DIL3x94+H4xYVdXI0UD0hmua+uruH
 W+1ia65o9vigDbQY1pqPfp5afDngZxW4QO4E230W7NbHFnT5uEbahl6CntG9kFoaecmv
 Fx+JzU7Dl0YDTr3KxrcxG2GFrOUepvFDjDpYkkZG1K79pBtuXYMLtvgACQ7izuaryHev
 VEaCjd+6WNz8FNYTNX+ylIJr+LznpEGBQFbeTcn1AX2GDN65C9W56OunXLoZFilvzjgb
 U8VQ==
X-Gm-Message-State: APjAAAXMiwRb+QjmgpcEMic61uJW/lkLlYjpDpAA+438/hJb3ZLJyZPI
 DgHtogWk1bPoWA12Y4fMzg8awyjI
X-Google-Smtp-Source: APXvYqwdU55za3qQbKOoyFsIFer/2zLFX7MYDt17W4dyYaliw0VfpmguCxpqRNOzr3CZoDHibRLljQ==
X-Received: by 2002:adf:dfd2:: with SMTP id q18mr6166609wrn.152.1576155224122; 
 Thu, 12 Dec 2019 04:53:44 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:43 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 046/132] meson: convert chardev directory to Meson (emulator
 part)
Date: Thu, 12 Dec 2019 13:51:30 +0100
Message-Id: <1576155176-2464-47-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.objs         |  1 -
 Makefile.target       |  2 ++
 chardev/Makefile.objs |  6 ------
 chardev/meson.build   |  7 ++++++-
 configure             |  2 ++
 meson.build           | 14 ++++++++++++++
 6 files changed, 24 insertions(+), 8 deletions(-)
 delete mode 100644 chardev/Makefile.objs

diff --git a/Makefile.objs b/Makefile.objs
index 56d0c60..8d14390 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -76,7 +76,6 @@ vl.o-cflags := $(GPROF_CFLAGS) $(SDL_CFLAGS)
 common-obj-$(CONFIG_TPM) += tpm.o
 
 common-obj-y += backends/
-common-obj-y += chardev/
 
 common-obj-$(CONFIG_SECCOMP) += qemu-seccomp.o
 qemu-seccomp.o-cflags := $(SECCOMP_CFLAGS)
diff --git a/Makefile.target b/Makefile.target
index 1cb7bc2..702e6f8 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -104,6 +104,7 @@ all: $(PROGS) stap
 	@true
 
 obj-y += $(LIBQEMU)
+
 obj-y += trace/
 
 #########################################################
@@ -166,6 +167,7 @@ LIBS := $(LIBS) @../block.syms @../qemu.syms
 ifneq ($(CONFIG_MODULES),y)
 LIBS := $(LIBS)
 endif
+LIBS := $(LIBS) $(BRLAPI_LIBS) $(SDL_LIBS) $(SPICE_LIBS)
 
 # Hardware support
 ifeq ($(TARGET_NAME), sparc64)
diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
deleted file mode 100644
index 8049d82..0000000
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
index 18850b3..c4a2bb0 100644
--- a/chardev/meson.build
+++ b/chardev/meson.build
@@ -31,4 +31,9 @@ libchardev = static_library('chardev', chardev_ss.sources(),
                             name_suffix: 'fa',
                             build_by_default: false)
 
-chardev = declare_dependency(link_with: libchardev)
+chardev = declare_dependency(link_whole: libchardev)
+
+softmmu_ss.add(files('msmouse.c', 'wctablet.c', 'testdev.c'))
+softmmu_ss.add(when: ['CONFIG_SDL', 'CONFIG_BRLAPI', sdl, brlapi], if_true: files('baum.c'))
+softmmu_ss.add(when: ['CONFIG_SPICE', spice], if_true: files('spice.c'))
+softmmu_ss.add(chardev)
diff --git a/configure b/configure
index 658b062..9d33df3 100755
--- a/configure
+++ b/configure
@@ -6908,6 +6908,8 @@ if test "$zlib" != "no" ; then
 fi
 if test "$spice" = "yes" ; then
   echo "CONFIG_SPICE=y" >> $config_host_mak
+  echo "SPICE_CFLAGS=$spice_cflags" >> $config_host_mak
+  echo "SPICE_LIBS=$spice_libs" >> $config_host_mak
 fi
 
 if test "$smartcard" = "yes" ; then
diff --git a/meson.build b/meson.build
index b16ab72..df16b58 100644
--- a/meson.build
+++ b/meson.build
@@ -107,6 +107,11 @@ if 'CONFIG_LIBCAP_NG' in config_host
   libcap_ng = declare_dependency(link_args: config_host['LIBCAP_NG_LIBS'].split())
 endif
 xkbcommon = dependency('xkbcommon', required: false)
+spice = declare_dependency()
+if 'CONFIG_SPICE' in config_host
+  spice = declare_dependency(compile_args: config_host['SPICE_CFLAGS'].split(),
+                             link_args: config_host['SPICE_LIBS'].split())
+endif
 rt = cc.find_library('rt', required: false)
 libmpathpersist = declare_dependency()
 if config_host.has_key('CONFIG_MPATH')
@@ -136,6 +141,15 @@ libudev = declare_dependency()
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
1.8.3.1



