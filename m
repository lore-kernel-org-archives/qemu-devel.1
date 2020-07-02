Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DDBC433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:30:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B43C2088E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AX+n/Z7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B43C2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqzHt-00049w-FA
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 09:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jqzDv-0004yn-PH
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 09:25:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42262
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jqzDj-0007BM-U8
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 09:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593696343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=1XBFvhmM5shzLN1YMzs8HNjfJvha9Xy2lVgHhZwjUDk=;
 b=AX+n/Z7Ee9PCtO8dCwV8ljNanPzC+XGhvGI4LEjPIDZ9s/7Zfw7k6VvdS4/TSAzM9IVcyH
 0lLxKtGkmYiLpvOCYSTJwSQWfXYoP0vsJc8HRiX3kLWtX9rWbvPNbndHASjYffYVAWU4XS
 o932YiFWIA87c3xGrD7Hs61sJnIedak=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-VrHErzTkPhGeLGz0rtyarA-1; Thu, 02 Jul 2020 09:25:38 -0400
X-MC-Unique: VrHErzTkPhGeLGz0rtyarA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F8C2800C64;
 Thu,  2 Jul 2020 13:25:37 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-62.ams2.redhat.com
 [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 045625DD61;
 Thu,  2 Jul 2020 13:25:37 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id BDE2331EE9; Thu,  2 Jul 2020 15:25:25 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 16/20] audio: create pcspk device early
Date: Thu,  2 Jul 2020 15:25:21 +0200
Message-Id: <20200702132525.6849-17-kraxel@redhat.com>
In-Reply-To: <20200702132525.6849-1-kraxel@redhat.com>
References: <20200702132525.6849-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:42:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 libvir-list@redhat.com, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Create the pcspk device early, so it exists at
machine type initialization time.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/i386/pc.h | 1 +
 hw/i386/pc.c         | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index d7690bf4290f..a802e699749a 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -33,6 +33,7 @@ struct PCMachineState {
     PCIBus *bus;
     I2CBus *smbus;
     PFlashCFI01 *flash[2];
+    ISADevice *pcspk;
 
     /* Configuration options: */
     uint64_t max_ram_below_4g;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 4fc1b7048b28..88785f9dcc70 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1219,7 +1219,7 @@ void pc_basic_device_init(struct PCMachineState *pcms,
             /* connect PIT to output control line of the HPET */
             qdev_connect_gpio_out(hpet, 0, qdev_get_gpio_in(DEVICE(pit), 0));
         }
-        pcspk_init(isa_new(TYPE_PC_SPEAKER), isa_bus, pit);
+        pcspk_init(pcms->pcspk, isa_bus, pit);
     }
 
     i8257_dma_init(isa_bus, 0);
@@ -1891,6 +1891,7 @@ static void pc_machine_initfn(Object *obj)
     pcms->pit_enabled = true;
 
     pc_system_flash_create(pcms);
+    pcms->pcspk = isa_new(TYPE_PC_SPEAKER);
 }
 
 static void pc_machine_reset(MachineState *machine)
-- 
2.18.4


