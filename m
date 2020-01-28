Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EFFC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:19:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93EB0214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCfYrrm1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93EB0214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVSY-0005nL-N7
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:19:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58453)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV4Y-00075P-IY
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV4W-0000MD-9V
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:45 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:39937)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV4W-0000Jf-2Y
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:44 -0500
Received: by mail-wr1-x430.google.com with SMTP id j104so1193427wrj.7
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=e6DA9mr38ESVjvtg3ifwRo8CjKVJ17mRZERMj+nppdE=;
 b=hCfYrrm14tjUmvQt8yRWkPjYKWkdHlFIEf1iAqjUYpIK6oiQYuVVHOn1fkjU+JcLHR
 2mHLdZsD7rsgqsnsn+yP8yCvTCEzR5u/np0PLISF4EfaIjdJsp1kHFQDzOxTEbfvGxZW
 ghbDIAF/8MnFo0bQD1IBuuWQH6jNnw4Nre4TQqTocF9+TPJrCkOdDJVYdT+uoeIUDO2x
 JkO4nwn1R9ah3j7idQY9bAMVJ414qY5PtM0dD/+hexuhMSN9UqMp0lJCp+bLcTihbYaL
 v7r2D7LDw6v2ZpTn011hdKKwaZvSfU3Trn3CjfZUkWm4/nq0zlFpuh5iGK5hLcayaJri
 WJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=e6DA9mr38ESVjvtg3ifwRo8CjKVJ17mRZERMj+nppdE=;
 b=AU78V2TcPf3GDNIajOpePZct4lsgpEd6/T2Rfhx0XhR1jytG+F4v1HEDMP0hD2YTqi
 FSOxEMpE/sQW2CAEXNcQBcUArjbBjLICuOX3oLTPE+yQmPTlRk7R3tosmsnyxcIm4Y42
 OPp7BBjUTI9gIMpKbWuPc/6EVwHZORrb1ReWV5U8GGs4E3lY42rk7KY3GRSwjGfxmWbo
 F2EgQUNMSbnvGVmsxzcz44CnCfZub0L5iUncV+LA6jr4A3yLkR1/HXfWR2YVJiZyXgGF
 TC/4otAoYO5UOyZ5LTK5uVdyFj1GOHhyt03qDEMBxs8C5s4vOmZW4Gx/nJqidYUq8hMX
 1rVg==
X-Gm-Message-State: APjAAAWIpIxT3CEZDq2psCLetxRTdxcq2sxjtc8T3xSjsGet1yLBQOwt
 caYzunm8qh/aVO9/iVrtbCWxRv8e
X-Google-Smtp-Source: APXvYqzJ0h+boB/iSNUnqJ2VRkK33ED1lVPpOsDjibBwQAvF8OTekGm6u0vd+1RTAvkrvIJECv5Z7w==
X-Received: by 2002:adf:ed83:: with SMTP id c3mr29046095wro.51.1580234082920; 
 Tue, 28 Jan 2020 09:54:42 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.54.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:54:42 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 023/142] contrib/elf2dmp: convert to meson
Date: Tue, 28 Jan 2020 18:51:43 +0100
Message-Id: <20200128175342.9066-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
 Makefile                      | 4 ----
 Makefile.objs                 | 6 ------
 configure                     | 3 ---
 contrib/elf2dmp/Makefile.objs | 4 ----
 contrib/elf2dmp/meson.build   | 4 ++++
 meson.build                   | 6 ++++++
 6 files changed, 10 insertions(+), 17 deletions(-)
 delete mode 100644 contrib/elf2dmp/Makefile.objs
 create mode 100644 contrib/elf2dmp/meson.build

