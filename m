Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D50C54FD0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:27:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C7F72075E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cld4TGjX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C7F72075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQrzg-0004gE-Sv
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 08:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59342)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpm-0005ho-EC
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:17:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpk-0006uH-Qe
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:17:01 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39043)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpi-0006dA-SF; Tue, 21 Apr 2020 08:16:59 -0400
Received: by mail-wm1-x343.google.com with SMTP id y24so3411611wma.4;
 Tue, 21 Apr 2020 05:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6IZGXEDwfoPtCg1GsMDYigPQKwJxDM34TttvkoqeAQE=;
 b=cld4TGjXlImqH0i0Lx9y7Jn/yVaEqLd0qkfCoCKNfcIqctdkFSoFFTgxOLZY3AffYE
 FM0xjenwG0+N2/SINbmuvXhTOZ5hgHiS3GCsDLDCSCs5rUtDDVUNzrFbvSZDdvAoFZkJ
 s5VlXJwhMC9Zp8/Gc3IZx3lmB07cvvxXqgnjRd+aIEeXPU/mmsgh4KD8JWi3MN1n/dEg
 aLYTAId3WRlgFST9uUntla4IdEFECOezHme9rdd346di9T+O2W5fOMPdEoNe68xFN1qn
 MCngY4a0nPnfTcGXcmms+7RMTlwyJArgcc8I5KWTZMJi1Gk7qpT+plwkrgQyJyo/lCso
 TVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=6IZGXEDwfoPtCg1GsMDYigPQKwJxDM34TttvkoqeAQE=;
 b=kNYFgg49V+SwKvM5GKgDgMJtF/5zZvZakvvD7OGX+sNNmB6j4JMvPifnnrp9eMiAg/
 tx5rlx+baSJTbxyElZu0HQr98Ii/7Tfx0GmNxUZaaHZ3w2tN2I91LXGaF5fwfVPquq9A
 QAJiSkO4Ye0SaBCYMV4fil8KrqT53s1O3GWDiSeYBh15QUWMGojJ2SfzPpNPa4AjJiJi
 rwYOmpXcfZg9hEWfMYvlEZ8tIFti4rlcCfZcoEq9iPyAzksVfNvz2ZLxLMldsSF4dEVu
 /Y2xlMe5X3ndihXQFyyFxu1vMmAVYH6RK+YxtpZfRaaZUICC81YUAM1Rvp5Ffmkm6NNT
 X3xQ==
X-Gm-Message-State: AGi0PuZYhHwD4vG7byIli6vmqmfMSsk+opkGYatm34GFqGA3FZhzvW5j
 lqpX+uroa3TdKyZ4zwxsD9Rwf5kDynA=
X-Google-Smtp-Source: APiQypKkBl6/Wv7/xjSPwC6+whbKMyjIMWK75D5sxM+69/jcpVqMC5dEkTNbIVRKSahKpmd3K+c8BQ==
X-Received: by 2002:a05:600c:2c04:: with SMTP id
 q4mr4410317wmg.7.1587471414039; 
 Tue, 21 Apr 2020 05:16:54 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id z76sm3761140wmc.9.2020.04.21.05.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 05:16:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 13/17] hw/misc/bcm2835_property: Implement the
 'temperature-sensor' interface
Date: Tue, 21 Apr 2020 14:16:22 +0200
Message-Id: <20200421121626.23791-14-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200421121626.23791-1-f4bug@amsat.org>
References: <20200421121626.23791-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, John Snow <jsnow@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The BCM2835 'property' QEMU device models the serialized responses
from the VideoCore firmware. As we can query the VC for its current
temperatyre, let this model implement the 'temperature-sensor'
interface.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/bcm2835_property.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index bbe80affd4..dd1e9a2e03 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -12,6 +12,7 @@
 #include "migration/vmstate.h"
 #include "hw/irq.h"
 #include "hw/misc/bcm2835_mbox_defs.h"
+#include "hw/misc/temp-sensor.h"
 #include "sysemu/dma.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
@@ -372,6 +373,27 @@ static const VMStateDescription vmstate_bcm2835_property = {
     }
 };
 
+static const char *bcm2835_property_get_temp_sensor_name(TempSensor *obj,
+                                                         unsigned sensor_id)
+{
+    return "videocore";
+}
+
+static float bcm2835_property_get_temp(TempSensor *obj, unsigned sensor_id)
+{
+    BCM2835PropertyState *s = BCM2835_PROPERTY(obj);
+
+    return s->temp_mC / 1000;
+}
+
+static void bcm2835_property_set_temp(TempSensor *obj, unsigned sensor_id,
+                                      float temp_C, Error **errp)
+{
+    BCM2835PropertyState *s = BCM2835_PROPERTY(obj);
+
+    s->temp_mC = temp_C * 1000;
+}
+
 static void bcm2835_property_init(Object *obj)
 {
     BCM2835PropertyState *s = BCM2835_PROPERTY(obj);
@@ -429,10 +451,15 @@ static Property bcm2835_property_props[] = {
 static void bcm2835_property_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    TempSensorClass *tc = TEMPSENSOR_INTERFACE_CLASS(klass);
 
     device_class_set_props(dc, bcm2835_property_props);
     dc->realize = bcm2835_property_realize;
     dc->vmsd = &vmstate_bcm2835_property;
+    tc->sensor_count = 1;
+    tc->get_name = bcm2835_property_get_temp_sensor_name;
+    tc->set_temperature = bcm2835_property_set_temp;
+    tc->get_temperature = bcm2835_property_get_temp;
 }
 
 static TypeInfo bcm2835_property_info = {
@@ -441,6 +468,10 @@ static TypeInfo bcm2835_property_info = {
     .instance_size = sizeof(BCM2835PropertyState),
     .class_init    = bcm2835_property_class_init,
     .instance_init = bcm2835_property_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TEMPSENSOR_INTERFACE },
+        { }
+    },
 };
 
 static void bcm2835_property_register_types(void)
-- 
2.21.1


