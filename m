Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AB1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 11:09:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C57CE2088E
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 11:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hMSlqtQv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C57CE2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeGPr-0007FI-UM
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 07:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jeGLJ-0005nx-S2
 for qemu-devel@nongnu.org; Thu, 28 May 2020 07:04:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21756
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jeGLE-0006hC-Og
 for qemu-devel@nongnu.org; Thu, 28 May 2020 07:04:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590663892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bfy+Oh8nlUt028pTCxJbbHy0rLw3m3T63uQUxAuRSvM=;
 b=hMSlqtQvpM3h6knP+FYDmFBpQ55GlVr2l5O1wyajgh8pJ4NSNI3Aq6yjoBaA94LYqtvQgM
 2ex8j7EIIBNwfjW5EJ/Xzoo0tZAudmLxjJR3YTua4nRgEA0Ew4/MwYA9g35dlUJW357Kjy
 Byo1129h/t+hbicWEVWtwqVLQVvmNno=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-ra6mxHWPO3qs9n-Rjisggg-1; Thu, 28 May 2020 07:04:50 -0400
X-MC-Unique: ra6mxHWPO3qs9n-Rjisggg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 571051005512;
 Thu, 28 May 2020 11:04:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 259C35D9EF;
 Thu, 28 May 2020 11:04:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0B85B11358CB; Thu, 28 May 2020 13:04:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 16/24] ppc/pnv: Put "*-pnv-chip" and "pnv-xive" on the main
 system bus
Date: Thu, 28 May 2020 13:04:36 +0200
Message-Id: <20200528110444.20456-17-armbru@redhat.com>
In-Reply-To: <20200528110444.20456-1-armbru@redhat.com>
References: <20200528110444.20456-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 03:11:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: berrange@redhat.com, ehabkost@redhat.com, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, pbonzini@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

pnv_init() creates "power10_v1.0-pnv-chip", "power8_v2.0-pnv-chip",
"power8e_v2.1-pnv-chip", "power8nvl_v1.0-pnv-chip", or
"power9_v2.0-pnv-chip" sysbus devices in a way that leaves them
unplugged.

pnv_chip_power9_instance_init() creates a "pnv-xive" sysbus device in
a way that leaves it unplugged.

Create them the common way that puts them into the main system bus.
Affects machines powernv8, powernv9, and powernv10.  Visible in "info
qtree".  Here's the change for powernv9:

     bus: main-system-bus
       type System
    +  dev: power9_v2.0-pnv-chip, id ""
    +    chip-id = 0 (0x0)
    +    ram-start = 0 (0x0)
    +    ram-size = 1879048192 (0x70000000)
    +    nr-cores = 1 (0x1)
    +    cores-mask = 72057594037927935 (0xffffffffffffff)
    +    nr-threads = 1 (0x1)
    +    num-phbs = 6 (0x6)
    +    mmio 000603fc00000000/0000000400000000
    [...]
    +  dev: pnv-xive, id ""
    +    ic-bar = 1692157036462080 (0x6030203100000)
    +    vc-bar = 1689949371891712 (0x6010000000000)
    +    pc-bar = 1690499127705600 (0x6018000000000)
    +    tm-bar = 1692157036986368 (0x6030203180000)

Cc: "Cédric Le Goater" <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index da637822f9..8d4fc8109a 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -818,7 +818,7 @@ static void pnv_init(MachineState *machine)
     pnv->chips = g_new0(PnvChip *, pnv->num_chips);
     for (i = 0; i < pnv->num_chips; i++) {
         char chip_name[32];
-        Object *chip = object_new(chip_typename);
+        Object *chip = OBJECT(qdev_create(NULL, chip_typename));
 
         pnv->chips[i] = PNV_CHIP(chip);
 
@@ -1317,8 +1317,8 @@ static void pnv_chip_power9_instance_init(Object *obj)
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(obj);
     int i;
 
-    object_initialize_child(obj, "xive", &chip9->xive, sizeof(chip9->xive),
-                            TYPE_PNV_XIVE, &error_abort, NULL);
+    sysbus_init_child_obj(obj, "xive", &chip9->xive, sizeof(chip9->xive),
+                          TYPE_PNV_XIVE);
     object_property_add_alias(obj, "xive-fabric", OBJECT(&chip9->xive),
                               "xive-fabric");
 
-- 
2.21.3


