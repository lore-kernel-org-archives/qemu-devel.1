Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC30C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:02:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6855D2077B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1i3W34x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6855D2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifO6m-0004y0-Rw
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:02:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNy3-0002z6-0B
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNy1-000656-HD
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:18 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:38404)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNy1-00063j-9g
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:17 -0500
Received: by mail-wr1-x42b.google.com with SMTP id y17so2619327wrh.5
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0NYMHi2w3AJtsFgwdAsi8gZ85gux6X8ozW51ZPtCtxA=;
 b=e1i3W34x4XDuLiSB9FJr6lRMBBfHtLNmHH7GvwHAdLcSeGlU4+A87P+9bLl5zVfNjc
 HSjVgGqTGlFbDSJUmXPhwLd0uWYlwSx3JeGiizI1vLwL98feKqF4gL+sx2LOaouyCP/4
 h28zy6lTo19bcspWPIOAUqHZM9nZfLEcbC/wsvL/EBzV5Nl7HO2MVR3vsmVIwMdZCXlR
 n0nLGjctk4s2l4a8D5PK1GcIt3pYNKFMoj3e6I6bbkraHy+ExcLg9RQ/lt80FLelkiaN
 HSkpPeu+K648qkz/tSgH7JdG9jGqrQyu2AxYL1qRtC0lAEzDnsFmaj9GO26G/WKd3aZE
 PDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=0NYMHi2w3AJtsFgwdAsi8gZ85gux6X8ozW51ZPtCtxA=;
 b=UkHA21HHY06BZZHFXhRysE5ZrkMAmfgsELZizOPxqOQBfQjKzR/97kSuzuiCxNYKnq
 st0fqGeXpuMr7rfaUi4auyOocUQP0bRoDgCZXqbcZQQf+lX9MskNWy14GYQ1Nh30D9GY
 f4zksrET8eD7Aa3+Px3Z4D8gw1Ukt/LbEvrfjEmMqzGNYNtXYhv6/h6nVOExZIDdBl2R
 QxcjMQGV2BJLk/Vw+4Kz7LPBoa73y8Nll9w8G/T4r24uoCK4Cjq8nk6bjmZQk29Uv3sk
 uFsLIofP8wD/sD6fS7rtlmNz2diG8bXw7aKxj0iG2eVP9bbHZLYhS3pgmH8sDfA5R5lt
 I/ig==
X-Gm-Message-State: APjAAAWEbB+3JrAoTlX30UmYijmQ4peoyfLiCSG41o4v3V/OIdGAiuBD
 ec0ReGmAJ5O20sUfrtMveeaVdXDY
X-Google-Smtp-Source: APXvYqzGL2nZHskZvfD7qg/CqNJtfVf6E4vU3KVl2k5rBbq2GBfD8l1RuUxXSJXCnTUfvnptKM39fQ==
X-Received: by 2002:adf:90e7:: with SMTP id i94mr5993891wri.47.1576155196042; 
 Thu, 12 Dec 2019 04:53:16 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:15 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 018/132] contrib/ivshmem: convert to meson
Date: Thu, 12 Dec 2019 13:51:02 +0100
Message-Id: <1576155176-2464-19-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
 Makefile                             | 9 ---------
 Makefile.objs                        | 2 --
 configure                            | 3 ---
 contrib/ivshmem-client/Makefile.objs | 1 -
 contrib/ivshmem-client/meson.build   | 3 +++
 contrib/ivshmem-server/Makefile.objs | 1 -
 contrib/ivshmem-server/meson.build   | 3 +++
 meson.build                          | 6 ++++++
 8 files changed, 12 insertions(+), 16 deletions(-)
 delete mode 100644 contrib/ivshmem-client/Makefile.objs
 create mode 100644 contrib/ivshmem-client/meson.build
 delete mode 100644 contrib/ivshmem-server/Makefile.objs
 create mode 100644 contrib/ivshmem-server/meson.build

