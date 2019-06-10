Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF46C282DD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 11:27:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E844B206BB
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 11:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRBKkGjJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E844B206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44590 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haISm-0008Na-A7
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 07:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43071)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1haIGe-00076n-Dv
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 07:15:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1haIGd-0000YB-7m
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 07:15:12 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33345)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1haIGd-0000Wd-0w
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 07:15:11 -0400
Received: by mail-wr1-x442.google.com with SMTP id n9so8781901wru.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 04:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=1zrIFAijuNVbF8dO1b1lYHUT6C8Kbe7c2Cym046QUnE=;
 b=KRBKkGjJpU4QOt/jNdsDx/1OpdSgbquLUk5NWRAjZbcYRx5JDiU/9xLxCkYsaYoS5F
 1Y+gUcsCbx8Qzmio89GH9Mm8axSHrcpRYrcV968hP+Y4O8yx0si+Oz5oKDnyLLhtzjTr
 ql4HlOtj23wPBfpFfGEDfe6ZKxZNQ2+ueaHjhtnEwFCgzVMEXaIpms+uYXSdSxWX/qSP
 JPj7V99p0hV/IzfpAzHftcgP16zEUj3tOmy9r/SwIJw1bkfEGN+qZa+UdoAFrEHOrUDF
 zKenmemSXXgRBTbqiAhqEdjqbB6a2qEYQOpno1CIcu4IkXQ4S0H0bWMNzxczE1YT/Pfq
 Tzpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=1zrIFAijuNVbF8dO1b1lYHUT6C8Kbe7c2Cym046QUnE=;
 b=i5QkCthBOL0xvANdU2/SrKI3yGyHSVosMyE8U7IZW2Ol+mBjL7FCcNzo4OPc1eGhii
 7hNHpTODsCWVXScVkMjhVvGNTY9FgVKj1ULn1g+5iwoyx7m6oICciXVJQdqJwhuUFhCW
 5T0A5eMoUPO4kziR0EddFf7pR8dgAmgN1ipPMPB2/cYTRwEF1LXTupSM6yDLJV0vEP4i
 O3sM1unQsinFmHytqdcDdTh7Ccx8SAi7BBDDSx4sbdv/2IhvTGOYxXdKTy/YG51Q17SG
 ohYzB22AisEGK8chAci/lT2I+yj+PAydbglaxqvlBzGmOmuE94eooP31pkbLEuYvRi3+
 8/hA==
X-Gm-Message-State: APjAAAU3WJOgCFUBzNXAUT06Yyh0yWPh4AIpKvXVVUwx3hdD4UOx2yoU
 /e+mezttE9OcdOrDF4qWBZOYLLSG
X-Google-Smtp-Source: APXvYqy+YQrRf+Wis1OURi99yd2MqRz3ytwchKCxkxs7yS6q0rOe7mzAwKy4JOgRK0Ix5zgBCK2cdg==
X-Received: by 2002:adf:dd82:: with SMTP id x2mr7391025wrl.27.1560165309690;
 Mon, 10 Jun 2019 04:15:09 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id u13sm11934414wrq.62.2019.06.10.04.15.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Jun 2019 04:15:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 10 Jun 2019 13:14:59 +0200
Message-Id: <1560165301-39026-6-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1560165301-39026-1-git-send-email-pbonzini@redhat.com>
References: <1560165301-39026-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH 5/7] vhost-user-blk: convert to Meson
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

The GLib pkg-config information is extracted from config-host.mak and
used to link vhost-user-blk.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitignore                           | 2 +-
 Makefile                             | 3 ---
 Makefile.objs                        | 1 -
 configure                            | 2 ++
 contrib/vhost-user-blk/Makefile.objs | 1 -
 contrib/vhost-user-blk/meson.build   | 3 +++
 meson.build                          | 4 ++++
 7 files changed, 10 insertions(+), 6 deletions(-)
 delete mode 100644 contrib/vhost-user-blk/Makefile.objs
 create mode 100644 contrib/vhost-user-blk/meson.build

diff --git a/.gitignore b/.gitignore
index fd6e6c3..20637a1 100644
--- a/.gitignore
+++ b/.gitignore
@@ -64,7 +64,7 @@
 /module_block.h
 /scsi/qemu-pr-helper
 /vhost-user-scsi
