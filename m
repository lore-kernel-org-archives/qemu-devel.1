Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33A7C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:52:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F5A52080C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I0YkHWWZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F5A52080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k82yI-0002bw-L0
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 10:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k82L4-0004eU-C0
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:11:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56524
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k82Kv-0007TH-Tr
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:11:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597759893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U0QPDbEQdkW4Bm5ZySZZzUjE9jYzwisvzs5oGyYKIiI=;
 b=I0YkHWWZx814TIMikfmvfGbyweUFzhticy2ipwFVrCmWYIPJxfjUSZqkLMT7KQjYz30BR6
 0S9jWFqBBJmYDpXMkKs41rfwzH+e/gHFmCUl7TYe8IcOHSqxiVKPmgrAE/XwuUvOezXYJS
 zQdactKYMgbmpK6Mr/hju2hxOpW2MFI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-yGOBIUV-N9KdPiQTnjf1EA-1; Tue, 18 Aug 2020 10:11:31 -0400
X-MC-Unique: yGOBIUV-N9KdPiQTnjf1EA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F71C186A573
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 14:11:30 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 00BA85D757;
 Tue, 18 Aug 2020 14:11:29 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 068/150] meson: convert chardev directory to Meson (emulator
 part)
Date: Tue, 18 Aug 2020 10:09:03 -0400
Message-Id: <20200818141025.21608-69-pbonzini@redhat.com>
In-Reply-To: <20200818141025.21608-1-pbonzini@redhat.com>
References: <20200818141025.21608-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 06:40:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.objs         |  2 --
 Makefile.target       |  2 ++
 chardev/Makefile.objs | 10 ----------
 chardev/meson.build   | 13 +++++++++++++
 configure             |  2 ++
 meson.build           | 14 ++++++++++++++
 6 files changed, 31 insertions(+), 12 deletions(-)
 delete mode 100644 chardev/Makefile.objs

diff --git a/Makefile.objs b/Makefile.objs
index eeaa0cfa82..e43526fe5f 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -87,8 +87,6 @@ common-obj-y += dma-helpers.o
 common-obj-$(CONFIG_TPM) += tpm.o
 
 common-obj-y += backends/
-common-obj-y += chardev/
-common-obj-m += chardev/
 
 common-obj-$(CONFIG_SECCOMP) += qemu-seccomp.o
 qemu-seccomp.o-cflags := $(SECCOMP_CFLAGS)
diff --git a/Makefile.target b/Makefile.target
index c0575da132..c8c4b70162 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -104,6 +104,7 @@ all: $(PROGS) stap
 	@true
 
 obj-y += $(LIBQEMU)
+
 obj-y += trace/
 
 #########################################################
@@ -167,6 +168,7 @@ LIBS := $(LIBS) @../block.syms @../qemu.syms
 ifneq ($(CONFIG_MODULES),y)
 LIBS := $(LIBS)
 endif
+LIBS := $(LIBS) $(BRLAPI_LIBS) $(SDL_LIBS) $(SPICE_LIBS)
 
 # Hardware support
 ifeq ($(TARGET_NAME), sparc64)
diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
deleted file mode 100644
index 6662d0df41..0000000000
--- a/chardev/Makefile.objs
+++ /dev/null
@@ -1,10 +0,0 @@
-chardev-obj-$(CONFIG_SOFTMMU) += chardev-sysemu.o
-common-obj-$(CONFIG_SOFTMMU) += msmouse.o wctablet.o testdev.o
-
-ifeq ($(CONFIG_BRLAPI),y)
-common-obj-m += baum.o
-baum.o-cflags := $(SDL_CFLAGS)
-baum.o-libs := $(BRLAPI_LIBS)
-endif
-
-common-obj-$(CONFIG_SPICE) += spice.o
diff --git a/chardev/meson.build b/chardev/meson.build
index a2e671ddfc..f79efaaf09 100644
--- a/chardev/meson.build
+++ b/chardev/meson.build
@@ -30,3 +30,16 @@ libchardev = static_library('chardev', chardev_ss.sources(),
                             build_by_default: false)
 
 chardev = declare_dependency(link_whole: libchardev)
+
+softmmu_ss.add(files('chardev-sysemu.c', 'msmouse.c', 'wctablet.c', 'testdev.c'))
+softmmu_ss.add(when: ['CONFIG_SPICE', spice], if_true: files('spice.c'))
+
+chardev_modules = {}
+
+if config_host.has_key('CONFIG_BRLAPI') and config_host.has_key('CONFIG_SDL')
+  module_ss = ss.source_set()
+  module_ss.add(when: [sdl, brlapi], if_true: files('baum.c'))
+  chardev_modules += { 'brlapi': module_ss }
+endif
+
+modules += { 'chardev': chardev_modules }
diff --git a/configure b/configure
index e47a3acc3a..9563f2a38f 100755
--- a/configure
+++ b/configure
@@ -7344,6 +7344,8 @@ if test "$zlib" != "no" ; then
 fi
 if test "$spice" = "yes" ; then
   echo "CONFIG_SPICE=y" >> $config_host_mak
+  echo "SPICE_CFLAGS=$spice_cflags" >> $config_host_mak
+  echo "SPICE_LIBS=$spice_libs" >> $config_host_mak
 fi
 
 if test "$smartcard" = "yes" ; then
diff --git a/meson.build b/meson.build
index 54d2a65fa4..7cb76884b0 100644
--- a/meson.build
+++ b/meson.build
@@ -144,6 +144,11 @@ if 'CONFIG_XKBCOMMON' in config_host
   xkbcommon = declare_dependency(compile_args: config_host['XKBCOMMON_CFLAGS'].split(),
                                  link_args: config_host['XKBCOMMON_LIBS'].split())
 endif
+spice = not_found
+if 'CONFIG_SPICE' in config_host
+  spice = declare_dependency(compile_args: config_host['SPICE_CFLAGS'].split(),
+                             link_args: config_host['SPICE_LIBS'].split())
+endif
 rt = cc.find_library('rt', required: false)
 libmpathpersist = not_found
 if config_host.has_key('CONFIG_MPATH')
@@ -178,6 +183,15 @@ libudev = not_found
 if 'CONFIG_LIBUDEV' in config_host
   libudev = declare_dependency(link_args: config_host['LIBUDEV_LIBS'].split())
 endif
+brlapi = not_found
+if 'CONFIG_BRLAPI' in config_host
+  brlapi = declare_dependency(link_args: config_host['BRLAPI_LIBS'].split())
+endif
+sdl = not_found
+if 'CONFIG_SDL' in config_host
+  sdl = declare_dependency(compile_args: config_host['SDL_CFLAGS'].split(),
+                           link_args: config_host['SDL_LIBS'].split())
+endif
 rbd = not_found
 if 'CONFIG_RBD' in config_host
   rbd = declare_dependency(link_args: config_host['RBD_LIBS'].split())
-- 
2.26.2



