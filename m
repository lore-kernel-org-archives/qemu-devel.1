Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC93CC33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 12:44:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBC6E2465A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 12:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="epnVG4vr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC6E2465A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iri28-0007Nk-Qq
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 07:44:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49735)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1irhuj-0002Mh-M7
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 07:36:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1irhui-00036u-0P
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 07:36:49 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:53588)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1irhuh-000352-NA; Wed, 15 Jan 2020 07:36:47 -0500
Received: from crumble.bar.greensocs.com (crumble.bar.greensocs.com
 [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPS id 1AD7F96F56;
 Wed, 15 Jan 2020 12:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1579091806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TaTucAelcar7/Tq5fUlcZtDaa3gxXAfZz25prtJ0NvI=;
 b=epnVG4vrWiCM7+MfE1NQPTL04XMMeC0LTTHRZSA+s/9CMMFBXmeEuY4mafo/6Fm8k8NnH6
 5bMibwSsxJUt2huevGldfGToPPjTI7/7F7nN/A2Kfsbmc+oCSl+eNdIpFAYssWw+m4CYgG
 w7XaeKJx7EKavSBdMgs3DhXe2gqyMhU=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 07/11] hw/core/qdev: update hotplug reset regarding
 resettable
Date: Wed, 15 Jan 2020 13:36:16 +0100
Message-Id: <20200115123620.250132-8-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200115123620.250132-1-damien.hedde@greensocs.com>
References: <20200115123620.250132-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1579091806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TaTucAelcar7/Tq5fUlcZtDaa3gxXAfZz25prtJ0NvI=;
 b=iOLfm/W0Q/B85PUet4WLkRqn+IO0lovEt9sVHsbKBsAWRM0xO0qVNab6QYM1n0G1L7uOhu
 H0MGlujrpaZi5IkQs5vF8oBSCmpSG+viufz+yWPHBLyUHt4KVjC6Cmq+YlMLloJgNJ1fhk
 GY8bAtyP7gtfM/278m5MrqgwYsI1STA=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1579091806; a=rsa-sha256; cv=none;
 b=BH96CwjmPPwAtwrYqEayq9pHd1FyY7wGKfUYH8sA3XAN9GGHPwrqpDE8luX6/yxOVEYUFB
 PgomI2cZdEMnwj0hrl7qJjFamG4HA2NehvaAjj9VwWR+vdFRPcgZN7TFIWkHmlgwVHdlEY
 Vqyy48r8V2ogCfedte45Lvc53WSzrbw=
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

This commit make use of the resettable API to reset the device being
hotplugged when it is realized. Also it ensures it is put in a reset
state coherent with the parent it is plugged into.

Note that there is a difference in the reset. Instead of resetting
only the hotplugged device, we reset also its subtree (switch to
resettable API). This is not expected to be a problem because
sub-buses are just realized too. If a hotplugged device has any
sub-buses it is logical to reset them too at this point.

The recently added should_be_hidden and PCI's partially_hotplugged
mechanisms do not interfere with realize operation:
+ In the should_be_hidden use case, device creation is
delayed.
+ The partially_hotplugged mechanism prevents a device to be
unplugged and unrealized from qdev POV and unrealized.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---

v7 update: inline resettable_state_clear()

v6 update: clear the reset state before doing any reset. Although it
is apparently highly improbable that a device be realized again after
being unrealized. See here for a discussion about this point and the
partially_hotplugged/shoud_be_hidden cases.
https://lists.nongnu.org/archive/html/qemu-devel/2019-11/msg04897.html
---
 include/hw/resettable.h | 11 +++++++++++
 hw/core/qdev.c          | 15 ++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/hw/resettable.h b/include/hw/resettable.h
index 3c87ab86c7..3f90da5b5b 100644
--- a/include/hw/resettable.h
+++ b/include/hw/resettable.h
@@ -153,6 +153,17 @@ struct ResettableState {
     bool exit_phase_in_progress;
 };
=20
+/**
+ * resettable_state_clear:
+ * Clear the state. It puts the state to the initial (zeroed) state requ=
ired
+ * to reuse an object. Typically used in realize step of base classes
+ * implementing the interface.
+ */
+static inline void resettable_state_clear(ResettableState *state)
+{
+    memset(state, 0, sizeof(ResettableState));
+}
+
 /**
  * resettable_reset:
  * Trigger a reset on an object @obj of type @type. @obj must implement
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 310b87e25a..5fac4cd8fc 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -937,6 +937,12 @@ static void device_set_realized(Object *obj, bool va=
lue, Error **errp)
             }
         }
=20
+        /*
+         * Clear the reset state, in case the object was previously unre=
alized
+         * with a dirty state.
+         */
+        resettable_state_clear(&dev->reset);
+
         QLIST_FOREACH(bus, &dev->child_bus, sibling) {
             object_property_set_bool(OBJECT(bus), true, "realized",
                                          &local_err);
@@ -945,7 +951,14 @@ static void device_set_realized(Object *obj, bool va=
lue, Error **errp)
             }
         }
         if (dev->hotplugged) {
-            device_legacy_reset(dev);
+            /*
+             * Reset the device, as well as its subtree which, at this p=
oint,
+             * should be realized too.
+             */
+            resettable_assert_reset(OBJECT(dev), RESET_TYPE_COLD);
+            resettable_change_parent(OBJECT(dev), OBJECT(dev->parent_bus=
),
+                                     NULL);
+            resettable_release_reset(OBJECT(dev), RESET_TYPE_COLD);
         }
         dev->pending_deleted_event =3D false;
=20
--=20
2.24.1