diff --git a/Makefile b/Makefile
index c0e62d8053..1ee3e8cb06 100644
--- a/Makefile
+++ b/Makefile
@@ -285,7 +285,6 @@ dummy := $(call unnest-vars,, \
                 authz-obj-y \
                 chardev-obj-y \
                 qga-obj-y \
-                elf2dmp-obj-y \
                 qga-vss-dll-obj-y \
                 block-obj-y \
                 block-obj-m \
@@ -483,9 +482,6 @@ ifneq ($(EXESUF),)
 qemu-ga: qemu-ga$(EXESUF) $(QGA_VSS_PROVIDER) $(QEMU_GA_MSI)
 endif
 
-elf2dmp$(EXESUF): $(elf2dmp-obj-y)
-	$(call LINK, $^)
-
 module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
 	$(call quiet-command,$(PYTHON) $< $@ \
 	$(addprefix $(SRC_PATH)/,$(patsubst %.mo,%.c,$(block-obj-m))), \
diff --git a/Makefile.objs b/Makefile.objs
index 92dc309fd7..4ffe38c7b1 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -102,9 +102,3 @@ util-obj-y +=  trace/
 # extracted into a QAPI schema module, or perhaps a separate schema.
 qga-obj-y = qga/
 qga-vss-dll-obj-y = qga/
-
-######################################################################
-# contrib
-elf2dmp-obj-y = contrib/elf2dmp/
-
-######################################################################
diff --git a/configure b/configure
index 52269b4ca6..6e107521d9 100755
--- a/configure
+++ b/configure
@@ -6209,9 +6209,6 @@ if test "$want_tools" = "yes" ; then
   if [ "$linux" = "yes" -o "$bsd" = "yes" -o "$solaris" = "yes" ] ; then
     tools="qemu-nbd\$(EXESUF) $tools"
   fi
-  if [ "$curl" = "yes" ]; then
-      tools="elf2dmp\$(EXESUF) $tools"
-  fi
 fi
 if test "$softmmu" = yes ; then
   if test "$linux" = yes; then
diff --git a/contrib/elf2dmp/Makefile.objs b/contrib/elf2dmp/Makefile.objs
deleted file mode 100644
index 1505716916..0000000000
--- a/contrib/elf2dmp/Makefile.objs
+++ /dev/null
@@ -1,4 +0,0 @@
-elf2dmp-obj-y = main.o addrspace.o download.o pdb.o qemu_elf.o
-
-download.o-cflags := $(CURL_CFLAGS)
-download.o-libs   := $(CURL_LIBS)
diff --git a/contrib/elf2dmp/meson.build b/contrib/elf2dmp/meson.build
new file mode 100644
index 0000000000..b9e51996e5
--- /dev/null
+++ b/contrib/elf2dmp/meson.build
@@ -0,0 +1,4 @@
+if 'CONFIG_CURL' in config_host
+  executable('elf2dmp', files('main.c', 'addrspace.c', 'download.c', 'pdb.c', 'qemu_elf.c'),
+             dependencies: [glib, curl])
+endif
diff --git a/meson.build b/meson.build
index 53e453026c..979e7f091d 100644
--- a/meson.build
+++ b/meson.build
@@ -70,6 +70,11 @@ if 'CONFIG_VIRGL' in config_host
   virgl = declare_dependency(compile_args: config_host['VIRGL_CFLAGS'].split(),
                              link_args: config_host['VIRGL_LIBS'].split())
 endif
+curl = declare_dependency()
+if 'CONFIG_CURL' in config_host
+  curl = declare_dependency(compile_args: config_host['CURL_CFLAGS'].split(),
+                            link_args: config_host['CURL_LIBS'].split())
+endif
 
 target_dirs = config_host['TARGET_DIRS'].split()
 have_user = false
@@ -210,6 +215,7 @@ qemuutil = declare_dependency(link_with: libqemuutil,
 
 if have_tools
   subdir('contrib/rdmacm-mux')
+  subdir('contrib/elf2dmp')
 
   if 'CONFIG_VHOST_USER' in config_host
     subdir('contrib/libvhost-user')
-- 
2.21.0



