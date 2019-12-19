Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F69C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:39:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DB30222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYBIQcLr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DB30222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihv5I-0001xY-9l
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:39:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34404)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihurZ-0008Tb-TA
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihurY-0001HB-9w
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:05 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32145
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihurX-0001Dj-V2
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qf0EzKe6oLRsH/L+PXJBFfkGsboS7PCszn0vT0Ecovc=;
 b=RYBIQcLrteGmsE3O5fjpQzYBb+b05dFM72KuR2UN2i2id5jt++5hZ6O7rFrT+r+NDJwf/n
 OpwBOZeLToGXyJttK6hnkbJqDl9Q7oA5JPrig657Vnf4EL/vIx5UTj7sz1JP6uYF5Lepme
 7+A2ROb7s5JmjRj5KLwHfXRw805/m4k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-Mpwd7xGmOmS5pwUudlOfOg-1; Thu, 19 Dec 2019 07:24:48 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21487107ACC9
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 12:24:47 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-55.ams2.redhat.com
 [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A927060C18;
 Thu, 19 Dec 2019 12:24:45 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 108/132] meson: linux-user
Date: Thu, 19 Dec 2019 13:23:28 +0100
Message-Id: <1576758232-12439-17-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Mpwd7xGmOmS5pwUudlOfOg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 Makefile.target                    |  3 ---
 linux-user/Makefile.objs           | 10 ----------
 linux-user/arm/nwfpe/Makefile.objs |  2 --
 linux-user/arm/nwfpe/meson.build   | 10 ++++++++++
 linux-user/meson.build             | 22 ++++++++++++++++++++++
 meson.build                        |  4 ++++
 6 files changed, 36 insertions(+), 15 deletions(-)
 delete mode 100644 linux-user/Makefile.objs
 delete mode 100644 linux-user/arm/nwfpe/Makefile.objs
 create mode 100644 linux-user/arm/nwfpe/meson.build
 create mode 100644 linux-user/meson.build

diff --git a/Makefile.target b/Makefile.target
index 438d27b..a8e6a28 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -128,9 +128,6 @@ QEMU_CFLAGS+=3D-I$(SRC_PATH)/linux-user/$(TARGET_ABI_DI=
R) \
              -I$(SRC_PATH)/linux-user/host/$(ARCH) \
              -I$(SRC_PATH)/linux-user
=20
-obj-y +=3D linux-user/
-obj-y +=3D gdbstub.o thunk.o
-
 endif #CONFIG_LINUX_USER
=20
 #########################################################
diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
deleted file mode 100644
index d2f33be..0000000
--- a/linux-user/Makefile.objs
+++ /dev/null
@@ -1,10 +0,0 @@
-obj-y =3D main.o syscall.o strace.o mmap.o signal.o \
-=09elfload.o linuxload.o uaccess.o uname.o \
-=09safe-syscall.o $(TARGET_ABI_DIR)/signal.o \
-        $(TARGET_ABI_DIR)/cpu_loop.o exit.o fd-trans.o
-
-obj-$(TARGET_HAS_BFLT) +=3D flatload.o
-obj-$(TARGET_I386) +=3D vm86.o
-obj-$(TARGET_ARM) +=3D arm/nwfpe/
-obj-$(TARGET_ARM) +=3D arm/semihost.o
-obj-$(TARGET_AARCH64) +=3D arm/semihost.o
diff --git a/linux-user/arm/nwfpe/Makefile.objs b/linux-user/arm/nwfpe/Make=
file.objs
deleted file mode 100644
index 51b0c32..0000000
--- a/linux-user/arm/nwfpe/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-obj-y =3D fpa11.o fpa11_cpdo.o fpa11_cpdt.o fpa11_cprt.o fpopcode.o
-obj-y +=3D single_cpdo.o double_cpdo.o extended_cpdo.o
diff --git a/linux-user/arm/nwfpe/meson.build b/linux-user/arm/nwfpe/meson.=
build
new file mode 100644
index 0000000..1c27e55
--- /dev/null
+++ b/linux-user/arm/nwfpe/meson.build
@@ -0,0 +1,10 @@
+linux_user_ss.add(when: 'TARGET_ARM', if_true: files(
+  'double_cpdo.c',
+  'extended_cpdo.c',
+  'fpa11.c',
+  'fpa11_cpdo.c',
+  'fpa11_cpdt.c',
+  'fpa11_cprt.c',
+  'fpopcode.c',
+  'single_cpdo.c',
+))
diff --git a/linux-user/meson.build b/linux-user/meson.build
new file mode 100644
index 0000000..b5711d9
--- /dev/null
+++ b/linux-user/meson.build
@@ -0,0 +1,22 @@
+linux_user_ss.add(files(
+  'elfload.c',
+  'exit.c',
+  'fd-trans.c',
+  'linuxload.c',
+  'main.c',
+  'mmap.c',
+  'safe-syscall.S',
+  'signal.c',
+  'strace.c',
+  'syscall.c',
+  'uaccess.c',
+  'uname.c',
+))
+linux_user_ss.add(rt)
+
+linux_user_ss.add(when: 'TARGET_AARCH64', if_true: files('arm/semihost.c')=
)
+linux_user_ss.add(when: 'TARGET_ARM', if_true: files('arm/semihost.c'))
+linux_user_ss.add(when: 'TARGET_HAS_BFLT', if_true: files('flatload.c'))
+linux_user_ss.add(when: 'TARGET_I386', if_true: files('vm86.c'))
+
+subdir('arm/nwfpe')
diff --git a/meson.build b/meson.build
index 1c9a941..64cbab1 100644
--- a/meson.build
+++ b/meson.build
@@ -646,6 +646,10 @@ subdir('hw')
 subdir('libdecnumber')
 subdir('target')
 subdir('accel')
+subdir('linux-user')
+
+linux_user_ss.add(files('gdbstub.c', 'thunk.c'))
+specific_ss.add_all(when: 'CONFIG_LINUX_USER', if_true: linux_user_ss)
=20
 mods =3D []
 block_mods =3D []
--=20
1.8.3.1



