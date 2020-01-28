Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B75FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:28:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C54D20716
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mc5Tw17z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C54D20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVbe-00038q-JK
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:28:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV4s-0007fU-QQ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV4r-0001En-Fr
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:06 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:41164)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV4r-0001D2-7Q
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:05 -0500
Received: by mail-wr1-x42d.google.com with SMTP id c9so17101729wrw.8
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vAvlm/xWZzqRR5NwywQxhbYG7nOJSR2l5vCiWJP7ubk=;
 b=Mc5Tw17zqlQhPTbufcjeUNnDE7f3IvsV894dzTOwfpJUkAmcoDYudD3SUrMXBMOs1o
 09F23xIFcUYjk+iiVFHhedhxyZeKzwA7H/FkS9QBXudMyxUVcjA58adqgMUUJveF2mAv
 bHdbU0YqjUfQyCYfpHpnZJ3xvkH7V8QOxWvZjRBtv+abhrAwsx8HX/g609ckuVGgkX46
 0lEQL0Ub4xLzO++x6mXoUR4/65mC3aKGyZeEmZGpqBoSdWT8pwNzffzBnourqwzE71l3
 NHqSlAXgQgh3GYXtGXssQEuizuKqnvkPcV05vKTfMxA82tHPeaIFSXQXuaNYVvUoLgTX
 gsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=vAvlm/xWZzqRR5NwywQxhbYG7nOJSR2l5vCiWJP7ubk=;
 b=Z27Zgk0rNF97cQUcKokXPoGIoP3Tz3oV7SHDC36AjF9FTqlS460t2RKSKIEUVjCOSh
 jaIcB+w1G/zXuqWh5RtVAIesnPBOjjTBMaievLD6DdMRXA5g13/1fOLiZ0y/V2AFXJxR
 7mBt0jLdpYwHWUWw69QCUofJVkeTuU68Z2GKtmJxpnLMVSIfjObvTIu/3tJCKVu69YC+
 I4IGwUcIvPtVeQOBAt15IUQkthVJpD9TbLw/bXDnyZpcPPqRG6frf/OuSw10+68N4MYm
 YCYUrl2AQ+KorXfwx+O9324GmVaiaXlsosbvxAbLOUYfSIbJrP+joKn/9HeP9BXDccR/
 Hm2Q==
X-Gm-Message-State: APjAAAW4nhl/Vj3Kbd+l8bL1nsLOvJ9rbFM9uVKwyZ6dbNZUvxBcDR/i
 vcMCXLvrFoYuOFqCNy4dQng4yg0u
X-Google-Smtp-Source: APXvYqwvk3dJygGfB7tyc8CABR1UGGTwYGCMU3w2xZOlyNBThloztqCvVOCNaoIt5rMKWW+Un/afTg==
X-Received: by 2002:a5d:4a91:: with SMTP id o17mr28486528wrq.232.1580234103975; 
 Tue, 28 Jan 2020 09:55:03 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.55.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:55:03 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 031/142] meson: add virtfs-proxy-helper
Date: Tue, 28 Jan 2020 18:51:51 +0100
Message-Id: <20200128175342.9066-32-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
 Makefile          | 2 --
 configure         | 6 ++++--
 fsdev/meson.build | 4 ++++
 meson.build       | 6 ++++++
 4 files changed, 14 insertions(+), 4 deletions(-)
 create mode 100644 fsdev/meson.build

diff --git a/Makefile b/Makefile
index f4965823c6..781d3595ae 100644
--- a/Makefile
+++ b/Makefile
@@ -401,8 +401,6 @@ qemu-img$(EXESUF): qemu-img.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io
 qemu-nbd$(EXESUF): qemu-nbd.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 qemu-io$(EXESUF): qemu-io.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 
-fsdev/virtfs-proxy-helper$(EXESUF): fsdev/virtfs-proxy-helper.o fsdev/9p-marshal.o fsdev/9p-iov-marshal.o $(COMMON_LDADDS)
-
 scsi/qemu-pr-helper$(EXESUF): scsi/qemu-pr-helper.o scsi/utils.o $(authz-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 ifdef CONFIG_MPATH
 scsi/qemu-pr-helper$(EXESUF): LIBS += -ludev -lmultipath -lmpathpersist
diff --git a/configure b/configure
index 6d0d0b5b72..36a6f8682f 100755
--- a/configure
+++ b/configure
@@ -4060,6 +4060,7 @@ fi
 ##########################################
 # attr probe
 
+libattr_libs=
 if test "$attr" != "no" ; then
   cat > $TMPC <<EOF
 #include <stdio.h>
@@ -4076,7 +4077,8 @@ EOF
   # Older distros have <attr/xattr.h>, and need -lattr:
   elif compile_prog "-DCONFIG_LIBATTR" "-lattr" ; then
     attr=yes
-    LIBS="-lattr $LIBS"
+    libattr_libs="-lattr"
+    LIBS="$libattr_libs $LIBS"
     libattr=yes
   else
     if test "$attr" = "yes" ; then
@@ -6211,7 +6213,6 @@ if test "$softmmu" = yes ; then
   if test "$linux" = yes; then
     if test "$virtfs" != no && test "$cap_ng" = yes && test "$attr" = yes ; then
       virtfs=yes
-      tools="$tools fsdev/virtfs-proxy-helper\$(EXESUF)"
     else
       if test "$virtfs" = yes; then
         error_exit "VirtFS requires libcap-ng devel and libattr devel"
@@ -7005,6 +7006,7 @@ if test "$linux_aio" = "yes" ; then
 fi
 if test "$attr" = "yes" ; then
   echo "CONFIG_ATTR=y" >> $config_host_mak
+  echo "LIBATTR_LIBS=$libattr_libs" >> $config_host_mak
 fi
 if test "$libattr" = "yes" ; then
   echo "CONFIG_LIBATTR=y" >> $config_host_mak
diff --git a/fsdev/meson.build b/fsdev/meson.build
new file mode 100644
index 0000000000..eee8507033
--- /dev/null
+++ b/fsdev/meson.build
@@ -0,0 +1,4 @@
+if have_tools and libattr.found() and libcap_ng.found() and 'CONFIG_VIRTFS' in config_host
+  executable('virtfs-proxy-helper', files('virtfs-proxy-helper.c', '9p-marshal.c', '9p-iov-marshal.c'),
+             dependencies: [qemuutil, libattr, libcap_ng])
+endif
diff --git a/meson.build b/meson.build
index 229d625bb4..9029821028 100644
--- a/meson.build
+++ b/meson.build
@@ -56,6 +56,10 @@ if 'CONFIG_GNUTLS' in config_host
 endif
 pixman = declare_dependency(compile_args: config_host['PIXMAN_CFLAGS'].split(),
                             link_args: config_host['PIXMAN_LIBS'].split())
+libattr = declare_dependency()
+if 'CONFIG_ATTR' in config_host
+  libattr = declare_dependency(link_args: config_host['LIBATTR_LIBS'].split())
+endif
 libcap_ng = declare_dependency()
 if 'CONFIG_LIBCAP_NG' in config_host
   libcap_ng = declare_dependency(link_args: config_host['LIBCAP_NG_LIBS'].split())
@@ -236,6 +240,8 @@ libqemuutil = static_library('qemuutil',
 qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: version_res)
 
+subdir('fsdev')
+
 # Other build targets
 if 'CONFIG_GUEST_AGENT' in config_host
   subdir('qga')
-- 
2.21.0



