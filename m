Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6900C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:37:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F44F222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X/V6hbe2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F44F222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihv3R-0007nQ-CX
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:37:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihurx-0000VC-4G
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihurv-0002Ow-IG
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:28 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21745
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihurt-0002L0-53
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HjtTPaAIcdrp3lmVBw8yg0yqaiOzTbq0fvZ7/rAOgBI=;
 b=X/V6hbe2rnhK73W1jPH8KqIEE07j36QgffWfpld7LFDiGQKKOTxGj8xgfDd8IgRpzl5WyE
 gywhvO/ahDY0EPXHq89uvPiIQ4K1PUhsNiNw6PV6P7mTHfYTR0t1xKqi0MyEBO5A8ONB6v
 KA8gyORlNupwNleo7+fI1ud1CcyQyBA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-NRxnPPfPO2-pkzojzd_ACg-1; Thu, 19 Dec 2019 07:25:22 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F907107ACC4
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 12:25:21 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-55.ams2.redhat.com
 [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0725C60C18;
 Thu, 19 Dec 2019 12:25:19 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 122/132] meson: install blobs
Date: Thu, 19 Dec 2019 13:23:42 +0100
Message-Id: <1576758232-12439-31-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: NRxnPPfPO2-pkzojzd_ACg-1
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
 Makefile            | 29 -------------------------
 pc-bios/meson.build | 61 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 61 insertions(+), 29 deletions(-)

diff --git a/Makefile b/Makefile
index e961286..b88110b 100644
--- a/Makefile
+++ b/Makefile
@@ -223,33 +223,9 @@ de-ch  es     fo  fr-ca  hu     ja  mk  pt  sl     tr =
\
 bepo    cz
=20
 ifdef INSTALL_BLOBS
-BLOBS=3Dbios.bin bios-256k.bin sgabios.bin vgabios.bin vgabios-cirrus.bin =
\
-vgabios-stdvga.bin vgabios-vmware.bin vgabios-qxl.bin vgabios-virtio.bin \
-vgabios-ramfb.bin vgabios-bochs-display.bin vgabios-ati.bin \
-ppc_rom.bin openbios-sparc32 openbios-sparc64 openbios-ppc QEMU,tcx.bin QE=
MU,cgthree.bin \
-pxe-e1000.rom pxe-eepro100.rom pxe-ne2k_pci.rom \
-pxe-pcnet.rom pxe-rtl8139.rom pxe-virtio.rom \
-efi-e1000.rom efi-eepro100.rom efi-ne2k_pci.rom \
-efi-pcnet.rom efi-rtl8139.rom efi-virtio.rom \
-efi-e1000e.rom efi-vmxnet3.rom \
-qemu-nsis.bmp \
-bamboo.dtb canyonlands.dtb petalogix-s3adsp1800.dtb petalogix-ml605.dtb \
-multiboot.bin linuxboot.bin linuxboot_dma.bin kvmvapic.bin pvh.bin \
-s390-ccw.img s390-netboot.img \
-slof.bin skiboot.lid \
-palcode-clipper \
-u-boot.e500 u-boot-sam460-20100605.bin \
-qemu_vga.ndrv \
-edk2-licenses.txt \
-hppa-firmware.img \
-opensbi-riscv32-virt-fw_jump.bin \
-opensbi-riscv64-sifive_u-fw_jump.bin opensbi-riscv64-virt-fw_jump.bin
-
-
 DESCS=3D50-edk2-i386-secure.json 50-edk2-x86_64-secure.json \
 60-edk2-aarch64.json 60-edk2-arm.json 60-edk2-i386.json 60-edk2-x86_64.jso=
n
 else
-BLOBS=3D
 DESCS=3D
 endif
=20
@@ -273,11 +249,6 @@ ifneq ($(vhost-user-json-y),)
 =09=09$(INSTALL_DATA) $$x "$(DESTDIR)$(qemu_datadir)/vhost-user/"; \
 =09done
 endif
-ifneq ($(BLOBS),)
-=09set -e; for x in $(BLOBS); do \
-=09=09$(INSTALL_DATA) $(SRC_PATH)/pc-bios/$$x "$(DESTDIR)$(qemu_datadir)";=
 \
-=09done
-endif
 ifneq ($(DESCS),)
 =09$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/firmware"
 =09set -e; tmpf=3D$$(mktemp); trap 'rm -f -- "$$tmpf"' EXIT; \
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index 18201b0..dc7de21 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -23,3 +23,64 @@ foreach f: fds
                 install: install_blobs,
                 install_dir: config_host['qemu_datadir'])
 endforeach
+
+blobs =3D files(
+  'QEMU,cgthree.bin',
+  'QEMU,tcx.bin',
+  'bamboo.dtb',
+  'bios-256k.bin',
+  'bios.bin',
+  'canyonlands.dtb',
+  'edk2-licenses.txt',
+  'efi-e1000.rom',
+  'efi-e1000e.rom',
+  'efi-eepro100.rom',
+  'efi-ne2k_pci.rom',
+  'efi-pcnet.rom',
+  'efi-rtl8139.rom',
+  'efi-virtio.rom',
+  'efi-vmxnet3.rom',
+  'hppa-firmware.img',
+  'kvmvapic.bin',
+  'linuxboot.bin',
+  'linuxboot_dma.bin',
+  'multiboot.bin',
+  'openbios-ppc',
+  'openbios-sparc32',
+  'openbios-sparc64',
+  'opensbi-riscv32-virt-fw_jump.bin',
+  'opensbi-riscv64-sifive_u-fw_jump.bin',
+  'opensbi-riscv64-virt-fw_jump.bin',
+  'palcode-clipper',
+  'petalogix-ml605.dtb',
+  'petalogix-s3adsp1800.dtb',
+  'ppc_rom.bin',
+  'pvh.bin',
+  'pxe-e1000.rom',
+  'pxe-eepro100.rom',
+  'pxe-ne2k_pci.rom',
+  'pxe-pcnet.rom',
+  'pxe-rtl8139.rom',
+  'pxe-virtio.rom',
+  'qemu-nsis.bmp',
+  'qemu_vga.ndrv',
+  's390-ccw.img',
+  's390-netboot.img',
+  'sgabios.bin',
+  'skiboot.lid',
+  'slof.bin',
+  'u-boot-sam460-20100605.bin',
+  'u-boot.e500',
+  'vgabios-ati.bin',
+  'vgabios-bochs-display.bin',
+  'vgabios-cirrus.bin',
+  'vgabios-qxl.bin',
+  'vgabios-ramfb.bin',
+  'vgabios-stdvga.bin',
+  'vgabios-virtio.bin',
+  'vgabios-vmware.bin',
+)
+
+if install_blobs
+  install_data(blobs, install_dir: config_host['qemu_datadir'])
+endif
--=20
1.8.3.1



