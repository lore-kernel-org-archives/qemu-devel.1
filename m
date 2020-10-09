Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C3FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:11:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF7CD22265
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NaBUfz3x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF7CD22265
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQvvh-0001Sc-Rc
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 13:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvs6-0004eB-5G
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 13:07:58 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52591)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvs4-0001Jp-2M
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 13:07:57 -0400
Received: by mail-wm1-x344.google.com with SMTP id e23so3502183wme.2
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 10:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PVp+3SZoiBidmYUzudMKJXMJHPS5QgRn7t+s2x5BNPU=;
 b=NaBUfz3x+ZRd3OG7DSuoRY7/ptq0o+d/mIN50vFjfzN1m13XIx+3fYTaLNxJVDTLgk
 ZWyz4LbxWcP5jbI1Wbbfll44vW8Qj8UUsDSxyVbSCFcTow2pbOgRKgwJTIBa8jhdjbvo
 7dK4fV00t3E/YIGz0dSwRhU1ye80PL8xM2/QUw8yYfLa+iFtgvRaTMHr5d4WH26eMjsd
 yavscVKZsU7cC7DnNOA6RVXrJ28v+AYGeohVl1aqVrl8B5M+Lh+eY/lFBwDmKAeuRNy8
 7nMRwy7Zup66cj+Ff0wykrXItjndHQPd/EktLPD+1fhsppPcswuy18JX5fMI/WQ4p10o
 ACHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PVp+3SZoiBidmYUzudMKJXMJHPS5QgRn7t+s2x5BNPU=;
 b=AhlMk8xZHe3/A8hLE4+BD8UprkyeAuAfOn4oHfNCc/StIwfiqU3OQfqRo/HLSv7sj6
 /JtytXD0Unx5UVgmLPdtpO9qdcrQ+TcincnYyC7pZY5LumhEDGy5pQl8dSrftc1FtyTg
 Bqw47GO/pAATMvSgj3y24G/MXjeGd+IozttmuDnXY17+mHsP6O4ZGLYhXpGBepngHWBR
 1NbluxX3wVbdpwMWdFm3voJNF2bo1WW0oV0rmRns94aAYUnE1SPWYXN05QlfKLjqjzIy
 eWwRCmqQL4PdSHzFDSnB1M49S215UFn9SaawV4t9akl3esvfQ1scXFpatNDy7lLLorp0
 kpWw==
X-Gm-Message-State: AOAM533loQrpw/62BTLX+SULqDtRZ2vTf6goBfMOndHTEjUa2FaCEGV6
 qWIinihZ5JXvFXD/8H0XzMxIDg==
X-Google-Smtp-Source: ABdhPJyTtKCuSA1tJG8uzXn9hLxtvNGMhVPEKuTabr9I5CuNqdL0JxfCiaob2O8iTlniAtrfp4+M0A==
X-Received: by 2002:a1c:5988:: with SMTP id n130mr15912119wmb.95.1602263274526; 
 Fri, 09 Oct 2020 10:07:54 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x1sm5234530wrl.41.2020.10.09.10.07.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 10:07:49 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6F2EB1FF90;
 Fri,  9 Oct 2020 18:07:43 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 4/4] generic_loader: allow the insertion of /chosen/module
 stanzas
Date: Fri,  9 Oct 2020 18:07:42 +0100
Message-Id: <20201009170742.23695-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201009170742.23695-1-alex.bennee@linaro.org>
References: <20201009170742.23695-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Alistair Francis <alistair@alistair23.me>, julien@xen.org,
 masami.hiramatsu@linaro.org, andre.przywara@arm.com,
 stefano.stabellini@linaro.org, takahiro.akashi@linaro.org,
 stefano.stabellini@xilinx.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The /chosen FDT node is how the firmware indicates information about
