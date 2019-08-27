Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5F3C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 08:26:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 894DF2184D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 08:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ZllCg2Rb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 894DF2184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2WoJ-0006Yr-Gv
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 04:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36685)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <32ehkXQYKCjAeMYQUPSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--sameid.bounces.google.com>)
 id 1i2Wmi-0004pQ-4F
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:25:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <32ehkXQYKCjAeMYQUPSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--sameid.bounces.google.com>)
 id 1i2Wmg-0007p1-TR
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:25:00 -0400
Received: from mail-qk1-x74a.google.com ([2607:f8b0:4864:20::74a]:42462)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <32ehkXQYKCjAeMYQUPSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--sameid.bounces.google.com>)
 id 1i2Wmg-0007oY-QB
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:24:58 -0400
Received: by mail-qk1-x74a.google.com with SMTP id b143so1759396qkg.9
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 01:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=AHiYmk3G3VP6+xQ4SnXZuYPSma1xOEV081sAD4q4MI0=;
 b=ZllCg2RbxXR9TfCTCXxBwylJghLBs/fqrOUInGlFuT6puckrSmNDjpAOYeCFzbGXL2
 gTlPQCODIEePYi9iczsECP88pLiAydnerIqwL1oUHYSJJsXTokLKTIJ3356M3qlRImue
 2y56ThB/Ou3M5+623fdKwbnr0evG17OlBMoJlzzCSyLEnUUr/7NcYqEQq5GExxXTwGlD
 sONueYEkgoKiuASkdVthnof8qvicd3Kpj0Rt8CUl70ZWx5U/YvGLJrfQU6G1CivB6Ea7
 5pcssY7BtqOBiNC+Jrw2qtjrf3PwCItwshiV3qHrArcoFnNHo0cyYh/2qsjz9ky7xa6L
 6icQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=AHiYmk3G3VP6+xQ4SnXZuYPSma1xOEV081sAD4q4MI0=;
 b=hYEqrsf00bY6bZbA1IL6o9RvmXaqKpNNgHBaOBpuauaiLYq7cQYfVY9dxA0SYp6lGJ
 uhmpg9hFxISW0+dlSayf/2q/jHLXS4As1S/RZi30AOH1MqLOwM2gIec4HVxPnmxVdyWf
 o6pJOKZ9cojp/IKku0uqD3I+lZKtn3qhWZ7NpQJQRcjuGYqQUv+/0B+PQcOp1uqHTsI3
 mYnUphfaXaqgJT1nI45mZHuMmqNbKMVX/HMzcLmy7F5dyJWQGjh0+H6SC8Zv0XC9oZ+M
 DtoPtbynnEEY/pk2sfDTZxbiHNgzChcs6WkMSjIa0isM2XZd5/z3PHvyw+jKbXcg2nyd
 8pQA==
X-Gm-Message-State: APjAAAXOEBKrh7VwmOlPBQ/aalTo43xwHtr6Dw1jej14c8JTibaGtK+e
 cV9CjFnmHf0qJW02MgCIuf5HKaE4RvnXxMANkBDuaq6xgrer/Tj5BankPCE+IYd86Zf07JS+y36
 u3Rr2CnrkVnDD1e6IY8O58K64FIkFlsbg/CwSwCPqpfFttOalhkBDCXwKuoJC
X-Google-Smtp-Source: APXvYqw/lGcoY5et+aEJyK9fWVS4bOPoXK/gMQDPOoxvDALF0GqY5FERAPOJPg36+xsn3NkKu/GeauDHMSw=
X-Received: by 2002:a0c:eccf:: with SMTP id o15mr18214744qvq.15.1566894297664; 
 Tue, 27 Aug 2019 01:24:57 -0700 (PDT)
