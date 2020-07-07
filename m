Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9488C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 12:55:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 747CC20708
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 12:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IWUOjyKH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 747CC20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsn8O-0000gf-LI
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 08:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jsn73-0007KH-CV
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 08:54:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23532
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jsn70-0004kE-Qs
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 08:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594126453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=d/4SzrO51wLCoiHfnRNqtnLD968Kuwi1FHNsO/et+5g=;
 b=IWUOjyKHFS52yJEfkohKdELw5yGpVV+QnJqPPSznZZtwQDRHgLl9I8MURMJRgKO2iz3n0X
 meIZelquIOG4sFpm2Z0FN08hkkxRQ3m48s7At1kZlhLd42mC5qskpNxOgdDOLYhgrKsoxl
 Vj+e/bW9dkllvaxZl95VBrIwEyNmZTM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-dqKA9R8iNjyMII90ISFL4A-1; Tue, 07 Jul 2020 08:54:11 -0400
X-MC-Unique: dqKA9R8iNjyMII90ISFL4A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9618B108BD0D;
 Tue,  7 Jul 2020 12:54:10 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-200.ams2.redhat.com
 [10.36.112.200])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C77C87846E;
 Tue,  7 Jul 2020 12:53:57 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id EAE0E31F0A; Tue,  7 Jul 2020 14:53:56 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 01/20] microvm: name qboot binary qboot.rom
Date: Tue,  7 Jul 2020 14:53:37 +0200
Message-Id: <20200707125356.32450-2-kraxel@redhat.com>
In-Reply-To: <20200707125356.32450-1-kraxel@redhat.com>
References: <20200707125356.32450-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 06:04:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qboot isn't a bios and shouldnt be named that way.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/i386/microvm.c                       |   4 ++--
 pc-bios/{bios-microvm.bin => qboot.rom} | Bin
 roms/Makefile                           |   6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)
 rename pc-bios/{bios-microvm.bin => qboot.rom} (100%)

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 5e931975a06d..1300c396947b 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -47,7 +47,7 @@
 #include "kvm_i386.h"
 #include "hw/xen/start_info.h"
 
-#define MICROVM_BIOS_FILENAME "bios-microvm.bin"
+#define MICROVM_QBOOT_FILENAME "qboot.rom"
 
 static void microvm_set_rtc(MicrovmMachineState *mms, ISADevice *s)
 {
@@ -158,7 +158,7 @@ static void microvm_devices_init(MicrovmMachineState *mms)
     }
 
     if (bios_name == NULL) {
-        bios_name = MICROVM_BIOS_FILENAME;
+        bios_name = MICROVM_QBOOT_FILENAME;
     }
     x86_bios_rom_init(get_system_memory(), true);
 }
diff --git a/pc-bios/bios-microvm.bin b/pc-bios/qboot.rom
similarity index 100%
rename from pc-bios/bios-microvm.bin
rename to pc-bios/qboot.rom
diff --git a/roms/Makefile b/roms/Makefile
index f9acf39954dc..b185c880541c 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -68,7 +68,7 @@ default help:
 	@echo "  opensbi64-virt     -- update OpenSBI for 64-bit virt machine"
 	@echo "  opensbi32-sifive_u -- update OpenSBI for 32-bit sifive_u machine"
 	@echo "  opensbi64-sifive_u -- update OpenSBI for 64-bit sifive_u machine"
-	@echo "  bios-microvm       -- update bios-microvm.bin (qboot)"
+	@echo "  qboot              -- update qboot"
 	@echo "  clean              -- delete the files generated by the previous" \
 	                              "build targets"
 
@@ -194,9 +194,9 @@ opensbi64-sifive_u:
 		PLATFORM="sifive/fu540"
 	cp opensbi/build/platform/sifive/fu540/firmware/fw_jump.bin ../pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
 
-bios-microvm:
+qboot:
 	$(MAKE) -C qboot
-	cp qboot/bios.bin ../pc-bios/bios-microvm.bin
+	cp qboot/bios.bin ../pc-bios/qboot.rom
 
 clean:
 	rm -rf seabios/.config seabios/out seabios/builds
-- 
2.18.4


