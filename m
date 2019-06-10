Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632B5C282DD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 11:19:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31A07207E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 11:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r0cLEwzG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A07207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44544 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haIKn-0001OI-Dp
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 07:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43084)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1haIGf-00078b-CP
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 07:15:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1haIGe-0000Zu-43
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 07:15:13 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37396)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1haIGd-0000YJ-Sz
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 07:15:12 -0400
Received: by mail-wr1-x441.google.com with SMTP id v14so8744140wrr.4
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 04:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=3rDTeC3Zw+Hw1sj7S+oSbSBKIxPHg3b0TKg/3EFDzXo=;
 b=r0cLEwzGba/WaEp6d0gFnLMaeVU60yjeIM61HpLGWV8O5b3QcLdXbmnC3aSm9Zsrdl
 VGDXS7h8lfwIo/MuSKFPbOeb1wYaLVF69LGlWKY+2KtmltJLBYXfl8XnCS15ti61qy4j
 25An/RU72JAU08Pg87uwDT/RZ7JzhgIWWLWSRG5AcqUoDruZGsjMDIGyqc6yc7yX7+on
 WOc9LtD3Xr3eoH/5Gmw1vAdhLd5I3aFpCpnYIT/10/04k4YPBhj5G1rg0HeOT5QWxTcX
 cydJk5unBb/Sw+gVV2WDetlLUkj/tqLbePm1Y3o23ohEtht9OY7er4Ml89Xuxd8OWabr
 gQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=3rDTeC3Zw+Hw1sj7S+oSbSBKIxPHg3b0TKg/3EFDzXo=;
 b=EC1x9kRtbTh36B9l9hM+cAfsYkzU57MR7q0/f/jRaUVZQkWcki8LmUajVXiXGAJ2RN
 UF2KdFQiqpKjxuywEwLDaHb5kZDGM4aM+PwhIOG8xXuOs1UkNe4arIxDjdGLyTenoy9d
 PLpUQWoddG4FwNGudn4+JX7rzS83J/24gwicHyhbzxbw7gdOQsm+lXvf483/LKok+eHS
 Yb+Tl9/fU3BqxlXWP6BaaNqAG/6On/P/3mKKX8AS5jkflTiCo2NEwaoqn4aQwLhH2uKJ
 /5WDn+SQCrJLubMKx9tCaQP7dYbIPAMHmvaqiK65Y5eLoAfcdRwfZMNdDlcaqbrJRrKI
 3IbA==
X-Gm-Message-State: APjAAAUKeCxoKX047W2Y1hH2qEU6qDW2qN1gA6HV3ypUud8LmqkRQI3y
 HMmaHnaKKJzWVj8lZR5gM+Ht+OE/
X-Google-Smtp-Source: APXvYqyX9e+xCRLViUCy/AIvH+iQQBxMG1iUQIPkEDNUR/H1qmPcJ/Xn7YN4H0B9s7+wmJLdeRy90g==
X-Received: by 2002:adf:e485:: with SMTP id i5mr8912317wrm.75.1560165310664;
 Mon, 10 Jun 2019 04:15:10 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id u13sm11934414wrq.62.2019.06.10.04.15.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Jun 2019 04:15:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 10 Jun 2019 13:15:00 +0200
Message-Id: <1560165301-39026-7-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1560165301-39026-1-git-send-email-pbonzini@redhat.com>
References: <1560165301-39026-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH 6/7] vhost-user-scsi: convert to Meson
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

The libiscsi pkg-config information is extracted from config-host.mak and
used to link vhost-user-blk.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitignore                            | 2 +-
 Makefile                              | 3 ---
 Makefile.objs                         | 3 ---
 contrib/vhost-user-scsi/Makefile.objs | 1 -
 contrib/vhost-user-scsi/meson.build   | 3 +++
 meson.build                           | 3 +++
 6 files changed, 7 insertions(+), 8 deletions(-)
 delete mode 100644 contrib/vhost-user-scsi/Makefile.objs
 create mode 100644 contrib/vhost-user-scsi/meson.build

