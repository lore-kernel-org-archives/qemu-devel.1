Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B1BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:19:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81DF4214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XM89IHd3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81DF4214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVSJ-0005R6-P9
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:19:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58200)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV4Q-0006od-Nc
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV4P-00005w-Gu
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:38 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:41167)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV4P-0008WM-9r
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:37 -0500
Received: by mail-wr1-x434.google.com with SMTP id c9so17100040wrw.8
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=n2jjZv/18hMmnXczKdeuYIeeEaQrafKZQf5x+OTNNlY=;
 b=XM89IHd3/HDJxq5d1en0xVuE4B9a1Te3T2yn467w6jq9bLY4sVap+hcONcl/H1vXy/
 V/sJ3qjvTYZBlEPcHF0iNSyIoYPIjwU11MZbCtazC03NfYRC3o3YkV/43BMg95Yt/hQp
 r0oth3JtkZBQyoTyTO13C3EEaUR62CjaV0rz7XfcMi68HCDwXGOIbys8KzpooT0M7Vvl
 u6bWMdWWgxG5DKbUimEeVanzqyfT3vRuWcDlMZizT1IQxRRUiQUgyOCSFq0L+lOJC332
 DZVJCu7WR5zRedgrTpAA//81pYvKklSksfUg3Qcv/oB5hXvDqdHBdHunFLIx5Hg/fK9i
 na3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=n2jjZv/18hMmnXczKdeuYIeeEaQrafKZQf5x+OTNNlY=;
 b=U7g+ri/wZj9tM3FySvztrk7maW6+Ia1Wa4J3RTajo2BYLGo1i1PSoGpgySSY1uGuQW
 I5H7K0c88t1Ob/16BDKMrxf/fiJRqfruNN+A1bqueJ3I61RSpYwwzLgAygY6vt1+G8Wx
 5msah2y4nE30IIzFMp/Ji99k6QD/iNV9XiL9xfqX+ps4LE/exI7UCxv5ZNDoEBGr0JZf
 ymfBhfGRCGWWai2+mcjywKyasUJwlAmiiKIKPa1w5I/FTFhaONmF9usKTb0VovEvvWok
 1oqGbOrsu97mpDvVO/caklhr1mX3YymAkJETMrHy+puWxSOS42leMnlAFKFWoD1Blwbe
 zBUQ==
X-Gm-Message-State: APjAAAXLRZ+IFzGgRmDP7MSkVBC6hNR4xDf+/km0IdWjTqqB/fbxfphS
 T3uAtlIlBWEBT1s4IuQ0nAfd+JSz
X-Google-Smtp-Source: APXvYqwiGq6fxmiFXkUd05FWBcZtW8R8XX6kpvGpWsBtxaDWHhxx3uP+1LR5/qf5dSjFHXOcmSYJUw==
X-Received: by 2002:adf:e8ca:: with SMTP id k10mr28082149wrn.50.1580234076099; 
 Tue, 28 Jan 2020 09:54:36 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.54.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:54:35 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 020/142] contrib/vhost-user-input: convert to meson
Date: Tue, 28 Jan 2020 18:51:40 +0100
Message-Id: <20200128175342.9066-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                               | 11 -----------
 Makefile.objs                          |  1 -
 contrib/vhost-user-input/Makefile.objs |  1 -
 contrib/vhost-user-input/meson.build   |  3 +++
 meson.build                            |  1 +
 5 files changed, 4 insertions(+), 13 deletions(-)
 delete mode 100644 contrib/vhost-user-input/Makefile.objs
 create mode 100644 contrib/vhost-user-input/meson.build

diff --git a/Makefile b/Makefile
index caafc07717..8b999e7f42 100644
--- a/Makefile
+++ b/Makefile
@@ -289,7 +289,6 @@ dummy := $(call unnest-vars,, \
                 elf2dmp-obj-y \
                 ivshmem-client-obj-y \
                 ivshmem-server-obj-y \
-                vhost-user-input-obj-y \
                 vhost-user-gpu-obj-y \
                 qga-vss-dll-obj-y \
                 block-obj-y \
@@ -501,16 +500,6 @@ endif
 vhost-user-gpu$(EXESUF): $(vhost-user-gpu-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
 	$(call LINK, $^)
 
-ifdef CONFIG_VHOST_USER_INPUT
-ifdef CONFIG_LINUX
-vhost-user-input$(EXESUF): $(vhost-user-input-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
-	$(call LINK, $^)
-
-# build by default, do not install
-all: vhost-user-input$(EXESUF)
-endif
-endif
-
 module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
 	$(call quiet-command,$(PYTHON) $< $@ \
 	$(addprefix $(SRC_PATH)/,$(patsubst %.mo,%.c,$(block-obj-m))), \
diff --git a/Makefile.objs b/Makefile.objs
index e62cbeba4a..aa5ca99c28 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -108,7 +108,6 @@ qga-vss-dll-obj-y = qga/
 elf2dmp-obj-y = contrib/elf2dmp/
 ivshmem-client-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-client/
 ivshmem-server-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-server/
-vhost-user-input-obj-y = contrib/vhost-user-input/
 vhost-user-gpu-obj-y = contrib/vhost-user-gpu/
 
 ######################################################################
diff --git a/contrib/vhost-user-input/Makefile.objs b/contrib/vhost-user-input/Makefile.objs
deleted file mode 100644
index b1fad90d51..0000000000
--- a/contrib/vhost-user-input/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-vhost-user-input-obj-y = main.o
diff --git a/contrib/vhost-user-input/meson.build b/contrib/vhost-user-input/meson.build
new file mode 100644
index 0000000000..6f79679e68
--- /dev/null
+++ b/contrib/vhost-user-input/meson.build
@@ -0,0 +1,3 @@
+executable('vhost-user-input', files('main.c'),
+           link_with: libvhost_user,
+           dependencies: qemuutil)
diff --git a/meson.build b/meson.build
index 4a69aad677..f56f8b3897 100644
--- a/meson.build
+++ b/meson.build
@@ -201,6 +201,7 @@ if have_tools
   if 'CONFIG_VHOST_USER' in config_host
     subdir('contrib/libvhost-user')
     subdir('contrib/vhost-user-blk')
+    subdir('contrib/vhost-user-input')
     subdir('contrib/vhost-user-scsi')
   endif
 endif
-- 
2.21.0



