Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87619C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 17:41:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 601552076A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 17:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 601552076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwUMa-0003Ga-JQ
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 13:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jwULP-0002dx-14
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 13:40:23 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48919
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jwULN-0001sz-Ic
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 13:40:22 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-sq4Ls5n3MhS_HQk96JGEcg-1; Fri, 17 Jul 2020 13:40:08 -0400
X-MC-Unique: sq4Ls5n3MhS_HQk96JGEcg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F1B1108E;
 Fri, 17 Jul 2020 17:40:07 +0000 (UTC)
Received: from bahia.lan (ovpn-113-187.ams2.redhat.com [10.36.113.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9D8FB619C4;
 Fri, 17 Jul 2020 17:40:06 +0000 (UTC)
Subject: [PATCH for-5.2] spapr: Simplify error handling in spapr_phb_realize()
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 17 Jul 2020 19:40:05 +0200
Message-ID: <159500760539.383731.10928308889360009122.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=207.211.31.81; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 05:27:47
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
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
---

Since we add ERRP_GUARD(), we could theoretically check *errp
rather than the return value, and thus avoid the uint32_t to
int32_t change but I personally find it clearer the other way.
---
 hw/ppc/spapr_pci.c |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 21681215d405..b1ce51327db4 100644
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
+        int32_t irq =3D SPAPR_IRQ_PCI_LSI + sphb->index * PCI_NUM_PINS + i=
;
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



