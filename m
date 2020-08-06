Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26394C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:48:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A6E62086A
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="elgEUD2H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A6E62086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3lrw-00022K-4l
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 15:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lPS-0007Ba-OK
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:18:38 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34179
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lPQ-0006f1-88
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596741515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MmtPcwRR1QK8m2j8EH3cQcFOMKlasr20fAnjsnC2kgc=;
 b=elgEUD2HQYBAkg/RYDiMv8m4s66feOClBoB5Ox4hZYcEsdE4tBo9NhUfJ35y/OkE5MkyPb
 uRI6C7ML82pN4wfwZ2HH1ky65TsYKOw8W3xL08HgNoJ5sWLHeB4+gd1ReChbR6uAbYIkjI
 Nxl+UxSHpOmPkgq8i9fw/ByxeK7XK2I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-9XQXihJeM8ulJt9po9ikZg-1; Thu, 06 Aug 2020 15:18:33 -0400
X-MC-Unique: 9XQXihJeM8ulJt9po9ikZg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B19111DE1
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:18:32 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C32A35FC3B;
 Thu,  6 Aug 2020 19:18:31 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 076/143] meson: convert net directory to Meson
Date: Thu,  6 Aug 2020 21:15:12 +0200
Message-Id: <1596741379-12902-77-git-send-email-pbonzini@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 05:03:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
 Makefile.objs         |  3 +--
 Makefile.target       |  1 +
 meson.build           | 10 ++++++++++
 net/Makefile.objs     | 32 --------------------------------
 net/can/Makefile.objs |  2 --
 net/can/meson.build   |  5 +++++
 net/meson.build       | 40 ++++++++++++++++++++++++++++++++++++++++
 7 files changed, 57 insertions(+), 36 deletions(-)
 delete mode 100644 net/Makefile.objs
 delete mode 100644 net/can/Makefile.objs
 create mode 100644 net/can/meson.build
 create mode 100644 net/meson.build

diff --git a/Makefile.objs b/Makefile.objs
index aabf709..8e73682 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -38,8 +38,7 @@ endif # CONFIG_SOFTMMU or CONFIG_TOOLS
 # single QEMU executable should support all CPUs and machines.
 
 ifeq ($(CONFIG_SOFTMMU),y)
-common-obj-y = net/
-common-obj-$(CONFIG_LINUX) += fsdev/
+common-obj-$(CONFIG_LINUX) = fsdev/
 
 common-obj-y += accel/
 
diff --git a/Makefile.target b/Makefile.target
index 4d912df..bf3fda9 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -168,6 +168,7 @@ LIBS := $(LIBS) $(GTK_LIBS) $(VTE_LIBS) $(X11_LIBS) $(CURSES_LIBS) $(ICONV_LIBS)
 endif
 LIBS := $(LIBS) $(BRLAPI_LIBS) $(SDL_LIBS) $(SPICE_LIBS) $(OPENGL_LIBS) $(SECCOMP_LIBS)
 LIBS := $(LIBS) $(COREAUDIO_LIBS) $(DSOUND_LIBS)
+LIBS := $(LIBS) $(VDE_LIBS) $(SLIRP_LIBS)
 
 # Hardware support
 ifeq ($(TARGET_NAME), sparc64)
diff --git a/meson.build b/meson.build
index f0af36f..73ad78d 100644
--- a/meson.build
+++ b/meson.build
@@ -137,6 +137,15 @@ if 'CONFIG_XKBCOMMON' in config_host
   xkbcommon = declare_dependency(compile_args: config_host['XKBCOMMON_CFLAGS'].split(),
                                  link_args: config_host['XKBCOMMON_LIBS'].split())
 endif
