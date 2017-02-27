Received: from eggs.gnu.org ([2001:4830:134:3::10]:37635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ciMJM-0000SS-Df
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:30:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ciMJI-00077L-Fc
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:30:00 -0500
Received: from 13.mo6.mail-out.ovh.net ([188.165.56.124]:51691)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ciMJI-00076e-9y
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:29:56 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id C5B88B0611
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 15:29:54 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 27 Feb 2017 15:29:09 +0100
Message-Id: <1488205773-30436-3-git-send-email-clg@kaod.org>
In-Reply-To: <1488205773-30436-1-git-send-email-clg@kaod.org>
References: <1488205773-30436-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 02/26] ppc/xics: fix ICP and ICS reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

commit 5b17c7207938 ("xics: XICS should not be a SysBusDevice")
changed the nature of the XICS object to be a descendent of
TYPE_DEVICE. By doing so, the object is not on a bus and its reset
handler is not called anymore. The direct consequence is that the ICP
and ICS objects are not correctly initialized and so the IRQ subsystem
is broken in the guest.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c        | 1 +
 include/hw/ppc/xics.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ceefbb57d0ac..3c79068075e4 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -104,6 +104,7 @@ static XICSState *try_create_xics(const char *type, i=
nt nr_servers,
     dev =3D DEVICE(object_new(type));
     qdev_prop_set_uint32(dev, "nr_servers", nr_servers);
     qdev_prop_set_uint32(dev, "nr_irqs", nr_irqs);
+    qdev_set_parent_bus(dev, sysbus_get_default());
     object_property_set_bool(OBJECT(dev), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 3f0c31610aa4..1aefd3d52257 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -80,7 +80,7 @@ struct XICSStateClass {
=20
 struct XICSState {
     /*< private >*/
-    SysBusDevice parent_obj;
+    DeviceState parent_obj;
     /*< public >*/
     uint32_t nr_servers;
     uint32_t nr_irqs;
--=20
2.7.4
