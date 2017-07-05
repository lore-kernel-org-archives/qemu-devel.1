Received: from eggs.gnu.org ([2001:4830:134:3::10]:41306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSnt2-0003e2-LI
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:14:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSnt1-0002wf-P7
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:14:48 -0400
Received: from 11.mo3.mail-out.ovh.net ([87.98.184.158]:50755)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dSnt1-0002w3-IV
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:14:47 -0400
Received: from player158.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 8A0E3FCC7D
	for <qemu-devel@nongnu.org>; Wed,  5 Jul 2017 19:14:46 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  5 Jul 2017 19:13:21 +0200
Message-Id: <1499274819-15607-9-git-send-email-clg@kaod.org>
In-Reply-To: <1499274819-15607-1-git-send-email-clg@kaod.org>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 08/26] ppc/xive: add flags to the XIVE
 interrupt source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

These flags define some characteristics of the source :

 - XIVE_SRC_H_INT_ESB  the Event State Buffer are controlled with a
                       specific hcall H_INT_ESB
 - XIVE_SRC_LSI        LSI or MSI source
 - XIVE_SRC_TRIGGER    the full function page supports trigger
 - XIVE_SRC_STORE_EOI  EOI can with a store.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xive.c        | 1 +
 include/hw/ppc/xive.h | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 816031b8ac81..8f8bb8b787bd 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -345,6 +345,7 @@ static Property xive_ics_properties[] =3D {
     DEFINE_PROP_UINT32("nr-irqs", ICSState, nr_irqs, 0),
     DEFINE_PROP_UINT32("irq-base", ICSState, offset, 0),
     DEFINE_PROP_UINT32("shift", XiveICSState, esb_shift, 0),
+    DEFINE_PROP_UINT64("flags", XiveICSState, flags, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 5303d96f5f59..1178300c9df3 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -30,9 +30,18 @@ typedef struct XiveICSState XiveICSState;
 #define TYPE_ICS_XIVE "xive-source"
 #define ICS_XIVE(obj) OBJECT_CHECK(XiveICSState, (obj), TYPE_ICS_XIVE)
=20
+/*
+ * XIVE Interrupt source flags
+ */
+#define XIVE_SRC_H_INT_ESB     (1ull << (63 - 60))
+#define XIVE_SRC_LSI           (1ull << (63 - 61))
+#define XIVE_SRC_TRIGGER       (1ull << (63 - 62))
+#define XIVE_SRC_STORE_EOI     (1ull << (63 - 63))
+
 struct XiveICSState {
     ICSState parent_obj;
=20
+    uint64_t     flags;
     uint32_t     esb_shift;
     MemoryRegion esb_iomem;
=20
--=20
2.7.5
