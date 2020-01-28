Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6024BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:43:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3285C207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="svlYlVfE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3285C207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVps-0008NI-Cn
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:43:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33627)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV6A-0001MB-2x
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV68-0004Ib-NS
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:25 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:54055)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV68-0004Ft-EB
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:24 -0500
Received: by mail-wm1-x32c.google.com with SMTP id s10so3519983wmh.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7nHp/4K3dRmQHoEenXynkehaiDpUUL3dsoppn++lsL0=;
 b=svlYlVfEuup0aVruhpIXamIh2kQLTvELDd9/V4L+d6wC2qWTudKik161j/VJnZ5ZpG
 Rz5FMBE1UBb2+QaXarOa5RXYCK22qiAIKgt5jmebmT5YjQ9SYe4oSdmsg1VnXk/6H5kI
 cuB4+4LxxRcJ0p/0Q8l8Jyunrt6qgiNj+PZsXiJmp6/juxsMcTwXaBcyYnotMtVUhcdx
 laasMciHQsmZA+0N3qVe6uYgV9C2zoQZSX2jc7beT2Dd5lnoawbPhrRcpIWo1pKK+XDp
 wLQwNlXhVme/fzrfhsc9XPxOtTmBisD10NJ3KKoQXj1tjncbeUzm0xczgbYDhTpiCVMC
 gzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=7nHp/4K3dRmQHoEenXynkehaiDpUUL3dsoppn++lsL0=;
 b=r4NxvQjcM90Ux+11YHMEq3HjYzYdkP71peEzGUXQ4YVr8gRfah7rqGgL88tmbIYVUE
 JEjyyEmDiie/gyzf6mQpO1hiLhYb4BAlovMuKgITTNfjSY1ng1uAs5/YBp0QEW7yB24B
 gpA+cyjdlZ+5u717GtE7Rdm6MqcgaB80HE38kBwlnHY1jV07MQHSMSUX2wlOq4496W4M
 4BWT6L/jGBn8JNg2VtkiZG2BhSn4povE+1hkRBgviElH6MqTXDmCjfDHzn1cSsoihhTa
 HR92xgYLHHo+RcvJkt/47S1QXnxrLLM82vV5/uDXyQzaSxs4kIhKMIN5El+0eArmbC/E
 TdMw==
X-Gm-Message-State: APjAAAXzxpOmA1zzJNX1T6JT0ObFBy5W0ThX6S/FCq2NnFfgrSs8lqbp
 A7SGyvlStRHYw/j3BLy7/6NS49bR
X-Google-Smtp-Source: APXvYqz5CzHzRgxuw8HGKwrrCCPCwvXKsFXbso5FD8y10d6d+HPMZs1Q7K3zRGIKXEIBuYCIzRDpNw==
X-Received: by 2002:a1c:1f56:: with SMTP id f83mr6229598wmf.93.1580234183187; 
 Tue, 28 Jan 2020 09:56:23 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.56.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:56:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 065/142] meson: convert backends directory to Meson
Date: Tue, 28 Jan 2020 18:52:25 +0100
Message-Id: <20200128175342.9066-66-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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
 Makefile.objs          |  1 -
 backends/Makefile.objs | 19 -------------------
 backends/meson.build   | 17 +++++++++++++++++
 configure              |  2 ++
 meson.build            |  5 +++++
 5 files changed, 24 insertions(+), 20 deletions(-)
 delete mode 100644 backends/Makefile.objs
 create mode 100644 backends/meson.build

diff --git a/Makefile.objs b/Makefile.objs
index 2b68f487a3..e56106400c 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -60,7 +60,6 @@ common-obj-$(if $(CONFIG_LZFSE),m) += block-dmg-lzfse$(DSOSUF)
 common-obj-$(if $(and $(CONFIG_BZIP2),$(CONFIG_DMG)),m) += block-dmg-bz2$(DSOSUF)
 
 common-obj-y += hw/
-common-obj-y += backends/
 endif
 
 #######################################################################
