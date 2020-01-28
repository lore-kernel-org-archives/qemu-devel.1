Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6B4C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:07:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E25A214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzI0FXcu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E25A214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVGw-0007S6-Kr
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:07:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58102)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV4I-0006WJ-Ei
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV4H-0008Mk-99
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:30 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:32930)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV4H-0008Kk-2U
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:29 -0500
Received: by mail-wm1-x342.google.com with SMTP id m10so2318108wmc.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qSGNSZ4LLs8L913XxoD2kYp6B0ALh2tsPmhGXALrdSs=;
 b=OzI0FXcutbJ9y5lw59va4idbimLGg3tiNr06ZHGXYZA8CRtI77m3ZfWn6C8BeCqTtu
 Qm/G1XBqYJqlAtTh2oum6nPvp86uv75LGYbMk20xTssBqPpwMTGqxjd8YKSoVVeRmQdI
 S4YwZflasYzBdvkep5vukVNc2DR0x94Su08FZ4FadXykfGsJD/BS3QQBsrlG59OBxuMV
 vAjf7K6/wbkh3uWJPyOf8KGtJcH+Mr30gMGoSuuCfOx9rBROdEHn+b/ok2uAlOFpSsmf
 oxbdslWSEMzz4NUehWwBKwQiaGwhihCWMCeEjBKb9kRg8kogXGii05UEns0oOkzki5hM
 Ai1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=qSGNSZ4LLs8L913XxoD2kYp6B0ALh2tsPmhGXALrdSs=;
 b=gIuIZH3I3EBnOaqmSbPsno3F1gNd09z0Iv6Q/Xzj/2UWuXI0VxWMRmne8b/l0mFDqV
 wFkvST+K5NDMLAPEbBMIC1FkiapQCUctC/+EoC8FHCYj1BuRA+pkNKcn3ehqt5JwmfJ4
 tfnKUCHGSjXaCmUnvIW1JjmGovB8muayW/zj+S7o+QozuTu1skyyc+wBqWkzBwqPMCsA
 khlvqVtPZASPDX/DbndsPkXalUKDW7zfHxRAdZmtllKr3ln1ensFYIpP/Xufk6b61yZf
 0taPogx4YnhnHTzg7rRy2+z3AsyPVHeK82w4AWODivcQaWXyiW3tv34glrnnEHWxO4cX
 i9jQ==
X-Gm-Message-State: APjAAAUOZEsOh6vD5TIMK6KdCcYSXMgxSX9fAsfGLCCtFbsKR6zrx+cr
 HE/oX8Y/84vfUOUB99MmWLSe4WdF
X-Google-Smtp-Source: APXvYqwkG8E02rXpPH5nNw+h0xSxTuyfP0s+Erq8fHPbDN7zNX8t5VEb/uNQKhXMWi86syj2LcmMeA==
X-Received: by 2002:a7b:c152:: with SMTP id z18mr6233429wmi.70.1580234067863; 
 Tue, 28 Jan 2020 09:54:27 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.54.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:54:27 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 016/142] contrib/libvhost-user: convert to Meson
Date: Tue, 28 Jan 2020 18:51:36 +0100
Message-Id: <20200128175342.9066-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
index f9c3b73ba6..e09b20887c 100644
--- a/Makefile
+++ b/Makefile
@@ -290,7 +290,6 @@ dummy := $(call unnest-vars,, \
                 ivshmem-client-obj-y \
                 ivshmem-server-obj-y \
                 rdmacm-mux-obj-y \
-                libvhost-user-obj-y \
                 vhost-user-scsi-obj-y \
                 vhost-user-blk-obj-y \
                 vhost-user-input-obj-y \
@@ -405,11 +404,6 @@ $(BUILD_DIR)/version.o: $(SRC_PATH)/version.rc config-host.h
 
 Makefile: $(version-obj-y)
 
-######################################################################
-# Build libraries
-
-libvhost-user.a: $(libvhost-user-obj-y)
-
 ######################################################################
 
 COMMON_LDADDS = libqemuutil.a
@@ -506,21 +500,21 @@ ivshmem-client$(EXESUF): $(ivshmem-client-obj-y) $(COMMON_LDADDS)
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
index dc726b2131..9a14ef50fd 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -108,7 +108,6 @@ qga-vss-dll-obj-y = qga/
 elf2dmp-obj-y = contrib/elf2dmp/
 ivshmem-client-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-client/
 ivshmem-server-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-server/
-libvhost-user-obj-y = contrib/libvhost-user/
 vhost-user-scsi.o-cflags := $(LIBISCSI_CFLAGS)
 vhost-user-scsi.o-libs := $(LIBISCSI_LIBS)
 vhost-user-scsi-obj-y = contrib/vhost-user-scsi/
diff --git a/contrib/libvhost-user/Makefile.objs b/contrib/libvhost-user/Makefile.objs
deleted file mode 100644
index ef3778edd4..0000000000
--- a/contrib/libvhost-user/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-libvhost-user-obj-y += libvhost-user.o libvhost-user-glib.o
diff --git a/contrib/libvhost-user/meson.build b/contrib/libvhost-user/meson.build
new file mode 100644
index 0000000000..03ba2af071
--- /dev/null
+++ b/contrib/libvhost-user/meson.build
@@ -0,0 +1,2 @@
+libvhost_user = static_library('vhost-user',
+                               [files('libvhost-user.c', 'libvhost-user-glib.c')])
diff --git a/meson.build b/meson.build
index 94727e8dfb..6e5240c37e 100644
--- a/meson.build
+++ b/meson.build
@@ -187,3 +187,11 @@ libqemuutil = static_library('qemuutil',
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
2.21.0



