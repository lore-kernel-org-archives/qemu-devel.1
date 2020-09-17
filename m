Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA2DC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 13:56:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC48420663
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 13:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OkIJ3yn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC48420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIuOK-0002Yg-Ud
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 09:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kIuM3-0008IO-VZ
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 09:53:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42796)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kIuLz-00082l-Sf
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 09:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600350819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZLD+Sit25/qmgfx5038iz6MD+ijxOcduhMfIIhwKx9Y=;
 b=OkIJ3yn0rjiJhSlBtItZ56+Ij8Ov5wuB7MLuXsLleHezzNTG+Zd9emEUAQS9MUjD0N+KVp
 OUJJySVAnCenG41tzdFpl7jh3v2fJO1HbRyXwDkPyoQcKgDltz6buV2OfymuhxzMw69n5c
 xFZT2wwh3+1SX/hlQgMFP5Hex5T+MGA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-PU9re5w9NLy6BLSD8YvVGQ-1; Thu, 17 Sep 2020 09:53:35 -0400
X-MC-Unique: PU9re5w9NLy6BLSD8YvVGQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F2CB80732A;
 Thu, 17 Sep 2020 13:53:33 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-85.ams2.redhat.com
 [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B12DE5DE51;
 Thu, 17 Sep 2020 13:53:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9F9DF9CBC; Thu, 17 Sep 2020 15:53:23 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/21] seabios: add microvm config, update build rules
Date: Thu, 17 Sep 2020 15:53:04 +0200
Message-Id: <20200917135323.18022-3-kraxel@redhat.com>
In-Reply-To: <20200917135323.18022-1-kraxel@redhat.com>
References: <20200917135323.18022-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 20:51:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Sergio Lopez <slp@redhat.com>
Message-id: 20200915120909.20838-3-kraxel@redhat.com
---
 roms/Makefile               |  5 ++++-
 roms/config.seabios-microvm | 26 ++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)
 create mode 100644 roms/config.seabios-microvm

diff --git a/roms/Makefile b/roms/Makefile
index 1395a46695be..1489d47350f2 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -72,9 +72,12 @@ default help:
 	@echo "  clean              -- delete the files generated by the previous" \
 	                              "build targets"
 
-bios: build-seabios-config-seabios-128k build-seabios-config-seabios-256k
+bios: build-seabios-config-seabios-128k \
+		build-seabios-config-seabios-256k \
+		build-seabios-config-seabios-microvm
 	cp seabios/builds/seabios-128k/bios.bin ../pc-bios/bios.bin
 	cp seabios/builds/seabios-256k/bios.bin ../pc-bios/bios-256k.bin
+	cp seabios/builds/seabios-microvm/bios.bin ../pc-bios/bios-microvm.bin
 
 vgabios seavgabios: $(patsubst %,seavgabios-%,$(vgabios_variants))
 
diff --git a/roms/config.seabios-microvm b/roms/config.seabios-microvm
new file mode 100644
index 000000000000..a253e2edc6ec
--- /dev/null
+++ b/roms/config.seabios-microvm
@@ -0,0 +1,26 @@
+CONFIG_QEMU=y
+CONFIG_QEMU_HARDWARE=y
+CONFIG_PERMIT_UNALIGNED_PCIROM=y
+CONFIG_ROM_SIZE=128
+CONFIG_XEN=n
+CONFIG_BOOTSPLASH=n
+CONFIG_ATA=n
+CONFIG_AHCI=n
+CONFIG_SDCARD=n
+CONFIG_PVSCSI=n
+CONFIG_ESP_SCSI=n
+CONFIG_LSI_SCSI=n
+CONFIG_MEGASAS=n
+CONFIG_MPT_SCSI=n
+CONFIG_FLOPPY=n
+CONFIG_FLASH_FLOPPY=n
+CONFIG_NVME=n
+CONFIG_PS2PORT=n
+CONFIG_USB=n
+CONFIG_LPT=n
+CONFIG_RTC_TIMER=n
+CONFIG_USE_SMM=n
+CONFIG_PMTIMER=n
+CONFIG_TCGBIOS=n
+CONFIG_HARDWARE_IRQ=n
+CONFIG_ACPI_PARSE=y
-- 
2.27.0


