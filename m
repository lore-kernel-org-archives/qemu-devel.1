Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D313C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:10:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBB1F2054F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVX7s4Zz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB1F2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gmT-0002U9-2O
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHM-00051l-6g
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:28 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:56087)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHF-0006Bh-SY
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:27 -0400
Received: by mail-wm1-x335.google.com with SMTP id 9so13414679wmj.5
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4PQbF8bhzVMCICmYbql34FE7vRnqpkhqgrq1jHhjLTw=;
 b=kVX7s4ZzBfEr6T135AHAFc6Zc/vw9fJfQ4yG/5I6DC/g9UNFB7NL/fs92ZqKnwFGOW
 MgWNRwCBXffDuoc3eMMLifk+XprZw1hTtPWsp7AVD9SHdcHRbJPcT9xZPrxCuSihdxEK
 PZB2FNMhFrH9LQT7Yl09bOmoHfr1iDTi87wC97OVIjTcPv3btWPrBukGCiMgEHUomJPT
 +ZBSqMjrDyx66vShlSq1dBMwXliA9GKzbRBrjK5AboFqtJZUxcOg4+hzIss9J55Z2UjB
 4IGhv3jVtiZz6aaGm0yS7sqvHATo8W3+Emkli4+MD2Ukx8Ky9j6ZTAEYHDBj3SEcNqlP
 feuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=4PQbF8bhzVMCICmYbql34FE7vRnqpkhqgrq1jHhjLTw=;
 b=uBn2Cy+cSofA1clCJdULA2EsKE3rPyJF+wvjiLVqg/m1HwcQyFebQ+ZmIIrTt5Ri5Q
 m/HAfHLYD7FprD+RKbiS+EAZw/y9FTj8hR+1RLCTLGJlNQnmr6T2KUdSmmoP6B9k235Y
 CMUAsj5IlkjVWU725RkjeRnr1xKNCHVkLIgB6MXzHqqUVLySb7y/Gj/x0qFzha5uS8Tb
 LInTwyrqOwNAeFGeEtX91kWpS4YSLRdUvNDuLDp+aV90mERH9OIaZMkrp8fOaVkj9RH8
 YHNHHfks8IBp3KIjNFxkgBStGS+PLBPTTcWRI6shZJXXypqB2zwWPHJ/f/1aVGPMpsjA
 E7ow==
X-Gm-Message-State: AOAM532l3m67Rm8T4DR7lsVIAb7jG2OV+5uSLsyiY+L1jXAFM7j19Ow2
 Yo9aS1g6GDKvFikOj9kWRuBo/PMXWOw=
X-Google-Smtp-Source: ABdhPJwtO4grclavmAk0gklVjKxhWBXj3EScdBPHchcRF9HEGus4xzz4R/ekpzd93Y/yEXy3Hwyi7g==
X-Received: by 2002:a1c:f30f:: with SMTP id q15mr14687404wmq.60.1597675100327; 
 Mon, 17 Aug 2020 07:38:20 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 056/150] meson: convert authz directory to Meson
Date: Mon, 17 Aug 2020 16:35:49 +0200
Message-Id: <20200817143723.343284-57-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x335.google.com
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
 Makefile            |  1 -
 Makefile.objs       |  3 ++-
 Makefile.target     |  2 +-
 authz/Makefile.objs |  7 -------
 authz/meson.build   | 19 +++++++++++++++++++
 meson.build         |  5 +++++
 6 files changed, 27 insertions(+), 10 deletions(-)
 delete mode 100644 authz/Makefile.objs
 create mode 100644 authz/meson.build

diff --git a/Makefile b/Makefile
index 1f95ba81f4..6051efe766 100644
--- a/Makefile
+++ b/Makefile
@@ -230,7 +230,6 @@ include $(SRC_PATH)/Makefile.objs
 endif
 
 dummy := $(call unnest-vars,, \
-                authz-obj-y \
                 chardev-obj-y \
                 block-obj-y \
                 block-obj-m \
diff --git a/Makefile.objs b/Makefile.objs
index 84bfa2a61a..0bc361d338 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -9,7 +9,8 @@ ifeq ($(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS)),y)
 
 chardev-obj-y = chardev/
 
-authz-obj-y = authz/
+authz-obj-y = authz/libauthz.fa
+authz/libauthz.fa-libs = $(if $(CONFIG_AUTH_PAM),-lpam)
 
 block-obj-y = block/ nbd/ scsi/
 block-obj-y += block.o blockjob.o job.o
diff --git a/Makefile.target b/Makefile.target
index 1e04551a8e..79b6e02bed 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -192,9 +192,9 @@ common-obj-m :=
 
 include $(SRC_PATH)/Makefile.objs
 dummy := $(call fix-paths,../,, \
+              authz-obj-y \
               qom-obj-y)
 dummy := $(call unnest-vars,.., \
-               authz-obj-y \
                block-obj-y \
                block-obj-m \
                chardev-obj-y \
diff --git a/authz/Makefile.objs b/authz/Makefile.objs
deleted file mode 100644
index ed7b273596..0000000000
--- a/authz/Makefile.objs
+++ /dev/null
@@ -1,7 +0,0 @@
-authz-obj-y += base.o
-authz-obj-y += simple.o
-authz-obj-y += list.o
-authz-obj-y += listfile.o
-authz-obj-$(CONFIG_AUTH_PAM) += pamacct.o
-
-pamacct.o-libs = -lpam
diff --git a/authz/meson.build b/authz/meson.build
new file mode 100644
index 0000000000..c1f63627c1
--- /dev/null
+++ b/authz/meson.build
@@ -0,0 +1,19 @@
+authz_ss = ss.source_set()
+authz_ss.add(genh)
+authz_ss.add(files(
+  'base.c',
+  'list.c',
+  'listfile.c',
+  'simple.c',
+))
+
+authz_ss.add(when: ['CONFIG_AUTH_PAM', pam], if_true: files('pamacct.c'))
+
+authz_ss = authz_ss.apply(config_host, strict: false)
+libauthz = static_library('authz', authz_ss.sources(),
+                          dependencies: [authz_ss.dependencies()],
+                          name_suffix: 'fa',
+                          build_by_default: false)
+
+authz = declare_dependency(link_whole: libauthz,
+                           dependencies: qom)
diff --git a/meson.build b/meson.build
index 30e7a0e35b..e1fc4c2169 100644
--- a/meson.build
+++ b/meson.build
@@ -99,6 +99,10 @@ if 'CONFIG_GNUTLS' in config_host
 endif
 pixman = declare_dependency(compile_args: config_host['PIXMAN_CFLAGS'].split(),
                             link_args: config_host['PIXMAN_LIBS'].split())
+pam = not_found
+if 'CONFIG_AUTH_PAM' in config_host
+  pam = cc.find_library('pam')
+endif
 libattr = not_found
 if 'CONFIG_ATTR' in config_host
   libattr = declare_dependency(link_args: config_host['LIBATTR_LIBS'].split())
@@ -337,6 +341,7 @@ qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: genh + version_res)
 
 subdir('qom')
+subdir('authz')
 subdir('fsdev')
 
 # Other build targets
-- 
2.26.2



