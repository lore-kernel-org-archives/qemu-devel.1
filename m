Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D1FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:50:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76A832086A
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MuGcFPNa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A832086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3lu6-0005fb-DQ
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 15:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lPX-0007MY-1P
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:18:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45269
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lPU-0006fn-UK
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:18:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596741520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oZ085/aeR2z1+BOPKTwsEhaR2W9Xh3eyDTl1aE3nrYQ=;
 b=MuGcFPNaYvztCB2EdDn5M5dwcTOtJ59znM6RhieDmoAOn0BJwMBW6acdEs9VFwhBig1u7c
 pTVhx2eUGiCH2Qd4ipjPFAnQF3yy0KEVsWdNEx47GtKZ9PtCGMmsRyai1SM4exs5I9/1+n
 mPqLCn8raNf5Q/jC2Ik1OTO7x7Z5G9Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-Mbnr7loXOe6v6PoJSGyPuQ-1; Thu, 06 Aug 2020 15:18:38 -0400
X-MC-Unique: Mbnr7loXOe6v6PoJSGyPuQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A234B1DE1
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:18:37 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 283DF5F9DC;
 Thu,  6 Aug 2020 19:18:32 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 077/143] meson: convert backends directory to Meson
Date: Thu,  6 Aug 2020 21:15:13 +0200
Message-Id: <1596741379-12902-78-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:07:42
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
index 8e73682..65b0ae6 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -65,8 +65,6 @@ common-obj-$(if $(and $(CONFIG_BZIP2),$(CONFIG_DMG)),m) += block-dmg-bz2$(DSOSUF
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
index e99af16..96ba99f 100755
--- a/configure
+++ b/configure
@@ -4675,6 +4675,7 @@ EOF
   if compile_prog "" "-lnuma" ; then
     numa=yes
     libs_softmmu="-lnuma $libs_softmmu"
+    numa_libs="-lnuma"
   else
     if test "$numa" = "yes" ; then
       feature_not_found "numa" "install numactl devel"
@@ -8309,6 +8310,7 @@ fi
 
 if test "$numa" = "yes"; then
   echo "CONFIG_NUMA=y" >> $config_host_mak
+  echo "NUMA_LIBS=$numa_libs" >> $config_host_mak
 fi
 
 if test "$ccache_cpp2" = "yes"; then
diff --git a/meson.build b/meson.build
index 73ad78d..77c0df6 100644
--- a/meson.build
+++ b/meson.build
@@ -304,6 +304,10 @@ rdma = not_found
 if 'CONFIG_RDMA' in config_host
   rdma = declare_dependency(link_args: config_host['RDMA_LIBS'].split())
 endif
+numa = not_found
+if 'CONFIG_NUMA' in config_host
+  numa = declare_dependency(link_args: config_host['NUMA_LIBS'].split())
+endif
 
 create_config = find_program('scripts/create_config')
 minikconf = find_program('scripts/minikconf.py')
@@ -641,6 +645,7 @@ softmmu_ss.add(when: ['CONFIG_FDT', fdt],  if_true: [files('device_tree.c')])
 common_ss.add(files('cpus-common.c'))
 
 subdir('softmmu')
+subdir('backends')
 subdir('migration')
 subdir('monitor')
 subdir('net')
-- 
1.8.3.1



