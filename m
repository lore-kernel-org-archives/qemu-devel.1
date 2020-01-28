Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3655C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:09:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF1B0214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/aZHpDc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF1B0214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVJ7-0002OK-Rg
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:09:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV4K-0006Yy-2n
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV4I-0008P2-VD
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:31 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34379)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV4I-0008Nl-Lf
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:30 -0500
Received: by mail-wr1-x441.google.com with SMTP id t2so17093489wrr.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3tX2+1FRjED10Vt1Su9pKzrcJCrFM/oNJwwahn4nJD8=;
 b=X/aZHpDcGxfXKt4j1rpiMgr+NSHkJln7jgyF8l2x42RwV60CVWShSlLPIenA0I2WYT
 7PDpUNUOyH+dzKhn96plo4AaEIZmOk14J/MycEwy1CofCKqfMWUwKvRMqpCuxoAK9jp8
 W9wk1gm6+LgSb5u2ulUv9dpqUPbmM5baWCtRcil/VWcs22WVjWndaJjJ4YbI+hWvk1o9
 j4ib336x1whMUAyKs54VUCwvNWaPi18+j3NLVYHFQQJc3WpWuGBG9KaJDV/uPCLHzP31
 Z/ZQOgpF9xjKxVxiEYPHySgpLEjAwg6hy37if8TEXBYG8Ic99WZ8PWhyXmCHtFlSKjCN
 O7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=3tX2+1FRjED10Vt1Su9pKzrcJCrFM/oNJwwahn4nJD8=;
 b=sJ6QhwXyuG009L6uOdr92KyiQPSZJORGXOiV/XNwMP+HXn1F4aL89/nHuMvpnVGTCM
 t3FO9rsO64d56CYLDaye68LwT+DObs1+jeJSRXvXOHd9cR6DsRkYLRmmpiKYZlkwL4Wf
 gCLCPe+lKt72ikzwrYLJAI8lLBGBA+Qv1kHe7JHMSegvc9qpxE4BSgtdMFhx6Jw9SLRP
 6R4o07Y/uQDK38JQl1ID+QZivZ9ItAENWskR/HfQldeaA8ZeJGD/psfRhMUisTEd7yhQ
 5eFIsDvQek9hYmJ1PkSb9vMJxmePVFfXK8ezzSBbkunJ009FTt5xh2x64+jBMi+cNjde
 tLMg==
X-Gm-Message-State: APjAAAVUUvfivB+eIxNssAe5wMUaT5cQS2DHUIpl9pd0K3Gu0/aIMaBj
 W5U7dopZoMG3WVP2OpqQYeMnvZzA
X-Google-Smtp-Source: APXvYqwAZfKUrrO5BgVH7kpTkHMHT7ZA+TpdsuDKinqQy5HfJZGf6UDGeXngg9/mgBsTxLL69w0N4A==
X-Received: by 2002:adf:c145:: with SMTP id w5mr30546923wre.205.1580234069499; 
 Tue, 28 Jan 2020 09:54:29 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.54.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:54:28 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 017/142] contrib/vhost-user-blk: convert to Meson
Date: Tue, 28 Jan 2020 18:51:37 +0100
Message-Id: <20200128175342.9066-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

The GLib pkg-config information is extracted from config-host.mak and
used to link vhost-user-blk.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                           | 3 ---
 Makefile.objs                      | 1 -
 contrib/vhost-user-blk/meson.build | 3 +++
 meson.build                        | 1 +
 4 files changed, 4 insertions(+), 4 deletions(-)
 create mode 100644 contrib/vhost-user-blk/meson.build

diff --git a/Makefile b/Makefile
index e09b20887c..8c88288d6d 100644
--- a/Makefile
+++ b/Makefile
@@ -291,7 +291,6 @@ dummy := $(call unnest-vars,, \
                 ivshmem-server-obj-y \
                 rdmacm-mux-obj-y \
                 vhost-user-scsi-obj-y \
-                vhost-user-blk-obj-y \
                 vhost-user-input-obj-y \
                 vhost-user-gpu-obj-y \
                 qga-vss-dll-obj-y \
@@ -502,8 +501,6 @@ ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
 endif
 vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
 	$(call LINK, $^)
-vhost-user-blk$(EXESUF): $(vhost-user-blk-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
-	$(call LINK, $^)
 
 rdmacm-mux$(EXESUF): LIBS += "-libumad"
 rdmacm-mux$(EXESUF): $(rdmacm-mux-obj-y) $(COMMON_LDADDS)
diff --git a/Makefile.objs b/Makefile.objs
index 9a14ef50fd..04c424bfa6 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -111,7 +111,6 @@ ivshmem-server-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-server/
 vhost-user-scsi.o-cflags := $(LIBISCSI_CFLAGS)
 vhost-user-scsi.o-libs := $(LIBISCSI_LIBS)
 vhost-user-scsi-obj-y = contrib/vhost-user-scsi/
-vhost-user-blk-obj-y = contrib/vhost-user-blk/
 rdmacm-mux-obj-y = contrib/rdmacm-mux/
 vhost-user-input-obj-y = contrib/vhost-user-input/
 vhost-user-gpu-obj-y = contrib/vhost-user-gpu/
diff --git a/contrib/vhost-user-blk/meson.build b/contrib/vhost-user-blk/meson.build
new file mode 100644
index 0000000000..3856a9a474
--- /dev/null
+++ b/contrib/vhost-user-blk/meson.build
@@ -0,0 +1,3 @@
+executable('vhost-user-blk', files('vhost-user-blk.c'),
+           link_with: libvhost_user,
+           dependencies: qemuutil)
diff --git a/meson.build b/meson.build
index 6e5240c37e..c95fc7c8f3 100644
--- a/meson.build
+++ b/meson.build
@@ -193,5 +193,6 @@ qemuutil = declare_dependency(link_with: libqemuutil,
 if have_tools
   if 'CONFIG_VHOST_USER' in config_host
     subdir('contrib/libvhost-user')
+    subdir('contrib/vhost-user-blk')
   endif
 endif
-- 
2.21.0



