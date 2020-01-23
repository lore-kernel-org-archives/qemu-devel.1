Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68B3C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:15:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90C1F21835
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="AOC32Dkw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C1F21835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iueCk-0002NI-1w
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 10:15:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46925)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1iucXK-000569-AV
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:28:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1iucXI-0003gq-OI
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:28:42 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:56738)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1iucXI-0003eq-F4; Thu, 23 Jan 2020 08:28:40 -0500
Received: from crumble.bar.greensocs.com (crumble.bar.greensocs.com
 [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPS id 0D94F96F53;
 Thu, 23 Jan 2020 13:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1579786119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vcpib3zFcAYdVXJLcbutzVpGItnzIhDtYOJszKUrma8=;
 b=AOC32Dkw7bOFRH3Uy4cHIX71+CeEdyb2Q1XRxxYYpHvn3pumqX7ngXwNpsD0k0iVrisMB8
 ZfowCVzMLXoJ5+hLvFhYlFzkfuv3JRmB6sb8DWt1yfg/zbBYBZ7O+qa7hAjJT7OG22sxJy
 v+jcGKvPQjUU0GHO0bQfk4Rz4HXwRUY=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 05/11] hw/core/resettable: add support for changing parent
Date: Thu, 23 Jan 2020 14:28:17 +0100
Message-Id: <20200123132823.1117486-6-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200123132823.1117486-1-damien.hedde@greensocs.com>
References: <20200123132823.1117486-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1579786119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vcpib3zFcAYdVXJLcbutzVpGItnzIhDtYOJszKUrma8=;
 b=ab/Vw0qRw0AcOe+uypjsHUTkxOc01L5b6fXAFLkMhq0+L/D4E+n4wKg5tByQCqp/7cA5vv
 yyuwiZ8dN/unwxUH+Gb30CHtUjqLfP+lhwXxfXGG57R7rlpd9pGsKge0KIo4yos46sFmUe
 V7lLmqFFrKm4VIdMTZKJSk6oIZulL2U=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1579786119; a=rsa-sha256; cv=none;
 b=0jBzAARSg6PMxJKb0hgh9uUARLymVb8qx00jjpd5p7LkiAQ76rKFiwTKiAlezxZuCV53jv
 YbJschzXFF+D+rQX+eqB+i/9SFzYecpQTEiLd79ttl9bPQFtxdIeE2IvXmz1JItvonHTJF
 rS9d+r2OXtyZQXoj8o7fNeidVR3ehrA=
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

Add a function resettable_change_parent() to do the required
plumbing when changing the parent a of Resettable object.

We need to make sure that the reset state of the object remains
coherent with the reset state of the new parent.

We make the 2 following hypothesis:
+ when an object is put in a parent under reset, the object goes in
reset.
+ when an object is removed from a parent under reset, the object
leaves reset.

The added function avoids any glitch if both old and new parent are
already in reset.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

---

v8 update: ResettableState.count type change from uint32_t to unsigned
---
 include/hw/resettable.h | 16 +++++++++++
 hw/core/resettable.c    | 62 +++++++++++++++++++++++++++++++++++++++--
 hw/core/trace-events    |  1 +
 3 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/include/hw/resettable.h b/include/hw/resettable.h
index c0b9fc6ad6..96073354fd 100644
--- a/include/hw/resettable.h
+++ b/include/hw/resettable.h
@@ -194,6 +194,22 @@ void resettable_release_reset(Object *obj, ResetType=
 type);
  */
 bool resettable_is_in_reset(Object *obj);
=20
+/**
+ * resettable_change_parent:
+ * Indicate that the parent of Ressettable @obj is changing from @oldp t=
o @newp.
+ * All 3 objects must implement resettable interface. @oldp or @newp may=
 be
+ * NULL.
+ *
+ * This function will adapt the reset state of @obj so that it is cohere=
nt
+ * with the reset state of @newp. It may trigger @resettable_assert_rese=
t()
+ * or @resettable_release_reset(). It will do such things only if the re=
set
+ * state of @newp and @oldp are different.
+ *
+ * When using this function during reset, it must only be called during
+ * a hold phase method. Calling this during enter or exit phase is an er=
ror.
+ */
+void resettable_change_parent(Object *obj, Object *newp, Object *oldp);
+
 /**
  * resettable_class_set_parent_phases:
  *
diff --git a/hw/core/resettable.c b/hw/core/resettable.c
index 9133208487..6e0b0f492f 100644
--- a/hw/core/resettable.c
+++ b/hw/core/resettable.c
@@ -28,12 +28,16 @@ static void resettable_phase_exit(Object *obj, void *=
opaque, ResetType type);
  * enter_phase_in_progress:
  * True if we are currently in reset enter phase.
  *
- * Note: This flag is only used to guarantee (using asserts) that the re=
set
- * API is used correctly. We can use a global variable because we rely o=
n the
+ * exit_phase_in_progress:
+ * count the number of exit phase we are in.
+ *
+ * Note: These flags are only used to guarantee (using asserts) that the=
 reset
+ * API is used correctly. We can use global variables because we rely on=
 the
  * iothread mutex to ensure only one reset operation is in a progress at=
 a
  * given time.
  */
 static bool enter_phase_in_progress;
+static unsigned exit_phase_in_progress;
=20
 void resettable_reset(Object *obj, ResetType type)
 {
@@ -65,7 +69,9 @@ void resettable_release_reset(Object *obj, ResetType ty=
pe)
     trace_resettable_reset_release_begin(obj, type);
     assert(!enter_phase_in_progress);
=20
+    exit_phase_in_progress +=3D 1;
     resettable_phase_exit(obj, NULL, type);
+    exit_phase_in_progress -=3D 1;
=20
     trace_resettable_reset_release_end(obj);
 }
@@ -206,6 +212,58 @@ static void resettable_phase_exit(Object *obj, void =
*opaque, ResetType type)
     trace_resettable_phase_exit_end(obj, obj_typename, s->count);
 }
