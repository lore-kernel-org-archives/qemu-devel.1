Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CEBC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:29:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6E7E24650
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EYZy2Usy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E7E24650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihuvR-000570-N3
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:29:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60155)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihur5-0007qY-HT
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:24:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihur4-0007pO-7S
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:24:35 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35694
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihur3-0007mS-Ty
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:24:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Wg/Q4q/RNcBJGQBWNYxbLFg95giGngh0RsUh+tG6p0=;
 b=EYZy2Usy4RUI77cVucQpcUpik+hnTYKI7sk8KnhayUGyeFOiVxoM1YYAPenNlq/GhBkSwz
 taFSxGf4Gdzzc3mt8VaZLSXwxWr9MQxCGWr6Ukp/+NU876B5RczaxKi0NmL6e9C7wuPh6H
 WiAvECFCBfzKnewDGWH/GPRTpdKbvEE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-zJu3RCx8PLGoWLXqC3reOQ-1; Thu, 19 Dec 2019 07:24:31 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9673184BECD
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 12:24:30 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-55.ams2.redhat.com
 [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B90F460C18;
 Thu, 19 Dec 2019 12:24:28 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 103/132] meson: convert hw/9pfs
Date: Thu, 19 Dec 2019 13:23:23 +0100
Message-Id: <1576758232-12439-12-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: zJu3RCx8PLGoWLXqC3reOQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 Kconfig.host          |  1 +
 Makefile.objs         |  5 -----
 Makefile.target       |  1 -
 hw/9pfs/Kconfig       |  4 ++++
 hw/9pfs/Makefile.objs |  9 ---------
 hw/9pfs/meson.build   | 20 ++++++++++++++++++++
 hw/Makefile.objs      |  6 ------
 hw/meson.build        |  1 +
 8 files changed, 26 insertions(+), 21 deletions(-)
 delete mode 100644 hw/9pfs/Makefile.objs
 create mode 100644 hw/9pfs/meson.build
 delete mode 100644 hw/Makefile.objs

diff --git a/Kconfig.host b/Kconfig.host
index 55136e0..ce78e49 100644
--- a/Kconfig.host
+++ b/Kconfig.host
@@ -34,6 +34,7 @@ config VHOST_KERNEL
 config XEN
     bool
     select FSDEV_9P if VIRTFS
+    select 9PFS if VIRTFS
=20
 config VIRTFS
     bool
diff --git a/Makefile.objs b/Makefile.objs
index c27b527..76326e9 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -56,11 +56,6 @@ common-obj-$(if $(CONFIG_LZFSE),m) +=3D block-dmg-lzfse$=
(DSOSUF)
 common-obj-$(if $(and $(CONFIG_BZIP2),$(CONFIG_DMG)),m) +=3D block-dmg-bz2=
$(DSOSUF)
 endif
=20
-#######################################################################
-# Target-independent parts used in system and user emulation
-
-common-obj-y =3D hw/
-
 ######################################################################
 # Resource file for Windows executables
 version-obj-$(CONFIG_WIN32) +=3D $(BUILD_DIR)/version.o
diff --git a/Makefile.target b/Makefile.target
index 82f384c..eecb11e 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -153,7 +153,6 @@ endif #CONFIG_BSD_USER
 ifdef CONFIG_SOFTMMU
 obj-y +=3D arch_init.o cpus.o gdbstub.o balloon.o ioport.o
 obj-y +=3D qtest.o
-obj-y +=3D hw/
 obj-y +=3D memory.o
 obj-y +=3D memory_mapping.o
 LIBS :=3D $(libs_softmmu) $(LIBS)
diff --git a/hw/9pfs/Kconfig b/hw/9pfs/Kconfig
index 3ae5749..d3ebd73 100644
--- a/hw/9pfs/Kconfig
+++ b/hw/9pfs/Kconfig
@@ -2,8 +2,12 @@ config FSDEV_9P
     bool
     depends on VIRTFS
=20
+config 9PFS
+    bool
+
 config VIRTIO_9P
     bool
     default y
     depends on VIRTFS && VIRTIO
     select FSDEV_9P
+    select 9PFS
diff --git a/hw/9pfs/Makefile.objs b/hw/9pfs/Makefile.objs
deleted file mode 100644
index 70ded6f..0000000
--- a/hw/9pfs/Makefile.objs
+++ /dev/null
@@ -1,9 +0,0 @@
-common-obj-y  =3D 9p.o 9p-util.o
-common-obj-y +=3D 9p-local.o 9p-xattr.o
-common-obj-y +=3D 9p-xattr-user.o 9p-posix-acl.o
-common-obj-y +=3D coth.o cofs.o codir.o cofile.o
-common-obj-y +=3D coxattr.o 9p-synth.o
-common-obj-y +=3D 9p-proxy.o
-
-common-obj-$(CONFIG_XEN) +=3D xen-9p-backend.o
-obj-$(CONFIG_VIRTIO_9P) +=3D virtio-9p-device.o
diff --git a/hw/9pfs/meson.build b/hw/9pfs/meson.build
new file mode 100644
index 0000000..cc09426
--- /dev/null
+++ b/hw/9pfs/meson.build
@@ -0,0 +1,20 @@
+fs_ss =3D ss.source_set()
+fs_ss.add(files(
+  '9p-local.c',
+  '9p-posix-acl.c',
+  '9p-proxy.c',
+  '9p-synth.c',
+  '9p-util.c',
+  '9p-xattr-user.c',
+  '9p-xattr.c',
+  '9p.c',
+  'codir.c',
+  'cofile.c',
+  'cofs.c',
+  'coth.c',
+  'coxattr.c',
+))
+fs_ss.add(when: 'CONFIG_XEN', if_true: files('xen-9p-backend.c'))
+softmmu_ss.add_all(when: 'CONFIG_9PFS', if_true: fs_ss)
+
+specific_ss.add(when: 'CONFIG_VIRTIO_9P', if_true: files('virtio-9p-device=
.c'))
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
deleted file mode 100644
index 3dc4dec..0000000
--- a/hw/Makefile.objs
+++ /dev/null
@@ -1,6 +0,0 @@
-ifeq ($(CONFIG_SOFTMMU), y)
-devices-dirs-$(call lor,$(CONFIG_VIRTIO_9P),$(call land,$(CONFIG_VIRTFS),$=
(CONFIG_XEN))) +=3D 9pfs/
-endif
-
-common-obj-y +=3D $(devices-dirs-y)
-obj-y +=3D $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index b2f8d6c..a79400b 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,3 +1,4 @@
+subdir('9pfs')
 subdir('acpi')
 subdir('adc')
 subdir('audio')
--=20
1.8.3.1