Date: Tue, 27 Aug 2019 11:24:22 +0300
In-Reply-To: <20190827082427.64280-1-sameid@google.com>
Message-Id: <20190827082427.64280-4-sameid@google.com>
Mime-Version: 1.0
References: <20190827082427.64280-1-sameid@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::74a
Subject: [Qemu-devel] [PATCH v6 3/8] bootdevice: Add interface to gather LCHS
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
From: Sam Eiderman via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Sam Eiderman <sameid@google.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org,
 Arbel Moshe <arbel.moshe@oracle.com>, seabios@seabios.org, kevin@koconnor.net,
 liran.alon@oracle.com, kraxel@redhat.com,
 Sam Eiderman <shmuel.eiderman@oracle.com>, sameid@google.com,
 karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sam Eiderman <shmuel.eiderman@oracle.com>

Add an interface to provide direct logical CHS values for boot devices.
We will use this interface in the next commits.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
---
 bootdevice.c            | 55 +++++++++++++++++++++++++++++++++++++++++
 include/sysemu/sysemu.h |  3 +++
 2 files changed, 58 insertions(+)

diff --git a/bootdevice.c b/bootdevice.c
index 1d225202f9..bc5e1c2de4 100644
--- a/bootdevice.c
+++ b/bootdevice.c
@@ -343,3 +343,58 @@ void device_add_bootindex_property(Object *obj, int32_t *bootindex,
     /* initialize devices' bootindex property to -1 */
     object_property_set_int(obj, -1, name, NULL);
 }
+
+typedef struct FWLCHSEntry FWLCHSEntry;
+
+struct FWLCHSEntry {
+    QTAILQ_ENTRY(FWLCHSEntry) link;
+    DeviceState *dev;
+    char *suffix;
+    uint32_t lcyls;
+    uint32_t lheads;
+    uint32_t lsecs;
+};
+
+static QTAILQ_HEAD(, FWLCHSEntry) fw_lchs =
+    QTAILQ_HEAD_INITIALIZER(fw_lchs);
+
+void add_boot_device_lchs(DeviceState *dev, const char *suffix,
+                          uint32_t lcyls, uint32_t lheads, uint32_t lsecs)
+{
+    FWLCHSEntry *node;
+
+    if (!lcyls && !lheads && !lsecs) {
+        return;
+    }
+
+    assert(dev != NULL || suffix != NULL);
+
+    node = g_malloc0(sizeof(FWLCHSEntry));
+    node->suffix = g_strdup(suffix);
+    node->dev = dev;
+    node->lcyls = lcyls;
+    node->lheads = lheads;
+    node->lsecs = lsecs;
+
+    QTAILQ_INSERT_TAIL(&fw_lchs, node, link);
+}
+
+void del_boot_device_lchs(DeviceState *dev, const char *suffix)
+{
+    FWLCHSEntry *i;
+
+    if (dev == NULL) {
+        return;
+    }
+
+    QTAILQ_FOREACH(i, &fw_lchs, link) {
+        if ((!suffix || !g_strcmp0(i->suffix, suffix)) &&
+             i->dev == dev) {
+            QTAILQ_REMOVE(&fw_lchs, i, link);
+            g_free(i->suffix);
+            g_free(i);
+
+            break;
+        }
+    }
+}
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index d2c38f611a..1a33f25a5a 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -105,6 +105,9 @@ void device_add_bootindex_property(Object *obj, int32_t *bootindex,
                                    DeviceState *dev, Error **errp);
 void restore_boot_order(void *opaque);
 void validate_bootdevices(const char *devices, Error **errp);
+void add_boot_device_lchs(DeviceState *dev, const char *suffix,
+                          uint32_t lcyls, uint32_t lheads, uint32_t lsecs);
+void del_boot_device_lchs(DeviceState *dev, const char *suffix);
 
 /* handler to set the boot_device order for a specific type of MachineClass */
 typedef void QEMUBootSetHandler(void *opaque, const char *boot_order,
-- 
2.23.0.187.g17f5b7556c-goog


