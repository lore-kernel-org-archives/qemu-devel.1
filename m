Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD3BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:57:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51213205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZL8YwdGD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51213205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gZP-00082d-JL
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGw-0004B9-NB
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:02 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:42250)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGv-00067s-2n
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:02 -0400
Received: by mail-wr1-x42f.google.com with SMTP id r4so15223775wrx.9
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eZ40KHdt5g1CPMsiLXKPeY2vOcqMNZVd2dgkLPBu8Lg=;
 b=ZL8YwdGDTashcH95TuQn8NItysNz3Ov3RRcoFKuR4ZQQVuMhwvJGz/JkasRxhi8KVQ
 NBUS1i1kqBUhauzXlVopOlewDUA8ltn7lbbNdTseVHqAJcIZy9eZoGM0f2mhiYVY8QET
 Fs8hhaixtO0GsZGcIojWFFgFZFYwhTawlop0Da5Arq94e0UU2rJd7zn0UVAhWn6Rvwi0
 fdJRCba1Dub+UdwNItKyOZ6F5M47R1d8MuMUL0fDlV/1ElgWVjxMt+KjY5iaCaZJY7SZ
 ArcFXtPPTlDarNTW6AcCn2pzNBPifb4pT2g/WxgD/C2Hj6xQ2wT7ursoiHxpDwASqhDW
 Cojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=eZ40KHdt5g1CPMsiLXKPeY2vOcqMNZVd2dgkLPBu8Lg=;
 b=M3YKfNhDKyWtd2F8+K8PnX5+AdG+4mVqebPcxRA8DQCtOMXtnNETpzwFn+Fg4mFCw8
 J4pURDN1TbP/EIJuPMs6Cunl33hSOOHIts3vKwWW5R3AbKIP3oM32f9oJ54V6TO6RpbA
 Lj7fhUweD355muOH56fo4Y82m5DDG1VEYgDYQAvU5bghqUIKi/g9QS74cznBabBweU4m
 qnrnM6H9Rsj1hFCVpwxkoKjJjRIeOXSf0eylp15XAfOJlva/SL1pQRAolhTjLViGm8yb
 17vb5xguYDuaJpkdQA+HS1h+s/Af8NM6Q5UisyzEn4ADuQ1FPylqpWPZYDuTcH4fNHRz
 Ncag==
X-Gm-Message-State: AOAM530P918/K6Et6ViOjhxrcsPEFjJc2YVbliLb6HkEB57Bb5hc+J4o
 HRHCKc9QC5GGTd3cm02mud6oovJYNc8=
X-Google-Smtp-Source: ABdhPJyeahjxH9B4Ce+h4B5kodGYBndYAfxDfJAVpjwXj4EUzy4HlDIkUGuYzL2Ng9Q+RU3dpoALhw==
X-Received: by 2002:adf:812a:: with SMTP id 39mr15319292wrm.137.1597675079464; 
 Mon, 17 Aug 2020 07:37:59 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.37.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:37:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 033/150] contrib/vhost-user-input: convert to meson
Date: Mon, 17 Aug 2020 16:35:26 +0200
Message-Id: <20200817143723.343284-34-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x42f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                               | 11 -----------
 Makefile.objs                          |  1 -
 contrib/vhost-user-input/Makefile.objs |  1 -
 contrib/vhost-user-input/meson.build   |  5 +++++
 meson.build                            |  1 +
 5 files changed, 6 insertions(+), 13 deletions(-)
 delete mode 100644 contrib/vhost-user-input/Makefile.objs
 create mode 100644 contrib/vhost-user-input/meson.build

diff --git a/Makefile b/Makefile
index 78f2cb12c7..d02910b073 100644
--- a/Makefile
+++ b/Makefile
@@ -300,7 +300,6 @@ dummy := $(call unnest-vars,, \
                 elf2dmp-obj-y \
                 ivshmem-client-obj-y \
                 ivshmem-server-obj-y \
-                vhost-user-input-obj-y \
                 vhost-user-gpu-obj-y \
                 qga-vss-dll-obj-y \
                 block-obj-y \
@@ -524,16 +523,6 @@ endif
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
index 0f80b63554..0922c3ed00 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -106,7 +106,6 @@ qga-vss-dll-obj-y = qga/
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
index 0000000000..1eeb1329d9
--- /dev/null
+++ b/contrib/vhost-user-input/meson.build
@@ -0,0 +1,5 @@
+executable('vhost-user-input', files('main.c'),
+           link_with: libvhost_user,
+           dependencies: qemuutil,
+           build_by_default: targetos == 'linux',
+           install: false)
diff --git a/meson.build b/meson.build
index 730442de1d..a8c22b20e5 100644
--- a/meson.build
+++ b/meson.build
@@ -261,6 +261,7 @@ if have_tools
   if 'CONFIG_VHOST_USER' in config_host
     subdir('contrib/libvhost-user')
     subdir('contrib/vhost-user-blk')
+    subdir('contrib/vhost-user-input')
     subdir('contrib/vhost-user-scsi')
   endif
 endif
-- 
2.26.2



