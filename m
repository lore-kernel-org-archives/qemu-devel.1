Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033A9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:35:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C43CD2087C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BqXEeNO3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C43CD2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAtiI-0005OM-2p
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 07:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kAthX-00043t-9V
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:34:47 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28174
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kAthU-0006lC-0G
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598441682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JwL5gsQ8ijtk4VlYbPtgCumyTw35aSg6Y8zKVQSO2WY=;
 b=BqXEeNO3Gbx+s2AtY6uLQSDevIq8ZmLEPQcvc+xvnbGx2nWoRKpkrVO2K0wFfbzrQYPW/M
 8Uw6XWjndX22rXOlrlNS5wMCtA3aCm+HlcA9pUiiPmGQWdD30GR9CGpvJfPTawrcTeFIO+
 re2nKBmBUSbeEiHFmiwJz1/yIXCZuTU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-vUbberoAO8y_ixJFuqTVlQ-1; Wed, 26 Aug 2020 07:34:40 -0400
X-MC-Unique: vUbberoAO8y_ixJFuqTVlQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A0FFE777
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 11:34:39 +0000 (UTC)
Received: from localhost (unknown [10.36.110.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A20697D889;
 Wed, 26 Aug 2020 11:34:35 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH] meson: install pc-bios blobs
Date: Wed, 26 Aug 2020 15:34:32 +0400
Message-Id: <20200826113432.534348-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 03:16:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: pbonzini@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 Makefile            | 31 ----------------------
 pc-bios/meson.build | 63 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 31 deletions(-)

diff --git a/Makefile b/Makefile
index 3ebd6929b4..be5acf10e6 100644
--- a/Makefile
+++ b/Makefile
@@ -229,32 +229,6 @@ distclean: clean ninja-distclean
 	rm -f linux-headers/asm
 	rm -Rf .sdk
 
-ifdef INSTALL_BLOBS
-BLOBS=bios.bin bios-256k.bin bios-microvm.bin sgabios.bin vgabios.bin vgabios-cirrus.bin \
-vgabios-stdvga.bin vgabios-vmware.bin vgabios-qxl.bin vgabios-virtio.bin \
-vgabios-ramfb.bin vgabios-bochs-display.bin vgabios-ati.bin \
-openbios-sparc32 openbios-sparc64 openbios-ppc QEMU,tcx.bin QEMU,cgthree.bin \
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
-opensbi-riscv32-generic-fw_dynamic.bin opensbi-riscv64-generic-fw_dynamic.bin \
-opensbi-riscv32-generic-fw_dynamic.elf opensbi-riscv64-generic-fw_dynamic.elf
-else
-BLOBS=
-endif
-
 install-datadir:
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)"
 
@@ -272,11 +246,6 @@ export DESTDIR
 install: all install-datadir install-localstatedir
 ifdef CONFIG_TRACE_SYSTEMTAP
 	$(INSTALL_PROG) "scripts/qemu-trace-stap" $(DESTDIR)$(bindir)
-endif
-ifneq ($(BLOBS),)
-	set -e; for x in $(BLOBS); do \
-		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/$$x "$(DESTDIR)$(qemu_datadir)"; \
-	done
 endif
 	for s in $(ICON_SIZES); do \
 		mkdir -p "$(DESTDIR)$(qemu_icondir)/hicolor/$${s}/apps"; \
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index c11e52ba26..8087e5c0a7 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -24,5 +24,68 @@ if 'DECOMPRESS_EDK2_BLOBS' in config_host
   endforeach
 endif
 
+blobs = files(
+  'bios.bin',
+  'bios-256k.bin',
+  'bios-microvm.bin',
+  'sgabios.bin',
+  'vgabios.bin',
+  'vgabios-cirrus.bin',
+  'vgabios-stdvga.bin',
+  'vgabios-vmware.bin',
+  'vgabios-qxl.bin',
+  'vgabios-virtio.bin',
+  'vgabios-ramfb.bin',
+  'vgabios-bochs-display.bin',
+  'vgabios-ati.bin',
+  'openbios-sparc32',
+  'openbios-sparc64',
+  'openbios-ppc',
+  'QEMU,tcx.bin',
+  'QEMU,cgthree.bin',
+  'pxe-e1000.rom',
+  'pxe-eepro100.rom',
+  'pxe-ne2k_pci.rom',
+  'pxe-pcnet.rom',
+  'pxe-rtl8139.rom',
+  'pxe-virtio.rom',
+  'efi-e1000.rom',
+  'efi-eepro100.rom',
+  'efi-ne2k_pci.rom',
+  'efi-pcnet.rom',
+  'efi-rtl8139.rom',
+  'efi-virtio.rom',
+  'efi-e1000e.rom',
+  'efi-vmxnet3.rom',
+  'qemu-nsis.bmp',
+  'bamboo.dtb',
+  'canyonlands.dtb',
+  'petalogix-s3adsp1800.dtb',
+  'petalogix-ml605.dtb',
+  'multiboot.bin',
+  'linuxboot.bin',
+  'linuxboot_dma.bin',
+  'kvmvapic.bin',
+  'pvh.bin',
+  's390-ccw.img',
+  's390-netboot.img',
+  'slof.bin',
+  'skiboot.lid',
+  'palcode-clipper',
+  'u-boot.e500',
+  'u-boot-sam460-20100605.bin',
+  'qemu_vga.ndrv',
+  'edk2-licenses.txt',
+  'hppa-firmware.img',
+  'opensbi-riscv32-generic-fw_dynamic.bin',
+  'opensbi-riscv64-generic-fw_dynamic.bin',
+  'opensbi-riscv32-generic-fw_dynamic.elf',
+  'opensbi-riscv64-generic-fw_dynamic.elf',
+)
+
+if install_blobs
+  install_data(blobs, install_dir: config_host['qemu_datadir'])
+endif
+
 subdir('descriptors')
 subdir('keymaps')
-- 
2.26.2


