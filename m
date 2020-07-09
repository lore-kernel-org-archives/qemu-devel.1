Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B323C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 17:13:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0105F2077D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 17:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0105F2077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jta7R-00071b-9J
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 13:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jta6c-000601-QL
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 13:13:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52403
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jta6a-0003Nr-Pm
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 13:13:06 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-F5zskHOVOiC5Ca40pSp7Fw-1; Thu, 09 Jul 2020 13:12:59 -0400
X-MC-Unique: F5zskHOVOiC5Ca40pSp7Fw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 074CF107ACCA;
 Thu,  9 Jul 2020 17:12:58 +0000 (UTC)
Received: from bahia.lan (ovpn-112-37.ams2.redhat.com [10.36.112.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5B0F119D61;
 Thu,  9 Jul 2020 17:12:48 +0000 (UTC)
Subject: [PATCH] spapr_pci: Robustify support of PCI bridges
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 09 Jul 2020 19:12:47 +0200
Message-ID: <159431476748.407044.16711294833569014964.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=207.211.31.120; envelope-from=groug@kaod.org;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 11:02:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=ham autolearn_force=no
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
Cc: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some recent error handling cleanups unveiled issues with our support of
PCI bridges:

1) QEMU aborts when using non-standard PCI bridge types,
   unveiled by commit 7ef1553dac "spapr_pci: Drop some dead error handling"

$ qemu-system-ppc64 -M pseries -device pcie-pci-bridge
Unexpected error in object_property_find() at qom/object.c:1240:
qemu-system-ppc64: -device pcie-pci-bridge: Property '.chassis_nr' not foun=
d
Aborted (core dumped)

This happens because we assume all PCI bridge types to have a "chassis_nr"
property. This property only exists with the standard PCI bridge type
"pci-bridge" actually. We could possibly revert 7ef1553dac but it seems
much simpler to check the presence of "chassis_nr" earlier.

2) QEMU abort if same "chassis_nr" value is used several times,
   unveiled by commit d2623129a7de "qom: Drop parameter @errp of
   object_property_add() & friends"

$ qemu-system-ppc64 -M pseries -device pci-bridge,chassis_nr=3D1 \
                        -device pci-bridge,chassis_nr=3D1
Unexpected error in object_property_try_add() at qom/object.c:1167:
qemu-system-ppc64: -device pci-bridge,chassis_nr=3D1: attempt to add duplic=
ate property '40000100' to object (type 'container')
Aborted (core dumped)

This happens because we assume that "chassis_nr" values are unique, but
nobody enforces that and we end up generating duplicate DRC ids. The PCI
code doesn't really care for duplicate "chassis_nr" properties since it
is only used to initialize the "Chassis Number Register" of the bridge,
with no functional impact on QEMU. So, even if passing the same value
several times might look weird, it never broke anything before, so
I guess we don't necessarily want to enforce strict checking in the PCI
code now.

Workaround both issues in the PAPR code: check that the bridge has a
unique and non null "chassis_nr" when plugging it into its parent bus.

Fixes: 05929a6c5dfe ("spapr: Don't use bus number for building DRC ids")
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_pci.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 57 insertions(+)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 329002ac040e..09d52ef7954d 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1480,6 +1480,57 @@ static void spapr_pci_bridge_plug(SpaprPhbState *phb=
,
     add_drcs(phb, bus);
 }
=20
+/* Returns non-zero if the value of "chassis_nr" is already in use */
+static int check_chassis_nr(Object *obj, void *opaque)
+{
+    int new_chassis_nr =3D
+        object_property_get_uint(opaque, "chassis_nr", &error_abort);
+    int chassis_nr =3D
+        object_property_get_uint(obj, "chassis_nr", NULL);
+
+    if (!object_dynamic_cast(obj, TYPE_PCI_BRIDGE)) {
+        return 0;
+    }
+
+    /* Skip unsupported bridge types */
+    if (!chassis_nr) {
+        return 0;
+    }
+
+    /* Skip self */
+    if (obj =3D=3D opaque) {
+        return 0;
+    }
+
+    return chassis_nr =3D=3D new_chassis_nr;
+}
+
+static bool bridge_has_valid_chassis_nr(Object *bridge, Error **errp)
+{
+    int chassis_nr =3D
+        object_property_get_uint(bridge, "chassis_nr", NULL);
+
+    /*
+     * slotid_cap_init() already ensures that "chassis_nr" isn't null for
+     * standard PCI bridges, so this really tells if "chassis_nr" is prese=
nt
+     * or not.
+     */
+    if (!chassis_nr) {
+        error_setg(errp, "PCI Bridge lacks a \"chassis_nr\" property");
+        error_append_hint(errp, "Try -device pci-bridge instead.\n");
+        return false;
+    }
+
+    /* We want unique values for "chassis_nr" */
+    if (object_child_foreach_recursive(object_get_root(), check_chassis_nr=
,
+                                       bridge)) {
+        error_setg(errp, "Bridge chassis %d already in use", chassis_nr);
+        return false;
+    }
+
+    return true;
+}
+
 static void spapr_pci_plug(HotplugHandler *plug_handler,
                            DeviceState *plugged_dev, Error **errp)
 {
@@ -1491,6 +1542,12 @@ static void spapr_pci_plug(HotplugHandler *plug_hand=
ler,
     PCIBus *bus =3D PCI_BUS(qdev_get_parent_bus(DEVICE(pdev)));
     uint32_t slotnr =3D PCI_SLOT(pdev->devfn);
=20
+    if (pc->is_bridge) {
+        if (!bridge_has_valid_chassis_nr(OBJECT(plugged_dev), errp)) {
+            return;
+        }
+    }
+
     /* if DR is disabled we don't need to do anything in the case of
      * hotplug or coldplug callbacks
      */



