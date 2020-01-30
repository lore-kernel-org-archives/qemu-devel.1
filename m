Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818F7C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:27:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08E1E206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R2H81Piv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E1E206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixCev-0007Ov-Vw
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:27:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43239)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCU5-0005it-Ky
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:16:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCU3-00035a-G1
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:16:01 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:46973)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixCU1-00033a-Ht
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:57 -0500
Received: by mail-wr1-x42d.google.com with SMTP id z7so4713297wrl.13
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 08:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=1jUSJvJpc6/xZHAejsMbUNB1llqeZQaXh0iGP/56VKU=;
 b=R2H81PivjVHu58X+bBtVqRCcUoVHZ6smZOVqe8POH/aK12fFD6IqC2AcVcVAyHn0yf
 pZ5j9pe4wF4gQIBJf62YwzpjpcVA3JLR25Bb5T2kgqbnwmY7p6S00x6LZFXAWCr1tMhO
 1E7M9PHI8Puwi6Cg/NcV4ldcj31KQXc5rgqKOB770rTocaG/SOHU14Cr3UcECbIE9LB6
 lIvk8YcZmmPq+kLK7yVkJeTG3pNzcA4lsWuzdE8ZehU9DH/5sDRAmWZgM4RKppOfCl7N
 AUve0H4b/Q1JRuI9LQEOD4bOn0342us9ge3DODP1U7bf61z6gtd34QGA8rsDYr8qJvTw
 Ob8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1jUSJvJpc6/xZHAejsMbUNB1llqeZQaXh0iGP/56VKU=;
 b=dgWlzuRhQXpplaFnPgPtxfuogUHiPXeyziaI+Iobq5y6B0h80/YxZrrNurx0QpK/p7
 E95w9vds2FVyzIwC5r13GzOZfOcRpPIklRBoXmOZMenwcpNzeCWxQRN0D6Hyqjee+0jR
 vPE6apaVfDjOOIzFDi2Lm4u80OSq7wqnbSrozn4NKb1hOrvAgN4T+e9k/iJwmA9lkYvg
 V45SQMfo4nP0BJkNtjXTldWi6F/Md7v8BC7aD+PjKpci3fFCQ83oD2rOfouphzWoDlgS
 hAt7fZJQmsFsnCpG6DJ0pq6jwCJlQUyDy4CKboItzExyodOUgBDxB8aT90GjC5bvoUd0
 nQtQ==
X-Gm-Message-State: APjAAAUmMd7ApfytZrJDeJ6lwVNd1MWh8BnpMG8wy6Ks3vtsAiTEG0e2
 EVm7dbmQuiZXifG/oM1RsGcb9J0/BpDO2A==
X-Google-Smtp-Source: APXvYqxiWqaZt4Icon4vOKuDW1sQ2sGobeGTwVQCXS/SFC3x60UiITfP/5xrUH4oqdLVqhrsH6IxHQ==
X-Received: by 2002:a05:6000:12ce:: with SMTP id
 l14mr6781509wrx.342.1580400954423; 
 Thu, 30 Jan 2020 08:15:54 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a22sm6994442wmd.20.2020.01.30.08.15.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 08:15:53 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/26] hw/core: deprecate old reset functions and introduce new
 ones
Date: Thu, 30 Jan 2020 16:15:23 +0000
Message-Id: <20200130161533.8180-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130161533.8180-1-peter.maydell@linaro.org>
References: <20200130161533.8180-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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

From: Damien Hedde <damien.hedde@greensocs.com>

Deprecate device_legacy_reset(), qdev_reset_all() and
qbus_reset_all() to be replaced by new functions
device_cold_reset() and bus_cold_reset() which uses resettable API.

Also introduce resettable_cold_reset_fn() which may be used as a
replacement for qdev_reset_all_fn and qbus_reset_all_fn().

Following patches will be needed to look at legacy reset call sites
and switch to resettable api. The legacy functions will be removed
when unused.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200123132823.1117486-9-damien.hedde@greensocs.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/qdev-core.h  | 27 +++++++++++++++++++++++++++
 include/hw/resettable.h |  9 +++++++++
 hw/core/bus.c           |  5 +++++
 hw/core/qdev.c          |  5 +++++
 hw/core/resettable.c    |  5 +++++
 5 files changed, 51 insertions(+)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 09b7a441eb6..1405b8a990a 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -411,6 +411,13 @@ int qdev_walk_children(DeviceState *dev,
                        qdev_walkerfn *post_devfn, qbus_walkerfn *post_busfn,
                        void *opaque);
 
