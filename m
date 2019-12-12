Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25EEC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:27:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE1B9214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kC3gYT/M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE1B9214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOVW-0004sT-By
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:27:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyS-0003fz-VM
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyR-0006wD-Ok
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:44 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:35170)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyR-0006v5-I3
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:43 -0500
Received: by mail-wm1-x32e.google.com with SMTP id p17so2391795wmb.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iabFqhpo6A2KWaNIf0m+RVkEHbWOeO2cBAZeGreYgno=;
 b=kC3gYT/MhrM0FuUACXFAy4qHLEdaNmARNSKTmrq6CPRGsjbTIM3gdeXERD6SX6Hr5f
 gMNqhWIZvYrojAz4dmBJmVt3zU8O4s4c77+r3plOzevrtH/T5SaFIiuLsm53plyphsye
 j0eGaqDgMC2HkaexK4PoX/roQCeFClX27bPuxxW/XjhcQaSsP7/VtoEdvs0Ao5zfXvrC
 27Vwzl7+drtKW06Ptm0JXTSEB2k/Oal0kJRZPHxTGBtlz7KESKfX/6vzAoueDLzB21ku
 FsVAacLeV3DzW0XzvoZuveib+Mv5xDez5IkKGCJPR9H5wK0r6PzrlP0W84Po8KZynFAv
 TLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=iabFqhpo6A2KWaNIf0m+RVkEHbWOeO2cBAZeGreYgno=;
 b=BgqnjdLbAB9ehwZQg+cPD8YKLl4HCEg/aUOZTtMBQQgmyae0W0QIHtcRaVrRPWcsR/
 kFdILWp/x8uj3NaGYd+rQ0x765FD2dc+B2bkY9ymN/vNseOeMT5K/Rv4qgngjlQbXsxa
 CUcyGzwJQmhQSR6aUT201GApsEOAGqUqKZalCn1cAMjLLQFtL8Z7nNeAuc7pbiJ5Ye7E
 xerffhtpdzXYthzyJnSBGaL6H7El6LM8Ywda8jdr6/7jVcgpU3Pd4WJ0wFTIBdXE3Z+F
 3O1a6Gw2P299lDgnRaUDfnfgOc8gBjGzPtEXm4jms89+oC6deVuC8G06jLtMhc1Am6A9
 8meA==
X-Gm-Message-State: APjAAAXy16ueGsaBgW3u6MArCzDgRzC45Bg3SPrLT/b5iWJe9id5uRVA
 4JjCQo+V8FRSkAmHz4Tva9q6FHFI
X-Google-Smtp-Source: APXvYqzG0QnvDhoH51BYWcZt7ISZfY4+vTEDfc6Yk7W6CSXBd38hDTlqa+xJFnd13t5kgUliuHPiNA==
X-Received: by 2002:a7b:c004:: with SMTP id c4mr6315495wmb.45.1576155222404;
 Thu, 12 Dec 2019 04:53:42 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:41 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 044/132] meson: qemu-pr-helper
Date: Thu, 12 Dec 2019 13:51:28 +0100
Message-Id: <1576155176-2464-45-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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
 Makefile    |  5 -----
 configure   |  1 -
 meson.build | 10 ++++++++++
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 764981d..0cbdc34 100644
--- a/Makefile
+++ b/Makefile
@@ -231,11 +231,6 @@ Makefile: $(version-obj-y)
 
 COMMON_LDADDS = libqemuutil.a
 
-scsi/qemu-pr-helper$(EXESUF): scsi/qemu-pr-helper.o scsi/utils.o $(authz-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
-ifdef CONFIG_MPATH
-scsi/qemu-pr-helper$(EXESUF): LIBS += -ludev -lmultipath -lmpathpersist
-endif
-
 ifneq ($(EXESUF),)
 .PHONY: qga/qemu-ga
 qga/qemu-ga: qga/qemu-ga$(EXESUF) $(QGA_VSS_PROVIDER) $(QEMU_GA_MSI)
diff --git a/configure b/configure
index 964897c..4757e45 100755
--- a/configure
+++ b/configure
@@ -6061,7 +6061,6 @@ if test "$softmmu" = yes ; then
       fi
       mpath=no
     fi
-    tools="$tools scsi/qemu-pr-helper\$(EXESUF)"
   else
     if test "$virtfs" = yes; then
       error_exit "VirtFS is supported only on Linux"
diff --git a/meson.build b/meson.build
index 2b4b36d..b16ab72 100644
--- a/meson.build
+++ b/meson.build
@@ -108,6 +108,10 @@ if 'CONFIG_LIBCAP_NG' in config_host
 endif
 xkbcommon = dependency('xkbcommon', required: false)
 rt = cc.find_library('rt', required: false)
+libmpathpersist = declare_dependency()
+if config_host.has_key('CONFIG_MPATH')
+  libmpathpersist = cc.find_library('mpathpersist')
+endif
 libiscsi = declare_dependency()
 if 'CONFIG_LIBISCSI' in config_host
   libiscsi = declare_dependency(compile_args: config_host['LIBISCSI_CFLAGS'].split(),
@@ -586,6 +590,7 @@ foreach target : target_dirs
 endforeach
 
 # Other build targets
+
 if 'CONFIG_GUEST_AGENT' in config_host
   subdir('qga')
 endif
@@ -623,6 +628,11 @@ if have_tools
                dependencies: [qemuutil, libcap_ng],
                install: true,
                install_dir: get_option('libexecdir'))
+
+    executable('qemu-pr-helper', files('scsi/qemu-pr-helper.c', 'scsi/utils.c'),
+               dependencies: [authz, crypto, io, qom, qemuutil,
+                              libcap_ng, libudev, libmpathpersist],
+               install: true)
   endif
 
   if 'CONFIG_IVSHMEM' in config_host
-- 
1.8.3.1



