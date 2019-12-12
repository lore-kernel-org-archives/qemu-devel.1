Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C90C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:39:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E44342077B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bha/P4oH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E44342077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOgN-0002JE-Ia
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:39:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyb-0003tG-Kt
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNya-0007FF-5R
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:53 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:55228)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyZ-0007DO-Tx
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:52 -0500
Received: by mail-wm1-x32a.google.com with SMTP id b11so2236948wmj.4
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Atnpcgx8oxW2ZL46UP1c38Ecu167rif8vvUIatLdPCk=;
 b=bha/P4oHOphE9TTm71AWhMgERPcecb1WRO7UkLXAXAlHecA3CsOfWevmYho23B6Jkb
 cj+MvLT0CrGS1Fz5havNVecunO79JIx+PifuGvr0FfSzw9lIjoPusNXzGQNZnr6eiJ3l
 Ad/bdHRYYDCwiJqDdJagO133ZmHZcZOLyVQqIQho1FQfyg/xjMuzmCBMFnNfz7SWKLi/
 6dm94fffQVpGytSJntbfR9/3RUXnte+zLkvUkRjr9Y14uKWOFQEvhF9Yn0TMOQAfnh3e
 5cZjJigBH4WCS1KHYQ6F7Zzkz1UJV72jRwEm3sb1jwNJhimsc26P9jVZXTmIMJAxIXJW
 qtew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Atnpcgx8oxW2ZL46UP1c38Ecu167rif8vvUIatLdPCk=;
 b=TSoaeqF8vpGWr/Yx/Onl4g/XGClkhQIZ3+1R4hfk/dBtTudP9gPKqKAbA8AuYVzJa1
 O0sV2cItQCs4n9i5k+hzS/Q3hNyRyjgPEc3udS/dfC/em++A6Xr9EICTEKUEIYBAFda3
 gziscTn4gza9akHajZ7nmZMieuqw0G4ArsDRqN0OIy4mgWG/G3kuqk8/VztCJ+KFZC/s
 9Cf5c+brGJewlC8/LLTwNH6xKgI/wFd9/7JvrVtyV1wC55pz8Lp92UXR2b9mnTkdDNlj
 ROf9Jc1fP3gRAj4+LrdPDRYHRlDX6Zxz8qTicQeoDpTYgahTzg+RxhJbnrRSgehNwI30
 RP1g==
X-Gm-Message-State: APjAAAXSy0oxuiY2rXK3/wl17Yty3OYhTgRsz1Army5fGdL1AKwTCLD8
 b9wWtkg+BykAUsjHkJR5FYrZrmc7
X-Google-Smtp-Source: APXvYqy9gc3UpLA5JB+Nc22BUEn+VMijDhB/wWQpJm15swGaEMN9y0xnMpoAqIiBuHjpPxV7HWNkMg==
X-Received: by 2002:a1c:286:: with SMTP id 128mr6206268wmc.176.1576155230652; 
 Thu, 12 Dec 2019 04:53:50 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:49 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 053/132] meson: convert dump/
Date: Thu, 12 Dec 2019 13:51:37 +0100
Message-Id: <1576155176-2464-54-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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
---
 Makefile.objs      | 3 +--
 Makefile.target    | 1 -
 configure          | 4 ++++
 dump/Makefile.objs | 3 ---
 dump/meson.build   | 4 ++++
 meson.build        | 9 +++++++++
 6 files changed, 18 insertions(+), 6 deletions(-)
 delete mode 100644 dump/Makefile.objs
 create mode 100644 dump/meson.build

diff --git a/Makefile.objs b/Makefile.objs
index 4c7ae48..1b1eff5 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -35,8 +35,7 @@ qom-obj-y = qom/libqom.fa
 # single QEMU executable should support all CPUs and machines.
 
 ifeq ($(CONFIG_SOFTMMU),y)
