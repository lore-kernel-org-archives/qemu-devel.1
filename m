Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85B1C33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 12:58:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92A652073A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 12:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="KPMTWVfM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A652073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iriFy-0001DP-LB
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 07:58:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49755)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1irhuk-0002NF-5p
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 07:36:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1irhui-00037t-Nz
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 07:36:50 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:53600)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1irhui-00036G-Cw; Wed, 15 Jan 2020 07:36:48 -0500
Received: from crumble.bar.greensocs.com (crumble.bar.greensocs.com
 [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPS id C228C96F57;
 Wed, 15 Jan 2020 12:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1579091807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ByZlpBg1Ioa2n8uk60WzpeK2/nY478exBwfI3pflHII=;
 b=KPMTWVfMzkcm5jcBEV6/y169evlaYcOPmJub5oX57w2r9kje6jnbHfyhafOfJMNvMDXShn
 qImQIiYDZoRh9q5BYSjLO5cQh2YX00QSF/7lW9tmKl47i1wfLW0vB7G3Jo1Mgl9ebV/yfZ
 co7ynud8EeRp3Y+vHbTlrUQFPbLbUKI=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 08/11] hw/core: deprecate old reset functions and introduce
 new ones
Date: Wed, 15 Jan 2020 13:36:17 +0100
Message-Id: <20200115123620.250132-9-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200115123620.250132-1-damien.hedde@greensocs.com>
References: <20200115123620.250132-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1579091807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ByZlpBg1Ioa2n8uk60WzpeK2/nY478exBwfI3pflHII=;
 b=GQNNq3S1QwTqmVNziEzqgPaeiMYubVkq5PpmLjs0wGKsIAfKWkkkWlwEfNU+WjvQa9nZgz
 hAJjhBCByaRl1Bf0/tErQGaJ4tSKwzdaMALs4rjvYjb9j2vhjdp5zpP0/4HWv8NGu3lnlL
 eIOSJa/Vp8jwkdc93pvkMVhrLv0KzA0=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1579091807; a=rsa-sha256; cv=none;
 b=bpARWuzcFn/F9NbmwUMimAmCzVT0NSCDcmGHtuLSM1uTLWugTLMUv5OJPwR4B9JZOkELGl
 J9S4S5RWeZwScoC5YxmnYdPufzJayHkAd4OYFxGrXyPQQEdmbRLckmVrl1umZX/o9bSYDK
 lbgwy2aeOUsfY63rqE0b7Ar3T8ACa/Y=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, peter.maydell@linaro.org,
 berrange@redhat.com, ehabkost@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>, cohuck@redhat.com,
 mark.burton@greensocs.com, qemu-s390x@nongnu.org, edgari@xilinx.com,
 pbonzini@redhat.com, philmd@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Deprecate device_legacy_reset(), qdev_reset_all() and
qbus_reset_all() to be replaced by new functions
device_cold_reset() and bus_cold_reset() which uses resettable API.

Also introduce resettable_cold_reset_fn() which may be used as a
replacement for qdev_reset_all_fn and qbus_reset_all_fn().

Following patches will be needed to look at legacy reset call sites
and switch to resettable api. The legacy functions will be removed
when unused.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/qdev-core.h  | 27 +++++++++++++++++++++++++++
 include/hw/resettable.h |  9 +++++++++
 hw/core/bus.c           |  5 +++++
 hw/core/qdev.c          |  5 +++++
 hw/core/resettable.c    |  5 +++++
 5 files changed, 51 insertions(+)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 1b4b420617..b84fcc32bf 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -406,6 +406,13 @@ int qdev_walk_children(DeviceState *dev,
                        qdev_walkerfn *post_devfn, qbus_walkerfn *post_bu=
sfn,
                        void *opaque);
=20
+/**
+ * @qdev_reset_all:
+ * Reset @dev. See @qbus_reset_all() for more details.
+ *
+ * Note: This function is deprecated and will be removed when it becomes=
 unused.
+ * Please use device_cold_reset() now.
+ */
 void qdev_reset_all(DeviceState *dev);
 void qdev_reset_all_fn(void *opaque);
=20
@@ -418,10 +425,28 @@ void qdev_reset_all_fn(void *opaque);
  * hard reset means that qbus_reset_all will reset all state of the devi=
ce.
  * For PCI devices, for example, this will include the base address regi=
sters
  * or configuration space.
+ *
+ * Note: This function is deprecated and will be removed when it becomes=
 unused.
+ * Please use bus_cold_reset() now.
  */
 void qbus_reset_all(BusState *bus);
 void qbus_reset_all_fn(void *opaque);
=20
+/**
+ * device_cold_reset:
+ * Reset device @dev and perform a recursive processing using the resett=
able
+ * interface. It triggers a RESET_TYPE_COLD.
+ */
+void device_cold_reset(DeviceState *dev);
+
+/**
+ * bus_cold_reset:
+ *
+ * Reset bus @bus and perform a recursive processing using the resettabl=
e
+ * interface. It triggers a RESET_TYPE_COLD.
+ */
+void bus_cold_reset(BusState *bus);
+
 /**
  * device_is_in_reset:
  * Return true if the device @dev is currently being reset.
@@ -452,6 +477,8 @@ void qdev_machine_init(void);
  * device_legacy_reset:
  *
  * Reset a single device (by calling the reset method).
+ * Note: This function is deprecated and will be removed when it becomes=
 unused.
+ * Please use device_cold_reset() now.
  */
 void device_legacy_reset(DeviceState *dev);
=20
diff --git a/include/hw/resettable.h b/include/hw/resettable.h
index 3f90da5b5b..0c1adf49ee 100644
--- a/include/hw/resettable.h
+++ b/include/hw/resettable.h
@@ -221,6 +221,15 @@ bool resettable_is_in_reset(Object *obj);
  */
 void resettable_change_parent(Object *obj, Object *newp, Object *oldp);
=20
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
index 2698f715bd..3dc0a825f0 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -68,6 +68,11 @@ int qbus_walk_children(BusState *bus,
     return 0;
 }
=20
+void bus_cold_reset(BusState *bus)
+{
+    resettable_reset(OBJECT(bus), RESET_TYPE_COLD);
+}
+
 bool bus_is_in_reset(BusState *bus)
 {
     return resettable_is_in_reset(OBJECT(bus));
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 5fac4cd8fc..a7a7abe569 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -361,6 +361,11 @@ void qbus_reset_all_fn(void *opaque)
     qbus_reset_all(bus);
 }
=20
+void device_cold_reset(DeviceState *dev)
+{
+    resettable_reset(OBJECT(dev), RESET_TYPE_COLD);
+}
+
 bool device_is_in_reset(DeviceState *dev)
 {
     return resettable_is_in_reset(OBJECT(dev));
diff --git a/hw/core/resettable.c b/hw/core/resettable.c
index e99bb30058..7647ef6863 100644
--- a/hw/core/resettable.c
+++ b/hw/core/resettable.c
@@ -264,6 +264,11 @@ void resettable_change_parent(Object *obj, Object *n=
ewp, Object *oldp)
     }
 }
=20
+void resettable_cold_reset_fn(void *opaque)
+{
+    resettable_reset((Object *) opaque, RESET_TYPE_COLD);
+}
+
 void resettable_class_set_parent_phases(ResettableClass *rc,
                                         ResettableEnterPhase enter,
                                         ResettableHoldPhase hold,
--=20
2.24.1


