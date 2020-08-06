Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE37C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 16:57:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 098702086A
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 16:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 098702086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3jD3-000320-Nq
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 12:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k3jC9-0001Ld-VV
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 12:56:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52506
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k3jC8-00079D-2z
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 12:56:45 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-ZytX8LsQMHOVkxGryd5kbQ-1; Thu, 06 Aug 2020 12:56:37 -0400
X-MC-Unique: ZytX8LsQMHOVkxGryd5kbQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6024C58;
 Thu,  6 Aug 2020 16:56:36 +0000 (UTC)
Received: from bahia.lan (ovpn-112-38.ams2.redhat.com [10.36.112.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6401887A61;
 Thu,  6 Aug 2020 16:56:35 +0000 (UTC)
Subject: [PATCH v2 for-5.2 5/5] spapr: Simplify error handling in
 spapr_phb_realize()
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 06 Aug 2020 18:56:34 +0200
Message-ID: <159673299447.766512.1951478231673831450.stgit@bahia.lan>
In-Reply-To: <159673295739.766512.2950380687630225803.stgit@bahia.lan>
References: <159673295739.766512.2950380687630225803.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=207.211.31.81; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 05:03:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Daniel Henrique Barboza <danielhb@linux.ibm.com>, qemu-ppc@nongnu.org,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The spapr_phb_realize() function has a local_err variable which
is used to:

1) check failures of spapr_irq_findone() and spapr_irq_claim()

2) prepend extra information to the error message

Recent work from Markus Armbruster highlighted we get better
code when testing the return value of a function, rather than
setting up all the local_err boiler plate. For similar reasons,
it is now preferred to use ERRP_GUARD() and error_prepend()
rather than error_propagate_prepend().

Since spapr_irq_findone() and spapr_irq_claim() return negative
values in case of failure, do both changes.

This is just cleanup, no functional impact.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 363cdb3f7b8d..0a418f1e6711 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1796,6 +1796,7 @@ static void spapr_phb_destroy_msi(gpointer opaque)
=20
 static void spapr_phb_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_GUARD();
     /* We don't use SPAPR_MACHINE() in order to exit gracefully if the use=
r
      * tries to add a sPAPR PHB to a non-pseries machine.
      */
@@ -1813,7 +1814,6 @@ static void spapr_phb_realize(DeviceState *dev, Error=
 **errp)
     uint64_t msi_window_size =3D 4096;
     SpaprTceTable *tcet;
     const unsigned windows_supported =3D spapr_phb_windows_supported(sphb)=
;
-    Error *local_err =3D NULL;
=20
     if (!spapr) {
         error_setg(errp, TYPE_SPAPR_PCI_HOST_BRIDGE " needs a pseries mach=
ine");
@@ -1964,13 +1964,12 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
=20
     /* Initialize the LSI table */
     for (i =3D 0; i < PCI_NUM_PINS; i++) {
-        uint32_t irq =3D SPAPR_IRQ_PCI_LSI + sphb->index * PCI_NUM_PINS + =
i;
+        int irq =3D SPAPR_IRQ_PCI_LSI + sphb->index * PCI_NUM_PINS + i;
=20
         if (smc->legacy_irq_allocation) {
-            irq =3D spapr_irq_findone(spapr, &local_err);
-            if (local_err) {
-                error_propagate_prepend(errp, local_err,
-                                        "can't allocate LSIs: ");
+            irq =3D spapr_irq_findone(spapr, errp);
+            if (irq < 0) {
+                error_prepend(errp, "can't allocate LSIs: ");
                 /*
                  * Older machines will never support PHB hotplug, ie, this=
 is an
                  * init only path and QEMU will terminate. No need to roll=
back.
@@ -1979,9 +1978,8 @@ static void spapr_phb_realize(DeviceState *dev, Error=
 **errp)
             }
         }
=20
-        spapr_irq_claim(spapr, irq, true, &local_err);
-        if (local_err) {
-            error_propagate_prepend(errp, local_err, "can't allocate LSIs:=
 ");
+        if (spapr_irq_claim(spapr, irq, true, errp) < 0) {
+            error_prepend(errp, "can't allocate LSIs: ");
             goto unrealize;
         }
=20



