Received: from eggs.gnu.org ([2001:4830:134:3::10]:37444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eMUt3-0005cq-BA
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 03:17:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eMUt0-0005t2-7X
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 03:17:01 -0500
Received: from 9.mo177.mail-out.ovh.net ([46.105.72.238]:60282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eMUt0-0005sk-1U
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 03:16:58 -0500
Received: from player779.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id A7E7090221
	for <qemu-devel@nongnu.org>; Wed,  6 Dec 2017 09:16:56 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 06 Dec 2017 09:16:52 +0100
Message-ID: <151254821213.27903.10774600450833875601.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] spapr_events: drop bogus cell from
 "interrupt-ranges" property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Cedric Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

According to LoPAPR 1.1 B.6.12, the "/event-sources" node has an "interru=
pt-
ranges" property, the format of which is described in B.6.9.1.2 as follow=
s:

=E2=80=9Cinterrupt-ranges=E2=80=9D
 Standard property name that defines the interrupt number(s) and range(s)
 handled by this unit.

 prop-encoded-array: List of (int-number, range) specifications.

 Int-number is encoded as with encode-int.
 Range is encoded as with encode-int.

 The first entry in this list shall contain the int-number associated wit=
h
 the first =E2=80=9Creg=E2=80=9D property entry. The int-num-ber is the v=
alue representing
 the interrupt source as would appear in the PowerPC External Interrupt
 Architecture XISR. The range shall be the number of sequential interrupt
 numbers which this unit can generate.

There's no such thing as a cell count at the end of the array, like the
one introduced by commit ffbb1705a33d in QEMU 2.8. It doesn't seem it had
any impact on existing guests and I couldn't find any related workaround
in linux. So, let's just drop the bogus lines.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_events.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index c7a64e6b8dd3..86836f0626dc 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -292,9 +292,6 @@ void spapr_dt_events(sPAPRMachineState *spapr, void *=
fdt)
         irq_ranges[count++] =3D cpu_to_be32(1);
     }
=20
-    irq_ranges[count] =3D cpu_to_be32(count);
-    count++;
-
     _FDT((fdt_setprop(fdt, event_sources, "interrupt-controller", NULL, =
0)));
     _FDT((fdt_setprop_cell(fdt, event_sources, "#interrupt-cells", 2)));
     _FDT((fdt_setprop(fdt, event_sources, "interrupt-ranges",