+/**
+ * @qdev_reset_all:
+ * Reset @dev. See @qbus_reset_all() for more details.
+ *
+ * Note: This function is deprecated and will be removed when it becomes unused.
+ * Please use device_cold_reset() now.
+ */
 void qdev_reset_all(DeviceState *dev);
 void qdev_reset_all_fn(void *opaque);
 
@@ -423,10 +430,28 @@ void qdev_reset_all_fn(void *opaque);
  * hard reset means that qbus_reset_all will reset all state of the device.
  * For PCI devices, for example, this will include the base address registers
  * or configuration space.
+ *
+ * Note: This function is deprecated and will be removed when it becomes unused.
+ * Please use bus_cold_reset() now.
  */
 void qbus_reset_all(BusState *bus);
 void qbus_reset_all_fn(void *opaque);
 
+/**
+ * device_cold_reset:
+ * Reset device @dev and perform a recursive processing using the resettable
+ * interface. It triggers a RESET_TYPE_COLD.
+ */
+void device_cold_reset(DeviceState *dev);
+
+/**
+ * bus_cold_reset:
+ *
+ * Reset bus @bus and perform a recursive processing using the resettable
+ * interface. It triggers a RESET_TYPE_COLD.
+ */
+void bus_cold_reset(BusState *bus);
+
 /**
  * device_is_in_reset:
  * Return true if the device @dev is currently being reset.
@@ -457,6 +482,8 @@ void qdev_machine_init(void);
  * device_legacy_reset:
  *
  * Reset a single device (by calling the reset method).
+ * Note: This function is deprecated and will be removed when it becomes unused.
+ * Please use device_cold_reset() now.
  */
 void device_legacy_reset(DeviceState *dev);
 
diff --git a/include/hw/resettable.h b/include/hw/resettable.h
index 5e215d94e42..f4c4bab0eff 100644
--- a/include/hw/resettable.h
+++ b/include/hw/resettable.h
@@ -221,6 +221,15 @@ bool resettable_is_in_reset(Object *obj);
  */
 void resettable_change_parent(Object *obj, Object *newp, Object *oldp);
 
+/**
+ * resettable_cold_reset_fn:
+ * Helper to call resettable_reset((Object *) opaque, RESET_TYPE_COLD).
+ *
+ * This function is typically useful to register a reset handler with
+ * qemu_register_reset.
+ */
+void resettable_cold_reset_fn(void *opaque);
+
 /**
  * resettable_class_set_parent_phases:
  *
diff --git a/hw/core/bus.c b/hw/core/bus.c
index 2698f715bd7..3dc0a825f09 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -68,6 +68,11 @@ int qbus_walk_children(BusState *bus,
     return 0;
 }
 
+void bus_cold_reset(BusState *bus)
+{
+    resettable_reset(OBJECT(bus), RESET_TYPE_COLD);
+}
+
 bool bus_is_in_reset(BusState *bus)
 {
     return resettable_is_in_reset(OBJECT(bus));
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 7697f033b19..3937d1eb1a5 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -361,6 +361,11 @@ void qbus_reset_all_fn(void *opaque)
     qbus_reset_all(bus);
 }
 
+void device_cold_reset(DeviceState *dev)
+{
+    resettable_reset(OBJECT(dev), RESET_TYPE_COLD);
+}
+
 bool device_is_in_reset(DeviceState *dev)
 {
     return resettable_is_in_reset(OBJECT(dev));
diff --git a/hw/core/resettable.c b/hw/core/resettable.c
index 6e0b0f492f1..96a99ce39ea 100644
--- a/hw/core/resettable.c
+++ b/hw/core/resettable.c
@@ -264,6 +264,11 @@ void resettable_change_parent(Object *obj, Object *newp, Object *oldp)
     }
 }
 
+void resettable_cold_reset_fn(void *opaque)
+{
+    resettable_reset((Object *) opaque, RESET_TYPE_COLD);
+}
+
 void resettable_class_set_parent_phases(ResettableClass *rc,
                                         ResettableEnterPhase enter,
                                         ResettableHoldPhase hold,
-- 
2.20.1


