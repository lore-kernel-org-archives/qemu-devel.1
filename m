Received: from eggs.gnu.org ([209.51.188.92]:38962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa9e-0001Li-2Q
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:03:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa9N-0000Hp-Lw
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:02:55 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  4 Feb 2019 20:01:21 +1100
Message-Id: <20190204090124.26191-35-david@gibson.dropbear.id.au>
In-Reply-To: <20190204090124.26191-1-david@gibson.dropbear.id.au>
References: <20190204090124.26191-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 34/37] spapr_pci: Fix endianness in
 assigned-addresses property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, lvivier@redhat.com, spopovyc@redhat.com, Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

reg->phys_hi and assigned->phys_hi are big endian but we do an extra
byteswap anyway when copying reg->phys_hi to assigned->phys_hi.
To make things slightly more messy, we also add a relocatable bit (b_n())
although in the right endianness.

This fixes endianness of assigned->phys_hi.

This is unlikely to produce any visible difference though as we should en=
d up
there only in the case of PCI hotplug and even then I am not sure if
(d->io_regions[i].addr =3D=3D PCI_BAR_UNMAPPED) =3D=3D true.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 5cdc98513d..c99721cde8 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -964,7 +964,7 @@ static void populate_resource_props(PCIDevice *d, Res=
ourceProps *rp)
         }
=20
         assigned =3D &rp->assigned[assigned_idx++];
-        assigned->phys_hi =3D cpu_to_be32(reg->phys_hi | b_n(1));
+        assigned->phys_hi =3D cpu_to_be32(be32_to_cpu(reg->phys_hi) | b_=
n(1));
         assigned->phys_mid =3D cpu_to_be32(d->io_regions[i].addr >> 32);
         assigned->phys_lo =3D cpu_to_be32(d->io_regions[i].addr);
         assigned->size_hi =3D reg->size_hi;
--=20
2.20.1
