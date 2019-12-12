Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1888AC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:10:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6A0B21655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9ttNJs9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6A0B21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOEB-0005aw-LO
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:09:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNy2-0002xk-0K
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNy0-00063b-KM
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:17 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:43661)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNy0-00061j-Cy
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:16 -0500
Received: by mail-wr1-x430.google.com with SMTP id d16so2587767wre.10
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IF5qsvUc74XpoVnD59p+tpu+W3LvjPJ8O9RYhUgLrSw=;
 b=Z9ttNJs967bIEorw8CUKzOYM/V77H5O439fvdf4uWyNEwGuaMA0Ddxo4ZCSREsBziV
 1LMFBIH5aSkkdgdb3dOB/JqzfrvOEU/XteUP/KmC2Nu4tMH+x9g00MIQ/1jxYxnOBHM8
 UJ2DxytGe7l6U2DdPKFOBa5ANych8F+20SDob3rIoVUibSX9MmnQsasy+iXfSHQpvRpK
 BFvNAS3X4ll+Dqw4O3jy5Pp1DMb7p5NQum9aaJcGf4ZSJ9N9G2Mb9Fkz7DV3uvhyUZBV
 cbL0NrTnLEEx8J4RN7wizD8RZ2TZ5AyJjmGqk9+F/FEs17s1s2Ab7Udktxr6+/Tu9MYm
 GVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=IF5qsvUc74XpoVnD59p+tpu+W3LvjPJ8O9RYhUgLrSw=;
 b=m4AXP71lNoTdw6b+6LA/mycPV7Vy9UygVU5Bi1Vdi2JQhuLKCTLEkh2iPIC2kvmBpT
 lHWNsAQug0cUROy4+DzobGzOe9bXAmJhs4tFzMcFZLwWDh1iif97psL827jdPxraemQA
 mE/Shzm78Z6npRZtQ8RAT53r+8bNy/wQ1/OMJ6Vs2yxreB+iESuYPYjNdHYVvm9niQ1s
 FpQJipJyCbFX98cMgoOIj6vj+bE/qH7E94USaj6uKi3M5n4UrOfIWzuzfReuNEOTFvxH
 MQeM0PvTEZcYr/SWd7srmezD9mv9EqI73GNe/83rP+XVGm3qTOByDBurM3L3dV3CCu1q
 0LNg==
X-Gm-Message-State: APjAAAVekL+FhGHL3TKg2wQ89+P0OIyDp8DkxLpd462FXlVKsQc8BFn5
 bArQCzUrrmhs/omC/RSQ5bcRxsMq
X-Google-Smtp-Source: APXvYqy9sbAimR3AcS2Ca17G252wUn1EjdJdnqkPB+4onCYRcOxDeGTBv7BgnRQM7lZeznqHP3a4OQ==
X-Received: by 2002:adf:d848:: with SMTP id k8mr5979763wrl.328.1576155195103; 
 Thu, 12 Dec 2019 04:53:15 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:14 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 017/132] contrib/vhost-user-gpu: convert to meson
Date: Thu, 12 Dec 2019 13:51:01 +0100
Message-Id: <1576155176-2464-18-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                             |  5 -----
 Makefile.objs                        |  1 -
 contrib/vhost-user-gpu/Makefile.objs | 10 ----------
 contrib/vhost-user-gpu/meson.build   |  5 +++++
 meson.build                          | 15 +++++++++++++++
 5 files changed, 20 insertions(+), 16 deletions(-)
 delete mode 100644 contrib/vhost-user-gpu/Makefile.objs
 create mode 100644 contrib/vhost-user-gpu/meson.build

diff --git a/Makefile b/Makefile
index 9528391..bf24c51 100644
--- a/Makefile
+++ b/Makefile
@@ -176,7 +176,6 @@ HELPERS-y =
 HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) = qemu-bridge-helper$(EXESUF)
 
 ifeq ($(CONFIG_LINUX)$(CONFIG_VIRGL)$(CONFIG_GBM)$(CONFIG_TOOLS),yyyy)
-HELPERS-y += vhost-user-gpu$(EXESUF)
 vhost-user-json-y += contrib/vhost-user-gpu/50-qemu-gpu.json
 endif
 
