Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07641C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 04:54:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C71C320733
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 04:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Pnashcfm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C71C320733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih4sf-0005b5-Je
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 23:54:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33616)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4i7-0008EL-UI
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:43:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4i1-0005T4-E1
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:43:48 -0500
Received: from ozlabs.org ([203.11.71.1]:39847)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4i1-0005Kk-28; Mon, 16 Dec 2019 23:43:45 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWR3VHcz9sSd; Tue, 17 Dec 2019 15:43:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557811;
 bh=DkwFpJiNBFvJaIJBPjZaMoONoRs9YS2BWDzgU84Y6bA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PnashcfmSEHJD4E3gp+tRqqzF360/15aSBhso7G9J9uRrxiDdjepUjWYHVp5q2Z1W
 vIgtsByciFPSUUp1gt8rpxFp8v5waGI+H8pEVIeNXO/+K+AZNhjUHh6xN7OLYl/2kF
 34GPYZCrOi4eMH95Ij+vkgSAPhypWmrwlCll1atY=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 14/88] xics: Link ICP_PROP_CPU property to ICPState::cs pointer
Date: Tue, 17 Dec 2019 15:42:08 +1100
Message-Id: <20191217044322.351838-15-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

The ICP object has both a pointer and an ICP_PROP_CPU property pointing
to the cpu. Confusing bugs could arise if these ever go out of sync.

Change the property definition so that it explicitly sets the pointer.
The property isn't optional : not being able to set the link is a bug
and QEMU should rather abort than exit in this case.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <157403284709.409804.16142099083325945141.stgit@bahia.lan>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 35dddb8867..0b259a09c5 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -305,25 +305,13 @@ void icp_reset(ICPState *icp)
 static void icp_realize(DeviceState *dev, Error **errp)
 {
     ICPState *icp =3D ICP(dev);
-    PowerPCCPU *cpu;
     CPUPPCState *env;
-    Object *obj;
     Error *err =3D NULL;
=20
     assert(icp->xics);
+    assert(icp->cs);
=20
-    obj =3D object_property_get_link(OBJECT(dev), ICP_PROP_CPU, &err);
-    if (!obj) {
-        error_propagate_prepend(errp, err,
-                                "required link '" ICP_PROP_CPU
-                                "' not found: ");
-        return;
-    }
-
-    cpu =3D POWERPC_CPU(obj);
-    icp->cs =3D CPU(obj);
-
-    env =3D &cpu->env;
+    env =3D &POWERPC_CPU(icp->cs)->env;
     switch (PPC_INPUT(env)) {
     case PPC_FLAGS_INPUT_POWER7:
         icp->output =3D env->irq_inputs[POWER7_INPUT_INT];
@@ -363,6 +351,7 @@ static void icp_unrealize(DeviceState *dev, Error **e=
rrp)
 static Property icp_properties[] =3D {
     DEFINE_PROP_LINK(ICP_PROP_XICS, ICPState, xics, TYPE_XICS_FABRIC,
                      XICSFabric *),
+    DEFINE_PROP_LINK(ICP_PROP_CPU, ICPState, cs, TYPE_CPU, CPUState *),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
@@ -397,8 +386,7 @@ Object *icp_create(Object *cpu, const char *type, XIC=
SFabric *xi, Error **errp)
     object_property_add_child(cpu, type, obj, &error_abort);
     object_unref(obj);
     object_property_set_link(obj, OBJECT(xi), ICP_PROP_XICS, &error_abor=
t);
-    object_ref(cpu);
-    object_property_add_const_link(obj, ICP_PROP_CPU, cpu, &error_abort)=
;
+    object_property_set_link(obj, cpu, ICP_PROP_CPU, &error_abort);
     object_property_set_bool(obj, true, "realized", &local_err);
     if (local_err) {
         object_unparent(obj);
@@ -413,7 +401,6 @@ void icp_destroy(ICPState *icp)
 {
     Object *obj =3D OBJECT(icp);
=20
-    object_unref(object_property_get_link(obj, ICP_PROP_CPU, &error_abor=
t));
     object_unparent(obj);
 }
=20
--=20
2.23.0