the kernel to the loader code. In a full boot chain this would come
from something like a boot loader. However if we use the generic
loader to load blobs into RAM before launching a hypervisor for
example we can boot directly:

  $QEMU $ARGS  -kernel ~/xen.git/xen/xen \
    -append "dom0_mem=1G,max:1G loglvl=all guest_loglvl=all" \
    -device loader,addr=0x47000000,\
    file=Image,\
    len-fdt-compat=2,\
    fdt-compat[0]='multiboot,,module',\
    fdt-compat[1]='multiboot,,kernel',\
    fdt-bootargs="root=/dev/mapper/vg0-root ro console=hvc0 earlyprintk=xen"

Note the ,, escapes required for the command line parser.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/hw/core/generic-loader.h |  4 +++
 hw/core/generic-loader.c         | 42 ++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/include/hw/core/generic-loader.h b/include/hw/core/generic-loader.h
index 19d87b39c8..98b0452430 100644
--- a/include/hw/core/generic-loader.h
+++ b/include/hw/core/generic-loader.h
@@ -39,6 +39,10 @@ struct GenericLoaderState {
     bool force_raw;
     bool data_be;
     bool set_pc;
+
+    char **fdt_compat;
+    uint32_t fdt_compat_count;
+    char *fdt_bootargs;
 };
 
 #define TYPE_GENERIC_LOADER "loader"
diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index a242c076f6..8bd8a33e80 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -40,6 +40,8 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/core/generic-loader.h"
+#include "sysemu/device_tree.h"
+#include "hw/boards.h"
 
 #define CPU_NONE 0xFFFFFFFF
 
@@ -61,6 +63,39 @@ static void generic_loader_reset(void *opaque)
     }
 }
 
+/*
+ * Insert some FDT nodes for the loaded blob.
+ */
+static void loader_insert_fdt(GenericLoaderState *s, int size, Error **errp)
+{
+    MachineState *machine = MACHINE(qdev_get_machine());
+    void *fdt = machine->fdt;
+    g_autofree char *node = g_strdup_printf("/chosen/module@%#08lx", s->addr);
+    uint64_t reg_attr[2] = {cpu_to_be64(s->addr), cpu_to_be64(size)};
+
+    if (!fdt) {
+        error_setg(errp, "Cannot modify FDT fields if the machine has none");
+        return;
+    }
+
+    qemu_fdt_add_subnode(fdt, node);
+    qemu_fdt_setprop(fdt, node, "reg", &reg_attr, sizeof(reg_attr));
+
+    if (s->fdt_compat) {
+        if (qemu_fdt_setprop_string_array
+            (fdt, node, "compatible", s->fdt_compat, s->fdt_compat_count) < 0) {
+            error_setg(errp, "couldn't set %s/compatible", node);
+            return;
+        }
+    }
+
+    if (s->fdt_bootargs) {
+        if (qemu_fdt_setprop_string(fdt, node, "bootargs", s->fdt_bootargs) < 0) {
+            error_setg(errp, "couldn't set %s/bootargs", node);
+        }
+    }
+}
+
 static void generic_loader_realize(DeviceState *dev, Error **errp)
 {
     GenericLoaderState *s = GENERIC_LOADER(dev);
@@ -171,6 +206,10 @@ static void generic_loader_realize(DeviceState *dev, Error **errp)
     } else {
         s->data = cpu_to_le64(s->data);
     }
+
+    if (s->fdt_compat || s->fdt_bootargs) {
+        loader_insert_fdt(s, size, errp);
+    }
 }
 
 static void generic_loader_unrealize(DeviceState *dev)
@@ -186,6 +225,9 @@ static Property generic_loader_props[] = {
     DEFINE_PROP_UINT32("cpu-num", GenericLoaderState, cpu_num, CPU_NONE),
     DEFINE_PROP_BOOL("force-raw", GenericLoaderState, force_raw, false),
     DEFINE_PROP_STRING("file", GenericLoaderState, file),
+    DEFINE_PROP_ARRAY("fdt-compat", GenericLoaderState, fdt_compat_count,
+                      fdt_compat, qdev_prop_string, char *),
+    DEFINE_PROP_STRING("fdt-bootargs", GenericLoaderState, fdt_bootargs),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.20.1


