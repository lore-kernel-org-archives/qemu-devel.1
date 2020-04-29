Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDCCC83004
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:08:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9092208FE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NcFwWb5G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9092208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTnO5-0006Q3-V3
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 10:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42506)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTnGm-0002Lh-BS
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:01:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTnGH-0003zT-0S
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:01:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55388
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jTnGG-0003yf-K8
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588168827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wVia+kqi56m7fobc/F24sqeB+1njvSGFY4Ow1Djzbvw=;
 b=NcFwWb5GLxu1VPy8tGzws7NblZk6Ca9bqLFFrDck9RMjOH+KABmrBBbDRI9cuOEey0z6id
 uj22AXfyfs770MGZO/P6QoimFpfsQPpi4BpXFjEWSIffV+hZ+PfMP3XV6+FCqV2Qy5FFlG
 GKbQu8QvGDkVIi88YJKu2Wr3gwu53rI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-oQ03J7uhMVqDnkHldktIHA-1; Wed, 29 Apr 2020 10:00:26 -0400
X-MC-Unique: oQ03J7uhMVqDnkHldktIHA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA698100A633;
 Wed, 29 Apr 2020 14:00:24 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 82EF2605FB;
 Wed, 29 Apr 2020 14:00:16 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 59C0A9D9F; Wed, 29 Apr 2020 16:00:03 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/15] rtc: add RTC_ISA_BASE
Date: Wed, 29 Apr 2020 15:59:54 +0200
Message-Id: <20200429140003.7336-7-kraxel@redhat.com>
In-Reply-To: <20200429140003.7336-1-kraxel@redhat.com>
References: <20200429140003.7336-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:42:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add and use RTC_ISA_BASE define instead of hardcoding 0x70.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/rtc/mc146818rtc.h | 1 +
 hw/rtc/mc146818rtc.c         | 5 ++---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/rtc/mc146818rtc.h b/include/hw/rtc/mc146818rtc.h
index 10c93a096a1d..3713181b56fe 100644
--- a/include/hw/rtc/mc146818rtc.h
+++ b/include/hw/rtc/mc146818rtc.h
@@ -47,6 +47,7 @@ typedef struct RTCState {
 } RTCState;
=20
 #define RTC_ISA_IRQ 8
+#define RTC_ISA_BASE 0x70
=20
 ISADevice *mc146818_rtc_init(ISABus *bus, int base_year,
                              qemu_irq intercept_irq);
diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index dc4269cc55cb..d18c09911be2 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -908,7 +908,6 @@ static void rtc_realizefn(DeviceState *dev, Error **err=
p)
 {
     ISADevice *isadev =3D ISA_DEVICE(dev);
     RTCState *s =3D MC146818_RTC(dev);
-    int base =3D 0x70;
=20
     s->cmos_data[RTC_REG_A] =3D 0x26;
     s->cmos_data[RTC_REG_B] =3D 0x02;
@@ -951,7 +950,7 @@ static void rtc_realizefn(DeviceState *dev, Error **err=
p)
     qemu_register_suspend_notifier(&s->suspend_notifier);
=20
     memory_region_init_io(&s->io, OBJECT(s), &cmos_ops, s, "rtc", 2);
-    isa_register_ioport(isadev, &s->io, base);
+    isa_register_ioport(isadev, &s->io, RTC_ISA_BASE);
=20
     /* register rtc 0x70 port for coalesced_pio */
     memory_region_set_flush_coalesced(&s->io);
@@ -960,7 +959,7 @@ static void rtc_realizefn(DeviceState *dev, Error **err=
p)
     memory_region_add_subregion(&s->io, 0, &s->coalesced_io);
     memory_region_add_coalescing(&s->coalesced_io, 0, 1);
=20
-    qdev_set_legacy_instance_id(dev, base, 3);
+    qdev_set_legacy_instance_id(dev, RTC_ISA_BASE, 3);
     qemu_register_reset(rtc_reset, s);
=20
     object_property_add_tm(OBJECT(s), "date", rtc_get_date, NULL);
--=20
2.18.2


