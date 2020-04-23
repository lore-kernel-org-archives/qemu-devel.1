Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D59C54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 12:16:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EAC620736
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 12:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coGGTA8v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EAC620736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRam7-0007jR-I9
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 08:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jRahP-00026H-GO
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 08:11:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jRahP-00088o-2F
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 08:11:23 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:35435)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jRahO-00086E-Lc; Thu, 23 Apr 2020 08:11:22 -0400
Received: by mail-lj1-x244.google.com with SMTP id g4so5967445ljl.2;
 Thu, 23 Apr 2020 05:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=A4c4N6qFKw7wpuvVvkmWf+aAEVWxYv87v7CLCkKzKPw=;
 b=coGGTA8vomQ1GHf8kwtf/FbV6J6ZiV1q5bKWojrJ5BcgnO7Gi51oOgXxBAal0uH3PD
 HstP7xrryPvxD5ApfDgW8Pg90mo6ShkRdxmMJfQdX7DidEGDooeMcqjY8BqqybuZtahy
 NRwag/m6FibTPHrQ3JZvXE6Eyk14pqt9xt6Ylw81u+5Dx4Ko9pcSTMThe/YDbECMyUDE
 UY59fMdfDOBHrWPZ/0FlOruF8c4itqU5oqLQTTP5Wr5R1e+LpEQW9pBQ6oi+bsu9dVWB
 Acb5Hgne52q7Buj1TAl40AIgu1Nj8PubTHaEgM93Ck2bvVzx1UVjW1akZWnZi8qsJs4R
 RTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=A4c4N6qFKw7wpuvVvkmWf+aAEVWxYv87v7CLCkKzKPw=;
 b=sTI+55paK9IWK/SRoLsi7PfhsowjDFRQ+9Tdn7r+izbMzLjAwry2tiEtV+ZA3lnEaj
 BPOdJnFidB6ZJJBjWb/BjkvcIAcyLwE5QXBgJ6eY3aw1oSVtJ0rEnJTm1UJuTcjDNJzE
 p5lIIX2s15spH+T50eBgJ1+ZIQRvUkHDBuQlKQpO9rwhXuOzyEexFLDyK9KrohTpAJdO
 YtVS1ij0hJGU5JWanY7SlGq37N/N/kSnMax7ZMZKEgGC2PnCnF5NGrYaXh/qH5oBRmLv
 bi30tAmQRWGjEA2kI9gM+iqTQr1DWoSRV2Lp3+cRi2CMk5+ugjhFLKtygxPeaN9hFEjz
 ZSwQ==
X-Gm-Message-State: AGi0PuaQjkOr2EBVwkfn3n1EdFKy9nK3lajQIKxREAjwDsUoOg2jL78t
 TrF7BpaUkoOm4rs/2eSAH2C4BPJoz2Q=
X-Google-Smtp-Source: APiQypJR8Zzwdm+DNKe/h0gxcuPsc/UdbsR70VyDEDrbbQ8RNhYLriKyDjMQ1xy9rZoe29B7Gtx1YQ==
X-Received: by 2002:a2e:a367:: with SMTP id i7mr2261216ljn.289.1587643880634; 
 Thu, 23 Apr 2020 05:11:20 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id b9sm1830439lfp.27.2020.04.23.05.11.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 05:11:19 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/4] hw/arm: xlnx-zcu102: Disable unsupported FDT firmware
 nodes
Date: Thu, 23 Apr 2020 14:11:14 +0200
Message-Id: <20200423121114.4274-5-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200423121114.4274-1-edgar.iglesias@gmail.com>
References: <20200423121114.4274-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::244
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/arm/xlnx-zcu102.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 4eb117c755..a798e228b7 100644
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


