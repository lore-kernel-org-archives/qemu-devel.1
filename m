Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97DDC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 11:53:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 981BE24679
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 11:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="i20x0w0J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 981BE24679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiGr0-0003tR-LB
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 06:53:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51031)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1iiGny-00027a-LZ
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 06:50:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1iiGnw-0006QZ-KM
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 06:50:50 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:45214)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1iiGnw-0006Kf-1G; Fri, 20 Dec 2019 06:50:48 -0500
Received: from crumble.bar.greensocs.com (crumble.bar.greensocs.com
 [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPS id 5257B96F53;
 Fri, 20 Dec 2019 11:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1576842646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Ro5j/lJpMIc5apYZDV6aZ59hl2r4/XjxpcA8G0uBAc=;
 b=i20x0w0JCw0MqSC/6li+UU8IKiNtNhwlqxQDBjkEYQ9EXVq99ELjdz/j+vAawPqjMBeX7Y
 6YqWM3CfTIp9fVwaC8Z/zji5mWBPOzCVAkTDAwrJDaBge2/XOuHZKPEe/xHigLhJNyZ9KE
 fxGB/HpXpK2sDq5kXGhul4QoYduBO9A=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 05/11] hw/core/resettable: add support for changing parent
Date: Fri, 20 Dec 2019 12:50:29 +0100
Message-Id: <20191220115035.709876-6-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191220115035.709876-1-damien.hedde@greensocs.com>
References: <20191220115035.709876-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1576842646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Ro5j/lJpMIc5apYZDV6aZ59hl2r4/XjxpcA8G0uBAc=;
 b=Qu8++/uDBpxBt+cbw2Mylsig/ZpmIlIi3jj0+Y7Yon/7OlmKiIBv8ASDYAQkUEVf3O5MKx
 /jEwAaOlesCqGFxSMnpUT3T15+vFzhRjtCNdIx8zll5zcJCDORhr2PFgsI85iDGM9S33wR
 SerPv/qz+FiYk68Bjoj8vuC7WNdMJh8=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1576842646; a=rsa-sha256; cv=none;
 b=o/p7oakuon4pvp704rlQQveAjmPLsiyR9dnUdLO12b+DKNzrbvB3rOpfxn076fV9yl7S0J
 SWIIn6AZQarNOB1E3rDiQ3yRqWFm1uM90g8CWQAlAg5a/o9X+g8drsgrPlqGuUUPbPKhnJ
 7lUqj5FBgx41GDLhel0u6ZlNW+4GpDA=
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
---
 include/hw/resettable.h | 16 +++++++++++
 hw/core/resettable.c    | 62 +++++++++++++++++++++++++++++++++++++++--
 hw/core/trace-events    |  1 +
 3 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/include/hw/resettable.h b/include/hw/resettable.h
index da610d41ac..2227c654a5 100644
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
index 6a6fc6107a..9104a84b99 100644
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
+static uint32_t resettable_get_count(Object *obj)
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
+    uint32_t newp_count =3D resettable_get_count(newp);
+    uint32_t oldp_count =3D resettable_get_count(oldp);
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
+    for (uint32_t i =3D oldp_count; i < newp_count; i++) {
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
+    for (uint32_t i =3D newp_count; i < oldp_count; i++) {
+        resettable_release_reset(obj, RESET_TYPE_COLD);
+    }
+}
+
 void resettable_class_set_parent_phases(ResettableClass *rc,
                                         ResettableEnterPhase enter,
                                         ResettableHoldPhase hold,
diff --git a/hw/core/trace-events b/hw/core/trace-events
index a2e43f1120..80e6325ab0 100644
--- a/hw/core/trace-events
+++ b/hw/core/trace-events
@@ -16,6 +16,7 @@ resettable_reset_assert_begin(void *obj, int cold) "obj=
=3D%p cold=3D%d"
 resettable_reset_assert_end(void *obj) "obj=3D%p"
 resettable_reset_release_begin(void *obj, int cold) "obj=3D%p cold=3D%d"
 resettable_reset_release_end(void *obj) "obj=3D%p"
+resettable_change_parent(void *obj, void *o, uint32_t oc, void *n, uint3=
2_t nc) "obj=3D%p from=3D%p(%" PRIu32 ") to=3D%p(%" PRIu32 ")"
 resettable_phase_enter_begin(void *obj, const char *objtype, uint32_t co=
unt, int type) "obj=3D%p(%s) count=3D%" PRIu32 " type=3D%d"
 resettable_phase_enter_exec(void *obj, const char *objtype, int type, in=
t has_method) "obj=3D%p(%s) type=3D%d method=3D%d"
 resettable_phase_enter_end(void *obj, const char *objtype, uint32_t coun=
t) "obj=3D%p(%s) count=3D%" PRIu32
--=20
2.24.0


