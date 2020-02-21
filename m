Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB81DC11D24
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 03:47:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B496B2071E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 03:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="p1NFPDHn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B496B2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4zHj-0002Gy-SC
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 22:47:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j4z87-0002Tj-Qw
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 22:37:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j4z86-0000I2-HO
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 22:37:31 -0500
Received: from ozlabs.org ([203.11.71.1]:57011)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j4z86-0008N7-2C; Thu, 20 Feb 2020 22:37:30 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48NxwK247Vz9sSm; Fri, 21 Feb 2020 14:37:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582256225;
 bh=ZWlfxuDNu4capZMYHkoGfmpDSiGt/RmLDnFclqC5olk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=p1NFPDHnN2QOmvecf4CqeVgYsx5OnN8iuHDCL7se/EhbLoPV0S+GWcdMdExBl9KkN
 CWpSIK+5FWksutB4UzZC5RiSjOFOXBNuyyPGZ7bpUO0oV3TRDXIw4s0zzGtXmrDhUH
 I+7LIB1ioZmhZplo8OhVwgYbhfPd9dsIfk4jmtTM=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 18/20] spapr: Don't use spapr_drc_needed() in CAS code
Date: Fri, 21 Feb 2020 14:36:48 +1100
Message-Id: <20200221033650.444386-19-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200221033650.444386-1-david@gibson.dropbear.id.au>
References: <20200221033650.444386-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
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

We currently don't support hotplug of devices between boot and CAS. If
this happens a CAS reboot is triggered. We detect this during CAS using
the spapr_drc_needed() function which is essentially a VMStateDescription
.needed callback. Even if the condition for CAS reboot happens to be the
same as for DRC migration, it looks wrong to piggyback a migration helper
for this.

Introduce a helper with slightly more explicit name and use it in both CA=
S
and DRC migration code. Since a subsequent patch will enhance this helper
to cover the case of hot unplug, let's go for spapr_drc_transient(). Whil=
e
here convert spapr_hotplugged_dev_before_cas() to the "transient" wording=
 as
well.

This doesn't change any behaviour.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <158169248180.3465937.9531405453362718771.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_drc.c         | 20 ++++++++++++++------
 hw/ppc/spapr_hcall.c       | 14 +++++++++-----
 include/hw/ppc/spapr_drc.h |  4 +++-
 3 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index fc62e04901..4c35ce7c5c 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -456,23 +456,31 @@ void spapr_drc_reset(SpaprDrc *drc)
     }
 }
=20
-bool spapr_drc_needed(void *opaque)
+bool spapr_drc_transient(SpaprDrc *drc)
 {
-    SpaprDrc *drc =3D (SpaprDrc *)opaque;
     SpaprDrcClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
=20
-    /* If no dev is plugged in there is no need to migrate the DRC state=
 */
+    /*
+     * If no dev is plugged in there is no need to migrate the DRC state
+     * nor to reset the DRC at CAS.
+     */
     if (!drc->dev) {
         return false;
     }
=20
     /*
-     * We need to migrate the state if it's not equal to the expected
-     * long-term state, which is the same as the coldplugged initial
-     * state */
+     * We need to reset the DRC at CAS or to migrate the DRC state if it=
's
+     * not equal to the expected long-term state, which is the same as t=
he
+     * coldplugged initial state.
+     */
     return (drc->state !=3D drck->ready_state);
 }
=20
+static bool spapr_drc_needed(void *opaque)
+{
+    return spapr_drc_transient(opaque);
+}
+
 static const VMStateDescription vmstate_spapr_drc =3D {
     .name =3D "spapr_drc",
     .version_id =3D 1,
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index b8bb66b5c0..6db3dbde9c 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1640,20 +1640,24 @@ static uint32_t cas_check_pvr(SpaprMachineState *=
spapr, PowerPCCPU *cpu,
     return best_compat;
 }
=20
-static bool spapr_hotplugged_dev_before_cas(void)
+static bool spapr_transient_dev_before_cas(void)
 {
-    Object *drc_container, *obj;
+    Object *drc_container;
     ObjectProperty *prop;
     ObjectPropertyIterator iter;
=20
     drc_container =3D container_get(object_get_root(), "/dr-connector");
     object_property_iter_init(&iter, drc_container);
     while ((prop =3D object_property_iter_next(&iter))) {
+        SpaprDrc *drc;
+
         if (!strstart(prop->type, "link<", NULL)) {
             continue;
         }
-        obj =3D object_property_get_link(drc_container, prop->name, NULL=
);
-        if (spapr_drc_needed(obj)) {
+        drc =3D SPAPR_DR_CONNECTOR(object_property_get_link(drc_containe=
r,
+                                                          prop->name, NU=
LL));
+
+        if (spapr_drc_transient(drc)) {
             return true;
         }
     }
@@ -1830,7 +1834,7 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
=20
     spapr_irq_update_active_intc(spapr);
=20
-    if (spapr_hotplugged_dev_before_cas()) {
+    if (spapr_transient_dev_before_cas()) {
         spapr->cas_reboot =3D true;
     }
=20
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index df3d958a66..21af8deac1 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -278,7 +278,9 @@ int spapr_dt_drc(void *fdt, int offset, Object *owner=
, uint32_t drc_type_mask);
=20
 void spapr_drc_attach(SpaprDrc *drc, DeviceState *d, Error **errp);
 void spapr_drc_detach(SpaprDrc *drc);
-bool spapr_drc_needed(void *opaque);
+
+/* Returns true if a hot plug/unplug request is pending */
+bool spapr_drc_transient(SpaprDrc *drc);
=20
 static inline bool spapr_drc_unplug_requested(SpaprDrc *drc)
 {
--=20
2.24.1


