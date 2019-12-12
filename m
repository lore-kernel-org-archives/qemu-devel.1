Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3383CC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:25:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00273206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vZ5Fjlr1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00273206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOTa-0001nE-Nb
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:25:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyQ-0003bP-08
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyO-0006ql-8a
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:41 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:38407)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyO-0006ot-1D
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:40 -0500
Received: by mail-wr1-x42b.google.com with SMTP id y17so2620534wrh.5
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pLbuKXWYLy4sq9L65tQenllcNQmXya4SSGFbhUfD1A8=;
 b=vZ5Fjlr1xnj+yD7AZ6kO42QbzN0/zovNHgJ53At7ms8RVWMebqRj5NoEZZuInqN50D
 LPpnipJDcWJ+dFHkdNEZOkcMTtgvKGrw8bJVkjx24mjNTSVzXF8lK6hKXsw44/V4lwXR
 t7Pd56+t5GYYdk7MxsL1BJN2S7pwFh0VRV8RykzRcl+sVfZtJZBtEGZFMo1Ltq0de3UP
 Y7qnl2iBi3Wul5tvoX+d5Mob3RGukam8vKpuN5BN1box2DDQSOXB6znHRa71n2ZVEX6U
 86kUv3Kzg4ZeNBYPIa5GKQ0cXjCDR/uMN0a2seMNosn3UKVqcPjWZ7z8S+IzPMALWof4
 SxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=pLbuKXWYLy4sq9L65tQenllcNQmXya4SSGFbhUfD1A8=;
 b=NF6vNLKcnyEV7bdDS1XvCbPq4DUtr0dAAlZsqdJ3iOz77j57z/s6SC2tNa4pIqgE77
 n7+AQlxqcQQd8Utx03vrO5ILnyVGW9s3IEVyzxqUnx1Vy3yfrpaejwPi9r4Wd51915P0
 47KECaKbo2+IAYkV1oKvnuakEKqMEyrwQU3tjGUsu9iVLbKHeLLmY3lu0+pL1GRP7nNx
 3NUJHclHTHN43qjcUtk3e2ojNGeRin9+NkVulMsECgzZo9Junz70hbY0s5TTZk20M1rp
 lj3YU3FMchMFvZ+PJc1WL/SMmH3wti1X/ErlR53gcnayS+gbo9rfxPk2AuycYkpds603
 E+jw==
X-Gm-Message-State: APjAAAXhddz+tX2ez2EJ/EIgPb2fG6bRdJaJz8i8nVcHG7Qr6WDdttb/
 zzmmeRzy66LgxHYcd/iY45VLl+AC
X-Google-Smtp-Source: APXvYqw7YtPpAUid7B7ivj5WEHS78FjJHyojW/gxt2r1Vq9VktTNpDnXXRSyGbh6w6kRBsFKvq/SuQ==
X-Received: by 2002:a5d:5704:: with SMTP id a4mr6168799wrv.198.1576155218843; 
 Thu, 12 Dec 2019 04:53:38 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 041/132] meson: convert chardev directory to Meson (tools part)
Date: Thu, 12 Dec 2019 13:51:25 +0100
Message-Id: <1576155176-2464-42-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
 Makefile              |  1 -
 Makefile.objs         |  6 ++----
 Makefile.target       |  2 +-
 chardev/Makefile.objs | 19 -------------------
 chardev/meson.build   | 34 ++++++++++++++++++++++++++++++++++
 meson.build           |  1 +
 6 files changed, 38 insertions(+), 25 deletions(-)
 create mode 100644 chardev/meson.build

