Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25099CA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 15:23:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6A94222C3
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 15:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="K+BEr3S4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A94222C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLU6e-0001ts-WF
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 11:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39187)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1iLTrE-0006nY-MT
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 11:08:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1iLTrD-0000Ju-4R
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 11:08:00 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:38718)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1iLTr9-0000G7-4u; Fri, 18 Oct 2019 11:07:55 -0400
Received: from crumble.bar.greensocs.com (crumble.bar.greensocs.com
 [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPS id 99A8E96F57;
 Fri, 18 Oct 2019 15:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1571411274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RqBxcWOE3GUk9NOvDWwY7MRG2couRRZlrwQCMsx9cb8=;
 b=K+BEr3S4fPz3+bqUh8rvo/LlgeBgDXJWbAL2F34zlmCe/tfuU70xY46CfbwiHCYR526AQW
 X8WpjL/Nhp2Na70OQCniAfLMIn0t0mlf0Y7wCFlN/nzkrvVS+nUAOQatXOgfeW1G88IHQz
 n5GqnSgHfirY0ckPaf7LMpImztCueoY=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 08/13] hw/core: deprecate old reset functions and introduce
 new ones
Date: Fri, 18 Oct 2019 17:06:25 +0200
Message-Id: <20191018150630.31099-9-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018150630.31099-1-damien.hedde@greensocs.com>
References: <20191018150630.31099-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1571411274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RqBxcWOE3GUk9NOvDWwY7MRG2couRRZlrwQCMsx9cb8=;
 b=Y3rATdAWJGXlgMiQg6iq0xdgiAsrgs/zyRhnX1e/XFoqFzjPIU/tCRUUDh03ox4nu7l0r/
 jOUcfnFqEf0pfquEOu94y0wwkPYNYmu4WTNQaCLZWb2q8qswzRzxqlvXAcV1PpA18g3cIX
 jksywxxs5VfW8OE26roXqJbhW57RYMk=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1571411274; a=rsa-sha256; cv=none;
 b=VFXiwxs2wZt0y1qBLHG37/xc2o0HrHCMhFU3jE9NMo8IDB/kJaLShZniac8usop1xwSkBo
 zj+eIw8mGH1bLkmMgehjPEJ7v1XUB7Cyg/oC686my9pQnTOI5nDlq4+j9gZCXWZ40vYb9R
 R+rp3leK4H+t1LLe06LYjxOg4v/ty0I=
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
 qemu-arm@nongnu.org, pbonzini@redhat.com, philmd@redhat.com,
 david@gibson.dropbear.id.au
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
---

I've removed the general helpers
+ device_reset(DeviceState *dev, ResetType type)
+ bus_reset(BusState *dev, ResetType type)
because with several reset types, all devices and buses will not
implement all of them. I think it is preferable to define a
type-specific helper every time it is needed for base classes
implementing the reset type (eg a device_pci_reset(PciDev*) for the
pci reset type if add that).

So device_reset()/bus_reset() symbol names are not taken anymore. I
don't have a strong opinion of what names should have the
device_cold_reset() and bus_cold_reset() function added in this
patch. It could be device/bus_hard_reset() (the current
qbus_reset_all() comment mention we do a "hard" reset) or simply
device/bus_reset() or anything else.
What do you think ? Any better idea ? It should be consistent with
the reset type name but we can change it also if cold is not what we
want.

Note that if we don't settle for device/bus_reset(). We can drop
the first patch that renames device_reset() to device_legacy_reset()
---
 hw/core/bus.c           |  5 +++++
 hw/core/qdev.c          |  5 +++++
 hw/core/resettable.c    |  5 +++++
 include/hw/qdev-core.h  | 27 +++++++++++++++++++++++++++
 include/hw/resettable.h |  9 +++++++++
 5 files changed, 51 insertions(+)

diff --git a/hw/core/bus.c b/hw/core/bus.c
index 7c05e80db8..5f9e261bb2 100644
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
index c5d107ea4e..3e6600ce76 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -335,6 +335,11 @@ void qbus_reset_all_fn(void *opaque)
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
index 60d4285fcc..3d3200bdbc 100644
--- a/hw/core/resettable.c
+++ b/hw/core/resettable.c
@@ -252,6 +252,11 @@ void resettable_change_parent(Object *obj, Object *n=
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
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 2e3346600e..1e88cb2f6a 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -386,6 +386,13 @@ int qdev_walk_children(DeviceState *dev,
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
@@ -398,10 +405,28 @@ void qdev_reset_all_fn(void *opaque);
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
@@ -432,6 +457,8 @@ void qdev_machine_init(void);
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
index f6d379669f..6a9e17344e 100644
--- a/include/hw/resettable.h
+++ b/include/hw/resettable.h
@@ -198,6 +198,15 @@ bool resettable_is_in_reset(Object *obj);
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
--=20
2.23.0


