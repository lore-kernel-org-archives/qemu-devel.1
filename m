Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E0DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:32:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF2E42467E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f993nKwl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF2E42467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVee-0007Q5-Rd
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:32:04 -0500
Received: from [2001:470:142:3::10] (port=59706 helo=eggs.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV59-0007vv-3Z
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV54-0001hh-P6
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:22 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36295)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV53-0001aI-Mn
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:18 -0500
Received: by mail-wr1-x443.google.com with SMTP id z3so17126073wru.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HINL6J6/Q21GKz35F6oJJvZeMUYceOY2knspGcuD++E=;
 b=f993nKwlDtL2Giph8hqvzo9vNvyp1d2o7M/NUoJVa+8lGQVUb43ZNOtuLH96rjjW7U
 E2d3SL4BjCvxHbxvHSzhlCJa/DQOfAIkn/n2hEgE9oqO0AC87jeLj0ask0aDROdMXnfx
 A8e8s4nP1KIyvjVqjEt24hxi+xynq5ubyo6xVw5Y8wDAclU1OLpd85T5T8ZLvsDDbFeI
 9uMKV3tOfRHTBcHKPzDLi6zifTlpuO3KS2LZgIr3iUDzL1Xd0GRLJPX7VtgqqDw/UU09
 y+Dd+0DYD7z0ssWult/C7MSceP+t0zyNFaqrVV3By/4MWZ+Z96126Lj7mlv4v1CVWD/U
 qSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=HINL6J6/Q21GKz35F6oJJvZeMUYceOY2knspGcuD++E=;
 b=fQbVfMZ8/9kEkL5UEIQ2eAZivOiIlf6EGlQ/Yru8I8ckwv43wIdL01mXGSnkKBD/aV
 Ho8dHfygPAJQEAWVVO+vCavePLNJMNXR6/ZOurkv0Pb7k6hdM/WZaAtQ0dL35D++HZNZ
 fTGZAwqMTOUaxft02s1Obr3Xm3/uxhmr1BuvHSPVmyiJpY1K9nbCyJ61XnCqp2XnLLtv
 cyZ9w4XClKnFsaEp7IoLt963K9U6SyoKer/pwRsaACyPVVLwnKmujHS3t+Lq+VzYYiVm
 7gyh45MRBoYb2drYt1Go44/ktLjh3xtOgThCOSH8X965zUJBCTt2C5J3c8MHgFYfsjt6
 oFlw==
X-Gm-Message-State: APjAAAXGaeWTSPVqUK2iPSTWRT0v0Y1iLzMhdZLtJ/9oi1kX63J2bu5P
 kJR+DqBY3PB++5hYUlWKQGET0Anb
X-Google-Smtp-Source: APXvYqyLyEa34LxsJdWBLQl+kS0PXV+toEPd0BGM5Xyu7yudcQLkK22jLgwn2sb6HA5rktnRW2mNSw==
X-Received: by 2002:a5d:484f:: with SMTP id n15mr29684814wrs.365.1580234115254; 
 Tue, 28 Jan 2020 09:55:15 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.55.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:55:14 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 036/142] meson: configure 50-qemu-gpu.json
Date: Tue, 28 Jan 2020 18:51:56 +0100
Message-Id: <20200128175342.9066-37-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
 Makefile                           | 13 +------------
 contrib/vhost-user-gpu/meson.build |  5 +++++
 rules.mak                          |  7 -------
 3 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/Makefile b/Makefile
index 040bcad43a..3629563bc6 100644
--- a/Makefile
+++ b/Makefile
@@ -128,13 +128,8 @@ $(call set-vpath, $(SRC_PATH))
 
 LIBS+=-lz $(LIBS_TOOLS)
 
-vhost-user-json-y =
 HELPERS-y =
 
-ifeq ($(CONFIG_LINUX)$(CONFIG_VIRGL)$(CONFIG_GBM)$(CONFIG_TOOLS),yyyy)
-vhost-user-json-y += contrib/vhost-user-gpu/50-qemu-gpu.json
-endif
-
 # Sphinx does not allow building manuals into the same directory as
 # the source files, so if we're doing an in-tree QEMU build we must
 # build the manuals into a subdirectory (and then install them from
@@ -240,7 +235,7 @@ dummy := $(call unnest-vars,, \
 
 include $(SRC_PATH)/tests/Makefile.include
 
-all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) $(TOOLS) $(HELPERS-y) recurse-all modules $(vhost-user-json-y)
+all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) $(TOOLS) $(HELPERS-y) recurse-all modules
 
 config-host.h: config-host.h-timestamp
 config-host.h-timestamp: config-host.mak
@@ -522,12 +517,6 @@ endif
 ifneq ($(HELPERS-y),)
 	$(call install-prog,$(HELPERS-y),$(DESTDIR)$(libexecdir))
 endif
-ifneq ($(vhost-user-json-y),)
-	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/vhost-user/"
-	for x in $(vhost-user-json-y); do \
-		$(INSTALL_DATA) $$x "$(DESTDIR)$(qemu_datadir)/vhost-user/"; \
-	done
-endif
 ifdef CONFIG_TRACE_SYSTEMTAP
 	$(INSTALL_PROG) "scripts/qemu-trace-stap" $(DESTDIR)$(bindir)
 endif
diff --git a/contrib/vhost-user-gpu/meson.build b/contrib/vhost-user-gpu/meson.build
index 8778aa79de..7303b6dbaf 100644
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
index fa9960cdbd..52891849c8 100644
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
2.21.0



