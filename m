Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0871C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:16:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FD67214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o7rlL/oN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD67214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVPM-0001M1-IG
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:16:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV4O-0006kW-UF
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV4N-0008Uh-P7
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:36 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50708)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV4N-0008T5-HA
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:35 -0500
Received: by mail-wm1-x342.google.com with SMTP id a5so3523674wmb.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fy8+EG63J25M05V/wVvQxun2CtWE4JAWf8OAbWpgUwQ=;
 b=o7rlL/oNnenSL3z2pKNpuqYb4853E95Wti5VNT3ea1ObGEVUkZ9Xzt1EVsZoZVhmze
 CvdiGai8BJDckdTMCOVhofKPuxpOFUsRBnO5R1Y17vnWxHX4SKLzd+chBaskq/MRN67T
 o/Pr+z0ahdEFWQpNvz6e/fqHN6uw+Hami3bL8Bi4jD57iS9prCya1UkxAl9idARKMuwO
 56c9xS4ZLpDsiuIYkktJI5QcUQt7IsKfJu/DMpCdSKMLKXOdSCcSz+z7Zdk4YLIRtnyB
 Qfx0mLHCXQQEktbtT4o4UIVSfwxLuIrqmvkDQLCxIF5SZTsKF/FJRstD36M4MM1cEFCW
 NHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=fy8+EG63J25M05V/wVvQxun2CtWE4JAWf8OAbWpgUwQ=;
 b=fvbI6kBm4E7d6/OQztADM13WBSp8AA64nVQ0fYH0YIJ6s40uVJcYJGXPjWJ37gKUeH
 7THLLGP7vbZ8Lz9NBPzAYSzSXPtikDzxmqLjt/JOJgxXkKmHJCCzMcMNgsJRMBykDIkF
 iNW0j43kM5Y8dSc7FSecr6qYlvblAF1UiD2cg2EdH/UZwUiTo4fnf48Yus/Net8Orve/
 RAVKQbJJSyTwFzRR0qd7UCiuyDsGkCNZcGfHla6veUG6UviuEfzznJ8uuWFtgskpSzPd
 LJQWEBz92Ul6dq8XiH4QMlAqtPfdRIiMRP3xn1skS2UF+dsQMEQc5YG+RTDh+ZItwnHC
 KBPA==
X-Gm-Message-State: APjAAAWVq2PR2yDZwF13a0rtkQO+WSQ4MlM5yrw47bxhBbRb3l3nxG/I
 8F/a8eYEOG3F8XzHTBgtMxHUlUeH
X-Google-Smtp-Source: APXvYqzjnygSzVMVVSvPE25Xkjly7m9EhRmJYAQWiqjlBHT3c5hVdqxgIHihr3D/vt/SCP6u61GCdg==
X-Received: by 2002:a1c:61c1:: with SMTP id v184mr6597280wmb.160.1580234073386; 
 Tue, 28 Jan 2020 09:54:33 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.54.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:54:32 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 019/142] contrib/rdmacm-mux: convert to Meson
Date: Tue, 28 Jan 2020 18:51:39 +0100
Message-Id: <20200128175342.9066-20-pbonzini@redhat.com>
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

We can use config-host.mak to decide whether the tool has to be built,
apart from that the conversion is straightforward.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                         | 5 -----
 Makefile.objs                    | 1 -
 contrib/rdmacm-mux/Makefile.objs | 3 ---
 contrib/rdmacm-mux/meson.build   | 6 ++++++
 meson.build                      | 2 ++
 5 files changed, 8 insertions(+), 9 deletions(-)
 delete mode 100644 contrib/rdmacm-mux/Makefile.objs
 create mode 100644 contrib/rdmacm-mux/meson.build

diff --git a/Makefile b/Makefile
index 2272d834cc..caafc07717 100644
--- a/Makefile
+++ b/Makefile
@@ -289,7 +289,6 @@ dummy := $(call unnest-vars,, \
                 elf2dmp-obj-y \
                 ivshmem-client-obj-y \
                 ivshmem-server-obj-y \
-                rdmacm-mux-obj-y \
                 vhost-user-input-obj-y \
                 vhost-user-gpu-obj-y \
                 qga-vss-dll-obj-y \
@@ -499,10 +498,6 @@ ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $^)
 endif
 
-rdmacm-mux$(EXESUF): LIBS += "-libumad"
-rdmacm-mux$(EXESUF): $(rdmacm-mux-obj-y) $(COMMON_LDADDS)
-	$(call LINK, $^)
-
 vhost-user-gpu$(EXESUF): $(vhost-user-gpu-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
 	$(call LINK, $^)
 
diff --git a/Makefile.objs b/Makefile.objs
index 02cee554ad..e62cbeba4a 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -108,7 +108,6 @@ qga-vss-dll-obj-y = qga/
 elf2dmp-obj-y = contrib/elf2dmp/
 ivshmem-client-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-client/
 ivshmem-server-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-server/
-rdmacm-mux-obj-y = contrib/rdmacm-mux/
 vhost-user-input-obj-y = contrib/vhost-user-input/
 vhost-user-gpu-obj-y = contrib/vhost-user-gpu/
 
diff --git a/contrib/rdmacm-mux/Makefile.objs b/contrib/rdmacm-mux/Makefile.objs
deleted file mode 100644
index 3df744af89..0000000000
--- a/contrib/rdmacm-mux/Makefile.objs
+++ /dev/null
@@ -1,3 +0,0 @@
-ifdef CONFIG_PVRDMA
-rdmacm-mux-obj-y = main.o
-endif
diff --git a/contrib/rdmacm-mux/meson.build b/contrib/rdmacm-mux/meson.build
new file mode 100644
index 0000000000..29a9ced472
--- /dev/null
+++ b/contrib/rdmacm-mux/meson.build
@@ -0,0 +1,6 @@
+if 'CONFIG_PVRDMA' in config_host
+  # if not found, CONFIG_PVRDMA should not be set
+  libumad = cc.find_library('ibumad', required: true)
+  executable('rdmacm-mux', files('main.c'),
+             dependencies: [glib, libumad])
+endif
diff --git a/meson.build b/meson.build
index fd5a7aa2e8..4a69aad677 100644
--- a/meson.build
+++ b/meson.build
@@ -196,6 +196,8 @@ qemuutil = declare_dependency(link_with: libqemuutil,
 # Other build targets
 
 if have_tools
+  subdir('contrib/rdmacm-mux')
+
   if 'CONFIG_VHOST_USER' in config_host
     subdir('contrib/libvhost-user')
     subdir('contrib/vhost-user-blk')
-- 
2.21.0



