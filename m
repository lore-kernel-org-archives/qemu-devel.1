Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114A3C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 05:12:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C989B20787
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 05:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HF4M4GPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C989B20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaY4w-0007Ir-1g
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 01:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jaXwt-000088-4p
 for qemu-devel@nongnu.org; Mon, 18 May 2020 01:04:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22081
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jaXwp-0004NU-FJ
 for qemu-devel@nongnu.org; Mon, 18 May 2020 01:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589778258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H5bAYuq8IxFxTWuifcj2i+IDfMnIMKYSHgvtt2OggQw=;
 b=HF4M4GPsWQBB51HPLmEePFqf876pjUGY0LJ7ApJLK33h69vlJkrqYYM+ogzzlmoagSkIId
 MSAPwFu+VVIE4VdDfo7uuDzACC9iiYyjBKpUNMGKdCkg8mFpXP1+A8f/bEONTQrfKmx/kh
 4yQNHLO8AbyhO+qvtmARfNiwsyx900E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-4BFTv4l5NjSRv0HB5f7jPQ-1; Mon, 18 May 2020 01:04:14 -0400
X-MC-Unique: 4BFTv4l5NjSRv0HB5f7jPQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08CEA805731;
 Mon, 18 May 2020 05:04:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C91EF8208F;
 Mon, 18 May 2020 05:04:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 60EBC11358CF; Mon, 18 May 2020 07:04:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/24] display/sm501 display/ati: Fix to realize "i2c-ddc"
Date: Mon, 18 May 2020 07:04:02 +0200
Message-Id: <20200518050408.4579-19-armbru@redhat.com>
In-Reply-To: <20200518050408.4579-1-armbru@redhat.com>
References: <20200518050408.4579-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-ppc@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

sm501_init() and ati_vga_realize() create an "i2c-ddc" device, but
neglect to realize it.  Affects machines sam460ex, shix, r2d, and
fulong2e.

I wonder how this ever worked.  If the "device becomes real only on
realize" thing actually works, then we've always been missing the
device, yet nobody noticed.

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
Fixes: 4a1f253adb45ac6019971193d5077c4d5d55886a
Cc: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-ppc@nongnu.org
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/display/ati.c   | 1 +
 hw/display/sm501.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 58ec8291d4..7c2177d7b3 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -929,6 +929,7 @@ static void ati_vga_realize(PCIDevice *dev, Error **errp)
     bitbang_i2c_init(&s->bbi2c, i2cbus);
     I2CSlave *i2cddc = I2C_SLAVE(qdev_create(BUS(i2cbus), TYPE_I2CDDC));
     i2c_set_slave_address(i2cddc, 0x50);
+    qdev_init_nofail(DEVICE(i2cddc));
 
     /* mmio register space */
     memory_region_init_io(&s->mm, OBJECT(s), &ati_mm_ops, s,
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index acc692531a..132e75b641 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -1816,6 +1816,7 @@ static void sm501_init(SM501State *s, DeviceState *dev,
     /* ddc */
     I2CDDCState *ddc = I2CDDC(qdev_create(BUS(s->i2c_bus), TYPE_I2CDDC));
     i2c_set_slave_address(I2C_SLAVE(ddc), 0x50);
+    qdev_init_nofail(DEVICE(ddc));
 
     /* mmio */
     memory_region_init(&s->mmio_region, OBJECT(dev), "sm501.mmio", MMIO_SIZE);
-- 
2.21.1