-/vhost-user-blk
+/contrib/vhost-user-blk/vhost-user-blk
 /fsdev/virtfs-proxy-helper
 *.tmp
 *.[1-9]
diff --git a/Makefile b/Makefile
index 6a3461e..da290fa 100644
--- a/Makefile
+++ b/Makefile
@@ -427,7 +427,6 @@ dummy := $(call unnest-vars,, \
                 ivshmem-server-obj-y \
                 rdmacm-mux-obj-y \
                 vhost-user-scsi-obj-y \
-                vhost-user-blk-obj-y \
                 vhost-user-input-obj-y \
                 vhost-user-gpu-obj-y \
                 qga-vss-dll-obj-y \
@@ -632,8 +631,6 @@ ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
 endif
 vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y) contrib/libvhost-user/libvhost-user.a
 	$(call LINK, $^)
-vhost-user-blk$(EXESUF): $(vhost-user-blk-obj-y) contrib/libvhost-user/libvhost-user.a
-	$(call LINK, $^)
 
 rdmacm-mux$(EXESUF): LIBS += "-libumad"
 rdmacm-mux$(EXESUF): $(rdmacm-mux-obj-y) $(COMMON_LDADDS)
diff --git a/Makefile.objs b/Makefile.objs
index 4f2fa6a..644e2bd 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -119,7 +119,6 @@ ivshmem-server-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-server/
 vhost-user-scsi.o-cflags := $(LIBISCSI_CFLAGS)
 vhost-user-scsi.o-libs := $(LIBISCSI_LIBS)
 vhost-user-scsi-obj-y = contrib/vhost-user-scsi/
-vhost-user-blk-obj-y = contrib/vhost-user-blk/
 rdmacm-mux-obj-y = contrib/rdmacm-mux/
 vhost-user-input-obj-y = contrib/vhost-user-input/
 vhost-user-gpu-obj-y = contrib/vhost-user-gpu/
diff --git a/configure b/configure
index b8c3c58..f00a9e4 100755
--- a/configure
+++ b/configure
@@ -7364,6 +7364,8 @@ echo "CFLAGS_NOPIE=$CFLAGS_NOPIE" >> $config_host_mak
 echo "QEMU_CFLAGS=$QEMU_CFLAGS" >> $config_host_mak
 echo "QEMU_CXXFLAGS=$QEMU_CXXFLAGS" >> $config_host_mak
 echo "QEMU_INCLUDES=$QEMU_INCLUDES" >> $config_host_mak
+echo "GLIB_CFLAGS=$glib_cflags" >> $config_host_mak
+echo "GLIB_LIBS=$glib_libs" >> $config_host_mak
 if test "$sparse" = "yes" ; then
   echo "CC           := REAL_CC=\"\$(CC)\" cgcc"       >> $config_host_mak
   echo "CPP          := REAL_CC=\"\$(CPP)\" cgcc"      >> $config_host_mak
diff --git a/contrib/vhost-user-blk/Makefile.objs b/contrib/vhost-user-blk/Makefile.objs
deleted file mode 100644
index 72e2cdc..0000000
--- a/contrib/vhost-user-blk/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-vhost-user-blk-obj-y = vhost-user-blk.o
diff --git a/contrib/vhost-user-blk/meson.build b/contrib/vhost-user-blk/meson.build
new file mode 100644
index 0000000..6c00b3b
--- /dev/null
+++ b/contrib/vhost-user-blk/meson.build
@@ -0,0 +1,3 @@
+executable('vhost-user-blk', files('vhost-user-blk.c'),
+           link_with: libvhost_user,
+           dependencies: glib)
diff --git a/meson.build b/meson.build
index a6748f9..c4cad8f 100644
--- a/meson.build
+++ b/meson.build
@@ -8,4 +8,8 @@ add_project_arguments(config_host['QEMU_CFLAGS'].split(),
 add_project_arguments(config_host['QEMU_INCLUDES'].split(),
                       language: 'c')
 
+glib = declare_dependency(compile_args: config_host['GLIB_CFLAGS'].split(),
+                          link_args: config_host['GLIB_LIBS'].split())
+
 subdir('contrib/libvhost-user')
+subdir('contrib/vhost-user-blk')
-- 
1.8.3.1



