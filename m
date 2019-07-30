Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27C5C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 09:38:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C51A520679
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 09:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C51A520679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsOak-00050q-59
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 05:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34689)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hsOZU-0002Wr-VK
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 05:37:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hsOZU-0005nH-1D
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 05:37:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:30748)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hsOZT-0005mm-Ps
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 05:37:27 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2869F636C
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 09:37:27 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-45.ams2.redhat.com
 [10.36.117.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2207919C65;
 Tue, 30 Jul 2019 09:37:25 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com,
	ehabkost@redhat.com
Date: Tue, 30 Jul 2019 10:37:18 +0100
Message-Id: <20190730093719.12958-2-dgilbert@redhat.com>
In-Reply-To: <20190730093719.12958-1-dgilbert@redhat.com>
References: <20190730093719.12958-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Tue, 30 Jul 2019 09:37:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/2] pcie_root_port: Allow ACS to be disabled
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
Cc: quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

ACS was added in 4.0 unconditionally, this breaks migration
compatibility.
Allow ACS to be disabled by adding a property that's
checked by pcie_root_port.

Unfortunately pcie-root-port doesn't have any instance data,
so there's no where for that flag to live, so stuff it into
PCIESlot.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/pci-bridge/pcie_root_port.c | 3 ++-
 include/hw/pci/pcie_port.h     | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_por=
t.c
index 09019ca05d..1d8a778709 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -111,7 +111,7 @@ static void rp_realize(PCIDevice *d, Error **errp)
     pcie_aer_root_init(d);
     rp_aer_vector_update(d);
=20
-    if (rpc->acs_offset) {
+    if (rpc->acs_offset && !s->disable_acs) {
         pcie_acs_init(d, rpc->acs_offset);
     }
     return;
@@ -145,6 +145,7 @@ static void rp_exit(PCIDevice *d)
 static Property rp_props[] =3D {
     DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
                     QEMU_PCIE_SLTCAP_PCP_BITNR, true),
+    DEFINE_PROP_BOOL("disable-acs", PCIESlot, disable_acs, false),
     DEFINE_PROP_END_OF_LIST()
 };
=20
diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
index 09586f4641..7515430087 100644
--- a/include/hw/pci/pcie_port.h
+++ b/include/hw/pci/pcie_port.h
@@ -53,6 +53,8 @@ struct PCIESlot {
     PCIExpLinkSpeed speed;
     PCIExpLinkWidth width;
=20
+    /* Disable ACS (really for a pcie_root_port) */
+    bool        disable_acs;
     QLIST_ENTRY(PCIESlot) next;
 };
=20
--=20
2.21.0


