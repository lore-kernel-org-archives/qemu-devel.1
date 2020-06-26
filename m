Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1140CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:19:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0F8420702
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sZg3zG2E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0F8420702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joq8l-0001OD-3z
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq3z-00025r-Kb
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:47 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:34914)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq3q-0006G7-Lg
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:47 -0400
Received: by mail-wm1-x332.google.com with SMTP id l2so8225944wmf.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Q8Ef3HWA8rNM9aTbA2EQAMf+hEg1mxxGyImAVLJmAIk=;
 b=sZg3zG2ErKaNOpVPZrMhqJcUjKJC77ZU+jmPSW2KgjOQ4tOEnJiT2Zu5jnQ+SIjjW7
 H2JFwjL2MiAKYKjDHw/gMuB96cmNceiWZGZ3co6eNvyocEDXmIUheXwvbMnpry9fkDZc
 dYQrJsJSNjoGQR7diwv1p1/EjzI2mVFfM7PzajphkljC8tqRII6gw6dT4YB0TpsbeV7s
 AmU92bfkBF0OOw7GIi4w9Qb6V5xLhgDgPYZKLQHUIOoKr0g6NvOrVgBu6DaW9onGGvQ4
 hZGVT1yXmNQqVNAHSz/DUz7Ky3ZN3l2LbnrYPJhcSmZaz951elvakB0ckgBNFcJDV5l9
 NyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Q8Ef3HWA8rNM9aTbA2EQAMf+hEg1mxxGyImAVLJmAIk=;
 b=PxFx8+t6V+lANn9EI9YByLsXPQUyDhWFSWK+n47m2EFO53F+Ax1weE6TcSf009VaJl
 31yd7iS+sHLQnHGV9NmhBd+LS3VLlY688wmNfI2a0yvBh5Hd40NDwEO/0Xnto5iT3bPP
 4XrIGkY0cvGsWHC9zTclkUehnVLMGNH/XvbId+JmUnPO3UqUwaqhllGuhwDypSGwb4kR
 9Hmi/hv9oy51ijgdrD+kfEkF87A1Abq+H3QvCM+aYHd3BkbJgHrJWDlxJzKv/M8Lxyhg
 9i70jG3vqlD4mWxvvjIoAFA4auGgs3s5LEFlACY3jCKdswwanww5+KCoyjsuXTUMVGH3
 FZVQ==
X-Gm-Message-State: AOAM530YS2yCnuIn9VxIQS5/TD8xFDJtYNMR+e1HQS4uBKR+Ou9BqqCX
 lKVhGcq19fFbyyTcL1lmOVL68ntteTUX0Q==
X-Google-Smtp-Source: ABdhPJwRYMVOauEYyWDMd6dL1z0UwW/sprD3rPfVgbjzawwk/whZ6CliGGJWD6V6RadziUekliIc2w==
X-Received: by 2002:a1c:e143:: with SMTP id y64mr3910481wmg.90.1593184475946; 
 Fri, 26 Jun 2020 08:14:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w13sm37838852wrr.67.2020.06.26.08.14.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 08:14:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/57] hw/misc/pca9552: Add a 'description' property for
 debugging purpose
Date: Fri, 26 Jun 2020 16:13:35 +0100
Message-Id: <20200626151424.30117-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626151424.30117-1-peter.maydell@linaro.org>
References: <20200626151424.30117-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Add a description field to distinguish between multiple devices.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20200623072723.6324-6-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/pca9552.h |  1 +
 hw/misc/pca9552.c         | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/hw/misc/pca9552.h b/include/hw/misc/pca9552.h
index 90843b03b8a..bf1a5891378 100644
--- a/include/hw/misc/pca9552.h
+++ b/include/hw/misc/pca9552.h
@@ -27,6 +27,7 @@ typedef struct PCA955xState {
     uint8_t pointer;
 
     uint8_t regs[PCA955X_NR_REGS];
+    char *description; /* For debugging purpose only */
 } PCA955xState;
 
 #endif
diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index 4de57dbe2e2..2cc52b02057 100644
--- a/hw/misc/pca9552.c
+++ b/hw/misc/pca9552.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "hw/qdev-properties.h"
 #include "hw/misc/pca9552.h"
 #include "hw/misc/pca9552_regs.h"
 #include "migration/vmstate.h"
@@ -317,13 +318,30 @@ static void pca955x_initfn(Object *obj)
     }
 }
 
+static void pca955x_realize(DeviceState *dev, Error **errp)
+{
+    PCA955xState *s = PCA955X(dev);
+
+    if (!s->description) {
+        s->description = g_strdup("pca-unspecified");
+    }
+}
+
+static Property pca955x_properties[] = {
+    DEFINE_PROP_STRING("description", PCA955xState, description),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void pca955x_class_init(ObjectClass *klass, void *data)
 {
+    DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
 
     k->event = pca955x_event;
     k->recv = pca955x_recv;
     k->send = pca955x_send;
+    dc->realize = pca955x_realize;
+    device_class_set_props(dc, pca955x_properties);
 }
 
 static const TypeInfo pca955x_info = {
-- 
2.20.1