diff --git a/Makefile b/Makefile
index bf24c51..d697aab 100644
--- a/Makefile
+++ b/Makefile
@@ -263,8 +263,6 @@ dummy := $(call unnest-vars,, \
                 chardev-obj-y \
                 qga-obj-y \
                 elf2dmp-obj-y \
-                ivshmem-client-obj-y \
-                ivshmem-server-obj-y \
                 qga-vss-dll-obj-y \
                 block-obj-y \
                 block-obj-m \
@@ -453,13 +451,6 @@ endif
 elf2dmp$(EXESUF): $(elf2dmp-obj-y)
 	$(call LINK, $^)
 
-ifdef CONFIG_IVSHMEM
-ivshmem-client$(EXESUF): $(ivshmem-client-obj-y) $(COMMON_LDADDS)
-	$(call LINK, $^)
-ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
-	$(call LINK, $^)
-endif
-
 module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
 	$(call quiet-command,$(PYTHON) $< $@ \
 	$(addprefix $(SRC_PATH)/,$(patsubst %.mo,%.c,$(block-obj-m))), \
diff --git a/Makefile.objs b/Makefile.objs
index cae0f1d..919961f 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -107,7 +107,5 @@ qga-vss-dll-obj-y = qga/
 ######################################################################
 # contrib
 elf2dmp-obj-y = contrib/elf2dmp/
-ivshmem-client-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-client/
-ivshmem-server-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-server/
 
 ######################################################################
diff --git a/configure b/configure
index c27d06f..d59c831 100755
--- a/configure
+++ b/configure
@@ -6065,9 +6065,6 @@ if test "$want_tools" = "yes" ; then
   if [ "$linux" = "yes" -o "$bsd" = "yes" -o "$solaris" = "yes" ] ; then
     tools="qemu-nbd\$(EXESUF) $tools"
   fi
-  if [ "$ivshmem" = "yes" ]; then
-    tools="ivshmem-client\$(EXESUF) ivshmem-server\$(EXESUF) $tools"
-  fi
   if [ "$curl" = "yes" ]; then
       tools="elf2dmp\$(EXESUF) $tools"
   fi
diff --git a/contrib/ivshmem-client/Makefile.objs b/contrib/ivshmem-client/Makefile.objs
deleted file mode 100644
index bfab2d2..0000000
--- a/contrib/ivshmem-client/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-ivshmem-client-obj-y = ivshmem-client.o main.o
diff --git a/contrib/ivshmem-client/meson.build b/contrib/ivshmem-client/meson.build
new file mode 100644
index 0000000..92ad844
--- /dev/null
+++ b/contrib/ivshmem-client/meson.build
@@ -0,0 +1,3 @@
+executable('ivshmem-client', files('ivshmem-client.c', 'main.c'),
+           dependencies: glib,
+           install: true)
diff --git a/contrib/ivshmem-server/Makefile.objs b/contrib/ivshmem-server/Makefile.objs
deleted file mode 100644
index c060dd3..0000000
--- a/contrib/ivshmem-server/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-ivshmem-server-obj-y = ivshmem-server.o main.o
diff --git a/contrib/ivshmem-server/meson.build b/contrib/ivshmem-server/meson.build
new file mode 100644
index 0000000..6dbe240
--- /dev/null
+++ b/contrib/ivshmem-server/meson.build
@@ -0,0 +1,3 @@
+executable('ivshmem-server', files('ivshmem-server.c', 'main.c'),
+           dependencies: [qemuutil, rt],
+           install: true)
diff --git a/meson.build b/meson.build
index b0f3622..e2eee80 100644
--- a/meson.build
+++ b/meson.build
@@ -54,6 +54,7 @@ if 'CONFIG_GNUTLS' in config_host
 endif
 pixman = declare_dependency(compile_args: config_host['PIXMAN_CFLAGS'].split(),
                             link_args: config_host['PIXMAN_LIBS'].split())
+rt = cc.find_library('rt', required: false)
 libiscsi = declare_dependency()
 if 'CONFIG_LIBISCSI' in config_host
   libiscsi = declare_dependency(compile_args: config_host['LIBISCSI_CFLAGS'].split(),
@@ -217,4 +218,9 @@ if have_tools
     subdir('contrib/vhost-user-input')
     subdir('contrib/vhost-user-scsi')
   endif
+
+  if 'CONFIG_IVSHMEM' in config_host
+    subdir('contrib/ivshmem-client')
+    subdir('contrib/ivshmem-server')
+  endif
 endif
-- 
1.8.3.1



