Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6D6C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:38:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D84A2173E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XTs3j3oI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D84A2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3liM-0006Ge-IO
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 15:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lP6-0006Kk-L7
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:18:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29144)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lP4-0006ZU-KH
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596741493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1agVZ10nKnAFLupkOl55CR0y1TkkENVqGmxO7cE97hg=;
 b=XTs3j3oI7yoFS3eGacQ3NDBQ0R/UmA+axCliXQYSozEnIoYWCITQOOyLiCpnsgUaDJUkb8
 8TwgUSw7bqHmzBsWVuI/rqGlIq4LjNqm+idTdNCRp9BFbqkPYo9tz1slGgZrhusHeFBpQz
 hNSK4e1Mc0d6R+uAWo33cWBf9RhTCcM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-t1y-23hZOa6cMQqAKfl1Fg-1; Thu, 06 Aug 2020 15:18:11 -0400
X-MC-Unique: t1y-23hZOa6cMQqAKfl1Fg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4790100AA22
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:18:10 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D459B1D3;
 Thu,  6 Aug 2020 19:18:09 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 062/143] meson: convert chardev directory to Meson (emulator
 part)
Date: Thu,  6 Aug 2020 21:14:58 +0200
Message-Id: <1596741379-12902-63-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 13:48:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
 chardev/meson.build   | 11 +++++++++++
 configure             |  2 ++
 meson.build           | 14 ++++++++++++++
 6 files changed, 29 insertions(+), 12 deletions(-)
 delete mode 100644 chardev/Makefile.objs

diff --git a/Makefile.objs b/Makefile.objs
index f79ff89..4c6631a 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -86,8 +86,6 @@ common-obj-y += dma-helpers.o
 common-obj-$(CONFIG_TPM) += tpm.o
 
 common-obj-y += backends/
-common-obj-y += chardev/
-common-obj-m += chardev/
 
 common-obj-$(CONFIG_SECCOMP) += qemu-seccomp.o
 qemu-seccomp.o-cflags := $(SECCOMP_CFLAGS)
diff --git a/Makefile.target b/Makefile.target
index c0575da..c8c4b70 100644
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
index 6662d0d..0000000
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
index a2e671d..2122505 100644
--- a/chardev/meson.build
+++ b/chardev/meson.build
@@ -30,3 +30,14 @@ libchardev = static_library('chardev', chardev_ss.sources(),
                             build_by_default: false)
 
 chardev = declare_dependency(link_whole: libchardev)
+
+softmmu_ss.add(files('chardev-sysemu.c', 'msmouse.c', 'wctablet.c', 'testdev.c'))
+softmmu_ss.add(when: ['CONFIG_SPICE', spice], if_true: files('spice.c'))
+
+chardev_modules = []
+
+if config_host.has_key('CONFIG_BRLAPI') and config_host.has_key('CONFIG_SDL')
+  chardev_modules += [['baum', files('baum.c'), [sdl, brlapi]]]
+endif
+
+modules += { 'chardev': chardev_modules }
diff --git a/configure b/configure
index f99b7ee..1b62959 100755
--- a/configure
+++ b/configure
@@ -7318,6 +7318,8 @@ if test "$zlib" != "no" ; then
 fi
 if test "$spice" = "yes" ; then
   echo "CONFIG_SPICE=y" >> $config_host_mak
+  echo "SPICE_CFLAGS=$spice_cflags" >> $config_host_mak
+  echo "SPICE_LIBS=$spice_libs" >> $config_host_mak
 fi
 
 if test "$smartcard" = "yes" ; then
diff --git a/meson.build b/meson.build
index 1743ae7..3daa82e 100644
--- a/meson.build
+++ b/meson.build
@@ -135,6 +135,11 @@ if 'CONFIG_XKBCOMMON' in config_host
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
@@ -164,6 +169,15 @@ libudev = not_found
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
1.8.3.1



