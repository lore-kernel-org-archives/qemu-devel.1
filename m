Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B77C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:27:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CBB6206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2ZXIv0T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CBB6206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOVA-0004G6-5i
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:27:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyh-00042U-Gy
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyg-0007Q1-39
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:59 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:38632)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyf-0007OT-Rp
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:58 -0500
Received: by mail-wm1-x333.google.com with SMTP id p17so2377038wmi.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WW4k8JNn6CBU2Fa9v+82C5oHQxkIO9+9vFjrxZX46U4=;
 b=m2ZXIv0TakOvPXiRh3KJ/E/le/wyI9sftjlXvwNWN6YnEB7q8B9UOPl5h81p17rg1G
 g5NmTuSNsDINMNWtPbDiFL/a6Ro4VQYfJSI+TJIQS0TqLfOF2C5voL4X6sNtYEbTId5A
 zCR/aR/rBN8SsYykDw/G0tx4Q+vRZHlnUWoJ9H2veMNa2LpMPEqh9dx89Lp1w/3T7t9S
 aRsJu9GGSpA5TRrHrq40ZudfUTMVPEUeDQcEZH3W77Kfn/Jvb3nR/mflhK7gV4KR6uKK
 N64z1n1xzpDuYWm/zH7hu2zBcpYLqzNNmCGekMLY551gA23MIH1cdgI+3Nb6EZm6o8Ot
 NUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=WW4k8JNn6CBU2Fa9v+82C5oHQxkIO9+9vFjrxZX46U4=;
 b=sd8qd7VD7G+M6Y5WEryS5nZVkgKNVZfGUg5TcVAhFZnnqE7/XBmJa00jvQvZleq79a
 2eiACCWr5szk7IbjgvJoJkVrBPemFDXj8My57qiJoXETYQJ1HYN81LVxrxF9d9ZnpH86
 Yu7/QEs+Oxs3uPxNsUg4AlGNGVblhugK5EW3f0bqNxEU2i3RvCeBwfDfMPX5k6CnjjGT
 ZicWP0kpdAouaO5l4s9XUzlp6EAAFVsaXxmK7cyY/eOgdvuPiPshHJTHS0he7Q93lXHy
 jWQyPDkK5/eHOWaUyeTJewyLX7ng4pTSQDkgE0HIMmUITKGVJt/1Wi1lWC6IuV1B6xo/
 T8Gg==
X-Gm-Message-State: APjAAAXf86SR0Nv+YaT3bcG/WjmPa1IKeBeepUqgQSSpBvloPo/EiFkZ
 ouTASQVXjLNlbymJc8wyssbSkHrC
X-Google-Smtp-Source: APXvYqyInI8iIQX9Wd0peKH5ML2sJlnPvRR+OHWAomflmQdhTZCLLdwvYUadLUT1lmqsbrOAtykgQg==
X-Received: by 2002:a05:600c:2290:: with SMTP id
 16mr6819118wmf.93.1576155236592; 
 Thu, 12 Dec 2019 04:53:56 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:55 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 058/132] meson: convert net directory to Meson
Date: Thu, 12 Dec 2019 13:51:42 +0100
Message-Id: <1576155176-2464-59-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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
 Makefile.objs         |  3 +--
 Makefile.target       |  1 +
 meson.build           | 10 ++++++++++
 net/Makefile.objs     | 32 --------------------------------
 net/can/Makefile.objs |  2 --
 net/can/meson.build   |  5 +++++
 net/meson.build       | 39 +++++++++++++++++++++++++++++++++++++++
 7 files changed, 56 insertions(+), 36 deletions(-)
 delete mode 100644 net/Makefile.objs
 delete mode 100644 net/can/Makefile.objs
 create mode 100644 net/can/meson.build
 create mode 100644 net/meson.build

diff --git a/Makefile.objs b/Makefile.objs
index 5f2a644..e316e96 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -35,8 +35,7 @@ qom-obj-y = qom/libqom.fa
 # single QEMU executable should support all CPUs and machines.
 
 ifeq ($(CONFIG_SOFTMMU),y)
-common-obj-y = net/
-common-obj-$(CONFIG_LINUX) += fsdev/
+common-obj-$(CONFIG_LINUX) = fsdev/
 
 common-obj-$(CONFIG_AUDIO_ALSA) += audio-alsa$(DSOSUF)
 common-obj-$(CONFIG_AUDIO_OSS) += audio-oss$(DSOSUF)
diff --git a/Makefile.target b/Makefile.target
index cc0c038..e025246 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -167,6 +167,7 @@ LIBS := $(LIBS) $(GTK_LIBS) $(VTE_LIBS) $(X11_LIBS) $(CURSES_LIBS) $(ICONV_LIBS)
 endif
 LIBS := $(LIBS) $(BRLAPI_LIBS) $(SDL_LIBS) $(SPICE_LIBS) $(OPENGL_LIBS) $(SECCOMP_LIBS)
 LIBS := $(LIBS) $(COREAUDIO_LIBS) $(DSOUND_LIBS)
+LIBS := $(LIBS) $(VDE_LIBS) $(SLIRP_LIBS)
 
 # Hardware support
 ifeq ($(TARGET_NAME), sparc64)
diff --git a/meson.build b/meson.build
index 2961c44..2333a87 100644
--- a/meson.build
+++ b/meson.build
@@ -109,6 +109,15 @@ if 'CONFIG_LIBCAP_NG' in config_host
   libcap_ng = declare_dependency(link_args: config_host['LIBCAP_NG_LIBS'].split())
 endif
 xkbcommon = dependency('xkbcommon', required: false)
+slirp = declare_dependency()
+if config_host.has_key('CONFIG_SLIRP')
+  slirp = declare_dependency(compile_args: config_host['SLIRP_CFLAGS'].split(),
+                             link_args: config_host['SLIRP_LIBS'].split())
+endif
+vde = declare_dependency()
+if config_host.has_key('CONFIG_VDE')
+  vde = declare_dependency(link_args: config_host['VDE_LIBS'].split())
+endif
 pulse = declare_dependency()
 if 'CONFIG_LIBPULSE' in config_host
   pulse = declare_dependency(compile_args: config_host['PULSE_CFLAGS'].split(),
@@ -601,6 +610,7 @@ common_ss.add(files('cpus-common.c'))
 
 subdir('migration')
 subdir('monitor')
+subdir('net')
 subdir('replay')
 
 mods = []
diff --git a/net/Makefile.objs b/net/Makefile.objs
deleted file mode 100644
index c5d076d..0000000
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
-
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
index 0000000..a67f5af
--- /dev/null
+++ b/net/meson.build
@@ -0,0 +1,39 @@
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
+
+subdir('can')
-- 
1.8.3.1