diff --git a/Makefile b/Makefile
index c8c402a..42077ae 100644
--- a/Makefile
+++ b/Makefile
@@ -140,7 +140,6 @@ include $(SRC_PATH)/Makefile.objs
 endif
 
 dummy := $(call unnest-vars,, \
-                chardev-obj-y \
                 block-obj-y \
                 block-obj-m \
                 common-obj-y \
diff --git a/Makefile.objs b/Makefile.objs
index 75d4355c..39e1d41 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -1,8 +1,4 @@
 #######################################################################
-# chardev-obj-y is code used by both qemu system emulation and some tests
-chardev-obj-y = chardev/
-
-#######################################################################
 # block-obj-y is code used by both qemu system emulation and qemu-img
 
 block-obj-y = nbd/
@@ -19,6 +15,8 @@ block-obj-m = block/
 authz-obj-y = authz/libauthz.fa
 authz/libauthz.fa-libs = $(if $(CONFIG_AUTH_PAM),-lpam)
 
+chardev-obj-y = chardev/libchardev.fa
+
 crypto-obj-y = crypto/libcrypto.fa
 
 io-obj-y = io/libio.fa
diff --git a/Makefile.target b/Makefile.target
index a0eb332..95823da 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -184,13 +184,13 @@ all-obj-y := $(obj-y)
 include $(SRC_PATH)/Makefile.objs
 dummy := $(call fix-paths,../,, \
               authz-obj-y \
+              chardev-obj-y \
               crypto-obj-y \
               io-obj-y \
               qom-obj-y)
 dummy := $(call unnest-vars,.., \
                block-obj-y \
                block-obj-m \
-               chardev-obj-y \
                common-obj-y \
                common-obj-m)
 all-obj-y += $(common-obj-y)
diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
index d68e134..8049d82 100644
--- a/chardev/Makefile.objs
+++ b/chardev/Makefile.objs
@@ -1,22 +1,3 @@
-chardev-obj-y += char.o
-chardev-obj-$(CONFIG_WIN32) += char-console.o
-chardev-obj-$(CONFIG_POSIX) += char-fd.o
-chardev-obj-y += char-fe.o
-chardev-obj-y += char-file.o
-chardev-obj-y += char-io.o
-chardev-obj-y += char-mux.o
-chardev-obj-y += char-null.o
-chardev-obj-$(CONFIG_POSIX) += char-parallel.o
-chardev-obj-y += char-pipe.o
-chardev-obj-$(CONFIG_POSIX) += char-pty.o
-chardev-obj-y += char-ringbuf.o
-chardev-obj-y += char-serial.o
-chardev-obj-y += char-socket.o
-chardev-obj-y += char-stdio.o
-chardev-obj-y += char-udp.o
-chardev-obj-$(CONFIG_WIN32) += char-win.o
-chardev-obj-$(CONFIG_WIN32) += char-win-stdio.o
-
 common-obj-y += msmouse.o wctablet.o testdev.o
 common-obj-$(CONFIG_BRLAPI) += baum.o
 baum.o-cflags := $(SDL_CFLAGS)
diff --git a/chardev/meson.build b/chardev/meson.build
new file mode 100644
index 0000000..18850b3
--- /dev/null
+++ b/chardev/meson.build
@@ -0,0 +1,34 @@
+chardev_ss = ss.source_set()
+chardev_ss.add(files(
+  'char-fe.c',
+  'char-file.c',
+  'char-io.c',
+  'char-mux.c',
+  'char-null.c',
+  'char-pipe.c',
+  'char-ringbuf.c',
+  'char-serial.c',
+  'char-socket.c',
+  'char-stdio.c',
+  'char-udp.c',
+  'char.c',
+))
+chardev_ss.add(when: 'CONFIG_POSIX', if_true: files(
+  'char-fd.c',
+  'char-parallel.c',
+  'char-pty.c',
+))
+chardev_ss.add(when: 'CONFIG_WIN32', if_true: files(
+  'char-console.c',
+  'char-win-stdio.c',
+  'char-win.c',
+))
+
+chardev_ss = chardev_ss.apply(config_host, strict: false)
+libchardev = static_library('chardev', chardev_ss.sources(),
+                            dependencies: [crypto, io, qom],
+                            link_with: libqemuutil,
+                            name_suffix: 'fa',
+                            build_by_default: false)
+
+chardev = declare_dependency(link_with: libchardev)
diff --git a/meson.build b/meson.build
index 3c292c6..b5aa6a2 100644
--- a/meson.build
+++ b/meson.build
@@ -395,6 +395,7 @@ qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: version_res)
 
 subdir('io')
+subdir('chardev')
 subdir('fsdev')
 
 mods = []
-- 
1.8.3.1



