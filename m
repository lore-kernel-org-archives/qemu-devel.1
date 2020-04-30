Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5604CC8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:07:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1744720757
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JtVAIYRt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1744720757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7yS-0006rs-61
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 08:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jq-0003de-KD
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jo-0000U5-UZ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:22 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51181)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jU7jo-0000Tk-FJ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:20 -0400
Received: by mail-wm1-x342.google.com with SMTP id x25so1516912wmc.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 04:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=VZsHlwetQydlsAkMRlAw7EDxgaTnzCyVqrqpBTTMf/c=;
 b=JtVAIYRtFhqDdwotVAXgWuqjjVQWXK3S7kHnqDR9nNUI6oOBPSaWl17TG1FYklyeo/
 BC0zpEKuS2H4GlutoLkbBP/be4g0db1+f6amIL3jeqng/fSm1R20siIVQqYTZaH7GZ8N
 cYFIn+mDOHjygCyzPa/C2Tb9rtJHi1MQJwAtHA4r5R0Jsohs0wWatfp1kIZ4R1eom2kB
 XULSySDN/D4PhE2IyXfLUp8VQXzHipOsQtTcCIqV+ZaMwjUDe5qURU85ZgZICO83onif
 jjHcgnUUHHDJIdqE43aRjaVaMx1b5DOUgHGm6Hm0ARDNGzzdBv2VUOpU7eHZmO1mVzBk
 DT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VZsHlwetQydlsAkMRlAw7EDxgaTnzCyVqrqpBTTMf/c=;
 b=i5v0vqOM7zYHiBmObEtKlXGo+ZPVS0ubU6gUP3IXfEvlaMukxU+RUM5vAFxSFNf7BT
 OsKPCarQVwQfWIX1A2iUqMikiRa5luHYhaZTUl7j+rnii+Gch0fiLfSUlbtxJT0YSUeu
 ob0fGs1zh0THY6LkgHBNy5AEbXzdR/gK0aclV/0aEtqdgFZfiNErSRF12SmmtgezLT7U
 K4ZeP50bOnd64PaecowcSBsE2BJKk1ZDBQnIuKBIktumDk9A78ZlFZLNJcfdzQ7yAmm7
 evrRTWELqak0QROBLGW6MYLZ3wkDpa/ky3paDlWjR1P1COKuya2SIw2zXMXgIq/a/H5x
 jqAw==
X-Gm-Message-State: AGi0PuZRxlUbWi6acaMIfbF7dK3padmF4JbQTMEwHyvq/DyBcdCDiI+2
 WZTUrF3TKOFGw3JwewsFmSLKWX8RCe/TsQ==
X-Google-Smtp-Source: APiQypJIn/2iluGTKXSAEhXjRZA47Wid20MRNxvPsEa9SI/yrqdPjO1s6MjS9c2o6MSY6YmND2VA5g==
X-Received: by 2002:a7b:c0d5:: with SMTP id s21mr2569473wmh.107.1588247538758; 
 Thu, 30 Apr 2020 04:52:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j22sm491518wre.84.2020.04.30.04.52.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 04:52:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/31] hw/arm: xlnx-zcu102: Disable unsupported FDT firmware
 nodes
Date: Thu, 30 Apr 2020 12:51:42 +0100
Message-Id: <20200430115142.13430-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430115142.13430-1-peter.maydell@linaro.org>
References: <20200430115142.13430-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::342
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

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Disable unsupported FDT firmware nodes if a user passes us
a DTB with nodes enabled that the machine cannot support
due to lack of EL3 or EL2 support.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20200423121114.4274-5-edgar.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xlnx-zcu102.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 4eb117c755a..a798e228b79 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -23,6 +23,7 @@
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "sysemu/qtest.h"
+#include "sysemu/device_tree.h"
 
 typedef struct XlnxZCU102 {
     MachineState parent_obj;
@@ -68,6 +69,34 @@ static void zcu102_set_virt(Object *obj, bool value, Error **errp)
     s->virt = value;
 }
 
+static void zcu102_modify_dtb(const struct arm_boot_info *binfo, void *fdt)
+{
+    XlnxZCU102 *s = container_of(binfo, XlnxZCU102, binfo);
+    bool method_is_hvc;
+    char **node_path;
+    const char *r;
+    int prop_len;
+    int i;
+
+    /* If EL3 is enabled, we keep all firmware nodes active.  */
+    if (!s->secure) {
+        node_path = qemu_fdt_node_path(fdt, NULL, "xlnx,zynqmp-firmware",
+                                       &error_fatal);
+
+        for (i = 0; node_path && node_path[i]; i++) {
+            r = qemu_fdt_getprop(fdt, node_path[i], "method", &prop_len, NULL);
+            method_is_hvc = r && !strcmp("hvc", r);
+
+            /* Allow HVC based firmware if EL2 is enabled.  */
+            if (method_is_hvc && s->virt) {
+                continue;
+            }
+            qemu_fdt_setprop_string(fdt, node_path[i], "status", "disabled");
+        }
+        g_strfreev(node_path);
+    }
+}
+
 static void xlnx_zcu102_init(MachineState *machine)
 {
     XlnxZCU102 *s = ZCU102_MACHINE(machine);
@@ -169,6 +198,7 @@ static void xlnx_zcu102_init(MachineState *machine)
 
     s->binfo.ram_size = ram_size;
     s->binfo.loader_start = 0;
+    s->binfo.modify_dtb = zcu102_modify_dtb;
     arm_load_kernel(s->soc.boot_cpu_ptr, machine, &s->binfo);
 }
 
-- 
2.20.1


