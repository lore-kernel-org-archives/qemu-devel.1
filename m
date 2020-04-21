Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E860C54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:18:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E2C32064C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kq9/xM/K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E2C32064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQrqp-00070w-9j
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 08:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpM-0004ul-LS
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:16:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpM-00061h-12
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:16:36 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41505)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpL-0005xi-IO; Tue, 21 Apr 2020 08:16:35 -0400
Received: by mail-wr1-x443.google.com with SMTP id g13so14174001wrb.8;
 Tue, 21 Apr 2020 05:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pxZXRr/t+7MI95fs3rvnz7JJgfY9Pqjebw0FQlRcGhQ=;
 b=Kq9/xM/KdnHhh/5l7k/q4Kgxpj9smFhRnSyIAIpFH5FmbrklQeyZSNMkaBW288RDcL
 U+esiByhvgylUDSTCpApvY8au8YMbHb91j5s1ods4QhZClq7fnvcUewjMJMn4WOiAugV
 t9BiHC/0WT3AMSOwD0Mnvkem6LjJ4XIYvbIQiX4NGOPd9u5QB8iqhnNTni00w2fe39vZ
 mEpgiVSQWQJCaVkRME78sqz+UWmyvx0k8+lLVf+VjInPBAyyVPOhdiVlZcosteP/tvza
 QCUsArSEV3zAMsQNtmuYh+F4np7dTsdAldgS+O8YDkANjt4psIkjrBHslyOMkNOKM1va
 2E/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=pxZXRr/t+7MI95fs3rvnz7JJgfY9Pqjebw0FQlRcGhQ=;
 b=VjY6Oipc3YIGA652vfoF6m5R9KCr25Y35Cmy6wescHp4p3+tz7s6U9uXC2+/HnrFvG
 cHVpL6jm9aoE48hXNtRGleWWPBc43wp/QicgXnMiPORYqkRzSAikZYXSjXrnSApzndLi
 5x6RVex+xYmG0M89YJshz+RF6mb9pzoapXQe8XqJ2efoB37WP+Uh+/G2PztEyUNhNvYy
 s/5dVeI+Q2CP9EH1l48rM2inaMn2umH6HQYVcp6MpjXeg3ds4juRXcCIBzHYaDQlirqj
 KSOh4Qz6O3ld75+8UpfQSxAPUrLE/Ss9IM7Q3TyoMaxnlwx39xD1KTbj76hgMuSL+bWm
 rMHA==
X-Gm-Message-State: AGi0Pua+eokTui8UjQePbFAUS9t3vux4upcyCGm8sIKSnwoMlCTQL5/u
 P0WhMLs7BQCwBI5IDbi5P6sLbK1Rg4U=
X-Google-Smtp-Source: APiQypJPTU+ujufDQvfXppous//hnvsbKH//+MP3cDatjnRx8MpSFSCUuYPuLjiejiKiGIAtL935Gw==
X-Received: by 2002:adf:f844:: with SMTP id d4mr23343754wrq.362.1587471392926; 
 Tue, 21 Apr 2020 05:16:32 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id z76sm3761140wmc.9.2020.04.21.05.16.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 05:16:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 02/17] hw/misc/temp-sensor: Add
 'query-temperature-sensors' QMP command
Date: Tue, 21 Apr 2020 14:16:11 +0200
Message-Id: <20200421121626.23791-3-f4bug@amsat.org>
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

Add a command to query current temperature from all sensors able
to report it:

  { "execute": "query-temperature-sensors" }
  {
      "return": [
          {
              "temperature": 25,
              "name": "videocore"
          },
          {
              "temperature": 25,
              "name": "bcm2835-thermal-0"
          }
      ]
  }

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 qapi/misc.json        | 24 ++++++++++++++++++++++
 hw/misc/temp-sensor.c | 48 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/qapi/misc.json b/qapi/misc.json
index 99b90ac80b..51881931e2 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1550,3 +1550,27 @@
 ##
 { 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
 
+##
+# @TemperatureSensor:
+#
+# Temperature sensor information.
+#
+# @name: the name of the sensor
+#
+# @temperature: the current temperature of the sensor (in C)
+#
+# Since: 5.1
+##
+{ 'struct': 'TemperatureSensor',
+  'data': { 'name': 'str',
+            'temperature': 'number' } }
+
+##
+# @query-temperature-sensors:
+#
+# Return a list of TemperatureSensor for devices that support
+# the TYPE_TEMPSENSOR_INTERFACE.
+#
+# Since: 5.1
+##
+{ 'command': 'query-temperature-sensors', 'returns': ['TemperatureSensor']}
diff --git a/hw/misc/temp-sensor.c b/hw/misc/temp-sensor.c
index b7c1eb2d87..27750c533d 100644
--- a/hw/misc/temp-sensor.c
+++ b/hw/misc/temp-sensor.c
@@ -10,6 +10,54 @@
 
 #include "qemu/osdep.h"
 #include "hw/misc/temp-sensor.h"
+#include "qapi/qapi-commands-misc.h"
+#include "qapi/error.h"
+
+static int query_temperature_sensors_foreach(Object *obj, void *opaque)
+{
+    TemperatureSensorList **list = opaque;
+    TempSensor *sensor;
+    TempSensorClass *k;
+
+    if (!object_dynamic_cast(obj, TYPE_TEMPSENSOR_INTERFACE)) {
+        return 0;
+    }
+
+    k = TEMPSENSOR_INTERFACE_GET_CLASS(obj);
+    if (!k->get_temperature) {
+        return 0;
+    }
+
+    sensor = TEMPSENSOR_INTERFACE(obj);
+    for (size_t i = 0; i < k->sensor_count; i++) {
+        TemperatureSensorList *info = g_malloc0(sizeof(*info));
+        TemperatureSensor *value = g_malloc0(sizeof(*value));
+
+        if (k->get_name) {
+            value->name = g_strdup(k->get_name(sensor, i));
+        } else {
+            value->name = g_strdup_printf("%s-%zu",
+                                          object_get_typename(obj), i);
+        }
+        value->temperature = k->get_temperature(sensor, i);
+
+        info->value = value;
+        info->next = *list;
+        *list = info;
+    }
+
+    return 0;
+}
+
+TemperatureSensorList *qmp_query_temperature_sensors(Error **errp)
+{
+    TemperatureSensorList *list = NULL;
+
+    object_child_foreach_recursive(object_get_root(),
+                                   query_temperature_sensors_foreach,
+                                   &list);
+    return list;
+}
 
 static TypeInfo tempsensor_interface_type_info = {
     .name = TYPE_TEMPSENSOR_INTERFACE,
-- 
2.21.1


