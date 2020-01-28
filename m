Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D84C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:16:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FBFF2173E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nipsxS+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FBFF2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWM5-0007WX-DY
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:16:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36609)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV7h-0003Sg-FP
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV7f-0007vM-Vw
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:01 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42948)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV7e-0007rS-PO
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:59 -0500
Received: by mail-wr1-x444.google.com with SMTP id k11so2428491wrd.9
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ADGhXzAA5ZFOFj0RnVgTynM0UWktqA+PwDI5EflMRB4=;
 b=nipsxS+tE7AVH9cr0NuVY13X67YmJOzdTaZDzcaDYr/NB4Ga695fqQQwQlWgJsuJSB
 NbeB+u+YxJNjph7lBQ1zuMq5Up0vavrBk7iW34lasAxN6EVFdeXWQYMF06un7m+mAj82
 zZKpxhZXkRIALQIwZFxIVKU9LmiJprA6isQdcZVKPtRzXUXLPAvOpqf14cfJADqYfngv
 yB5ut4HVVY8toTqREKXQiSpjN2LUl9M68iM5BPbnV7Y1KjTHNPbkcAT8JZv0YGn2G/GC
 V+JbdEvVCXBCj8AShdG87hmqil+rBsjAeGQ7KjawdYX4bNCSvgNmnBzttxqA9/BOG6n7
 nMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ADGhXzAA5ZFOFj0RnVgTynM0UWktqA+PwDI5EflMRB4=;
 b=L6bSh+t9lfEQ5TaIiq3ZpPeNdomRCdGbi90hETcH+WL9i6go/IaN4WRlmRVtomNd5u
 +5Mcwfnljka/2iXJRt1v+R9P0gl4zGoKFAtdPLLQacPwcKIldhfqOqsvIrpqvUL/W9l8
 BYx6WJA9UhGbKVTnAPT4W3b+eeOrHVCxgwKhmfSyNDIHgOEuQpmK+uRX19FJ/42Dfcuz
 7tpYIZUwQrBMD4prHf6f8BCv1UsJ/VxuB7ns9wvn6kDYi63/e4O3HZQl3zawsj2aJ1VR
 xmpJ4pijfZ0SWKiYnpmeHAQxQGAKQCR8E8knHM0qB5i/p0X2d5MjOAuEGjhnEF21AH6Y
 /JJg==
X-Gm-Message-State: APjAAAU7KHQOYSWWBDJ3DYFgo86sjaqfm7R0ugEqO6sG48aFgsbsGcZx
 YjvyAfsZSP9IQn7ZfVE/IsLKzEcw
X-Google-Smtp-Source: APXvYqwGay5xfMPKoEOxI1QIa2VAGy9kczgsWJMFVjUsnkNWSPIUT0u7A8AEPud1Nx8zz3Lh0i6KQQ==
X-Received: by 2002:adf:e40f:: with SMTP id g15mr29410225wrm.223.1580234277500; 
 Tue, 28 Jan 2020 09:57:57 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:57:57 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 106/142] meson: convert hw/block
