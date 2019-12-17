Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B76C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 04:58:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51CC820733
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 04:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="fwQ2P6Nc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51CC820733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih4wC-0002cs-1z
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 23:58:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33474)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4hz-00087W-Tu
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:43:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4hy-0005Oy-Mg
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:43:43 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:59887 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4hy-0005JP-BC; Mon, 16 Dec 2019 23:43:42 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWR0Dtnz9sRX; Tue, 17 Dec 2019 15:43:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557811;
 bh=eIhwrx3OcXp3/wr/CB8zxrx4IUYT4c8un45IagMXKSk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fwQ2P6NclKPnCR9V852flQoYRWui02gKSN/Q5y0Nt/K6hIQ9/lHjcpPk000eEMLP8
 GN9iG7yx5i9ffc21aE11dhZZla+nbrOKI9fpxy7rLNYcgilYt7Wb4Jc5y86HawdOTz
 JiKV8tsOxN73PxrkItO++Ef6gL/ibmOfaXLhQrFw=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 15/88] spapr: Abort if XICS interrupt controller cannot be
 initialized
Date: Tue, 17 Dec 2019 15:42:09 +1100
Message-Id: <20191217044322.351838-16-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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

Failing to set any of the ICS property should really never happen:
- object_property_add_child() always succeed unless the child object
  already has a parent, which isn't the case here obviously since the
  ICS has just been created with object_new()
- the ICS has an "nr-irqs" property than can be set as long as the ICS
  isn't realized

In both cases, an error indicates there is a bug in QEMU. Propagating the
error, ie. exiting QEMU since spapr_irq_init() is called with &error_fata=
l
doesn't make much sense. Abort instead. This is consistent with what is
done with XIVE : both qdev_create() and qdev_prop_set_uint32() abort QEMU
on error.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <157403285265.409804.8683093665795248192.stgit@bahia.lan>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_irq.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index fbdda14372..d4a54afc86 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -313,20 +313,11 @@ void spapr_irq_init(SpaprMachineState *spapr, Error=
 **errp)
         Object *obj;
=20
         obj =3D object_new(TYPE_ICS_SPAPR);
-        object_property_add_child(OBJECT(spapr), "ics", obj, &local_err)=
;
-        if (local_err) {
-            error_propagate(errp, local_err);
-            return;
-        }
=20
+        object_property_add_child(OBJECT(spapr), "ics", obj, &error_abor=
t);
         object_property_set_link(obj, OBJECT(spapr), ICS_PROP_XICS,
                                  &error_abort);
-        object_property_set_int(obj, smc->nr_xirqs, "nr-irqs", &local_er=
r);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            return;
-        }
-
+        object_property_set_int(obj, smc->nr_xirqs, "nr-irqs", &error_ab=
ort);
         object_property_set_bool(obj, true, "realized", &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
--=20
2.23.0


