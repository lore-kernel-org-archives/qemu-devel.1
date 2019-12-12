Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD789C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:10:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A607921655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xu+uZMze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A607921655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOEK-0005on-8Y
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:10:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57757)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNy0-0002uY-14
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNxy-0005zq-Pc
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:15 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41960)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNxy-0005yO-IQ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:14 -0500
Received: by mail-wr1-x444.google.com with SMTP id c9so2601377wrw.8
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=1wrzZ1Ksb/mG5EXFgTH7MXPQmgtd/c+05f2V5IPErPI=;
 b=Xu+uZMze83nWUu2uLsJ22stgVhkKTM5HIKTQVG/ccDr4aPqFHph0i4d9e+DQ/5QGMO
 /K6Y/2MQXhROqjlqYYdLRi1g0ksa7icHLRKVBJNNJEtEp72B3bKHihwN9bx9AeIy7d7r
 swtJbFVo4GsGn3+dyubX1tiyeZYSgfbN/Z8yUlQ6/H+8HN/CIJszS/EJ6AefMl4LmNNo
 yCflbLOlXSEM+G5Unn8iHzCpu3iKYO3qXo3AfwHJhSyI1VasH+JiwizpRtXEo+maJ4oJ
 V/x6H5WERjOUZVK9/xzs/5PxV/bzHEjgQQW8pzbmpVmPef1ssUULpQ6q66ug68ZCopQy
 GkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=1wrzZ1Ksb/mG5EXFgTH7MXPQmgtd/c+05f2V5IPErPI=;
 b=PxERzqgBFyGHQLLexuRNk8agPQrlj8IxSCc/J4lhogVg1oZIc7r8bqX1rX8oBseOO3
 oDFHJuNR6G765lHyxZaEn8RkwLW209Vr7iQcp/EzvLusf68V8j/t1kG1YzcSaIFK84JE
 Pu8CynAe9P27L/cMZXGoxOLLdufD91PHqQ6jEurcPTttBwRRSdxqtzlo3hds4ccnmPoJ
 ZTzXZfQICmETiXFcqMxU4TqiJZgtq2iSAKLGSiDD+dzszq4Zl4m3gfENUiamgDV/sO6+
 tBsUMO3Tb5XPYZQCEZGvvVoJyZDaWTDlCEIyA67k+1sSIYUnQA/STC3HM3XmHyMH+q8Q
 nVyg==
X-Gm-Message-State: APjAAAUUE+pIAEuH38FQsoTbi9bGuYnxvX4DnMUhwKsxVgdeiwiwyk0t
 iWWhv4LKPF380min+MURboOvDY15
X-Google-Smtp-Source: APXvYqxWvsTg/VCv7XiLZ3b+xEoatUN5r0mrG6reC7fK2yvgDtgKFbgHBHikbCFPRJOzToxV4n9b4g==
X-Received: by 2002:adf:ffc7:: with SMTP id x7mr6128883wrs.159.1576155193398; 
 Thu, 12 Dec 2019 04:53:13 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 015/132] contrib/rdmacm-mux: convert to Meson
Date: Thu, 12 Dec 2019 13:50:59 +0100
Message-Id: <1576155176-2464-16-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
index 3971171..5845a50 100644
--- a/Makefile
+++ b/Makefile
@@ -266,7 +266,6 @@ dummy := $(call unnest-vars,, \
                 elf2dmp-obj-y \
                 ivshmem-client-obj-y \
                 ivshmem-server-obj-y \
-                rdmacm-mux-obj-y \
                 vhost-user-input-obj-y \
                 vhost-user-gpu-obj-y \
                 qga-vss-dll-obj-y \
@@ -464,10 +463,6 @@ ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $^)
 endif
 
-rdmacm-mux$(EXESUF): LIBS += "-libumad"
-rdmacm-mux$(EXESUF): $(rdmacm-mux-obj-y) $(COMMON_LDADDS)
-	$(call LINK, $^)
-
 vhost-user-gpu$(EXESUF): $(vhost-user-gpu-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
 	$(call LINK, $^)
 
diff --git a/Makefile.objs b/Makefile.objs
index 30804f0..f2e8864 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -109,7 +109,6 @@ qga-vss-dll-obj-y = qga/
 elf2dmp-obj-y = contrib/elf2dmp/
 ivshmem-client-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-client/
 ivshmem-server-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-server/
-rdmacm-mux-obj-y = contrib/rdmacm-mux/
 vhost-user-input-obj-y = contrib/vhost-user-input/
 vhost-user-gpu-obj-y = contrib/vhost-user-gpu/
 
diff --git a/contrib/rdmacm-mux/Makefile.objs b/contrib/rdmacm-mux/Makefile.objs
deleted file mode 100644
index 3df744a..0000000
--- a/contrib/rdmacm-mux/Makefile.objs
+++ /dev/null
@@ -1,3 +0,0 @@
-ifdef CONFIG_PVRDMA
-rdmacm-mux-obj-y = main.o
-endif
diff --git a/contrib/rdmacm-mux/meson.build b/contrib/rdmacm-mux/meson.build
new file mode 100644
index 0000000..29a9ced
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
index 7ad5458..119fcd4 100644
--- a/meson.build
+++ b/meson.build
@@ -194,6 +194,8 @@ qemuutil = declare_dependency(link_with: libqemuutil,
 # Other build targets
 
 if have_tools
+  subdir('contrib/rdmacm-mux')
+
   if 'CONFIG_VHOST_USER' in config_host
     subdir('contrib/libvhost-user')
     subdir('contrib/vhost-user-blk')
-- 
1.8.3.1



