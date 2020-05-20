Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E66C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 13:26:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 667DC20748
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 13:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fCY1FjWj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 667DC20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbOkH-0007Ry-JG
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 09:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jbOe6-0001v4-Vf
 for qemu-devel@nongnu.org; Wed, 20 May 2020 09:20:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27790
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jbOe4-0000FO-42
 for qemu-devel@nongnu.org; Wed, 20 May 2020 09:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589980827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=5/bLq9KGCPysYPYe9QiKsWgS2E2AvDpIpEzAaMPZmiE=;
 b=fCY1FjWjOy231gNzlCygMRUZ+tA21mUHvMxV/CYnhiKSe11r7dODwZSiPLOXhQjL9DzeYE
 vZhmwPNae5l5t65nJtMEbEIhQ6tIpk6Cjo47u02WxKbVD58RrHMzcCRt8Rl5xySECdsgbW
 4202uriANNaaCJKWlvYuecgdUTlNxL0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-d0NoXSp3PZudtJrC8OAcrg-1; Wed, 20 May 2020 09:20:25 -0400
X-MC-Unique: d0NoXSp3PZudtJrC8OAcrg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3390A100CCCB;
 Wed, 20 May 2020 13:20:24 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD3682E170;
 Wed, 20 May 2020 13:20:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 668A49D71; Wed, 20 May 2020 15:20:04 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 19/22] microvm/acpi: use seabios with acpi=on
Date: Wed, 20 May 2020 15:20:00 +0200
Message-Id: <20200520132003.9492-20-kraxel@redhat.com>
In-Reply-To: <20200520132003.9492-1-kraxel@redhat.com>
References: <20200520132003.9492-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 01:34:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With acpi=off continue to use qboot.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/i386/microvm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 7d8174809ae1..ddb8570a2915 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -52,6 +52,7 @@
 #include "hw/xen/start_info.h"
 
 #define MICROVM_QBOOT_FILENAME "qboot.bin"
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
2.18.4


