Return-Path: <SRS0=RqUc=6D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A35C38A30
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 16:28:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13D5C206D9
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 16:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g65OAbpp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D5C206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQCoM-0008Kl-9C
	for qemu-devel@archiver.kernel.org; Sun, 19 Apr 2020 12:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42292 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jQCn9-0006vQ-GH
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 12:27:35 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jQCn9-0006mw-5V
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 12:27:35 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:44652)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jQCn8-0006jH-PA; Sun, 19 Apr 2020 12:27:34 -0400
Received: by mail-lf1-x141.google.com with SMTP id 131so5833339lfh.11;
 Sun, 19 Apr 2020 09:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=amT1mUeA8CgJ+fNQXmKD+MyQ372jkNh8S+OnBAOdBHA=;
 b=g65OAbpp5q6AX75HMC7olMHDiTTdW+R5IYHA2hOfUnv1Cma7UxINjtEVgmkgPAJkQj
 Qqf0bQ55xIw5Np/oSdeo4orsPOq94VoKWxEiW3g1lctklnthIpFeq6hCOykeEbTAdNzX
 BB8aGVZqDg3+bHpEhpuXSw5HGV2QPiTYw2BssmMbejFhf1jwtMJ5X3ALlWgEs8fKNm6a
 NpUAjkGQ3lctxxpodlL8Q5oOirGZmZeqsKn5kp4SjCZSCyABlSYR4+Egc1RJSFXpbmO1
 dRYSG2UkuQKwRwwXteIclv+ygDmvqPTOWEO33eHg9KjAK+yeKKz/rHMsWuUV51YdUqcJ
 I91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=amT1mUeA8CgJ+fNQXmKD+MyQ372jkNh8S+OnBAOdBHA=;
 b=VPuImf0qqVkbBKQJBE3HNVPc4302yU9ln/aqEFKdWOkl+WFg/XvD0lZHrPQ/C+w5b+
 tM2DgW9nQCnzzAPUOcajbUnTS5zd9Vhyn4WjPmx0kDsh2uMoUolRojUVz8OVhL+Gzd8k
 LypGUJuMzUo6x8UNBogaJ52w8v0SaOutb80LG9V8DpmMnmGqCsVP3T/5D4IY8TfaC9XI
 Um0fS7/nlaZNhThfj08kPR2bUl0XPKm9nGN+rAuiIpB1CB7Qj1UdupFuxwkTI69w1V1J
 Fk3qnXpr/gVvCDgAYr0hYh5/llW1AhFgtXSslOMzu57Tiwn187+pD7amZxXKMMJ7Q8ZM
 swSQ==
X-Gm-Message-State: AGi0PuZgqd4vVZG2h83N3+Iv6qk6olRpId/9jxFCzj9cEaz58X3gGvVD
 Ixq37IaZAtSl/kxB4DqxERYdPJKz2mY=
X-Google-Smtp-Source: APiQypJN9NvhxTRvnVyxXEQVkZ024cG5jxyTzGznspLDCa/YYKRfORIGMigm1gOQHF+fMKVjlsTXOg==
X-Received: by 2002:a19:4a03:: with SMTP id x3mr7836383lfa.159.1587313652464; 
 Sun, 19 Apr 2020 09:27:32 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id v7sm4670854lfq.55.2020.04.19.09.27.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2020 09:27:31 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 3/3] hw/arm: xlnx-zcu102: Disable unsupported FDT firmware
 nodes
Date: Sun, 19 Apr 2020 18:27:27 +0200
Message-Id: <20200419162727.19148-4-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419162727.19148-1-edgar.iglesias@gmail.com>
References: <20200419162727.19148-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x141.google.com
X-detected-operating-system: by eggs1p.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 philmd@redhat.com, luc.michel@greensocs.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Disable unsupported FDT firmware nodes if a user passes us
a DTB with nodes enabled that the machine cannot support
due to lack of EL3 or EL2 support.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/arm/xlnx-zcu102.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 4eb117c755..3332630380 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -23,6 +23,7 @@
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "sysemu/qtest.h"
+#include "sysemu/device_tree.h"
 
 typedef struct XlnxZCU102 {
     MachineState parent_obj;
@@ -68,6 +69,35 @@ static void zcu102_set_virt(Object *obj, bool value, Error **errp)
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
+        node_path = qemu_fdt_node_path(fdt, NULL,
+                                       (char *)"xlnx,zynqmp-firmware",
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
@@ -169,6 +199,7 @@ static void xlnx_zcu102_init(MachineState *machine)
 
     s->binfo.ram_size = ram_size;
     s->binfo.loader_start = 0;
+    s->binfo.modify_dtb = zcu102_modify_dtb;
     arm_load_kernel(s->soc.boot_cpu_ptr, machine, &s->binfo);
 }
 
-- 
2.20.1