=20
+/*
+ * resettable_get_count:
+ * Get the count of the Resettable object @obj. Return 0 if @obj is NULL=
.
+ */
+static unsigned resettable_get_count(Object *obj)
+{
+    if (obj) {
+        ResettableClass *rc =3D RESETTABLE_GET_CLASS(obj);
+        return rc->get_state(obj)->count;
+    }
+    return 0;
+}
+
+void resettable_change_parent(Object *obj, Object *newp, Object *oldp)
+{
+    ResettableClass *rc =3D RESETTABLE_GET_CLASS(obj);
+    ResettableState *s =3D rc->get_state(obj);
+    unsigned newp_count =3D resettable_get_count(newp);
+    unsigned oldp_count =3D resettable_get_count(oldp);
+
+    /*
+     * Ensure we do not change parent when in enter or exit phase.
+     * During these phases, the reset subtree being updated is partly in=
 reset
+     * and partly not in reset (it depends on the actual position in
+     * resettable_child_foreach()s). We are not able to tell in which pa=
rt is a
+     * leaving or arriving device. Thus we cannot set the reset count of=
 the
+     * moving device to the proper value.
+     */
+    assert(!enter_phase_in_progress && !exit_phase_in_progress);
+    trace_resettable_change_parent(obj, oldp, oldp_count, newp, newp_cou=
nt);
+
+    /*
+     * At most one of the two 'for' loops will be executed below
+     * in order to cope with the difference between the two counts.
+     */
+    /* if newp is more reset than oldp */
+    for (unsigned i =3D oldp_count; i < newp_count; i++) {
+        resettable_assert_reset(obj, RESET_TYPE_COLD);
+    }
+    /*
+     * if obj is leaving a bus under reset, we need to ensure
+     * hold phase is not pending.
+     */
+    if (oldp_count && s->hold_phase_pending) {
+        resettable_phase_hold(obj, NULL, RESET_TYPE_COLD);
+    }
+    /* if oldp is more reset than newp */
+    for (unsigned i =3D newp_count; i < oldp_count; i++) {
+        resettable_release_reset(obj, RESET_TYPE_COLD);
+    }
+}
+
 void resettable_class_set_parent_phases(ResettableClass *rc,
                                         ResettableEnterPhase enter,
                                         ResettableHoldPhase hold,
diff --git a/hw/core/trace-events b/hw/core/trace-events
index 77d61cb66e..aecd8e160e 100644
--- a/hw/core/trace-events
+++ b/hw/core/trace-events
@@ -16,6 +16,7 @@ resettable_reset_assert_begin(void *obj, int cold) "obj=
=3D%p cold=3D%d"
 resettable_reset_assert_end(void *obj) "obj=3D%p"
 resettable_reset_release_begin(void *obj, int cold) "obj=3D%p cold=3D%d"
 resettable_reset_release_end(void *obj) "obj=3D%p"
+resettable_change_parent(void *obj, void *o, unsigned oc, void *n, unsig=
ned nc) "obj=3D%p from=3D%p(%d) to=3D%p(%d)"
 resettable_phase_enter_begin(void *obj, const char *objtype, unsigned co=
unt, int type) "obj=3D%p(%s) count=3D%d type=3D%d"
 resettable_phase_enter_exec(void *obj, const char *objtype, int type, in=
t has_method) "obj=3D%p(%s) type=3D%d method=3D%d"
 resettable_phase_enter_end(void *obj, const char *objtype, unsigned coun=
t) "obj=3D%p(%s) count=3D%d"
--=20
2.24.1