Date: Tue, 28 Jan 2020 18:53:06 +0100
Message-Id: <20200128175342.9066-107-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
---
 hw/Makefile.objs                 |  1 -
 hw/block/Makefile.objs           | 18 ------------------
 hw/block/dataplane/Makefile.objs |  2 --
 hw/block/dataplane/meson.build   |  2 ++
 hw/block/meson.build             | 21 +++++++++++++++++++++
 hw/meson.build                   |  1 +
 6 files changed, 24 insertions(+), 21 deletions(-)
 delete mode 100644 hw/block/Makefile.objs
 delete mode 100644 hw/block/dataplane/Makefile.objs
 create mode 100644 hw/block/dataplane/meson.build
 create mode 100644 hw/block/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 6ddffced72..0c92a04856 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -3,7 +3,6 @@ devices-dirs-$(call lor,$(CONFIG_VIRTIO_9P),$(call land,$(CONFIG_VIRTFS),$(CONFI
 devices-dirs-y += acpi/
 devices-dirs-y += adc/
 devices-dirs-y += audio/
-devices-dirs-y += block/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
deleted file mode 100644
index 28c2495a00..0000000000
--- a/hw/block/Makefile.objs
+++ /dev/null
@@ -1,18 +0,0 @@
-common-obj-y += block.o cdrom.o hd-geometry.o
-common-obj-$(CONFIG_FDC) += fdc.o
-common-obj-$(CONFIG_SSI_M25P80) += m25p80.o
-common-obj-$(CONFIG_NAND) += nand.o
-common-obj-$(CONFIG_PFLASH_CFI01) += pflash_cfi01.o
-common-obj-$(CONFIG_PFLASH_CFI02) += pflash_cfi02.o
-common-obj-$(CONFIG_XEN) += xen-block.o
-common-obj-$(CONFIG_ECC) += ecc.o
-common-obj-$(CONFIG_ONENAND) += onenand.o
-common-obj-$(CONFIG_NVME_PCI) += nvme.o
-common-obj-$(CONFIG_SWIM) += swim.o
-
-obj-$(CONFIG_SH4) += tc58128.o
-
-obj-$(CONFIG_VIRTIO_BLK) += virtio-blk.o
-obj-$(CONFIG_VHOST_USER_BLK) += vhost-user-blk.o
-
-obj-y += dataplane/
diff --git a/hw/block/dataplane/Makefile.objs b/hw/block/dataplane/Makefile.objs
deleted file mode 100644
index 0c5270268e..0000000000
--- a/hw/block/dataplane/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-obj-$(CONFIG_VIRTIO_BLK) += virtio-blk.o
-obj-$(CONFIG_XEN) += xen-block.o
diff --git a/hw/block/dataplane/meson.build b/hw/block/dataplane/meson.build
new file mode 100644
index 0000000000..12c6a264f1
--- /dev/null
+++ b/hw/block/dataplane/meson.build
@@ -0,0 +1,2 @@
+specific_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk.c'))
+specific_ss.add(when: 'CONFIG_XEN', if_true: files('xen-block.c'))
diff --git a/hw/block/meson.build b/hw/block/meson.build
new file mode 100644
index 0000000000..c633376fb4
--- /dev/null
+++ b/hw/block/meson.build
@@ -0,0 +1,21 @@
+softmmu_ss.add(files(
+  'block.c',
+  'cdrom.c',
+  'hd-geometry.c'
+))
+softmmu_ss.add(when: 'CONFIG_ECC', if_true: files('ecc.c'))
+softmmu_ss.add(when: 'CONFIG_FDC', if_true: files('fdc.c'))
+softmmu_ss.add(when: 'CONFIG_NAND', if_true: files('nand.c'))
+softmmu_ss.add(when: 'CONFIG_NVME_PCI', if_true: files('nvme.c'))
+softmmu_ss.add(when: 'CONFIG_ONENAND', if_true: files('onenand.c'))
+softmmu_ss.add(when: 'CONFIG_PFLASH_CFI01', if_true: files('pflash_cfi01.c'))
+softmmu_ss.add(when: 'CONFIG_PFLASH_CFI02', if_true: files('pflash_cfi02.c'))
+softmmu_ss.add(when: 'CONFIG_SSI_M25P80', if_true: files('m25p80.c'))
+softmmu_ss.add(when: 'CONFIG_SWIM', if_true: files('swim.c'))
+softmmu_ss.add(when: 'CONFIG_XEN', if_true: files('xen-block.c'))
+
+specific_ss.add(when: 'CONFIG_SH4', if_true: files('tc58128.c'))
+specific_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk.c'))
+specific_ss.add(when: 'CONFIG_VHOST_USER_BLK', if_true: files('vhost-user-blk.c'))
+
+subdir('dataplane')
diff --git a/hw/meson.build b/hw/meson.build
index dd0c77ec2b..f968aa8374 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,3 +1,4 @@
+subdir('block')
 subdir('char')
 subdir('core')
 subdir('cpu')
-- 
2.21.0



