Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3609C7114D
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 15:48:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A40372082F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 15:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G9NIazqV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40372082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2zfp-00038B-RJ
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 10:48:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j2zf3-00021P-2T
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 10:47:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j2zf2-0001xr-26
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 10:47:17 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24047
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j2zf1-0001x9-UF
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 10:47:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581781635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FTP3xzlZ0VWGPBVKT2Sfyim4a9LHfPuMAb04JhgkED8=;
 b=G9NIazqVWlsPRTLQmGD8ylC0cQ/KH070FAoysl9XfQd5WrMrAWNK9ty0xc3eQz+vTR5xz8
 +heCQJzGHTG607eWdcANBTqJe+ns6r6sM4D4hqPUOmT9I6Cv8yAuZyG7/WZpztJxtec+JY
 LLLgxdxoE1sXHMQo3UoGDwRkajtpiXc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-XRq17jY2Oa24iK5_Tcuqnw-1; Sat, 15 Feb 2020 10:47:13 -0500
Received: by mail-wr1-f69.google.com with SMTP id 50so5929217wrc.2
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 07:47:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eZP65pruJ7LU66NXEUZwSpQyQCU3S9jHPPlqpEz5cwM=;
 b=teZj+otmZlvoCApYOAEuR0yX/lDnH4kxx2ygVZ+UomKxR+gN85JNrMBMKK6iQJsLhy
 8qI0C+zbYsxO7/Pdas2f+0cf92ZUyOpHtQ/XZq0/aeNyEMiYiU0ZkQRQXHSuO1z97hVd
 iioL1LgGqvfqp5aVyHWqBkF9vQfTEQiJr/IwzCryDVgrPr8ZA9YA5/2IBZqqSMj9peEe
 7PPP21OZEQ80I+GBZStrgh5J8rlK+9boNKbInDe4kFonMxdJ2/KCRsLxpr5+t4exf2JH
 IQrA6FYw0f9ToK+9dAA9Yb2UXuuoRd22cbE7hm8hrwrrYZ6BwaRZQskaqYcQfB76dSRo
 BYDQ==
X-Gm-Message-State: APjAAAXCDGn0ppfMeeNbS3XK9CIqdrp77ft7ukrJAoA6V78fYyQRpZRN
 nhdT/WknFadbU4J55iQToA8rgWbb2G2QOGBsJuHQSwPNNdh99Fh7IRfaHJY0vDe2C1CQf1rnVrx
 2HhkKli1VPKEuELQ=
X-Received: by 2002:a7b:ce84:: with SMTP id q4mr10962460wmj.57.1581781632209; 
 Sat, 15 Feb 2020 07:47:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqwcc4VGaBaKbbDDxYrQ3EhhEeyv8oOYPATK8XL83neBBMLCCDeSooCgVy2ioRXEJ8U8DVGVbg==
X-Received: by 2002:a7b:ce84:: with SMTP id q4mr10962447wmj.57.1581781631981; 
 Sat, 15 Feb 2020 07:47:11 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id w26sm11766519wmi.8.2020.02.15.07.47.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2020 07:47:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] hw/sd/sd: Delay timer_new_ns() from init to realize to
 avoid memleaks
Date: Sat, 15 Feb 2020 16:47:06 +0100
Message-Id: <20200215154706.19837-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200215154706.19837-1-philmd@redhat.com>
References: <20200215154706.19837-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: XRq17jY2Oa24iK5_Tcuqnw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Pan Nengyuan <pannengyuan@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Corey Minyard <minyard@acm.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In commit f3a508eb4e the Euler Robot reported calling timer_new()
in instance_init() can leak heap memory. The easier fix is to
delay the timer creation at instance realize(). Similarly move
timer_del() into a new instance unrealize() method.

This case was found with the following coccinelle script:

    @ match @
    identifier instance_init;
    typedef Object;
    identifier obj;
    expression val, scale;
    identifier clock_type, callback, opaque;
    position pos;
    @@
    static void instance_init(Object *obj)
    {
      <...
    (
      val =3D timer_new@pos(clock_type, scale, callback, opaque);
    |
      val =3D timer_new_ns@pos(clock_type, callback, opaque);
    |
      val =3D timer_new_us@pos(clock_type, callback, opaque);
    |
      val =3D timer_new_ms@pos(clock_type, callback, opaque);
    )
      ...>
    }

    @ script:python @
    f << match.instance_init;
    p << match.pos;
    @@
    print "check %s:%s:%s in %s()" % (p[0].file, p[0].line, p[0].column, f)

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Cc: Pan Nengyuan <pannengyuan@huawei.com>
---
 hw/sd/sd.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 71a9af09ab..d72cf3de2a 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2058,14 +2058,12 @@ static void sd_instance_init(Object *obj)
     SDState *sd =3D SD_CARD(obj);
=20
     sd->enable =3D true;
-    sd->ocr_power_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, sd_ocr_poweru=
p, sd);
 }
=20
 static void sd_instance_finalize(Object *obj)
 {
     SDState *sd =3D SD_CARD(obj);
=20
-    timer_del(sd->ocr_power_timer);
     timer_free(sd->ocr_power_timer);
 }
=20
@@ -2098,6 +2096,15 @@ static void sd_realize(DeviceState *dev, Error **err=
p)
         }
         blk_set_dev_ops(sd->blk, &sd_block_ops, sd);
     }
+
+    sd->ocr_power_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, sd_ocr_poweru=
p, sd);
+}
+
+static void sd_unrealize(DeviceState *dev, Error **errp)
+{
+    SDState *sd =3D SD_CARD(dev);
+
+    timer_del(sd->ocr_power_timer);
 }
=20
 static Property sd_properties[] =3D {
@@ -2118,6 +2125,7 @@ static void sd_class_init(ObjectClass *klass, void *d=
ata)
     SDCardClass *sc =3D SD_CARD_CLASS(klass);
=20
     dc->realize =3D sd_realize;
+    dc->unrealize =3D sd_unrealize;
     device_class_set_props(dc, sd_properties);
     dc->vmsd =3D &sd_vmstate;
     dc->reset =3D sd_reset;
--=20
2.21.1


