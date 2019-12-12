Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AD8C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:11:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52A0921655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n469trpL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A0921655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOFo-00079d-VX
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:11:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyF-0003Im-Hu
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyE-0006UO-6N
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:31 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:54265)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyD-0006T4-Vx
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:30 -0500
Received: by mail-wm1-x335.google.com with SMTP id n9so2244661wmd.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=o0zqfdZ8p5g/pfdlVwgBoMj3GcdSJMfztzyAKgF38iE=;
 b=n469trpLtiVxcZfHiZo3wgL4eoEOwvEPTdTWFmb+v0n5WXWR4UfjCtRW/9P+kB+l4P
 DQiBWclHgnxLHgTFbaJTACRhqtLeNSsjiBANYdt/CIS8uMkJu4L5TMq6hK25cgwtKDJR
 mQiA/nfALyJEKQlckAiNvkfTxj9aZCaIe8QAWlsdqP7+tODM28phO7liZctoy9D6ByHo
 QleYFJ5TRnJPHq7DSVTdKNuuia9c+qdD4NGpbVmrvobLgjERAzFu4Y/f0qvi5kZdg6PZ
 9HTGKOwbasb8kP/8lk5spUcrmepS7yZ9g+Xu3u8AymUX2Kl2COozEuT9Q8jBgxTAXXjJ
 ipJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=o0zqfdZ8p5g/pfdlVwgBoMj3GcdSJMfztzyAKgF38iE=;
 b=Hcr0DfVD4TF4HCk9abo0diST8PHiDrTZhgJgGHAFpWLxq7+yxeuGNiO09a6xFS6buo
 OBnHCl5ImcunPys0g9zpPt03Id+IaJ670/qjEbZOcQs0Hj+49nCaXbi9Pk5oFV88A5W/
 Cmr4suKHlJz7PAZ140hHGywaNCCF9O7E9xNFRrzTVHVINzPjP2UQd47dcaV6tOTNSSqC
 YQs1vU/2smlhI+QfGKxI//a7LqoxbquaBZKqlP/Ce6Q7Te2BrQM4e64PSTyhmtTqB0lg
 GwMZjS6ADN568FxjGj0SQDvIWBngj1qrENF96XE4EjWzbk2QQw2HB8LpEiyCkyo/P4tP
 00Jg==
X-Gm-Message-State: APjAAAW/JKKTJBcdNoBSE+5F5zs0F4DKqqiBfbgrj58bnaC6E3YSODlg
 /0dY/tAfQqZfYYDGqTut2F6jioHw
X-Google-Smtp-Source: APXvYqw6SNzzN++v1Il9p61CAVIoov3uVoVy3Ec04r6CSTIIPog0oDYI/8Ii9cGIBpWEa4KisXIJEg==
X-Received: by 2002:a05:600c:2290:: with SMTP id
 16mr6817055wmf.93.1576155208811; 
 Thu, 12 Dec 2019 04:53:28 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:28 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 031/132] meson: configure 50-qemu-gpu.json
Date: Thu, 12 Dec 2019 13:51:15 +0100
Message-Id: <1576155176-2464-32-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
 Makefile                           | 7 +------
 contrib/vhost-user-gpu/meson.build | 5 +++++
 rules.mak                          | 7 -------
 3 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/Makefile b/Makefile
index 7588467..0a6615c 100644
--- a/Makefile
+++ b/Makefile
@@ -118,13 +118,8 @@ $(call set-vpath, $(SRC_PATH))
 
 LIBS+=-lz $(LIBS_TOOLS)
 
-vhost-user-json-y =
 HELPERS-y =
 
-ifeq ($(CONFIG_LINUX)$(CONFIG_VIRGL)$(CONFIG_GBM)$(CONFIG_TOOLS),yyyy)
-vhost-user-json-y += contrib/vhost-user-gpu/50-qemu-gpu.json
-endif
-
 ifdef BUILD_DOCS
 DOCS=qemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 qemu-nbd.8 qemu-ga.8
 DOCS+=docs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt docs/interop/qemu-qmp-ref.7
@@ -217,7 +212,7 @@ dummy := $(call unnest-vars,, \
 
 include $(SRC_PATH)/tests/Makefile.include
 
-all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) $(TOOLS) $(HELPERS-y) recurse-all modules $(vhost-user-json-y)
+all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) $(TOOLS) $(HELPERS-y) recurse-all modules
 
 config-host.h: config-host.h-timestamp
 config-host.h-timestamp: config-host.mak
diff --git a/contrib/vhost-user-gpu/meson.build b/contrib/vhost-user-gpu/meson.build
index 8778aa7..7303b6d 100644
--- a/contrib/vhost-user-gpu/meson.build
+++ b/contrib/vhost-user-gpu/meson.build
@@ -2,4 +2,9 @@ if 'CONFIG_VIRGL' in config_host and 'CONFIG_GBM' in config_host
   executable('vhost-user-gpu', files('main.c', 'virgl.c', 'vugbm.c'),
              link_with: libvhost_user,
              dependencies: [qemuutil, pixman, gbm, virgl])
+
+  configure_file(input: '50-qemu-gpu.json.in',
+                 output: '50-qemu-gpu.json',
+                 configuration: config_host,
+                 install_dir: config_host['qemu_datadir'] / 'vhost-user')
 endif
diff --git a/rules.mak b/rules.mak
index fa9960c..5289184 100644
--- a/rules.mak
+++ b/rules.mak
@@ -393,10 +393,3 @@ TEXI2MAN = $(call quiet-command, \
 	$(call TEXI2MAN)
 %.8:
 	$(call TEXI2MAN)
-
-GEN_SUBST = $(call quiet-command, \
-	sed -e "s!@libexecdir@!$(libexecdir)!g" < $< > $@, \
-	"GEN","$@")
-
-%.json: %.json.in
-	$(call GEN_SUBST)
-- 
1.8.3.1



