Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF767C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 21:06:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C0062078E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 21:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XoLKb1Dy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C0062078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkwJk-0008MB-MH
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 17:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jkvuN-000360-V6
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 16:40:43 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41897
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jkvuJ-0000Z3-Bd
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 16:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592253637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kw11XaV9llR6IZI+iMTb4XV+xoOGm5V1oibzp+Gl5kU=;
 b=XoLKb1DyPlg1a941H03gfaWGan8P+bX9CB+qDug3XDxk3dzkcwBxSGdU17P6pXK3o1lu5/
 znwGIPudCecon2MjJB6LocQyx6sMjO6vYSAikf+6jw0dMgSWc+9VCvFHUVKG46y4ykWqyd
 qJEh5PuZTbFhjdWwuks0/Kkc5XZV1k8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-30uSdQByPlOQ9EPheSxQUg-1; Mon, 15 Jun 2020 16:40:35 -0400
X-MC-Unique: 30uSdQByPlOQ9EPheSxQUg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27CDE873402;
 Mon, 15 Jun 2020 20:40:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 35FA45D9D5;
 Mon, 15 Jun 2020 20:40:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 61D5311358DB; Mon, 15 Jun 2020 22:40:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/84] display/sm501 display/ati: Fix to realize "i2c-ddc"
Date: Mon, 15 Jun 2020 22:39:04 +0200
Message-Id: <20200615204008.3069956-21-armbru@redhat.com>
In-Reply-To: <20200615204008.3069956-1-armbru@redhat.com>
References: <20200615204008.3069956-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 15:33:00
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
Cc: Magnus Damm <magnus.damm@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

sm501_init() and ati_vga_realize() create an "i2c-ddc" device, but
neglect to realize it.  Affects machines sam460ex, shix, r2d, and
fulong2e.

In theory, a device becomes real only on realize.  In practice, the
transition from unreal to real is a fuzzy one.  The work to make a
device real can be spread between realize methods (fine),
instance_init methods (wrong), and board code wiring up the device
(fine as long as it effectively happens on realize).  Depending on
what exactly is done where, a device can work even when we neglect
to realize it.

This one appears to work.  Nevertheless, it's a clear misuse of the
interface.  Even when it works today (more or less by chance), it can
break tomorrow.

Fix by realizing it right away.  Visible in "info qom-tree"; here's
the change for sam460ex:

     /machine (sam460ex-machine)
       [...]
       /unattached (container)
         [...]
    -    /device[14] (sii3112)
    +    /device[14] (i2c-ddc)
    +    /device[15] (sii3112)
         [rest of device[*] renumbered...]

Fixes: 4a1f253adb45ac6019971193d5077c4d5d55886a
Fixes: c82c7336de58876862e6b4dccbda29e9240fd388
Cc: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-ppc@nongnu.org
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200609122339.937862-19-armbru@redhat.com>
---
 hw/display/ati.c   | 2 ++
 hw/display/sm501.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 67604e68de..1d9df92b96 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -935,6 +935,8 @@ static void ati_vga_realize(PCIDevice *dev, Error **errp)
     bitbang_i2c_init(&s->bbi2c, i2cbus);
     I2CSlave *i2cddc = I2C_SLAVE(qdev_create(BUS(i2cbus), TYPE_I2CDDC));
     i2c_set_slave_address(i2cddc, 0x50);
+    object_property_set_bool(OBJECT(i2cddc), true, "realized",
+                             &error_abort);
 
     /* mmio register space */
     memory_region_init_io(&s->mm, OBJECT(s), &ati_mm_ops, s,
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index edd8d24a76..fa23a78164 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -1833,6 +1833,8 @@ static void sm501_init(SM501State *s, DeviceState *dev,
     /* ddc */
     I2CDDCState *ddc = I2CDDC(qdev_create(BUS(s->i2c_bus), TYPE_I2CDDC));
     i2c_set_slave_address(I2C_SLAVE(ddc), 0x50);
+    object_property_set_bool(OBJECT(ddc), true, "realized",
+                             &error_abort);
 
     /* mmio */
     memory_region_init(&s->mmio_region, OBJECT(dev), "sm501.mmio", MMIO_SIZE);
-- 
2.26.2


