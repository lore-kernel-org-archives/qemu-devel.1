Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E98C3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 07:49:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7A83246A1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 07:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gKDBjKuZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7A83246A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8fpn-0003WO-0p
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 02:49:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j8fhX-0004ZT-GD
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 02:41:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j8fhW-0003i7-F9
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 02:41:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60700
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j8fhW-0003hV-BQ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 02:41:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583134878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tUVMgu3taFrVdtqL+TAAQJ+eS/lDgUc1HJ2Th9oKz08=;
 b=gKDBjKuZf+8qAB0khJLud4PSmwcxUnYHm4qyvW2FxyJn4FH4ojSj6O9uyjScij6P9Vj+XI
 EUUE3x7mC6DI2Lc5A2/u93PLzaQBJiI9dYOTAh9l3/KSXw0B5ySWli+y8lR7mQqgrhrnqn
 HweuImjwWfDWPpf8OhuTJgPds66r13Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-Zd6wmuNNPDqgXSH72neiiA-1; Mon, 02 Mar 2020 02:41:14 -0500
X-MC-Unique: Zd6wmuNNPDqgXSH72neiiA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA11D800D4E;
 Mon,  2 Mar 2020 07:41:12 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-58.pek2.redhat.com
 [10.72.12.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4AB0560BF3;
 Mon,  2 Mar 2020 07:41:11 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL 13/23] dp8393x: Don't reset Silicon Revision register
Date: Mon,  2 Mar 2020 15:40:26 +0800
Message-Id: <1583134836-23991-14-git-send-email-jasowang@redhat.com>
In-Reply-To: <1583134836-23991-1-git-send-email-jasowang@redhat.com>
References: <1583134836-23991-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Finn Thain <fthain@telegraphics.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Finn Thain <fthain@telegraphics.com.au>

The jazzsonic driver in Linux uses the Silicon Revision register value
to probe the chip. The driver fails unless the SR register contains 4.
Unfortunately, reading this register in QEMU usually returns 0 because
the s->regs[] array gets wiped after a software reset.

Fixes: bd8f1ebce4 ("net/dp8393x: fix hardware reset")
Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/dp8393x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index cfbc2ee..c2ac2a1 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -923,6 +923,7 @@ static void dp8393x_reset(DeviceState *dev)
     timer_del(s->watchdog);
=20
     memset(s->regs, 0, sizeof(s->regs));
+    s->regs[SONIC_SR] =3D 0x0004; /* only revision recognized by Linux/mip=
s */
     s->regs[SONIC_CR] =3D SONIC_CR_RST | SONIC_CR_STP | SONIC_CR_RXDIS;
     s->regs[SONIC_DCR] &=3D ~(SONIC_DCR_EXBUS | SONIC_DCR_LBR);
     s->regs[SONIC_RCR] &=3D ~(SONIC_RCR_LB0 | SONIC_RCR_LB1 | SONIC_RCR_BR=
D | SONIC_RCR_RNT);
@@ -975,7 +976,6 @@ static void dp8393x_realize(DeviceState *dev, Error **e=
rrp)
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
=20
     s->watchdog =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, dp8393x_watchdog, s);
-    s->regs[SONIC_SR] =3D 0x0004; /* only revision recognized by Linux */
=20
     memory_region_init_ram(&s->prom, OBJECT(dev),
                            "dp8393x-prom", SONIC_PROM_SIZE, &local_err);
--=20
2.5.0


