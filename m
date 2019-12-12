Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE59C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:18:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9766621655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/gEKCk/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9766621655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOMi-000858-Bc
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:18:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59827)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyA-0003Bb-UN
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNy9-0006Kq-Jw
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:26 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:40421)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNy9-0006J9-B9
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:25 -0500
Received: by mail-wm1-x334.google.com with SMTP id t14so2370700wmi.5
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xSwt9wbl5F36WhAyO5q9Z+UABxMxg8aLFFIonQFV0ZI=;
 b=f/gEKCk/XUaOSVmfmoV0SzT0dGhPIm6K4QJWBLAQJqvirUvI/6zb/eVfSsdiGcuZE8
 RxeUNnE5FND13W9sZqL7YJZQVn9x9xzqcp7cLr+BZfbPGqHx4x8mQPMK3BEHFt/F8BML
 fJwbV6nVuVJSKybPTAFI10TaiqBBv1YSzzF8UxoUYViD3kFUiLI5RAflnI1I0kSXv9f2
 mOcIfCHpvn/3ZEvikwB0ixqlJZ1//OY4MpmEOcBsNi2PPgmR5f+TdaDE13ajVWAVmI+O
 C+ukl54otyAMjpUGhf2hz7i9VZpO2zbxc5YlYWkjVGlYW4Cne13eZ3dmzIxIEobUUvob
 ZHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=xSwt9wbl5F36WhAyO5q9Z+UABxMxg8aLFFIonQFV0ZI=;
 b=t0Bbci1FUMM9qin8A3DwMDSrBEyznIDOcPlbaCqnL2YI2NRXKzPRdlrUe9g2aJoREK
 PIK2nZyN82OFbEAetbBWkVXzOYU5JfKW06zwjZW3bxAfqhFZTBysBSazSf6HLwbFIB1M
 kp5GBeWUtlGxHnH6Q/v+c5GTkEtwBhdWGFaeChpa+8hLNcI7DYyPjiqtXhi7lrM5ODAS
 CoCx/kmp6hBxgyJB7/gxrdFDji7xcqiFAmnnGQFTiGDOZsx7y11kduas6UjXhIfQfvXT
 LUC9w2+7MuPcJNnfLs4rJ8yqX6k4xH8Jaui9GPrxxdFsRK29nsTyBmT8qJ+VGvB+WmOR
 TH+Q==
X-Gm-Message-State: APjAAAW97CpIRbp6o/d0RDxtuJRDsXIGayquPNuc/vPCoPJTaz9reviC
 Pfdih17JR+a0rZRwkrBzOQUB4YOl
X-Google-Smtp-Source: APXvYqwq1rWduoMDzxs2tDeA/WdQtc6xWxSpF3ILrUq2A2zDZVjLoOlbjoX8RbDNFLZzLPxcHzllZA==
X-Received: by 2002:a1c:48c1:: with SMTP id v184mr6703342wma.5.1576155204141; 
 Thu, 12 Dec 2019 04:53:24 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:23 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 026/132] meson: add virtfs-proxy-helper
Date: Thu, 12 Dec 2019 13:51:10 +0100
Message-Id: <1576155176-2464-27-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
 Makefile          | 3 ---
 configure         | 6 ++++--
 fsdev/meson.build | 4 ++++
 meson.build       | 6 ++++++
 4 files changed, 14 insertions(+), 5 deletions(-)
 create mode 100644 fsdev/meson.build

diff --git a/Makefile b/Makefile
index 6a888b0..9110115 100644
--- a/Makefile
+++ b/Makefile
@@ -372,9 +372,6 @@ qemu-img$(EXESUF): qemu-img.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io
 qemu-nbd$(EXESUF): qemu-nbd.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 qemu-io$(EXESUF): qemu-io.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 
-fsdev/virtfs-proxy-helper$(EXESUF): fsdev/virtfs-proxy-helper.o fsdev/9p-marshal.o fsdev/9p-iov-marshal.o $(COMMON_LDADDS)
-fsdev/virtfs-proxy-helper$(EXESUF): LIBS += -lcap
-
 scsi/qemu-pr-helper$(EXESUF): scsi/qemu-pr-helper.o scsi/utils.o $(authz-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 ifdef CONFIG_MPATH
 scsi/qemu-pr-helper$(EXESUF): LIBS += -ludev -lmultipath -lmpathpersist
diff --git a/configure b/configure
index 0b294bb..ca91a76 100755
--- a/configure
+++ b/configure
@@ -3969,6 +3969,7 @@ fi
 ##########################################
 # attr probe
 
+libattr_libs=
 if test "$attr" != "no" ; then
   cat > $TMPC <<EOF
 #include <stdio.h>
@@ -3985,7 +3986,8 @@ EOF
   # Older distros have <attr/xattr.h>, and need -lattr:
   elif compile_prog "-DCONFIG_LIBATTR" "-lattr" ; then
     attr=yes
-    LIBS="-lattr $LIBS"
+    libattr_libs="-lattr"
+    LIBS="$libattr_libs $LIBS"
     libattr=yes
   else
     if test "$attr" = "yes" ; then
@@ -6050,7 +6052,6 @@ if test "$softmmu" = yes ; then
   if test "$linux" = yes; then
     if test "$virtfs" != no && test "$cap_ng" = yes && test "$attr" = yes ; then
       virtfs=yes
-      tools="$tools fsdev/virtfs-proxy-helper\$(EXESUF)"
     else
       if test "$virtfs" = yes; then
         error_exit "VirtFS requires libcap devel and libattr devel"
@@ -6833,6 +6834,7 @@ if test "$linux_aio" = "yes" ; then
 fi
 if test "$attr" = "yes" ; then
   echo "CONFIG_ATTR=y" >> $config_host_mak
+  echo "LIBATTR_LIBS=$libattr_libs" >> $config_host_mak
 fi
 if test "$libattr" = "yes" ; then
   echo "CONFIG_LIBATTR=y" >> $config_host_mak
diff --git a/fsdev/meson.build b/fsdev/meson.build
new file mode 100644
index 0000000..eee8507
--- /dev/null
+++ b/fsdev/meson.build
@@ -0,0 +1,4 @@
+if have_tools and libattr.found() and libcap_ng.found() and 'CONFIG_VIRTFS' in config_host
+  executable('virtfs-proxy-helper', files('virtfs-proxy-helper.c', '9p-marshal.c', '9p-iov-marshal.c'),
+             dependencies: [qemuutil, libattr, libcap_ng])
+endif
diff --git a/meson.build b/meson.build
index e5b0e31..b53c2dc 100644
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
@@ -220,6 +224,8 @@ libqemuutil = static_library('qemuutil',
 qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: version_res)
 
+subdir('fsdev')
+
 # Other build targets
 if 'CONFIG_GUEST_AGENT' in config_host
   subdir('qga')
-- 
1.8.3.1



