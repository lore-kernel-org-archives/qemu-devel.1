Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD9CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:42:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 330A121734
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="2bYxY1K1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 330A121734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuecd-0004dN-GR
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 10:42:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46961)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1iucXL-00057m-W0
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:28:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1iucXK-0003iM-JD
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:28:43 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:56764)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1iucXK-0003hW-AE; Thu, 23 Jan 2020 08:28:42 -0500
Received: from crumble.bar.greensocs.com (crumble.bar.greensocs.com
 [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPS id 6D77696F56;
 Thu, 23 Jan 2020 13:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1579786121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dzvKbyxikkccILCxuKcmdnhT6iGxt2vyARq+Np6UnOc=;
 b=2bYxY1K1dG5Sh3ldZKJQN8SP8BibRI6cE3QXyH6YQPdGQgUpM/hlv/Uwbs5+gkZNt/oDwZ
 3JM8eBsUlUKdBwwmImcAUvUkF0ZoKhXxBpGWWwac3TwUb+zVNT+dH8kXNygwH9urDGTJ/V
 dre1I3Lz9C0SKb5uooV1ycE3Lv5C7Vs=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 07/11] hw/core/qdev: update hotplug reset regarding
 resettable
Date: Thu, 23 Jan 2020 14:28:19 +0100
Message-Id: <20200123132823.1117486-8-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200123132823.1117486-1-damien.hedde@greensocs.com>
References: <20200123132823.1117486-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1579786121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dzvKbyxikkccILCxuKcmdnhT6iGxt2vyARq+Np6UnOc=;
 b=uEHF7HbOQLZ4xns06KRXrcke7EW0X/fBoJK7Ctoohlh5K0/xndLW+Ly0Z3PO46AGm9L5Zi
 JzakeRBqcgZizjP8jkw1F+db49rz+mBw4pQ+wCQ2pXgLapLzrmWwbCB2qIOQHEsALxTsyS
 LM2AObxJU5/cumGFEPpBvTzAr6hXvEg=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1579786121; a=rsa-sha256; cv=none;
 b=1uXaVinekaoULMrbQDZzxWm41fRV0hV+Am8JbGIBJAYi1PcbvJ4G9NUXo9sm2qaFG8JPHh
 zPCp70GtVhtUEKkwQGjkO7aqF4hzhhPGXGsn//32Gw7pQTmKKNBjKKo0JwOqpoUocHY8AR
 5GBrKAiZh1/LAx5sU6L0x9rj7xtLl1c=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
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
index 96073354fd..5e215d94e4 100644
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
index ce23b35383..36bfcbc697 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -938,6 +938,12 @@ static void device_set_realized(Object *obj, bool va=
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
@@ -946,7 +952,14 @@ static void device_set_realized(Object *obj, bool va=
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


