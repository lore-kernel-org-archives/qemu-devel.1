Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D1DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 05:19:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38F4620787
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 05:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XK0Rl0tj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F4620787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaYBt-000671-E0
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 01:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jaXws-00006S-Hb
 for qemu-devel@nongnu.org; Mon, 18 May 2020 01:04:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58636
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jaXwo-0004NF-VR
 for qemu-devel@nongnu.org; Mon, 18 May 2020 01:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589778258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P94U20LYuAeV1P/fzoOqSMl+y60Cy8yJ6i9oCIIMJ/U=;
 b=XK0Rl0tjMoP4vuZ5VDWoJ8V9TCqUZ6MXQcA0RDTNcqeltXZs3i1NZXqtCqW7ZVUiDydjze
 LFwD8Nj8/tVDAdUqIOK0FH9PHcYEMWswbioiQaF+chAS6+kyBvwFn+cP4A93Y5I+HLpfrj
 sXy247y7Lu4a8j5O6uptJsokRy3XBGA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-BjDC9FgVOuGH-m2qu1p6qQ-1; Mon, 18 May 2020 01:04:14 -0400
X-MC-Unique: BjDC9FgVOuGH-m2qu1p6qQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79B09872FF2;
 Mon, 18 May 2020 05:04:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 31F978208F;
 Mon, 18 May 2020 05:04:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 72A3D11358D2; Mon, 18 May 2020 07:04:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 21/24] sparc/leon3: Fix to put grlib,* devices on sysbus
Date: Mon, 18 May 2020 07:04:05 +0200
Message-Id: <20200518050408.4579-22-armbru@redhat.com>
In-Reply-To: <20200518050408.4579-1-armbru@redhat.com>
References: <20200518050408.4579-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 23:32:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: berrange@redhat.com, ehabkost@redhat.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, pbonzini@redhat.com,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

leon3_generic_hw_init() creates a "grlib,ahbpnp" and a "grlib,apbpnp"
sysbus device in a way that leaves them unplugged.

Create them the common way that puts them into the main system bus.
Affects machine leon3_generic.  Visible in "info qtree":

     bus: main-system-bus
       type System
    +  dev: grlib,ahbpnp, id ""
    +    mmio 00000000fffff000/0000000000001000
    +  dev: grlib,apbpnp, id ""
    +    mmio 00000000800ff000/0000000000001000
       dev: grlib,irqmp, id ""

Cc: Fabien Chouteau <chouteau@adacore.com>
Cc: KONRAD Frederic <frederic.konrad@adacore.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Artyom Tarasenko <atar4qemu@gmail.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/sparc/leon3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 8f024dab7b..3facb8c2ae 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -213,14 +213,14 @@ static void leon3_generic_hw_init(MachineState *machine)
     reset_info->sp    = LEON3_RAM_OFFSET + ram_size;
     qemu_register_reset(main_cpu_reset, reset_info);
 
-    ahb_pnp = GRLIB_AHB_PNP(object_new(TYPE_GRLIB_AHB_PNP));
+    ahb_pnp = GRLIB_AHB_PNP(qdev_create(NULL, TYPE_GRLIB_AHB_PNP));
     object_property_set_bool(OBJECT(ahb_pnp), true, "realized", &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(ahb_pnp), 0, LEON3_AHB_PNP_OFFSET);
     grlib_ahb_pnp_add_entry(ahb_pnp, 0, 0, GRLIB_VENDOR_GAISLER,
                             GRLIB_LEON3_DEV, GRLIB_AHB_MASTER,
                             GRLIB_CPU_AREA);
 
-    apb_pnp = GRLIB_APB_PNP(object_new(TYPE_GRLIB_APB_PNP));
+    apb_pnp = GRLIB_APB_PNP(qdev_create(NULL, TYPE_GRLIB_APB_PNP));
     object_property_set_bool(OBJECT(apb_pnp), true, "realized", &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(apb_pnp), 0, LEON3_APB_PNP_OFFSET);
     grlib_ahb_pnp_add_entry(ahb_pnp, LEON3_APB_PNP_OFFSET, 0xFFF,
-- 
2.21.1


