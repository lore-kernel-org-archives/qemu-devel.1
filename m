Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65900C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 06:07:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C07020734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 06:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P530zYsB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C07020734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jitt9-0002og-Db
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 02:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jitMX-0005Rn-5v
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 01:33:21 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57372
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jitME-0003t8-7K
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 01:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591767180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=idTC9JzziR4pPGldaT4XMbrFOZN8fuVOyaxxwQl71FA=;
 b=P530zYsBicBAmEKNmhljVqOOVHIx4XGSFy/1zuFzSixzEr+EUC3/WoP7Jk7WyeOw2QGmEi
 UUK1TCQvv8BTzfCd7EhZXxes2yCQTKAzYfF7H3IILUS99eL8JK0muIuvwWBExEHlyHIW/7
 A5McbI0BW3xZeVjQeP+QSrNZk/XLHXY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-n1yBbh3XMmKZp_Bdkc-SYQ-1; Wed, 10 Jun 2020 01:32:58 -0400
X-MC-Unique: n1yBbh3XMmKZp_Bdkc-SYQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F03EE835B40
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 05:32:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C149819C71;
 Wed, 10 Jun 2020 05:32:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 06908113848A; Wed, 10 Jun 2020 07:32:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v3 52/58] microbit: Eliminate two local variables in
 microbit_init()
Date: Wed, 10 Jun 2020 07:32:41 +0200
Message-Id: <20200610053247.1583243-53-armbru@redhat.com>
In-Reply-To: <20200610053247.1583243-1-armbru@redhat.com>
References: <20200610053247.1583243-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/arm/microbit.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
index d20ebd3aad..8fe42c9d6a 100644
--- a/hw/arm/microbit.c
+++ b/hw/arm/microbit.c
@@ -36,15 +36,13 @@ static void microbit_init(MachineState *machine)
     MicrobitMachineState *s = MICROBIT_MACHINE(machine);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *mr;
-    Object *soc = OBJECT(&s->nrf51);
-    Object *i2c = OBJECT(&s->i2c);
 
     object_initialize_child(OBJECT(machine), "nrf51", &s->nrf51,
                             TYPE_NRF51_SOC);
     qdev_prop_set_chr(DEVICE(&s->nrf51), "serial0", serial_hd(0));
-    object_property_set_link(soc, OBJECT(system_memory), "memory",
-                             &error_fatal);
-    sysbus_realize(SYS_BUS_DEVICE(soc), &error_fatal);
+    object_property_set_link(OBJECT(&s->nrf51), OBJECT(system_memory),
+                             "memory", &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&s->nrf51), &error_fatal);
 
     /*
      * Overlap the TWI stub device into the SoC.  This is a microbit-specific
@@ -53,13 +51,13 @@ static void microbit_init(MachineState *machine)
      */
     object_initialize_child(OBJECT(machine), "microbit.twi", &s->i2c,
                             TYPE_MICROBIT_I2C);
-    sysbus_realize(SYS_BUS_DEVICE(i2c), &error_fatal);
-    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(i2c), 0);
+    sysbus_realize(SYS_BUS_DEVICE(&s->i2c), &error_fatal);
+    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->i2c), 0);
     memory_region_add_subregion_overlap(&s->nrf51.container, NRF51_TWI_BASE,
                                         mr, -1);
 
     armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
-                       NRF51_SOC(soc)->flash_size);
+                       s->nrf51.flash_size);
 }
 
 static void microbit_machine_class_init(ObjectClass *oc, void *data)
-- 
2.26.2