-common-obj-y = dump/
-common-obj-y += monitor/
+common-obj-y = monitor/
 common-obj-y += net/
 common-obj-$(CONFIG_LINUX) += fsdev/
 common-obj-y += migration/
diff --git a/Makefile.target b/Makefile.target
index bad50ce..569f2d9 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -153,7 +153,6 @@ endif #CONFIG_BSD_USER
 ifdef CONFIG_SOFTMMU
 obj-y += arch_init.o cpus.o gdbstub.o balloon.o ioport.o
 obj-y += qtest.o
-obj-y += dump/
 obj-y += hw/
 obj-y += monitor/
 obj-y += qapi/
diff --git a/configure b/configure
index c4b50a7..8e55f3a 100755
--- a/configure
+++ b/configure
@@ -2351,6 +2351,7 @@ int main(void) { lzo_version(); return 0; }
 EOF
     if compile_prog "" "-llzo2" ; then
         libs_softmmu="$libs_softmmu -llzo2"
+        lzo_libs="-llzo2"
         lzo="yes"
     else
         if test "$lzo" = "yes"; then
@@ -2370,6 +2371,7 @@ int main(void) { snappy_max_compressed_length(4096); return 0; }
 EOF
     if compile_prog "" "-lsnappy" ; then
         libs_softmmu="$libs_softmmu -lsnappy"
+        snappy_libs='-lsnappy'
         snappy="yes"
     else
         if test "$snappy" = "yes"; then
@@ -6976,10 +6978,12 @@ fi
 
 if test "$lzo" = "yes" ; then
   echo "CONFIG_LZO=y" >> $config_host_mak
+  echo "LZO_LIBS=$lzo_libs" >> $config_host_mak
 fi
 
 if test "$snappy" = "yes" ; then
   echo "CONFIG_SNAPPY=y" >> $config_host_mak
+  echo "SNAPPY_LIBS=$snappy_libs" >> $config_host_mak
 fi
 
 if test "$bzip2" = "yes" ; then
diff --git a/dump/Makefile.objs b/dump/Makefile.objs
deleted file mode 100644
index d2a5db3..0000000
--- a/dump/Makefile.objs
+++ /dev/null
@@ -1,3 +0,0 @@
-obj-y += dump.o
-common-obj-y += dump-hmp-cmds.o
-obj-$(TARGET_X86_64) += win_dump.o
diff --git a/dump/meson.build b/dump/meson.build
new file mode 100644
index 0000000..2eff29c
--- /dev/null
+++ b/dump/meson.build
@@ -0,0 +1,4 @@
+softmmu_ss.add(files('dump-hmp-cmds.c'))
+
+specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: [files('dump.c'), snappy, lzo])
+specific_ss.add(when: ['CONFIG_SOFTMMU', 'TARGET_X86_64'], if_true: files('win_dump.c'))
diff --git a/meson.build b/meson.build
index cb60aac..804a9bc 100644
--- a/meson.build
+++ b/meson.build
@@ -265,6 +265,14 @@ if 'CONFIG_FDT' in config_host
   fdt = declare_dependency(compile_args: config_host['FDT_CFLAGS'].split(),
                            link_args: config_host['FDT_LIBS'].split())
 endif
+snappy = declare_dependency()
+if 'CONFIG_SNAPPY' in config_host
+  snappy = declare_dependency(link_args: config_host['SNAPPY_LIBS'].split())
+endif
+lzo = declare_dependency()
+if 'CONFIG_LZO' in config_host
+  lzo = declare_dependency(link_args: config_host['LZO_LIBS'].split())
+endif
 
 create_config = find_program('scripts/create_config')
 minikconf = find_program('scripts/minikconf.py')
@@ -546,6 +554,7 @@ subdir('audio')
 subdir('io')
 subdir('chardev')
 subdir('fsdev')
+subdir('dump')
 
 block_ss.add(files(
   'block.c',
-- 
1.8.3.1



