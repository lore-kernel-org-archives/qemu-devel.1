Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AB0C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:16:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCDC12173E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVHMAmhd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCDC12173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOK8-0004K6-8l
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:16:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59367)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNy8-00037m-GB
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNy7-0006Fu-1m
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:24 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:33619)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNy6-0006E3-Pf
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:22 -0500
Received: by mail-wr1-x435.google.com with SMTP id b6so2659121wrq.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HXR0svkyY3DtengHr9Una6kU9oDOnxpx+/sr/xfZFfM=;
 b=XVHMAmhdkBkblMMFlb157dveyCNuYEr9KhrnLNszlVx/7OzqlKqwm144LVYIIPoUXu
 bHPuPYeXdFAoFYwk0RwBb15Zt6XNBqvIXnAdFOqVat1LBjFmX8GQ5mvWGPx7NhBVea8b
 iZWqmQZdze/7SYL8glnxNBu7TVtjhu6HVTRqUznTXDbGgntKz3Iz9lFGZPJDx1cnZOiY
 a/ejM0NQR6hARkhh2NP7SgJuTiyhkZTMM62b050JLDEfIgmvYYgBegAuf1+uMSaxrKAZ
 NoBzXmN0BaRScr2lAhZe2Ty0hWoAQUitp9qbvVEXZ2AWM9Li/2udTvKFFdjeSvjmHjzX
 HtMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=HXR0svkyY3DtengHr9Una6kU9oDOnxpx+/sr/xfZFfM=;
 b=fqaL+uRAb1oX+YvCCeY3yaPNzO5TKIcJkNaYY/g8TRUd4bq6h9HtqfGV9Lw6Sk/RS5
 ENpdV93d+OeiCq6yu4bPur8bHf/Cm5bukqrbMqVG/jw0/8Sujs8KLvhSOPN+sNQ9P+Nv
 Epo//hQ9czwkOQUK657MRRpoArj7U7sO4u6KuZJxexf0JsaR9YITitOJu4v6Lh7N4MIc
 xZG0IU7Jf/O0kQXmD73eANr1wcGNVmzTmkHYfb8pT2mEMjBZZAFk53jSQll1oiZ/iv1C
 bm31gjh1agRXMOS6jb8uBT4Qh7LCaAfEAA4FZLjO9FksdyBpsgTGE7EoYp24Kq5qm9tm
 /SzQ==
X-Gm-Message-State: APjAAAXOV8mWuImFBuqCsksyVSbhKluW9jJ4qqWNgp3aN+CrJF3xWvOa
 Iuz8SgsRPmXCeBr7w5tFMK9ogxnO
X-Google-Smtp-Source: APXvYqwj+CIKZDwlp/uEKyMSItUN2MO8kdJtusCOimeoXlHiBdqk+AKBnZ1soo9nMQ1GgiOu70HCtQ==
X-Received: by 2002:a5d:4b8f:: with SMTP id b15mr6560367wrt.100.1576155201288; 
 Thu, 12 Dec 2019 04:53:21 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:20 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 023/132] meson: add qemu-bridge-helper
Date: Thu, 12 Dec 2019 13:51:07 +0100
Message-Id: <1576155176-2464-24-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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
 Makefile    |  4 ----
 configure   |  1 +
 meson.build | 12 +++++++++++-
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 328b3c3..d153186 100644
--- a/Makefile
+++ b/Makefile
@@ -173,8 +173,6 @@ LIBS+=-lz $(LIBS_TOOLS)
 vhost-user-json-y =
 HELPERS-y =
 
-HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) = qemu-bridge-helper$(EXESUF)
-
 ifeq ($(CONFIG_LINUX)$(CONFIG_VIRGL)$(CONFIG_GBM)$(CONFIG_TOOLS),yyyy)
 vhost-user-json-y += contrib/vhost-user-gpu/50-qemu-gpu.json
 endif
@@ -374,8 +372,6 @@ qemu-img$(EXESUF): qemu-img.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io
 qemu-nbd$(EXESUF): qemu-nbd.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 qemu-io$(EXESUF): qemu-io.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 
-qemu-bridge-helper$(EXESUF): qemu-bridge-helper.o $(COMMON_LDADDS)
-
 qemu-keymap$(EXESUF): qemu-keymap.o ui/input-keymap.o $(COMMON_LDADDS)
 
 qemu-edid$(EXESUF): qemu-edid.o hw/display/edid-generate.o $(COMMON_LDADDS)
diff --git a/configure b/configure
index 4ed65db..9615d63 100755
--- a/configure
+++ b/configure
@@ -6603,6 +6603,7 @@ if test "$l2tpv3" = "yes" ; then
 fi
 if test "$cap_ng" = "yes" ; then
   echo "CONFIG_LIBCAP_NG=y" >> $config_host_mak
+  echo "LIBCAP_NG_LIBS=$cap_libs" >> $config_host_mak
 fi
 echo "CONFIG_AUDIO_DRIVERS=$audio_drv_list" >> $config_host_mak
 for drv in $audio_drv_list; do
diff --git a/meson.build b/meson.build
index 7e772c1..854b1cb 100644
--- a/meson.build
+++ b/meson.build
@@ -56,6 +56,10 @@ if 'CONFIG_GNUTLS' in config_host
 endif
 pixman = declare_dependency(compile_args: config_host['PIXMAN_CFLAGS'].split(),
                             link_args: config_host['PIXMAN_LIBS'].split())
+libcap_ng = declare_dependency()
+if 'CONFIG_LIBCAP_NG' in config_host
+  libcap_ng = declare_dependency(link_args: config_host['LIBCAP_NG_LIBS'].split())
+endif
 rt = cc.find_library('rt', required: false)
 libiscsi = declare_dependency()
 if 'CONFIG_LIBISCSI' in config_host
@@ -216,7 +220,6 @@ qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: version_res)
 
 # Other build targets
-
 if 'CONFIG_GUEST_AGENT' in config_host
   subdir('qga')
 endif
@@ -235,6 +238,13 @@ if have_tools
     subdir('contrib/vhost-user-scsi')
   endif
 
+  if host_machine.system() == 'linux'
+    executable('qemu-bridge-helper', files('qemu-bridge-helper.c'),
+               dependencies: [qemuutil, libcap_ng],
+               install: true,
+               install_dir: get_option('libexecdir'))
+  endif
+
   if 'CONFIG_IVSHMEM' in config_host
     subdir('contrib/ivshmem-client')
     subdir('contrib/ivshmem-server')
-- 
1.8.3.1



