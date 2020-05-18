Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC7CC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 05:06:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07C0120657
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 05:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kfq81pOm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C0120657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaXyl-0003hu-3R
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 01:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jaXwt-0000A6-Og
 for qemu-devel@nongnu.org; Mon, 18 May 2020 01:04:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51472
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jaXws-0004Og-GB
 for qemu-devel@nongnu.org; Mon, 18 May 2020 01:04:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589778261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t4O5dU6OXScPqqUWYQSyYlMZ+HtADWQ8rEMv7vhvyQI=;
 b=Kfq81pOmVXTy24fMWOgkhewL9XEM+Yr9/9Tn9GoypYlZysKiE366BZHznI3ud0PCP3eJe6
 /MjOKszluWqB8Xb6R73tCrBsFXWhtIxDFYY7Z9PpHXd4CRwFCAD7x+7pW61/Pt6bruojjf
 DfCSctiiGkEKXvPeiV1z7IOBBvz0Pjk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-CWtNukdVOO6sZWFhOa3X2Q-1; Mon, 18 May 2020 01:04:13 -0400
X-MC-Unique: CWtNukdVOO6sZWFhOa3X2Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D112EEC1A6;
 Mon, 18 May 2020 05:04:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FC1B79589;
 Mon, 18 May 2020 05:04:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5496111358CD; Mon, 18 May 2020 07:04:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/24] ppc/pnv: Put "*-pnv-chip" and "pnv-xive" on the main
 system bus
Date: Mon, 18 May 2020 07:04:00 +0200
Message-Id: <20200518050408.4579-17-armbru@redhat.com>
In-Reply-To: <20200518050408.4579-1-armbru@redhat.com>
References: <20200518050408.4579-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 00:53:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
2.21.1


