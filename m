Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097C7C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:16:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 960DB2068F
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h46w18R+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 960DB2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxnSH-0000jr-LB
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 04:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jxnMs-0007uA-Dj
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:11:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31819
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jxnMq-0004Mt-Hs
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595319075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=c31UckBapyQ7PA0FmBG8QNdyiHw16PrRPEEFlCLHzdw=;
 b=h46w18R+yPmiGE5f7ZKOxNbcEP7h38KAdo9f1wBQVIqxYU3tkb7Eobpk7hwNSZqD/D6ije
 CBm/TBzODcJA9b5/6Et0EZmg2dtSOxSyQ6a26szbRGA9gJNJVjKGz/ON6Ymu28BycGCH65
 jWBjGXyXit2PzPWcEQ5jX7njyPw9QCs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-BpaeWHyvP02kls1kxFPxPA-1; Tue, 21 Jul 2020 04:11:13 -0400
X-MC-Unique: BpaeWHyvP02kls1kxFPxPA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86F7918C63C0;
 Tue, 21 Jul 2020 08:11:12 +0000 (UTC)
Received: from thuth.com (ovpn-112-102.ams2.redhat.com [10.36.112.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8AD033C67;
 Tue, 21 Jul 2020 08:11:11 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 10/10] hw: Mark nd_table[] misuse in realize methods FIXME
Date: Tue, 21 Jul 2020 10:10:55 +0200
Message-Id: <20200721081055.14073-11-thuth@redhat.com>
In-Reply-To: <20200721081055.14073-1-thuth@redhat.com>
References: <20200721081055.14073-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:46:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Markus Armbruster <armbru@redhat.com>

nd_table[] contains NIC configuration for boards to pick up.  Device
code has no business looking there.  Several devices do it anyway.
Two of them already have a suitable FIXME comment: "allwinner-a10" and
"msf2-soc".  Copy it to the others: "allwinner-h3", "xlnx-versal",
"xlnx,zynqmp", "sparc32-ledma", "riscv.sifive.u.soc".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200715140440.3540942-3-armbru@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/allwinner-h3.c | 1 +
 hw/arm/xlnx-versal.c  | 1 +
 hw/arm/xlnx-zynqmp.c  | 1 +
 hw/dma/sparc32_dma.c  | 1 +
 hw/riscv/sifive_u.c   | 1 +
 5 files changed, 5 insertions(+)

diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index 8e09468e86..ff92ded82c 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -358,6 +358,7 @@ static void allwinner_h3_realize(DeviceState *dev, Error **errp)
                               "sd-bus");
 
     /* EMAC */
+    /* FIXME use qdev NIC properties instead of nd_table[] */
     if (nd_table[0].used) {
         qemu_check_nic_model(&nd_table[0], TYPE_AW_SUN8I_EMAC);
         qdev_set_nic_properties(DEVICE(&s->emac), &nd_table[0]);
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index ead038b971..e3aa4bd1e5 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -160,6 +160,7 @@ static void versal_create_gems(Versal *s, qemu_irq *pic)
         object_initialize_child(OBJECT(s), name, &s->lpd.iou.gem[i],
                                 TYPE_CADENCE_GEM);
         dev = DEVICE(&s->lpd.iou.gem[i]);
+        /* FIXME use qdev NIC properties instead of nd_table[] */
         if (nd->used) {
             qemu_check_nic_model(nd, "cadence_gem");
             qdev_set_nic_properties(dev, nd);
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 772cfa3771..5855e5d5bf 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -455,6 +455,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < XLNX_ZYNQMP_NUM_GEMS; i++) {
         NICInfo *nd = &nd_table[i];
 
+        /* FIXME use qdev NIC properties instead of nd_table[] */
         if (nd->used) {
             qemu_check_nic_model(nd, TYPE_CADENCE_GEM);
             qdev_set_nic_properties(DEVICE(&s->gem[i]), nd);
diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index 9459178866..bcd1626fbd 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -341,6 +341,7 @@ static void sparc32_ledma_device_realize(DeviceState *dev, Error **errp)
     DeviceState *d;
     NICInfo *nd = &nd_table[0];
 
+    /* FIXME use qdev NIC properties instead of nd_table[] */
     qemu_check_nic_model(nd, TYPE_LANCE);
 
     d = qdev_new(TYPE_LANCE);
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 19a976c9a6..e5682c38a9 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -714,6 +714,7 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->otp), 0, memmap[SIFIVE_U_OTP].base);
 
+    /* FIXME use qdev NIC properties instead of nd_table[] */
     if (nd->used) {
         qemu_check_nic_model(nd, TYPE_CADENCE_GEM);
         qdev_set_nic_properties(DEVICE(&s->gem), nd);
-- 
2.18.1


