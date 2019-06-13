Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9FAC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 21:49:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEE5420B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 21:49:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEE5420B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45924 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbXbL-0004sT-1Q
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 17:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51730)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hbXMo-0000RH-7j
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 17:34:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hbXMl-0003GE-DE
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 17:34:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54280)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hbXMl-00036R-3M; Thu, 13 Jun 2019 17:34:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 49F8B30A6986;
 Thu, 13 Jun 2019 21:34:18 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-48.brq.redhat.com [10.40.204.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D65AE5D9C5;
 Thu, 13 Jun 2019 21:34:09 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 23:34:06 +0200
Message-Id: <20190613213406.22053-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 13 Jun 2019 21:34:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2] spapr_pci: Fix potential NULL pointer
 dereference in spapr_dt_pci_bus()
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Greg Kurz <groug@kaod.org>,
 qemu-ppc@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 14e714900f6 refactored the call to spapr_dt_drc(),
introducing a potential NULL pointer dereference while
accessing bus->parent_dev.
A trivial audit show 'bus' is not null in the two places
the static function spapr_dt_drc() is called.

Since the 'bus' parameter is not NULL in both callers, remove
remove the test on if (bus), and add an assert() to silent
static analyzers.

This fixes:

  /hw/ppc/spapr_pci.c: 1367 in spapr_dt_pci_bus()
  >>>     CID 1401933:  Null pointer dereferences  (FORWARD_NULL)
  >>>     Dereferencing null pointer "bus".
  1367         ret =3D spapr_dt_drc(fdt, offset, OBJECT(bus->parent_dev),
  1368                            SPAPR_DR_CONNECTOR_TYPE_PCI);

Fixes: 14e714900f6
Reported-by: Coverity (CID 1401933)
Suggested-by: Greg Kurz <groug@kaod.org>
Suggested-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/ppc/spapr_pci.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 957ae88bbd..fbeb1c90ee 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1356,12 +1356,11 @@ static int spapr_dt_pci_bus(SpaprPhbState *sphb, =
PCIBus *bus,
     _FDT(fdt_setprop_cell(fdt, offset, "#size-cells",
                           RESOURCE_CELLS_SIZE));
=20
-    if (bus) {
-        pci_for_each_device_reverse(bus, pci_bus_num(bus),
-                                    spapr_dt_pci_device_cb, &cbinfo);
-        if (cbinfo.err) {
-            return cbinfo.err;
-        }
+    assert(bus);
+    pci_for_each_device_reverse(bus, pci_bus_num(bus),
+                                spapr_dt_pci_device_cb, &cbinfo);
+    if (cbinfo.err) {
+        return cbinfo.err;
     }
=20
     ret =3D spapr_dt_drc(fdt, offset, OBJECT(bus->parent_dev),
--=20
2.20.1


