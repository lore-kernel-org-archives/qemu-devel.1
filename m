Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FB0C54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:28:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87ACB2077D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qppkq85u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87ACB2077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQs17-00077S-Kv
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 08:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59138)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpY-0005IM-Et
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:16:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpS-0006AL-Ei
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:16:48 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43783)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpS-00066S-0g; Tue, 21 Apr 2020 08:16:42 -0400
Received: by mail-wr1-x443.google.com with SMTP id i10so16182252wrv.10;
 Tue, 21 Apr 2020 05:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GEsba70DRlLJ93uPzs+mr1zMRSnp49U/A5f7HHRTeFE=;
 b=Qppkq85up1c6ppkmHL+8aeLnbXywhG5l6y8CyvTN9prmFjxDDl0ZPsRXOKmJ10VheF
 Dp1Aqu34xgZZ6Nsce6O0efVi8n7BKK6hb2VkVhJNuEln5naD/J/mWRpq0AaT44qvutRS
 iVEaIcEuIlSu2CxmRFH86M7NB0WlR5E8CZ/U00CS47CdUtiU0PchJ2DrgrT+UuaRIilg
 5j27UPhaXHI+RqLLhfmrCitBAkhbOI4PRT+9H4NmZMk4eTKSF9BrS87Uwu6l6mMRG09/
 Xoy6BRc6b7XYUHUct3MOmIb+SvCrKHjxfJqgNFEBDIsyoP7n7jw9cwRfTTgUXrKi3yBG
 eniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=GEsba70DRlLJ93uPzs+mr1zMRSnp49U/A5f7HHRTeFE=;
 b=RtYRdiW/AbraDnG791mrM5/8oMf59vzcgFHQEyW9ujfagajTEdQWMwC6IWadxTiagp
 2TESPTQXlZJ2SJZZNFUf0cK78n40q2i/YCA4ixx95VTO6pGdtfCREMJTe632nfrjwoQy
 HIZKFO8nmfXVR8inBaxGYus4bfvCX3FzpU9Y9TWciPqWnMdRdyjr+goymAdB5tkhXEYQ
 xozb7QbgX2Er/GiBUJl4Vb8JtqpzO+m61qedydP+ggK/H4AwfgAjhgQ5tGOGptC2MUKC
 3F0uyZmGELeS7gytOKBZacmjeikIDEGffPa0QncAo75WkaHZ3ENzHqfRg3gt3y1U1wKI
 RDVw==
X-Gm-Message-State: AGi0PuZqaBaSJ9qvQE3E7Hn6JnwBcrGppu0Ysz2Oekuw/Q8d4q6e5d3Y
 LLQtgC8b3+X+quUr7qmhmTMxyMQijHg=
X-Google-Smtp-Source: APiQypIANLtaugy4ubDmmu/0fKbEMp7mjg8JTblbgspQ1KDa9YXiv5SdTg8BGFZ0gOxQWPQzMRjUJA==
X-Received: by 2002:adf:f986:: with SMTP id f6mr23636914wrr.221.1587471398577; 
 Tue, 21 Apr 2020 05:16:38 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id z76sm3761140wmc.9.2020.04.21.05.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 05:16:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 05/17] hw/misc/tmp105: Implement the 'temperature-sensor'
 qdev interface
Date: Tue, 21 Apr 2020 14:16:14 +0200
Message-Id: <20200421121626.23791-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200421121626.23791-1-f4bug@amsat.org>
References: <20200421121626.23791-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::443
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

The TMP105 is an I2C temperature sensor.
Let it implement the 'temperature-sensor' interface.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/tmp105.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/misc/tmp105.c b/hw/misc/tmp105.c
index 754c8a6eb4..1f0cb28012 100644
--- a/hw/misc/tmp105.c
+++ b/hw/misc/tmp105.c
@@ -26,6 +26,7 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "qemu/module.h"
+#include "hw/misc/temp-sensor.h"
 
 static void tmp105_interrupt_update(TMP105State *s)
 {
@@ -74,6 +75,17 @@ static void set_temp_mC(TMP105State *s, int64_t temp_mC, Error **errp)
     tmp105_alarm_update(s);
 }
 
+static float tmp105_get_temp(TempSensor *obj, unsigned sensor_id)
+{
+    return get_temp_mC(TMP105(obj)) / 1000.f;
+}
+
+static void tmp105_set_temp(TempSensor *obj, unsigned sensor_id,
+                            float temp_C, Error **errp)
+{
+    set_temp_mC(TMP105(obj), temp_C * 1000.f, errp);
+}
+
 static void tmp105_get_temperature(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
@@ -261,12 +273,16 @@ static void tmp105_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
+    TempSensorClass *tc = TEMPSENSOR_INTERFACE_CLASS(klass);
 
     dc->realize = tmp105_realize;
     k->event = tmp105_event;
     k->recv = tmp105_rx;
     k->send = tmp105_tx;
     dc->vmsd = &vmstate_tmp105;
+    tc->sensor_count = 1;
+    tc->set_temperature = tmp105_set_temp;
+    tc->get_temperature = tmp105_get_temp;
 }
 
 static const TypeInfo tmp105_info = {
@@ -275,6 +291,10 @@ static const TypeInfo tmp105_info = {
     .instance_size = sizeof(TMP105State),
     .instance_init = tmp105_initfn,
     .class_init    = tmp105_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TEMPSENSOR_INTERFACE },
+        { }
+    },
 };
 
 static void tmp105_register_types(void)
-- 
2.21.1


