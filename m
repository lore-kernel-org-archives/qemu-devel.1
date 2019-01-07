Received: from eggs.gnu.org ([209.51.188.92]:43978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ggZq8-0003Xu-TE
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:41:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ggZq7-0004Ic-KT
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:41:32 -0500
Received: from 9.mo173.mail-out.ovh.net ([46.105.72.44]:60154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ggZq5-00044A-25
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:41:30 -0500
Received: from player687.ha.ovh.net (unknown [10.109.146.5])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 8BD66E4E2D
	for <qemu-devel@nongnu.org>; Mon,  7 Jan 2019 19:41:25 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon,  7 Jan 2019 19:39:45 +0100
Message-Id: <20190107183946.7230-13-clg@kaod.org>
In-Reply-To: <20190107183946.7230-1-clg@kaod.org>
References: <20190107183946.7230-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 12/13] spapr/xics: ignore the lower 4K in the
 IRQ number space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The IRQ number space of the XIVE and XICS interrupt mode are aligned
when using the dual interrupt mode for the machine. This means that
the ICS offset is set to zero in QEMU and that the KVM XICS device
should be informed of this new value. Unfortunately, there is now way
to do so and KVM still maintains the XICS_IRQ_BASE (0x1000) offset.

Ignore the lower 4K which are not used under the XICS interrupt
mode. These IRQ numbers are only claimed by XIVE for the CPU IPIs.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics_kvm.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 651bbfdf6966..1d21ff217b82 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -238,6 +238,15 @@ static void ics_get_kvm_state(ICSState *ics)
     for (i =3D 0; i < ics->nr_irqs; i++) {
         ICSIRQState *irq =3D &ics->irqs[i];
=20
+        /*
+         * The KVM XICS device considers that the IRQ numbers should
+         * start at XICS_IRQ_BASE (0x1000). Ignore the lower 4K
+         * numbers (only claimed by XIVE for the CPU IPIs).
+         */
+        if (i + ics->offset < XICS_IRQ_BASE) {
+            continue;
+        }
+
         kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURCES,
                           i + ics->offset, &state, false, &error_fatal);
=20
@@ -303,6 +312,15 @@ static int ics_set_kvm_state(ICSState *ics, int vers=
ion_id)
         ICSIRQState *irq =3D &ics->irqs[i];
         int ret;
=20
+        /*
+         * The KVM XICS device considers that the IRQ numbers should
+         * start at XICS_IRQ_BASE (0x1000). Ignore the lower 4K
+         * numbers (only claimed by XIVE for the CPU IPIs).
+         */
+        if (i + ics->offset < XICS_IRQ_BASE) {
+            continue;
+        }
+
         state =3D irq->server;
         state |=3D (uint64_t)(irq->saved_priority & KVM_XICS_PRIORITY_MA=
SK)
             << KVM_XICS_PRIORITY_SHIFT;
--=20
2.20.1
