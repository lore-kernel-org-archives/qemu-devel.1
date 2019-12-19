Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1B3C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:37:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59F2D222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GgiKpaj9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F2D222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihv3u-0008Jh-Nx
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:37:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58835)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihuqt-0007YQ-U9
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:24:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihuqs-0006nJ-GE
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:24:23 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45188
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihuqs-0006k7-9j
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:24:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GY8eV7vOM/DBZpy9+Eb4dk6x6aTcb4shyecE+wleKs4=;
 b=GgiKpaj9gyyqfEpKCnLva6abs2i5CcNw4VD3ulylZE6s2eGts4SOIeX1fviMFkxV4WSIpk
 OM4GR56ljskujEEqM3FgS1zNDr02vwXgXeU3vk/lseFHrUOkPbS18psExT4KlBrDRlMl7v
 /5aWtuDGynAcr6DBbdLMChAD7VQFci8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-cgb9Z8Z1NGiAdYf0UkuNFA-1; Thu, 19 Dec 2019 07:24:20 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B98E6107ACC5
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 12:24:19 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-55.ams2.redhat.com
 [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5DAAB60C18;
 Thu, 19 Dec 2019 12:24:16 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 099/132] meson: convert hw/block
Date: Thu, 19 Dec 2019 13:23:19 +0100
Message-Id: <1576758232-12439-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: cgb9Z8Z1NGiAdYf0UkuNFA-1
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
 hw/Makefile.objs                 |  1 -
 hw/block/Makefile.objs           | 17 -----------------
 hw/block/dataplane/Makefile.objs |  2 --
 hw/block/dataplane/meson.build   |  2 ++
 hw/block/meson.build             | 20 ++++++++++++++++++++
 hw/meson.build                   |  1 +
 6 files changed, 23 insertions(+), 20 deletions(-)
 delete mode 100644 hw/block/Makefile.objs
 delete mode 100644 hw/block/dataplane/Makefile.objs
 create mode 100644 hw/block/dataplane/meson.build
 create mode 100644 hw/block/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 6ddffce..0c92a04 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -3,7 +3,6 @@ devices-dirs-$(call lor,$(CONFIG_VIRTIO_9P),$(call land,$(C=
ONFIG_VIRTFS),$(CONFI
 devices-dirs-y +=3D acpi/
 devices-dirs-y +=3D adc/
 devices-dirs-y +=3D audio/
-devices-dirs-y +=3D block/
 endif
=20
 common-obj-y +=3D $(devices-dirs-y)
diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
deleted file mode 100644
index f5f643f..0000000
--- a/hw/block/Makefile.objs
+++ /dev/null
@@ -1,17 +0,0 @@
-common-obj-y +=3D block.o cdrom.o hd-geometry.o
-common-obj-$(CONFIG_FDC) +=3D fdc.o
-common-obj-$(CONFIG_SSI_M25P80) +=3D m25p80.o
-common-obj-$(CONFIG_NAND) +=3D nand.o
-common-obj-$(CONFIG_PFLASH_CFI01) +=3D pflash_cfi01.o
-common-obj-$(CONFIG_PFLASH_CFI02) +=3D pflash_cfi02.o
-common-obj-$(CONFIG_XEN) +=3D xen-block.o
-common-obj-$(CONFIG_ECC) +=3D ecc.o
-common-obj-$(CONFIG_ONENAND) +=3D onenand.o
-common-obj-$(CONFIG_NVME_PCI) +=3D nvme.o
-
-obj-$(CONFIG_SH4) +=3D tc58128.o
-
-obj-$(CONFIG_VIRTIO_BLK) +=3D virtio-blk.o
-obj-$(CONFIG_VHOST_USER_BLK) +=3D vhost-user-blk.o
-
-obj-y +=3D dataplane/
diff --git a/hw/block/dataplane/Makefile.objs b/hw/block/dataplane/Makefile=
.objs
deleted file mode 100644
index 0c52702..0000000
--- a/hw/block/dataplane/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-obj-$(CONFIG_VIRTIO_BLK) +=3D virtio-blk.o
-obj-$(CONFIG_XEN) +=3D xen-block.o
diff --git a/hw/block/dataplane/meson.build b/hw/block/dataplane/meson.buil=
d
new file mode 100644
index 0000000..12c6a26
--- /dev/null
+++ b/hw/block/dataplane/meson.build
@@ -0,0 +1,2 @@
+specific_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk.c'))
+specific_ss.add(when: 'CONFIG_XEN', if_true: files('xen-block.c'))
diff --git a/hw/block/meson.build b/hw/block/meson.build
new file mode 100644
index 0000000..a435ab4
--- /dev/null
+++ b/hw/block/meson.build
@@ -0,0 +1,20 @@
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
+softmmu_ss.add(when: 'CONFIG_PFLASH_CFI01', if_true: files('pflash_cfi01.c=
'))
+softmmu_ss.add(when: 'CONFIG_PFLASH_CFI02', if_true: files('pflash_cfi02.c=
'))
+softmmu_ss.add(when: 'CONFIG_SSI_M25P80', if_true: files('m25p80.c'))
+softmmu_ss.add(when: 'CONFIG_XEN', if_true: files('xen-block.c'))
+
+specific_ss.add(when: 'CONFIG_SH4', if_true: files('tc58128.c'))
+specific_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk.c'))
+specific_ss.add(when: 'CONFIG_VHOST_USER_BLK', if_true: files('vhost-user-=
blk.c'))
+
+subdir('dataplane')
diff --git a/hw/meson.build b/hw/meson.build
index 54414a6..a6782a5 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,3 +1,4 @@
+subdir('block')
 subdir('bt')
 subdir('char')
 subdir('core')
--=20
1.8.3.1



