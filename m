Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB30C54FD0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:20:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 660612075E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAp23JYa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660612075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQrtN-0002Wg-Fc
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 08:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpO-0004vG-9R
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:16:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpN-00065F-S1
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:16:38 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45001)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpN-00061L-Ez; Tue, 21 Apr 2020 08:16:37 -0400
Received: by mail-wr1-x441.google.com with SMTP id d17so16173787wrg.11;
 Tue, 21 Apr 2020 05:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5z6HGxXR+98mfge1lDQbmcUEQ1irNfVSb4DhyuqpZaU=;
 b=bAp23JYaCjwPAvB20SfhIgBDbx6C2LP1jcIxFZdesmm5CNqtQjmvrxKPNqqP7BJbIG
 xc8ea4Am7UtCPSX8zEeL9qz8j/Mwasv20Iz3jiCxr/e1Ty+r8Cy1fz7gjmtwv51xJH8d
 k99YHg+ts04ei7hyzs9s4yMUN7b4ya4D9re0hGHYu/gu+jfE1K7jV5KwLtJjdRCg/8R6
 rRtpjSaUf7FZO3GyNDpjfhCA2EUcCRqRbhNk1H/zbX6bqdnIW1uNGPouypS/McB0BG4Y
 e9eIqk6ik7kW6Zu9b3dsWvWIbt0PWlzrEruFYwosWl9LqFnp4Smu4mVrbxNPlslRMbD3
 W2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=5z6HGxXR+98mfge1lDQbmcUEQ1irNfVSb4DhyuqpZaU=;
 b=dSZ/iJ9FHct6hDNvwTNAF7PE4bT17IecMwnq9i1EWuwXODrC+Kcjmlkyh7xBZlpvji
 dMtf5rw/cAoNTmXvaivdzjFS4//OWB/ncPsfrjEdkCn4P6rvEdioxf/zbBr5ajXTriYb
 WIfX9FuNi+zanEysO0woMFpw9BfyaI3Mtop5TSKG48tSSHGU7osvzGEezuVXhXp7xH5C
 s3fy1+nXdXasd5XWlhk/4OOPlHjBqesCgmkKLM+JYRl2oC9eZLYL7v9wMKT35DCo9LqF
 eCqNOb/KXpU5frCA/iRQEsv2nKFfx7XwhVe2QDvt3c/Yxml8ktIKKcGgPTMZ73Paq7kd
 6Fhw==
X-Gm-Message-State: AGi0PuZLBJa/MH2b9P2FmIDecKj6jWuzPcvXxPdNshqA1WecudLdzKG5
 KAuCurk6zD6tH8XbKFeai/1ksKErPVA=
X-Google-Smtp-Source: APiQypI4s/Kkq1rMeyVksOLK2llygXFyIhCp/kfFEg8wtT6F/ttM/xv5ay28NezwrJ+0zwl9mdAlhQ==
X-Received: by 2002:adf:eecc:: with SMTP id a12mr23369459wrp.112.1587471394924; 
 Tue, 21 Apr 2020 05:16:34 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id z76sm3761140wmc.9.2020.04.21.05.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 05:16:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 03/17] hw/misc/temp-sensor: Add 'info temp' HMP command
Date: Tue, 21 Apr 2020 14:16:12 +0200
Message-Id: <20200421121626.23791-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200421121626.23791-1-f4bug@amsat.org>
References: <20200421121626.23791-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::441
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

Add a command to display current devices temperature in the monitor:

  (qemu) info temp
  Temperatures (in C):
  videocore                          25.00
  bcm2835-thermal-0                  25.00

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/monitor/hmp.h |  1 +
 hw/misc/temp-sensor.c | 29 +++++++++++++++++++++++++++++
 hmp-commands-info.hx  | 11 +++++++++++
 3 files changed, 41 insertions(+)

diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index e33ca5a911..f023230bd1 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -129,5 +129,6 @@ void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
 void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
 void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
 void hmp_info_sev(Monitor *mon, const QDict *qdict);
+void hmp_info_temp(Monitor *mon, const QDict *qdict);
 
 #endif
diff --git a/hw/misc/temp-sensor.c b/hw/misc/temp-sensor.c
index 27750c533d..5f591bd9c3 100644
--- a/hw/misc/temp-sensor.c
+++ b/hw/misc/temp-sensor.c
@@ -12,6 +12,8 @@
 #include "hw/misc/temp-sensor.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/error.h"
+#include "monitor/monitor.h"
+#include "monitor/hmp.h"
 
 static int query_temperature_sensors_foreach(Object *obj, void *opaque)
 {
@@ -59,6 +61,33 @@ TemperatureSensorList *qmp_query_temperature_sensors(Error **errp)
     return list;
 }
 
+void hmp_info_temp(Monitor *mon, const QDict *qdict)
+{
+    TemperatureSensorList *list, *sensor;
+    Error *err = NULL;
+
+    list = qmp_query_temperature_sensors(&err);
+    if (!list) {
+        monitor_printf(mon, "No temperature sensors\n");
+        return;
+    }
+    if (err) {
+        monitor_printf(mon, "Error while getting temperatures: %s\n",
+                       error_get_pretty(err));
+        error_free(err);
+        goto out;
+    }
+
+    monitor_printf(mon, "Temperatures (in C):\n");
+    for (sensor = list; sensor; sensor = sensor->next) {
+        monitor_printf(mon, "%-33s %6.2f\n", sensor->value->name,
+                       sensor->value->temperature);
+    }
+
+out:
+    qapi_free_TemperatureSensorList(list);
+}
+
 static TypeInfo tempsensor_interface_type_info = {
     .name = TYPE_TEMPSENSOR_INTERFACE,
     .parent = TYPE_INTERFACE,
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index ca5198438d..77f1c43ce3 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -880,4 +880,15 @@ SRST
     Show SEV information.
 ERST
 
+    {
+        .name       = "temp",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show device temperatures",
+        .cmd        = hmp_info_temp,
+    },
 
+SRST
+  ``info temp``
+    Show device temperatures.
+ERST
-- 
2.21.1


