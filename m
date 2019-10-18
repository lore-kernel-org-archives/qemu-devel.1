Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C1BCA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 15:13:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E532021897
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 15:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="A5S94pTw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E532021897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLTwB-0001oX-V4
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 11:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39112)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1iLTrC-0006ka-Ar
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 11:07:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1iLTrA-0000I5-TJ
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 11:07:58 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:38684)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1iLTr7-0000DH-6A; Fri, 18 Oct 2019 11:07:53 -0400
Received: from crumble.bar.greensocs.com (crumble.bar.greensocs.com
 [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPS id 985CC96F53;
 Fri, 18 Oct 2019 15:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1571411272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=viHjPgtc5HTCRsQlMywrp57XhUG1VOp0+kLWxpMlyqs=;
 b=A5S94pTw0UDr+7bCBWTCw6RNRzg4BRCxMf3Yvd5hzNDKaiz2WjH9pJUPNpSuiWK7Rz4SAm
 hUcVW8CKZV5x/gpe3vQB8dztdHy3XXwlsD35CEjoKL/geqKd3u5I39VpAJBvdKYLn1DlGZ
 DODUOGDTDvB5xB4ZQW/ONMRYJ6/BF5g=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 05/13] hw/core/resettable: add support for changing parent
Date: Fri, 18 Oct 2019 17:06:22 +0200
Message-Id: <20191018150630.31099-6-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018150630.31099-1-damien.hedde@greensocs.com>
References: <20191018150630.31099-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1571411272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=viHjPgtc5HTCRsQlMywrp57XhUG1VOp0+kLWxpMlyqs=;
 b=xtM+7hXVtdGDUw9yE8WtYEHDnqFfDJHWCGz6rs0uOddJ0P4YaVdORYpA9yoPdeeSlp5V1a
 /QMpV1k8F+sZnkMYW02T5eZxF+rXo0lW6MgyIsDNQDv8nxPp/mXAN3nw+qdKy8IBbbsDO7
 TjsOw6fmBJJY7vb44eg9yEC6U5HCQmk=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1571411272; a=rsa-sha256; cv=none;
 b=ofUFQx6vB2S5YrWDeau9gYS9mzviv68FpdylAFHdKZf668q/I23kNUVepXfB0l0EkbOv5v
 jJD1xxSTY8yzaDBhfN+fNObGMTORJyLo/wyGmv7UoIpf6l8+F0laaigJvKrWyE6pR2/eJt
 PjoU30p5sbS7CP7ZlAMexYdITjBQASs=
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

Add a function resettable_change_parent() to do the required
plumbing when changing the parent a of Resettable object.

We need to make sure that the reset state of the object remains
coherent with the reset state of the new parent.

We make the 2 following hypothesis:
+ when an object is put in a parent under reset, the object goes in
reset.
+ when an object is removed from a parent under reset, the object
leaves reset.

The added function avoid any glitch if both old and new parent are
already in reset.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 hw/core/resettable.c    | 54 +++++++++++++++++++++++++++++++++++++++++
 hw/core/trace-events    |  1 +
 include/hw/resettable.h | 16 ++++++++++++
 3 files changed, 71 insertions(+)

diff --git a/hw/core/resettable.c b/hw/core/resettable.c
index c5e11cff4f..60d4285fcc 100644
--- a/hw/core/resettable.c
+++ b/hw/core/resettable.c
@@ -32,6 +32,14 @@ static void resettable_phase_exit(Object *obj, void *o=
paque, ResetType type);
  */
 static bool enter_phase_in_progress;
=20
+/**
+ * exit_phase_in_progress:
+ * Flag telling whether we are currently in an enter phase where side
+ * effects are forbidden. This flag allows us to catch if
+ * resettable_change_parent() is called during exit phase.
+ */
+static unsigned exit_phase_in_progress;
+
 void resettable_reset(Object *obj, ResetType type)
 {
     trace_resettable_reset(obj, type);
@@ -58,7 +66,9 @@ void resettable_release_reset(Object *obj, ResetType ty=
pe)
     /* TODO: change that assert when adding support for other reset type=
s */
     assert(type =3D=3D RESET_TYPE_COLD);
     trace_resettable_reset_release_begin(obj, type);
+    exit_phase_in_progress +=3D 1;
     resettable_phase_exit(obj, NULL, type);
+    exit_phase_in_progress -=3D 1;
     trace_resettable_reset_release_end(obj);
 }
=20
@@ -198,6 +208,50 @@ static void resettable_phase_exit(Object *obj, void =
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
+    assert(!enter_phase_in_progress && !exit_phase_in_progress);
+    trace_resettable_change_parent(obj, oldp, oldp_count, newp, newp_cou=
nt);
+
+    /*
+     * At most one of the two 'for' loop will be executed below
+     * in order to cope with the diff between the two count.
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
index 66081d0fb4..6d03ef7ff9 100644
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
diff --git a/include/hw/resettable.h b/include/hw/resettable.h
index 6b24e1633b..f6d379669f 100644
--- a/include/hw/resettable.h
+++ b/include/hw/resettable.h
@@ -182,6 +182,22 @@ void resettable_release_reset(Object *obj, ResetType=
 type);
  */
 bool resettable_is_in_reset(Object *obj);
=20
+/**
+ * resettable_change_parent:
+ * Indicate that the parent of Ressettable @obj change from @oldp to @ne=
wp.
+ * All 3 objects must implements resettable interface. @oldp or @newp ma=
y be
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
+ * an hold phase method. Calling this during enter or exit phase is an e=
rror.
+ */
+void resettable_change_parent(Object *obj, Object *newp, Object *oldp);
+
 /**
  * resettable_class_set_parent_phases:
  *
--=20
2.23.0


