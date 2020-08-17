Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54579C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:57:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E3FF205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhNeSvzK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3FF205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7ga1-0001I9-Dt
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHI-0004uM-7i
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:24 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:39222)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHE-0006BZ-Mr
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:23 -0400
Received: by mail-wr1-x42b.google.com with SMTP id a5so15258866wrm.6
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MxRrNlWMa4peGdDiN+aPCZQxNRXBWH2i6GnS6XF+Ofc=;
 b=NhNeSvzKgniEF68kToAuUqCjWOWYcddHp31ToGUk8NUkr4ir1X0Kl+Jdehabsswm/7
 qvftkomKG63pArHGNcMlWFwHeEcxnbvD+9g9LLm8xmmnxEo3l15rqW0tFWaa25A+Kami
 Twf0R24j45vgZeIVqf7BlhyxGbz943I7I0wyOEdXd1wHvz6ZT0St/jEgZa5K/0SkQiVS
 CMGXAkIE0z3NnMgLnjbsvUm3jDhtw9JX90/cTlbYXFA5Xlm+GMbKUlrr+Rg7P+rjYVIr
 8fGwrxADjJbVsuzofJ9JKci54jQiMdptL1dpFfaGcGxN3ZoBlgoPxcSAnYllMMO8Cyzb
 ZMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=MxRrNlWMa4peGdDiN+aPCZQxNRXBWH2i6GnS6XF+Ofc=;
 b=AiZRlgXH2ayv96WzX6sUG3WDj6FTpFvgVAs/32b5otzrHlGuGv5+7n9JyZeOX2mh8o
 BgsNHdSbGrsJ5JEXPAbLLbK/qTbir5aWgCUMwETO79mt6WpKXkaMIM+gsMoqAzvSg9ef
 /fvsGINfupUVkAi5CNA2N80Tc7xgaUzl++Zm9U7wxKA08Tnlt6gahGSjqiJpYWc3WSex
 qBm7rmJ/ujSI6/bIImEMcX+AcPCLghJecJmoTMQRWCn8vbhuY8eLw7l7obtD0ggOO2S4
 2XacKTWAaJ/c/w5jU9gEtWBHBECgdGsxHiSy+6Be93tsICIop1qKA0P10TCw0xwizD0U
 BN5w==
X-Gm-Message-State: AOAM5310I2k4aVK/nZfMonSE/LrDA8wE52NFZBwzGf/M3qkqBNbuWAqX
 l5BNwy/W73OMl+/PRDVfJz6oWQ7eg2o=
X-Google-Smtp-Source: ABdhPJx5Cb4RWKXzHql7txQgtEeny1rIKPkiilm9tzR7nJ+G0P0XhISv3pmgSjzWJzP6+Z4Rh6nAZg==
X-Received: by 2002:adf:e704:: with SMTP id c4mr16993074wrm.81.1597675099215; 
 Mon, 17 Aug 2020 07:38:19 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 055/150] meson: convert qom directory to Meson (tools part)
Date: Mon, 17 Aug 2020 16:35:48 +0200
Message-Id: <20200817143723.343284-56-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x42b.google.com
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
 Makefile          |  2 +-
 Makefile.objs     |  2 +-
 Makefile.target   |  3 ++-
 meson.build       |  1 +
 qom/Makefile.objs |  3 ---
 qom/meson.build   | 15 +++++++++++++++
 6 files changed, 20 insertions(+), 6 deletions(-)
 create mode 100644 qom/meson.build

diff --git a/Makefile b/Makefile
index 68ad75d210..1f95ba81f4 100644
--- a/Makefile
+++ b/Makefile
@@ -237,7 +237,6 @@ dummy := $(call unnest-vars,, \
                 storage-daemon-obj-y \
                 storage-daemon-obj-m \
                 crypto-obj-y \
-                qom-obj-y \
                 io-obj-y \
                 common-obj-y \
                 common-obj-m)
@@ -258,6 +257,7 @@ $(SOFTMMU_ALL_RULES): $(storage-daemon-obj-y)
 $(SOFTMMU_ALL_RULES): $(chardev-obj-y)
 $(SOFTMMU_ALL_RULES): $(crypto-obj-y)
 $(SOFTMMU_ALL_RULES): $(io-obj-y)
+$(SOFTMMU_ALL_RULES): $(qom-obj-y)
 $(SOFTMMU_ALL_RULES): config-all-devices.mak
 
 SOFTMMU_FUZZ_RULES=$(filter %-softmmu/fuzz, $(TARGET_DIRS_RULES))
diff --git a/Makefile.objs b/Makefile.objs
index baf15656e8..84bfa2a61a 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -1,6 +1,6 @@
 #######################################################################
 # Common libraries for tools and emulators
-qom-obj-y = qom/
+qom-obj-y = qom/libqom.fa
 
 #######################################################################
 # code used by both qemu system emulation and qemu-img
diff --git a/Makefile.target b/Makefile.target
index 257afc2723..1e04551a8e 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -191,13 +191,14 @@ all-obj-y := $(obj-y)
 common-obj-m :=
 
 include $(SRC_PATH)/Makefile.objs
+dummy := $(call fix-paths,../,, \
+              qom-obj-y)
 dummy := $(call unnest-vars,.., \
                authz-obj-y \
                block-obj-y \
                block-obj-m \
                chardev-obj-y \
                crypto-obj-y \
-               qom-obj-y \
                io-obj-y \
                common-obj-y \
                common-obj-m)
diff --git a/meson.build b/meson.build
index 00b3220fc8..30e7a0e35b 100644
--- a/meson.build
+++ b/meson.build
@@ -336,6 +336,7 @@ libqemuutil = static_library('qemuutil',
 qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: genh + version_res)
 
+subdir('qom')
 subdir('fsdev')
 
 # Other build targets
diff --git a/qom/Makefile.objs b/qom/Makefile.objs
index 1b45d104ba..b9629045e6 100644
--- a/qom/Makefile.objs
+++ b/qom/Makefile.objs
@@ -1,5 +1,2 @@
-qom-obj-y = object.o container.o qom-qobject.o
-qom-obj-y += object_interfaces.o
-
 common-obj-$(CONFIG_SOFTMMU) += qom-hmp-cmds.o qom-qmp-cmds.o
 storage-daemon-obj-y += qom-qmp-cmds.o
diff --git a/qom/meson.build b/qom/meson.build
new file mode 100644
index 0000000000..3c41ed37e4
--- /dev/null
+++ b/qom/meson.build
@@ -0,0 +1,15 @@
+qom_ss = ss.source_set()
+qom_ss.add(files(
+  'container.c',
+  'object.c',
+  'object_interfaces.c',
+  'qom-qobject.c',
+))
+
+qom_ss = qom_ss.apply(config_host, strict: false)
+libqom = static_library('qom', qom_ss.sources(),
+                        dependencies: [qom_ss.dependencies()],
+                        link_with: [libqemuutil],
+                        name_suffix: 'fa')
+
+qom = declare_dependency(link_whole: libqom)
-- 
2.26.2



