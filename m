Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5642DC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:03:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5D1824679
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="K+akQlB3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D1824679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiH0U-0003gp-Og
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 07:03:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1iiGo0-00027v-P1
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 06:50:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1iiGny-0006WO-RK
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 06:50:52 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:45252)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1iiGnx-0006SU-Pd; Fri, 20 Dec 2019 06:50:50 -0500
Received: from crumble.bar.greensocs.com (crumble.bar.greensocs.com
 [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPS id 410CF96F57;
 Fri, 20 Dec 2019 11:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1576842648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wKfWB1jOWR+21dEPgfN4W8tiW090GyA+F812Esq3Tts=;
 b=K+akQlB3116qc4+1/CutgZ6XCFuoqfw8OsuBp7/8XZpOc2//WmdFi7SrOEBcwuF7skLixk
 k4hbWiUei94n70aoVNVJ3Z4X8Hhe+b2RTBFhfHK406d+0wpLILSxJLPjzZQ/DOsaQE6KMl
 SDNJctSu7y4d5+bphyvIDOQ62j5br3k=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 08/11] hw/core: deprecate old reset functions and introduce
 new ones
Date: Fri, 20 Dec 2019 12:50:32 +0100
Message-Id: <20191220115035.709876-9-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191220115035.709876-1-damien.hedde@greensocs.com>
References: <20191220115035.709876-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1576842648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wKfWB1jOWR+21dEPgfN4W8tiW090GyA+F812Esq3Tts=;
 b=M3qua82Oesw09sKhe8flduC0COSMPjvo1fmTSGaHEkmwvLBUEtge00mrgioVwkyC+/bYul
 +9hMtOmvyyTyd6YGTNm9Z+enu2J/VHBoz4+eSfDaBjINXC9Jj4dfkJ53bigkZgJbwTqtq3
 g2YZu/2vqohOeCipuJ0PjMvto0keijg=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1576842648; a=rsa-sha256; cv=none;
 b=7TsRbSN71A8S3AjWkFiLu6bhjulb1YQgkwE4YoK4eHgj9td1Hhb1o0kaV29YGBHxrZckUx
 1cOOiS4OYq2rSOEa2isKIADitLsMbephKMXV8tkseetla/9djm3O4TwMCOdrjylAgy0pmk
 Mh6fZVZxYDoChyusYb5XsEREQNjarB0=
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
 berrange@redhat.com, ehabkost@redhat.com, cohuck@redhat.com,
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
index 4ae2a3363c..f2ac9c6ecc 100644
--- a/include/hw/resettable.h
+++ b/include/hw/resettable.h
@@ -218,6 +218,15 @@ bool resettable_is_in_reset(Object *obj);
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
index 495b5338e2..0224509cdf 100644
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
index 9f6d586fce..101ba9dfa5 100644
--- a/hw/core/resettable.c
+++ b/hw/core/resettable.c
@@ -269,6 +269,11 @@ void resettable_change_parent(Object *obj, Object *n=
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
2.24.0


