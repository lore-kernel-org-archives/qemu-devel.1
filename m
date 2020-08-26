Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC832C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 10:59:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9ECB206EB
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 10:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3hGVU4F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9ECB206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAt9j-0002BR-0G
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 06:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kAt3a-0006Wb-Uw
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 06:53:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54613)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kAt3P-0001ZO-M4
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 06:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598439198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3oE6jZipdDk0METVeCLVyc8aV6ZhNb6/y6HHqyX62vU=;
 b=X3hGVU4FMxj8Oabm6akeZUGapk7n8lbSnLzxyWQJ5S4vLxBes+DJDQStjk3w6YPX/dtau3
 SSwxuPYIMzSTrbB4qwIeiPSeRhiu4sdBk2PlMTLsMA+o0dJsoXno4QCPDXopyvuA2b6HZd
 YJuJDoxqbWwqy7lQ9xMacnTZ9X9o9LE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-7Po-9udqMVq_4d8KxviIEg-1; Wed, 26 Aug 2020 06:53:15 -0400
X-MC-Unique: 7Po-9udqMVq_4d8KxviIEg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA4F0807330;
 Wed, 26 Aug 2020 10:53:13 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-54.ams2.redhat.com
 [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF5E65C1BB;
 Wed, 26 Aug 2020 10:53:05 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9443031F50; Wed, 26 Aug 2020 12:52:54 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 11/20] microvm/acpi: use seabios with acpi=on
Date: Wed, 26 Aug 2020 12:52:45 +0200
Message-Id: <20200826105254.28496-12-kraxel@redhat.com>
In-Reply-To: <20200826105254.28496-1-kraxel@redhat.com>
References: <20200826105254.28496-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 23:30:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

With acpi=off continue to use qboot.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/i386/microvm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index ca0c9983f137..54510a03f754 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -52,6 +52,7 @@
 #include "hw/xen/start_info.h"
 
 #define MICROVM_QBOOT_FILENAME "qboot.rom"
+#define MICROVM_BIOS_FILENAME  "bios-microvm.bin"
 
 static void microvm_set_rtc(MicrovmMachineState *mms, ISADevice *s)
 {
@@ -174,7 +175,9 @@ static void microvm_devices_init(MicrovmMachineState *mms)
     }
 
     if (bios_name == NULL) {
-        bios_name = MICROVM_QBOOT_FILENAME;
+        bios_name = x86_machine_is_acpi_enabled(x86ms)
+            ? MICROVM_BIOS_FILENAME
+            : MICROVM_QBOOT_FILENAME;
     }
     x86_bios_rom_init(get_system_memory(), true);
 }
-- 
2.27.0