@@ -266,7 +265,6 @@ dummy := $(call unnest-vars,, \
                 elf2dmp-obj-y \
                 ivshmem-client-obj-y \
                 ivshmem-server-obj-y \
-                vhost-user-gpu-obj-y \
                 qga-vss-dll-obj-y \
                 block-obj-y \
                 block-obj-m \
@@ -462,9 +460,6 @@ ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $^)
 endif
 
-vhost-user-gpu$(EXESUF): $(vhost-user-gpu-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
-	$(call LINK, $^)
-
 module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
 	$(call quiet-command,$(PYTHON) $< $@ \
 	$(addprefix $(SRC_PATH)/,$(patsubst %.mo,%.c,$(block-obj-m))), \
diff --git a/Makefile.objs b/Makefile.objs
index c7f7637..cae0f1d 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -109,6 +109,5 @@ qga-vss-dll-obj-y = qga/
 elf2dmp-obj-y = contrib/elf2dmp/
 ivshmem-client-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-client/
 ivshmem-server-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-server/
-vhost-user-gpu-obj-y = contrib/vhost-user-gpu/
 
 ######################################################################
diff --git a/contrib/vhost-user-gpu/Makefile.objs b/contrib/vhost-user-gpu/Makefile.objs
deleted file mode 100644
index 6170c91..0000000
--- a/contrib/vhost-user-gpu/Makefile.objs
+++ /dev/null
@@ -1,10 +0,0 @@
-vhost-user-gpu-obj-y = main.o virgl.o vugbm.o
-
-main.o-cflags := $(PIXMAN_CFLAGS) $(GBM_CFLAGS)
-main.o-libs := $(PIXMAN_LIBS)
-
-virgl.o-cflags := $(VIRGL_CFLAGS) $(GBM_CFLAGS)
-virgl.o-libs := $(VIRGL_LIBS)
-
-vugbm.o-cflags := $(GBM_CFLAGS)
-vugbm.o-libs := $(GBM_LIBS)
diff --git a/contrib/vhost-user-gpu/meson.build b/contrib/vhost-user-gpu/meson.build
new file mode 100644
index 0000000..8778aa7
--- /dev/null
+++ b/contrib/vhost-user-gpu/meson.build
@@ -0,0 +1,5 @@
+if 'CONFIG_VIRGL' in config_host and 'CONFIG_GBM' in config_host
+  executable('vhost-user-gpu', files('main.c', 'virgl.c', 'vugbm.c'),
+             link_with: libvhost_user,
+             dependencies: [qemuutil, pixman, gbm, virgl])
+endif
diff --git a/meson.build b/meson.build
index e38c8a9..b0f3622 100644
--- a/meson.build
+++ b/meson.build
@@ -52,11 +52,23 @@ if 'CONFIG_GNUTLS' in config_host
   gnutls = declare_dependency(compile_args: config_host['GNUTLS_CFLAGS'].split(),
                               link_args: config_host['GNUTLS_LIBS'].split())
 endif
+pixman = declare_dependency(compile_args: config_host['PIXMAN_CFLAGS'].split(),
+                            link_args: config_host['PIXMAN_LIBS'].split())
 libiscsi = declare_dependency()
 if 'CONFIG_LIBISCSI' in config_host
   libiscsi = declare_dependency(compile_args: config_host['LIBISCSI_CFLAGS'].split(),
                                 link_args: config_host['LIBISCSI_LIBS'].split())
 endif
+gbm = declare_dependency()
+if 'CONFIG_GBM' in config_host
+  gbm = declare_dependency(compile_args: config_host['GBM_CFLAGS'].split(),
+                           link_args: config_host['GBM_LIBS'].split())
+endif
+virgl = declare_dependency()
+if 'CONFIG_VIRGL' in config_host
+  virgl = declare_dependency(compile_args: config_host['VIRGL_CFLAGS'].split(),
+                             link_args: config_host['VIRGL_LIBS'].split())
+endif
 
 target_dirs = config_host['TARGET_DIRS'].split()
 have_user = false
@@ -199,6 +211,9 @@ if have_tools
   if 'CONFIG_VHOST_USER' in config_host
     subdir('contrib/libvhost-user')
     subdir('contrib/vhost-user-blk')
+    if 'CONFIG_LINUX' in config_host
+      subdir('contrib/vhost-user-gpu')
+    endif
     subdir('contrib/vhost-user-input')
     subdir('contrib/vhost-user-scsi')
   endif
-- 
1.8.3.1



