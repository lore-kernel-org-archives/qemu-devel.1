Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD80BC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 12:56:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7464C22527
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 12:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyFyFQoe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7464C22527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifO0m-0006ML-U5
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 07:56:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNxx-0002po-2O
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNxv-0005tq-JJ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:12 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39303)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNxv-0005sH-Bu
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:11 -0500
Received: by mail-wr1-x441.google.com with SMTP id y11so2611783wrt.6
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=rBx/jhpeemEhVPmqdIJ1QkUAPiG8kXc9Er3XvzBvw64=;
 b=MyFyFQoeNLQAflpSFNNljxQWJKLf+3N9PodvOu1G5c79X5Isst/TAUaqF2xERpsERo
 EytZteKBUAEQC8Ghwoox0pEgWZHbYmwLH6ftSI/C7jw1Fz/AgnvGaDlsCVjMdiTUFF1O
 aJAnmkp+3FK427HEUGkjWPARpMeQaHiYMS1cmmZaAg0etVjXAtx1WgNQ4vBKduGn3GmH
 h+qVyQ5anwpaSJH/H4+ltFtW0w6Rkb8qIqoSoSUOTotc7gm7VcqmB2s2h/SvpO+V+/dq
 jo7UwJKsuypt7GFK0nWW5rJDHRxqYtL3dUXOSJnezk7dsvHKNBPYbKTzgZz01+XGNd4H
 Q5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=rBx/jhpeemEhVPmqdIJ1QkUAPiG8kXc9Er3XvzBvw64=;
 b=sQn3uOlsIptu0jRiK4FLyaZ8IyMElNaui6FD2N3frckLuE9QVSGo3TRrX37t+ZuC/u
 jjwkbQsBVTgrP1HPY7a0f8RwAOwWyg27c3I40CdOqtNTKo1DpHKWakrATuSm4G3OjGni
 sk1dj+TISuN7sX5STLZY3u6jZBwWpGvtrCS6s0mZEmdbXQL+t55+CMrAeLcF5Jzl1B18
 zuOCD8Y/KZdpW4Kds9539Sl+IysW5Lzly3DuBTXW1vb+8MFv2VyOXvvBvJNWdDRai3sy
 xtJKUk0vDOthFKTk4xyogprASqUuceq0jpAO3vd/40cX4iqs6uIQA3BBU8GDYcVXE5bX
 E0nQ==
X-Gm-Message-State: APjAAAXXBDaBAaIrZt/PhaG/nYPZAVDEgk1WX7guZUl9IKPSkgoOF1ku
 iKcZ2yT9gPIES3i79tCYaSQVWaai
X-Google-Smtp-Source: APXvYqxGqjRrdNy+8RPukoOb8AIp8XsrBKufHHqRfDggHuXygpzxDvpY6Ay0fHB0xNSy3KumidkCsg==
X-Received: by 2002:adf:f288:: with SMTP id k8mr6535645wro.301.1576155190018; 
 Thu, 12 Dec 2019 04:53:10 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:09 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 012/132] contrib/libvhost-user: convert to Meson
Date: Thu, 12 Dec 2019 13:50:56 +0100
Message-Id: <1576155176-2464-13-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

Since libqemuutil.a has been converted to Meson, the conversion is
straightforward.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                            | 14 ++++----------
 Makefile.objs                       |  1 -
 contrib/libvhost-user/Makefile.objs |  1 -
 contrib/libvhost-user/meson.build   |  2 ++
 meson.build                         |  8 ++++++++
 5 files changed, 14 insertions(+), 12 deletions(-)
 delete mode 100644 contrib/libvhost-user/Makefile.objs
 create mode 100644 contrib/libvhost-user/meson.build

diff --git a/Makefile b/Makefile
index 97f9ffd..27e9ea3 100644
--- a/Makefile
+++ b/Makefile
@@ -267,7 +267,6 @@ dummy := $(call unnest-vars,, \
                 ivshmem-client-obj-y \
                 ivshmem-server-obj-y \
                 rdmacm-mux-obj-y \
-                libvhost-user-obj-y \
                 vhost-user-scsi-obj-y \
                 vhost-user-blk-obj-y \
                 vhost-user-input-obj-y \
@@ -377,11 +376,6 @@ $(BUILD_DIR)/version.o: $(SRC_PATH)/version.rc config-host.h
 Makefile: $(version-obj-y)
 
 ######################################################################
-# Build libraries
-
-libvhost-user.a: $(libvhost-user-obj-y)
-
-######################################################################
 
 COMMON_LDADDS = libqemuutil.a
 
@@ -471,21 +465,21 @@ ivshmem-client$(EXESUF): $(ivshmem-client-obj-y) $(COMMON_LDADDS)
 ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $^)
 endif
-vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y) libvhost-user.a $(COMMON_LDADDS)
+vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
 	$(call LINK, $^)
-vhost-user-blk$(EXESUF): $(vhost-user-blk-obj-y) libvhost-user.a $(COMMON_LDADDS)
+vhost-user-blk$(EXESUF): $(vhost-user-blk-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
 	$(call LINK, $^)
 
 rdmacm-mux$(EXESUF): LIBS += "-libumad"
 rdmacm-mux$(EXESUF): $(rdmacm-mux-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $^)
 
-vhost-user-gpu$(EXESUF): $(vhost-user-gpu-obj-y) $(libvhost-user-obj-y) $(COMMON_LDADDS)
+vhost-user-gpu$(EXESUF): $(vhost-user-gpu-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
 	$(call LINK, $^)
 
 ifdef CONFIG_VHOST_USER_INPUT
 ifdef CONFIG_LINUX
-vhost-user-input$(EXESUF): $(vhost-user-input-obj-y) libvhost-user.a $(COMMON_LDADDS)
+vhost-user-input$(EXESUF): $(vhost-user-input-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
 	$(call LINK, $^)
 
 # build by default, do not install
diff --git a/Makefile.objs b/Makefile.objs
index f820829..3142dbb 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -109,7 +109,6 @@ qga-vss-dll-obj-y = qga/
 elf2dmp-obj-y = contrib/elf2dmp/
 ivshmem-client-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-client/
 ivshmem-server-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-server/
-libvhost-user-obj-y = contrib/libvhost-user/
 vhost-user-scsi.o-cflags := $(LIBISCSI_CFLAGS)
 vhost-user-scsi.o-libs := $(LIBISCSI_LIBS)
 vhost-user-scsi-obj-y = contrib/vhost-user-scsi/
diff --git a/contrib/libvhost-user/Makefile.objs b/contrib/libvhost-user/Makefile.objs
deleted file mode 100644
index ef3778e..0000000
--- a/contrib/libvhost-user/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-libvhost-user-obj-y += libvhost-user.o libvhost-user-glib.o
diff --git a/contrib/libvhost-user/meson.build b/contrib/libvhost-user/meson.build
new file mode 100644
index 0000000..03ba2af
--- /dev/null
+++ b/contrib/libvhost-user/meson.build
@@ -0,0 +1,2 @@
+libvhost_user = static_library('vhost-user',
+                               [files('libvhost-user.c', 'libvhost-user-glib.c')])
diff --git a/meson.build b/meson.build
index ba4d891..6b9636d 100644
--- a/meson.build
+++ b/meson.build
@@ -185,3 +185,11 @@ libqemuutil = static_library('qemuutil',
                              dependencies: [util_ss.dependencies(), m, glib, socket])
 qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: version_res)
+
+# Other build targets
+
+if have_tools
+  if 'CONFIG_VHOST_USER' in config_host
+    subdir('contrib/libvhost-user')
+  endif
+endif
-- 
1.8.3.1