diff --git a/backends/Makefile.objs b/backends/Makefile.objs
deleted file mode 100644
index f0691116e8..0000000000
--- a/backends/Makefile.objs
+++ /dev/null
@@ -1,19 +0,0 @@
-common-obj-y += rng.o rng-egd.o rng-builtin.o
-common-obj-$(CONFIG_POSIX) += rng-random.o
-
-common-obj-$(CONFIG_TPM) += tpm.o
-
-common-obj-y += hostmem.o hostmem-ram.o
-common-obj-$(CONFIG_POSIX) += hostmem-file.o
-
-common-obj-y += cryptodev.o
-common-obj-y += cryptodev-builtin.o
-
-ifeq ($(CONFIG_VIRTIO_CRYPTO),y)
-common-obj-y += cryptodev-vhost.o
-common-obj-$(CONFIG_VHOST_CRYPTO) += cryptodev-vhost-user.o
-endif
-
-common-obj-$(call land,$(CONFIG_VHOST_USER),$(CONFIG_VIRTIO)) += vhost-user.o
-
-common-obj-$(CONFIG_LINUX) += hostmem-memfd.o
diff --git a/backends/meson.build b/backends/meson.build
new file mode 100644
index 0000000000..3c81e9aff5
--- /dev/null
+++ b/backends/meson.build
@@ -0,0 +1,17 @@
+softmmu_ss.add([files(
+  'cryptodev-builtin.c',
+  'cryptodev.c',
+  'hostmem-ram.c',
+  'hostmem.c',
+  'rng-builtin.c',
+  'rng-egd.c',
+  'rng.c',
+), numa])
+
+softmmu_ss.add(when: 'CONFIG_POSIX', if_true: files('rng-random.c'))
+softmmu_ss.add(when: 'CONFIG_POSIX', if_true: files('hostmem-file.c'))
+softmmu_ss.add(when: 'CONFIG_TPM', if_true: files('tpm.c'))
+softmmu_ss.add(when: 'CONFIG_LINUX', if_true: files('hostmem-memfd.c'))
+softmmu_ss.add(when: ['CONFIG_VHOST_USER', 'CONFIG_VIRTIO'], if_true: files('vhost-user.c'))
+softmmu_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('cryptodev-vhost.c'))
+softmmu_ss.add(when: ['CONFIG_VIRTIO_CRYPTO', 'CONFIG_VHOST_CRYPTO'], if_true: files('cryptodev-vhost-user.c'))
diff --git a/configure b/configure
index 5f579b2ea3..cfc7a5352c 100755
--- a/configure
+++ b/configure
@@ -4408,6 +4408,7 @@ EOF
   if compile_prog "" "-lnuma" ; then
     numa=yes
     libs_softmmu="-lnuma $libs_softmmu"
+    numa_libs="-lnuma"
   else
     if test "$numa" = "yes" ; then
       feature_not_found "numa" "install numactl devel"
@@ -8001,6 +8002,7 @@ fi
 
 if test "$numa" = "yes"; then
   echo "CONFIG_NUMA=y" >> $config_host_mak
+  echo "NUMA_LIBS=$numa_libs" >> $config_host_mak
 fi
 
 if test "$ccache_cpp2" = "yes"; then
diff --git a/meson.build b/meson.build
index 713aca221e..24fe26e635 100644
--- a/meson.build
+++ b/meson.build
@@ -290,6 +290,10 @@ if 'CONFIG_LIBPMEM' in config_host
   libpmem = declare_dependency(compile_args: config_host['LIBPMEM_CFLAGS'].split(),
                                link_args: config_host['LIBPMEM_LIBS'].split())
 endif
+numa = declare_dependency()
+if 'CONFIG_NUMA' in config_host
+  numa = declare_dependency(link_args: config_host['NUMA_LIBS'].split())
+endif
 
 create_config = find_program('scripts/create_config')
 minikconf = find_program('scripts/minikconf.py')
@@ -618,6 +622,7 @@ softmmu_ss.add(when: ['CONFIG_FDT', fdt],  if_true: [files('device_tree.c')])
 
 common_ss.add(files('cpus-common.c'))
 
+subdir('backends')
 subdir('migration')
 subdir('monitor')
 subdir('net')
-- 
2.21.0



