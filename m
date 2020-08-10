Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC645C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:44:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDA2F20885
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ecbKO2uj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA2F20885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5BqY-0001lB-S0
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 13:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BKV-00014b-P0
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:11:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29640
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BKT-00039E-KO
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:11:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597079480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GEBjx1iany2QD0lBsoTZZfzIMugxH4W6T0fpRerskMk=;
 b=ecbKO2ujoZ/G+EK8NrNbxZCaCsx2r6xckAp65StWXhoyHDY3gtR/4GgSLiSv5URD6qlbsa
 l/YYvLgHnwd07wZ6p4V+mco/G5fxNP3PJlyc7Sp+HPS16zXb3Ya9UJfSfEW7RCRHKCivfX
 OwTtun5y0gRxphl4tPpE4hkkTpvpDJk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-6necAZYgMjiZgLzjJvS-Kg-1; Mon, 10 Aug 2020 13:11:18 -0400
X-MC-Unique: 6necAZYgMjiZgLzjJvS-Kg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9CF719067E1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:11:17 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E5C5B5F1E9;
 Mon, 10 Aug 2020 17:11:16 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 078/147] meson: convert backends directory to Meson
Date: Mon, 10 Aug 2020 19:07:56 +0200
Message-Id: <1597079345-42801-79-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 03:29:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
index f270044..c00851a 100644
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
index 22d204c..0000000
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
index 0000000..484456e
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
index db2731f..0000000
--- a/backends/tpm/Makefile.objs
+++ /dev/null
@@ -1,4 +0,0 @@
-common-obj-y += tpm_backend.o
-common-obj-y += tpm_util.o
-common-obj-$(CONFIG_TPM_PASSTHROUGH) += tpm_passthrough.o
-common-obj-$(CONFIG_TPM_EMULATOR) += tpm_emulator.o
diff --git a/backends/tpm/meson.build b/backends/tpm/meson.build
new file mode 100644
index 0000000..8579290
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
index 6f02538..f3baba1 100755
--- a/configure
+++ b/configure
@@ -4678,6 +4678,7 @@ EOF
   if compile_prog "" "-lnuma" ; then
     numa=yes
     libs_softmmu="-lnuma $libs_softmmu"
+    numa_libs="-lnuma"
   else
     if test "$numa" = "yes" ; then
       feature_not_found "numa" "install numactl devel"
@@ -8314,6 +8315,7 @@ fi
 
 if test "$numa" = "yes"; then
   echo "CONFIG_NUMA=y" >> $config_host_mak
+  echo "NUMA_LIBS=$numa_libs" >> $config_host_mak
 fi
 
 if test "$ccache_cpp2" = "yes"; then
diff --git a/meson.build b/meson.build
index 151f4ca..67e7342 100644
--- a/meson.build
+++ b/meson.build
@@ -309,6 +309,10 @@ rdma = not_found
 if 'CONFIG_RDMA' in config_host
   rdma = declare_dependency(link_args: config_host['RDMA_LIBS'].split())
 endif
+numa = not_found
+if 'CONFIG_NUMA' in config_host
+  numa = declare_dependency(link_args: config_host['NUMA_LIBS'].split())
+endif
 
 create_config = find_program('scripts/create_config')
 minikconf = find_program('scripts/minikconf.py')
@@ -656,6 +660,7 @@ softmmu_ss.add(when: ['CONFIG_FDT', fdt],  if_true: [files('device_tree.c')])
 common_ss.add(files('cpus-common.c'))
 
 subdir('softmmu')
+subdir('backends')
 subdir('migration')
 subdir('monitor')
 subdir('net')
-- 
1.8.3.1



