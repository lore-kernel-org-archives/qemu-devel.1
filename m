Received: from eggs.gnu.org ([2001:4830:134:3::10]:55412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fXNdH-0006pd-66
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 05:18:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fXNdC-0001sn-Dw
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 05:17:59 -0400
Received: from 6.mo179.mail-out.ovh.net ([46.105.56.76]:35381)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fXNdC-0001qw-74
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 05:17:54 -0400
Received: from player789.ha.ovh.net (unknown [10.109.122.15])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 9F7C9D4C70
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 11:17:52 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 25 Jun 2018 11:17:18 +0200
Message-Id: <20180625091718.18544-6-clg@kaod.org>
In-Reply-To: <20180625091718.18544-1-clg@kaod.org>
References: <20180625091718.18544-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 5/5] ppc/xics: rework the ICS classes
 inheritance tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

With the previous changes, we can now let the ICS_KVM class inherit
directly from ICS_BASE class and not from the intermediate ICS_SIMPLE.
It makes the class hierarchy much cleaner.

What is left in the top classes is the low level interface to access
the KVM XICS device in ICS_KVM and the XICS emulating handlers in
ICS_SIMPLE.

This should not break migration compatibility.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics_kvm.c | 12 +++++-------
 hw/ppc/spapr.c     |  2 +-
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index b314eb7d1607..30c3769a2084 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -359,12 +359,10 @@ static void ics_kvm_class_init(ObjectClass *klass, =
void *data)
     ICSStateClass *icsc =3D ICS_BASE_CLASS(klass);
     DeviceClass *dc =3D DEVICE_CLASS(klass);
=20
-    /*
-     * Use device_class_set_parent_realize() when ics-kvm inherits
-     * directly from ics-base and not from ics-simple anymore.
-     */
-    dc->realize =3D ics_kvm_realize;
-    dc->reset =3D ics_kvm_reset;
+    device_class_set_parent_realize(dc, ics_kvm_realize,
+                                    &icsc->parent_realize);
+    device_class_set_parent_reset(dc, ics_kvm_reset,
+                                  &icsc->parent_reset);
=20
     icsc->pre_save =3D ics_get_kvm_state;
     icsc->post_load =3D ics_set_kvm_state;
@@ -373,7 +371,7 @@ static void ics_kvm_class_init(ObjectClass *klass, vo=
id *data)
=20
 static const TypeInfo ics_kvm_info =3D {
     .name =3D TYPE_ICS_KVM,
-    .parent =3D TYPE_ICS_SIMPLE,
+    .parent =3D TYPE_ICS_BASE,
     .instance_size =3D sizeof(ICSState),
     .class_init =3D ics_kvm_class_init,
 };
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0d032a1ad03c..8cc996d0b822 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -137,7 +137,7 @@ static ICSState *spapr_ics_create(sPAPRMachineState *=
spapr,
         goto error;
     }
=20
-    return ICS_SIMPLE(obj);
+    return ICS_BASE(obj);
=20
 error:
     error_propagate(errp, local_err);
--=20
2.13.6
