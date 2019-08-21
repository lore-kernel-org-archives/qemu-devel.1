Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2E2C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 16:52:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2C3E22DD3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 16:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=temperror (0-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="fMpN/mte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2C3E22DD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Tr0-0007pN-SG
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 12:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59685)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1i0Ta5-0007n8-Br
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:35:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1i0Ta4-0006AF-26
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:35:29 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:36476)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1i0Ta3-00069Q-Pv
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:35:28 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPS id 72AF396F53;
 Wed, 21 Aug 2019 16:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1566405326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4T0tdRysLQN0/hyNXEL3bhUMmWy8v0Titbmq3w/t+44=;
 b=fMpN/mteEmPFjIusu2nrD5fpFOwsUBu4FTzCwoiYZiBE9EAFdAB/OGYyjEcmvBt1UdRaU8
 FE9WHpmPKD/YKi1l8y+6Va5yfJmWivYUpFnOAa7q488tKVfx6k6jXjnPBw1nwSTTPtvxdY
 jebIa0vPNNBdiETKGNMeaeqp6bBWCNY=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 18:33:39 +0200
Message-Id: <20190821163341.16309-9-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190821163341.16309-1-damien.hedde@greensocs.com>
References: <20190821163341.16309-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1566405326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4T0tdRysLQN0/hyNXEL3bhUMmWy8v0Titbmq3w/t+44=;
 b=mJEIsJfKIHztppP3z7aj0IcbaDA4BX4MDI1H1BF3nVXDA/8CVzUHv4iRq0BtYW4bd/B5Xa
 FCEtJ12f38syUmB2pPmMh0aQzE3lPQJVjQpoS5qIYpXfMbrzoVd9d4Rw2NL9pal3yNmXbU
 slb6mzjjJ2Yvcx1vIQh/q4Rdnu4PM9o=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1566405326; a=rsa-sha256; cv=none;
 b=faWP2sO/fWFFCBIxuHjkfDog4OdVgP7Eukg1C08m7KQrbMPDmtwAI7ihjm9f3aRKl7MlnC
 UJBKcWsRasLGqoYBmLYa66szysuuYREFFsKBWuBTorjUY+8u1SYfwTWjewQw4pXd0MLztQ
 PNn5h7aU03rDKdtMg43NWL/AvSqVlwk=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [PATCH v4 08/10] hw/core/resettable: add support for
 warm reset
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
 edgar.iglesias@xilinx.com, berrange@redhat.com, ehabkost@redhat.com,
 mark.burton@greensocs.com, pbonzini@redhat.com, philmd@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the RESET_TYPE_WARM reset type.
Expand the actual implementation to support several types.

I used values which can be or'ed together. This way we can what reset
has been triggered.

Documentation is added in a following patch.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 hw/core/resettable.c    | 25 +++++++++++++++++++------
 include/hw/resettable.h | 22 +++++++++++++++++-----
 2 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/hw/core/resettable.c b/hw/core/resettable.c
index b534c2c7a4..80674292b3 100644
--- a/hw/core/resettable.c
+++ b/hw/core/resettable.c
@@ -34,12 +34,17 @@ static void resettable_init_reset(Object *obj, ResetT=
ype type)
     ResetState *s =3D rc->get_state(obj);
     bool action_needed =3D false;
=20
-    /* Only take action if we really enter reset for the 1st time. */
+    /* ensure type is empty if no reset is in progress */
+    if (s->count =3D=3D 0) {
+        s->type =3D 0;
+    }
+
     /*
-     * TODO: if adding more ResetType support, some additional checks
-     * are probably needed here.
+     * Only take action if:
+     * + we are not already in cold reset,
+     * + and we enter a new type of reset.
      */
-    if (s->count =3D=3D 0) {
+    if ((s->type & RESET_TYPE_COLD) =3D=3D 0 && (s->type & type) =3D=3D =
0) {
         action_needed =3D true;
     }
     s->count +=3D 1;
@@ -62,6 +67,7 @@ static void resettable_init_reset(Object *obj, ResetTyp=
e type)
=20
     /* exec init phase */
     if (action_needed) {
+        s->type |=3D type;
         s->hold_phase_needed =3D true;
         if (rc->phases.init) {
             rc->phases.init(obj, type);
@@ -133,8 +139,7 @@ static void resettable_exit_reset(Object *obj)
=20
 void resettable_reset(Object *obj, ResetType type)
 {
-    /* TODO: change that when adding support for other reset types */
-    assert(type =3D=3D RESET_TYPE_COLD);
+    assert(type =3D=3D RESET_TYPE_COLD || type =3D=3D RESET_TYPE_WARM);
     trace_resettable_reset(obj, type);
     resettable_init_reset(obj, type);
     resettable_hold_reset(obj);
@@ -154,6 +159,14 @@ bool resettable_is_resetting(Object *obj)
     return (s->count > 0);
 }
=20
+ResetType resettable_get_type(Object *obj)
+{
+    ResettableClass *rc =3D RESETTABLE_GET_CLASS(obj);
+    ResetState *s =3D rc->get_state(obj);
+
+    return s->type;
+}
+
 void resettable_class_set_parent_phases(ResettableClass *rc,
                                         ResettableInitPhase init,
                                         ResettableHoldPhase hold,
diff --git a/include/hw/resettable.h b/include/hw/resettable.h
index 5808c3c187..1e77cbd75b 100644
--- a/include/hw/resettable.h
+++ b/include/hw/resettable.h
@@ -12,15 +12,14 @@ typedef struct ResetState ResetState;
=20
 /**
  * ResetType:
- * Types of reset.
+ * Types of reset, values can be OR'ed together.
  *
  * + Cold: reset resulting from a power cycle of the object.
- *
- * TODO: Support has to be added to handle more types. In particular,
- * ResetState structure needs to be expanded.
+ * + Warm: reset without power cycling.
  */
 typedef enum ResetType {
-    RESET_TYPE_COLD,
+    RESET_TYPE_COLD =3D 0x1,
+    RESET_TYPE_WARM =3D 0x2,
 } ResetType;
=20
 /*
@@ -107,11 +106,13 @@ typedef struct ResettablePhases ResettablePhases;
  *
  * @count: Number of reset level the object is into. It is incremented w=
hen
  * the reset operation starts and decremented when it finishes.
+ * @type: Type of the in-progress reset. Valid only when count is non-ze=
ro.
  * @hold_phase_needed: flag which indicates that we need to invoke the '=
hold'
  * phase handler for this object.
  */
 struct ResetState {
     uint32_t count;
+    ResetType type;
     bool hold_phase_needed;
 };
=20
@@ -123,6 +124,17 @@ struct ResetState {
  */
 bool resettable_is_resetting(Object *obj);
=20
+/**
+ * resettable_get_type:
+ * Return the current type of reset @obj is under.
+ *
+ * @obj must implement Resettable interface. Result is only valid if
+ * @resettable_is_resetting is true.
+ *
+ * Note: this return an OR'ed value of type if several reset were trigge=
red
+ */
+ResetType resettable_get_type(Object *obj);
+
 /**
  * resettable_reset:
  * Trigger a reset on a object @obj of type @type. @obj must implement
--=20
2.22.0