diff --git a/.gitignore b/.gitignore
index 20637a1..3934eff 100644
--- a/.gitignore
+++ b/.gitignore
@@ -63,7 +63,7 @@
 /qemu-version.h.tmp
 /module_block.h
 /scsi/qemu-pr-helper
-/vhost-user-scsi
+/contrib/vhost-user-scsi/vhost-user-scsi
 /contrib/vhost-user-blk/vhost-user-blk
 /fsdev/virtfs-proxy-helper
 *.tmp
diff --git a/Makefile b/Makefile
index da290fa..bff097c 100644
--- a/Makefile
+++ b/Makefile
@@ -426,7 +426,6 @@ dummy := $(call unnest-vars,, \
                 ivshmem-client-obj-y \
                 ivshmem-server-obj-y \
                 rdmacm-mux-obj-y \
-                vhost-user-scsi-obj-y \
                 vhost-user-input-obj-y \
                 vhost-user-gpu-obj-y \
                 qga-vss-dll-obj-y \
@@ -629,8 +628,6 @@ ivshmem-client$(EXESUF): $(ivshmem-client-obj-y) $(COMMON_LDADDS)
 ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $^)
 endif
-vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y) contrib/libvhost-user/libvhost-user.a
-	$(call LINK, $^)
 
 rdmacm-mux$(EXESUF): LIBS += "-libumad"
 rdmacm-mux$(EXESUF): $(rdmacm-mux-obj-y) $(COMMON_LDADDS)
diff --git a/Makefile.objs b/Makefile.objs
index 644e2bd..adf2f92 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -116,9 +116,6 @@ qga-vss-dll-obj-y = qga/
 elf2dmp-obj-y = contrib/elf2dmp/
 ivshmem-client-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-client/
 ivshmem-server-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-server/
-vhost-user-scsi.o-cflags := $(LIBISCSI_CFLAGS)
-vhost-user-scsi.o-libs := $(LIBISCSI_LIBS)
-vhost-user-scsi-obj-y = contrib/vhost-user-scsi/
 rdmacm-mux-obj-y = contrib/rdmacm-mux/
 vhost-user-input-obj-y = contrib/vhost-user-input/
 vhost-user-gpu-obj-y = contrib/vhost-user-gpu/
diff --git a/contrib/vhost-user-scsi/Makefile.objs b/contrib/vhost-user-scsi/Makefile.objs
deleted file mode 100644
index e83a38a..0000000
--- a/contrib/vhost-user-scsi/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-vhost-user-scsi-obj-y = vhost-user-scsi.o
diff --git a/contrib/vhost-user-scsi/meson.build b/contrib/vhost-user-scsi/meson.build
new file mode 100644
index 0000000..b80398c
--- /dev/null
+++ b/contrib/vhost-user-scsi/meson.build
@@ -0,0 +1,3 @@
+executable('vhost-user-scsi', files('vhost-user-scsi.c'),
+           link_with: libvhost_user,
+           dependencies: [glib, libiscsi])
diff --git a/meson.build b/meson.build
index c4cad8f..bc7fbea 100644
--- a/meson.build
+++ b/meson.build
@@ -10,6 +10,9 @@ add_project_arguments(config_host['QEMU_INCLUDES'].split(),
 
 glib = declare_dependency(compile_args: config_host['GLIB_CFLAGS'].split(),
                           link_args: config_host['GLIB_LIBS'].split())
+libiscsi = declare_dependency(compile_args: config_host['LIBISCSI_CFLAGS'].split(),
+                          link_args: config_host['LIBISCSI_LIBS'].split())
 
 subdir('contrib/libvhost-user')
 subdir('contrib/vhost-user-blk')
+subdir('contrib/vhost-user-scsi')
-- 
1.8.3.1