+slirp = not_found
+if config_host.has_key('CONFIG_SLIRP')
+  slirp = declare_dependency(compile_args: config_host['SLIRP_CFLAGS'].split(),
+                             link_args: config_host['SLIRP_LIBS'].split())
+endif
+vde = not_found
+if config_host.has_key('CONFIG_VDE')
+  vde = declare_dependency(link_args: config_host['VDE_LIBS'].split())
+endif
 pulse = not_found
 if 'CONFIG_LIBPULSE' in config_host
   pulse = declare_dependency(compile_args: config_host['PULSE_CFLAGS'].split(),
@@ -634,6 +643,7 @@ common_ss.add(files('cpus-common.c'))
 subdir('softmmu')
 subdir('migration')
 subdir('monitor')
+subdir('net')
 subdir('replay')
 
 # needed for fuzzing binaries
diff --git a/net/Makefile.objs b/net/Makefile.objs
deleted file mode 100644
index 5ab4554..0000000
--- a/net/Makefile.objs
+++ /dev/null
@@ -1,32 +0,0 @@
-common-obj-y = net.o queue.o checksum.o util.o hub.o
-common-obj-y += socket.o
-common-obj-y += dump.o
-common-obj-y += eth.o
-common-obj-y += announce.o
-common-obj-$(CONFIG_L2TPV3) += l2tpv3.o
-common-obj-$(call land,$(CONFIG_VIRTIO_NET),$(CONFIG_VHOST_NET_USER)) += vhost-user.o
-common-obj-$(call land,$(call lnot,$(CONFIG_VIRTIO_NET)),$(CONFIG_VHOST_NET_USER)) += vhost-user-stub.o
-common-obj-$(CONFIG_ALL) += vhost-user-stub.o
-common-obj-$(CONFIG_SLIRP) += slirp.o
-slirp.o-cflags := $(SLIRP_CFLAGS)
-slirp.o-libs := $(SLIRP_LIBS)
-common-obj-$(CONFIG_VDE) += vde.o
-common-obj-$(CONFIG_NETMAP) += netmap.o
-common-obj-y += filter.o
-common-obj-y += filter-buffer.o
-common-obj-y += filter-mirror.o
-common-obj-y += colo-compare.o
-common-obj-y += colo.o
-common-obj-y += filter-rewriter.o
-common-obj-y += filter-replay.o
-
-tap-obj-$(CONFIG_LINUX) = tap-linux.o
-tap-obj-$(CONFIG_BSD) = tap-bsd.o
-tap-obj-$(CONFIG_SOLARIS) = tap-solaris.o
-tap-obj-y ?= tap-stub.o
-common-obj-$(CONFIG_POSIX) += tap.o $(tap-obj-y)
-common-obj-$(CONFIG_WIN32) += tap-win32.o
-common-obj-$(CONFIG_VHOST_NET_VDPA) += vhost-vdpa.o
-vde.o-libs = $(VDE_LIBS)
-
-common-obj-$(CONFIG_CAN_BUS) += can/
diff --git a/net/can/Makefile.objs b/net/can/Makefile.objs
deleted file mode 100644
index 9f35dc5..0000000
--- a/net/can/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-common-obj-y += can_core.o can_host.o
-common-obj-$(CONFIG_LINUX) += can_socketcan.o
diff --git a/net/can/meson.build b/net/can/meson.build
new file mode 100644
index 0000000..f53d9ec
--- /dev/null
+++ b/net/can/meson.build
@@ -0,0 +1,5 @@
+can_ss = ss.source_set()
+can_ss.add(files('can_core.c', 'can_host.c'))
+can_ss.add(when: 'CONFIG_LINUX', if_true: files('can_socketcan.c'))
+
+softmmu_ss.add_all(when: 'CONFIG_CAN_BUS', if_true: can_ss)
diff --git a/net/meson.build b/net/meson.build
new file mode 100644
index 0000000..6c2ec47
--- /dev/null
+++ b/net/meson.build
@@ -0,0 +1,40 @@
+softmmu_ss.add(files(
+  'announce.c',
+  'checksum.c',
+  'colo-compare.c',
+  'colo.c',
+  'dump.c',
+  'eth.c',
+  'filter-buffer.c',
+  'filter-mirror.c',
+  'filter-replay.c',
+  'filter-rewriter.c',
+  'filter.c',
+  'hub.c',
+  'net.c',
+  'queue.c',
+  'socket.c',
+  'util.c',
+))
+
+softmmu_ss.add(when: 'CONFIG_L2TPV3', if_true: files('l2tpv3.c'))
+softmmu_ss.add(when: ['CONFIG_SLIRP', slirp], if_true: files('slirp.c'))
+softmmu_ss.add(when: ['CONFIG_VDE', vde], if_true: files('vde.c'))
+softmmu_ss.add(when: 'CONFIG_NETMAP', if_true: files('netmap.c'))
+vhost_user_ss = ss.source_set()
+vhost_user_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('vhost-user.c'), if_false: files('vhost-user-stub.c'))
+softmmu_ss.add_all(when: 'CONFIG_VHOST_NET_USER', if_true: vhost_user_ss)
+softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('vhost-user-stub.c'))
+
+softmmu_ss.add(when: 'CONFIG_LINUX', if_true: files('tap-linux.c'))
+softmmu_ss.add(when: 'CONFIG_BSD', if_true: files('tap-bsd.c'))
+softmmu_ss.add(when: 'CONFIG_SOLARIS', if_true: files('tap-solaris.c'))
+tap_posix = ['tap.c']
+if not config_host.has_key('CONFIG_LINUX') and not config_host.has_key('CONFIG_BSD') and not config_host.has_key('CONFIG_SOLARIS')
+  tap_posix += 'tap-stub.c'
+endif
+softmmu_ss.add(when: 'CONFIG_POSIX', if_true: files(tap_posix))
+softmmu_ss.add(when: 'CONFIG_WIN32', if_true: files('tap-win32.c'))
+softmmu_ss.add(when: 'CONFIG_VHOST_NET_VDPA', if_true: files('vhost-vdpa.c'))
+
+subdir('can')
-- 
1.8.3.1



