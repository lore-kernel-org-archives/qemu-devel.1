Received: from eggs.gnu.org ([2001:4830:134:3::10]:53310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePixP-0003i0-Ip
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 00:54:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePixO-0004k5-7v
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 00:54:51 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 15 Dec 2017 16:54:31 +1100
Message-Id: <20171215055435.24204-21-david@gibson.dropbear.id.au>
In-Reply-To: <20171215055435.24204-1-david@gibson.dropbear.id.au>
References: <20171215055435.24204-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 20/24] spapr_events: drop bogus cell from
 "interrupt-ranges" property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, mdroth@linux.vnet.ibm.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

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
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_events.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index c7a64e6b8d..86836f0626 100644
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
--=20
2.14.3
