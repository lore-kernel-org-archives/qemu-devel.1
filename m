Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EF3C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:53:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62738204EA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sk6A1icf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62738204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6WOY-00040N-Kq
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 05:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6VnH-0006gP-Ku
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:14:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56234)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6VnE-00031J-3L
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:14:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597396471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=58ST2JBFXGz6KLDJCL2Z29LR+CNCHx9z3DOQXmXwWSs=;
 b=Sk6A1icf7rmFuNpQbwI9lkAyBny7hAab2wPEvovYZ1t8wfZfMFeU8DnjDFUzUd7ckoQUhV
 xUNBWYWs2G6YLX5VOnUdYpcgKIh76c8vjfHEvy5+wQM4tn09cofllLdo2M273iN9cGYn1x
 dRYZ5Zh66JL+2Fcs5GXx91+2OQx+x4c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-YTn9ep9uO-m33LrKrx1Jjw-1; Fri, 14 Aug 2020 05:14:29 -0400
X-MC-Unique: YTn9ep9uO-m33LrKrx1Jjw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8D241DDE0
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:14:28 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7AE75600E4;
 Fri, 14 Aug 2020 09:14:28 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 081/150] meson: convert backends directory to Meson
Date: Fri, 14 Aug 2020 05:12:17 -0400
Message-Id: <20200814091326.16173-82-pbonzini@redhat.com>
In-Reply-To: <20200814091326.16173-1-pbonzini@redhat.com>
References: <20200814091326.16173-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 05:13:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
 Makefile.objs              |  2 --
 backends/Makefile.objs     | 23 -----------------------
 backends/meson.build       | 19 +++++++++++++++++++
 backends/tpm/Makefile.objs |  4 ----
 backends/tpm/meson.build   |  8 ++++++++
 configure                  |  2 ++
 meson.build                |  5 +++++
 7 files changed, 34 insertions(+), 29 deletions(-)
 delete mode 100644 backends/Makefile.objs
 create mode 100644 backends/meson.build
 delete mode 100644 backends/tpm/Makefile.objs
 create mode 100644 backends/tpm/meson.build

diff --git a/Makefile.objs b/Makefile.objs
index f2700442a4..c00851a0cd 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -66,8 +66,6 @@ common-obj-$(if $(and $(CONFIG_BZIP2),$(CONFIG_DMG)),m) += block-dmg-bz2$(DSOSUF
 common-obj-y += hw/
 common-obj-m += hw/
 
-common-obj-y += backends/
-
 common-obj-y += qapi/
 
 common-obj-y += libqmp.fa
diff --git a/backends/Makefile.objs b/backends/Makefile.objs
deleted file mode 100644
index 22d204cb48..0000000000
--- a/backends/Makefile.objs
+++ /dev/null
@@ -1,23 +0,0 @@
-common-obj-y += rng.o rng-egd.o rng-builtin.o
-common-obj-$(CONFIG_POSIX) += rng-random.o
-
-common-obj-$(CONFIG_TPM) += tpm/
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
-
-common-obj-$(CONFIG_GIO) += dbus-vmstate.o
-dbus-vmstate.o-cflags = $(GIO_CFLAGS)
-dbus-vmstate.o-libs = $(GIO_LIBS)
diff --git a/backends/meson.build b/backends/meson.build
new file mode 100644
index 0000000000..484456ece7
--- /dev/null
+++ b/backends/meson.build
@@ -0,0 +1,19 @@
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
+softmmu_ss.add(when: 'CONFIG_LINUX', if_true: files('hostmem-memfd.c'))
+softmmu_ss.add(when: ['CONFIG_VHOST_USER', 'CONFIG_VIRTIO'], if_true: files('vhost-user.c'))
+softmmu_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('cryptodev-vhost.c'))
+softmmu_ss.add(when: ['CONFIG_VIRTIO_CRYPTO', 'CONFIG_VHOST_CRYPTO'], if_true: files('cryptodev-vhost-user.c'))
+softmmu_ss.add(when: 'CONFIG_GIO', if_true: [files('dbus-vmstate.c'), gio])
+
+subdir('tpm')
diff --git a/backends/tpm/Makefile.objs b/backends/tpm/Makefile.objs
deleted file mode 100644
index db2731f634..0000000000
--- a/backends/tpm/Makefile.objs
+++ /dev/null
@@ -1,4 +0,0 @@
-common-obj-y += tpm_backend.o
-common-obj-y += tpm_util.o
-common-obj-$(CONFIG_TPM_PASSTHROUGH) += tpm_passthrough.o
-common-obj-$(CONFIG_TPM_EMULATOR) += tpm_emulator.o
diff --git a/backends/tpm/meson.build b/backends/tpm/meson.build
new file mode 100644
index 0000000000..857929082e
--- /dev/null
+++ b/backends/tpm/meson.build
@@ -0,0 +1,8 @@
+tpm_ss = ss.source_set()
+
+tpm_ss.add(files('tpm_backend.c'))
+tpm_ss.add(files('tpm_util.c'))
+tpm_ss.add(when: 'CONFIG_TPM_PASSTHROUGH', if_true: files('tpm_passthrough.c'))
+tpm_ss.add(when: 'CONFIG_TPM_EMULATOR', if_true: files('tpm_emulator.c'))
+
+softmmu_ss.add_all(when: 'CONFIG_TPM', if_true: tpm_ss)
diff --git a/configure b/configure
index ebce9e6766..c2aa600084 100755
--- a/configure
+++ b/configure
@@ -4692,6 +4692,7 @@ EOF
   if compile_prog "" "-lnuma" ; then
     numa=yes
     libs_softmmu="-lnuma $libs_softmmu"
+    numa_libs="-lnuma"
   else
     if test "$numa" = "yes" ; then
       feature_not_found "numa" "install numactl devel"
@@ -8318,6 +8319,7 @@ fi
 
 if test "$numa" = "yes"; then
   echo "CONFIG_NUMA=y" >> $config_host_mak
+  echo "NUMA_LIBS=$numa_libs" >> $config_host_mak
 fi
 
 if test "$ccache_cpp2" = "yes"; then
diff --git a/meson.build b/meson.build
index 18d9e97d32..8955ca280e 100644
--- a/meson.build
+++ b/meson.build
@@ -317,6 +317,10 @@ rdma = not_found
 if 'CONFIG_RDMA' in config_host
   rdma = declare_dependency(link_args: config_host['RDMA_LIBS'].split())
 endif
+numa = not_found
+if 'CONFIG_NUMA' in config_host
+  numa = declare_dependency(link_args: config_host['NUMA_LIBS'].split())
+endif
 
 create_config = find_program('scripts/create_config')
 minikconf = find_program('scripts/minikconf.py')
@@ -664,6 +668,7 @@ softmmu_ss.add(when: ['CONFIG_FDT', fdt],  if_true: [files('device_tree.c')])
 common_ss.add(files('cpus-common.c'))
 
 subdir('softmmu')
+subdir('backends')
 subdir('migration')
 subdir('monitor')
 subdir('net')
-- 
2.26.2



