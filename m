Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E085C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:00:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 376C120707
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QAQTyY6j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 376C120707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jefYa-0005bG-BJ
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 10:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jefKQ-0002oI-1k
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:45:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47508
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jefKK-00074i-PJ
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590759935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c4gA2VhRpcNayUDq5XGnLwcMe9WmGatWAtOLY5fvC6A=;
 b=QAQTyY6jlOJx4qOcTwlTQ5OXoLihuEXEF/kPh1NpCIAGLmk3HVMmNAor4VNR1NqMAid1Zl
 ut++2NnaCpuid3uejukgrVLcj2BY0FHXzYdblYMz75AxCXC8q7/kTmPm7Lw3/wg3lo0Gtn
 8xY9fj3B2L2mbeXmSffb/9bjwkTegS4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-_Vs3X3b5OfigfBzSRBfozw-1; Fri, 29 May 2020 09:45:33 -0400
X-MC-Unique: _Vs3X3b5OfigfBzSRBfozw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC0C7107ACCD
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 13:45:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F04860C05;
 Fri, 29 May 2020 13:45:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6863A1135233; Fri, 29 May 2020 15:45:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 40/58] microbit: Tidy up sysbus_init_child_obj() @child
 argument
Date: Fri, 29 May 2020 15:45:05 +0200
Message-Id: <20200529134523.8477-41-armbru@redhat.com>
In-Reply-To: <20200529134523.8477-1-armbru@redhat.com>
References: <20200529134523.8477-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 01:34:27
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The callers of sysbus_init_child_obj() commonly pass either &child,
sizeof(child), or pchild, sizeof(*pchild).  Tidy up two that don't,
mostly to keep future commits simpler.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/arm/microbit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
index ef213695bd..72fab429c4 100644
--- a/hw/arm/microbit.c
+++ b/hw/arm/microbit.c
@@ -39,7 +39,7 @@ static void microbit_init(MachineState *machine)
     Object *soc = OBJECT(&s->nrf51);
     Object *i2c = OBJECT(&s->i2c);
 
-    sysbus_init_child_obj(OBJECT(machine), "nrf51", soc, sizeof(s->nrf51),
+    sysbus_init_child_obj(OBJECT(machine), "nrf51", &s->nrf51, sizeof(s->nrf51),
                           TYPE_NRF51_SOC);
     qdev_prop_set_chr(DEVICE(&s->nrf51), "serial0", serial_hd(0));
     object_property_set_link(soc, OBJECT(system_memory), "memory",
@@ -51,7 +51,7 @@ static void microbit_init(MachineState *machine)
      * hack until we implement the nRF51 TWI controller properly and the
      * magnetometer/accelerometer devices.
      */
-    sysbus_init_child_obj(OBJECT(machine), "microbit.twi", i2c,
+    sysbus_init_child_obj(OBJECT(machine), "microbit.twi", &s->i2c,
                           sizeof(s->i2c), TYPE_MICROBIT_I2C);
     object_property_set_bool(i2c, true, "realized", &error_fatal);
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(i2c), 0);
-- 
2.21.3


