Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D721DC54FCC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 19:20:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E6B320656
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 19:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SOb6vy7j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E6B320656
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQyRv-0001F0-HS
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 15:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52132)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1jQyQj-0007vq-BH
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 15:19:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1jQyQi-0007mf-MK
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 15:19:37 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41021)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <palmerdabbelt@google.com>)
 id 1jQyQi-0007lt-9f
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 15:19:36 -0400
Received: by mail-pf1-x441.google.com with SMTP id b8so7041064pfp.8
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 12:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=J18hrsuxLmsCXXOrk6dxkfjT6yK/2TCdOo0otnuZFwo=;
 b=SOb6vy7jD+6hYjXUQqfSx8XeXQx38unn+uuxgVMkImPseS54ll88fyF9psRdiKCy4D
 rCFCPj5m/vZzw8zLccO57PyQSTuu0s2Cr6UFQRYdMjlAuV8QnQCXssADkW/4kVj8eNoV
 eig03ISZgRy/LMv0eb8Oev4voVoVIZgarE+mgXqDGFjbgeI+bG5LFRmGjX9YBASsOPkS
 kdK1It83tUp19NY7EeM0HBuS4FymiWamo6pbu2+DnwdZr1i3oyrl61f2WBnG/YDAPmUo
 6P09GFkdoWHwI03VY84xqsPUllOeEfxvrfp3XJSb/ZWJ3wNqZzWr3cT2fQB5wT48DfLc
 wkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=J18hrsuxLmsCXXOrk6dxkfjT6yK/2TCdOo0otnuZFwo=;
 b=j64rRHtX//B3ta7me6AD6TEJy1kOxwV7CkHnhT3HerfAIW5yv0vOJYNqg4Ug9KA9Kv
 Z9GslOx/UWE3c423gwxqIPVPefKL73ezKzGA/ng8P72s/F/v48d0IFGHoAIDXznKuMiX
 uP268gNVJ3HOtZC2YIDSoyn1KxVjmGisXF9/zAma3vNy/qpONVLZSrjnz1vs9V7Tj3I6
 wvIu91CzDrtY8iT6vigsgDLBxC6Oj3RkG5oZEAdMFs/+Mv/9OWKXRCt6DZOoVXp5IYnB
 3/caQ/d9GZjHi2JmGNU/Uqy4h4IBXJXX+YJZDhrAVm8M1//xaTt20n6vdKpxawO313EL
 oHUQ==
X-Gm-Message-State: AGi0PuZxAIOIJuV3aBTnSEowHuPUIgRMcGK8QQgOf8O9YM3qFjGBs0gz
 tRoy7ALayiPyFjmyuh+gZCahsg==
X-Google-Smtp-Source: APiQypJxkkLvXrt96+FhIfK0RUUlmrsD1hpL9sUDTNr4iwbieYWFxkxbP9GU923uJCkahCvgU+xdJg==
X-Received: by 2002:aa7:9e49:: with SMTP id z9mr22812291pfq.225.1587496774828; 
 Tue, 21 Apr 2020 12:19:34 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net.
 [76.210.143.223])
 by smtp.gmail.com with ESMTPSA id p68sm3101993pfb.89.2020.04.21.12.19.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 12:19:34 -0700 (PDT)
Subject: [PULL 6/6] riscv/sifive_u: Add a serial property to the sifive_u
 machine
Date: Tue, 21 Apr 2020 12:10:01 -0700
Message-Id: <20200421191001.92644-7-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
In-Reply-To: <20200421191001.92644-1-palmerdabbelt@google.com>
References: <20200421191001.92644-1-palmerdabbelt@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: qemu-riscv@nongnu.org,          qemu-devel@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, Palmer Dabbelt <palmerdabbelt@google.com>,
 Alistair Francis <alistair.francis@wdc.com>
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=palmerdabbelt@google.com; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::441
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bmeng.cn@gmail.com>

At present the board serial number is hard-coded to 1, and passed
to OTP model during initialization. Firmware (FSBL, U-Boot) uses
the serial number to generate a unique MAC address for the on-chip
ethernet controller. When multiple QEMU 'sifive_u' instances are
created and connected to the same subnet, they all have the same
MAC address hence it creates a unusable network.

A new "serial" property is introduced to specify the board serial
number. When not given, the default serial number 1 is used.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <1573916930-19068-1-git-send-email-bmeng.cn@gmail.com>
[ Changed by AF:
 - Use the SoC's serial property to pass the info to the SoC
 - Fixup commit title
 - Rebase on file restructuring
]
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 hw/riscv/sifive_u.c         | 20 ++++++++++++++++++++
 include/hw/riscv/sifive_u.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 9bfd16d2bb..eb0abcae89 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -34,6 +34,7 @@
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qapi/visitor.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "hw/sysbus.h"
@@ -326,6 +327,8 @@ static void sifive_u_machine_init(MachineState *machine)
     object_initialize_child(OBJECT(machine), "soc", &s->soc,
                             sizeof(s->soc), TYPE_RISCV_U_SOC,
                             &error_abort, NULL);
+    object_property_set_uint(OBJECT(&s->soc), s->serial, "serial",
+                            &error_abort);
     object_property_set_bool(OBJECT(&s->soc), true, "realized",
                             &error_abort);
 
@@ -417,6 +420,18 @@ static void sifive_u_machine_set_start_in_flash(Object *obj, bool value, Error *
     s->start_in_flash = value;
 }
 
+static void sifive_u_machine_get_serial(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    visit_type_uint32(v, name, (uint32_t *)opaque, errp);
+}
+
+static void sifive_u_machine_set_serial(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    visit_type_uint32(v, name, (uint32_t *)opaque, errp);
+}
+
 static void sifive_u_machine_instance_init(Object *obj)
 {
     SiFiveUState *s = RISCV_U_MACHINE(obj);
@@ -428,6 +443,11 @@ static void sifive_u_machine_instance_init(Object *obj)
                                     "Set on to tell QEMU's ROM to jump to " \
                                     "flash. Otherwise QEMU will jump to DRAM",
                                     NULL);
+
+    s->serial = OTP_SERIAL;
+    object_property_add(obj, "serial", "uint32", sifive_u_machine_get_serial,
+                        sifive_u_machine_set_serial, NULL, &s->serial, NULL);
+    object_property_set_description(obj, "serial", "Board serial number", NULL);
 }
 
 
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index a2baa1de5f..16c297ec5f 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -61,6 +61,7 @@ typedef struct SiFiveUState {
     int fdt_size;
 
     bool start_in_flash;
+    uint32_t serial;
 } SiFiveUState;
 
 enum {
-- 
2.26.1.301.g55bc3eb7cb9-goog


