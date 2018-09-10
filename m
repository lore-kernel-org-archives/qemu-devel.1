Received: from eggs.gnu.org ([2001:4830:134:3::10]:55614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fzNie-0006qr-S0
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 11:03:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fzNiZ-0001ai-NT
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 11:03:16 -0400
Received: from 4.mo179.mail-out.ovh.net ([46.105.36.149]:38534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fzNiX-0001Sy-Qx
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 11:03:11 -0400
Received: from player772.ha.ovh.net (unknown [10.109.143.3])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 1FEF6F7B30
	for <qemu-devel@nongnu.org>; Mon, 10 Sep 2018 17:03:01 +0200 (CEST)
Date: Mon, 10 Sep 2018 17:02:53 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180910170253.50f4cd88@bahia.lan>
In-Reply-To: <20180910110222.8162-1-clg@kaod.org>
References: <20180910110222.8162-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] spapr: introduce a new sPAPRIrq backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Mon, 10 Sep 2018 13:02:19 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> Hello,
>=20
> This series adds a new sPAPRIrq backend increasing the number of
> available IRQ numbers in pseries-3.1 machines. This change is an
> opportunity to also fix the "ibm,pe-total-#msi" and remove the old
> XICS_IRQS_SPAPR definition.
>=20

This cleanup looks sane but I still have a concern with the semantics of
"ibm,pe-total-#msi".

According to LoPAPR:

"ibm,pe-total-#msi"

property name defines the maximum number of Message Signaled Interrupts (MS=
I plus MSI-X) that are available
to the PE below this device tree node. This number only indicates the numbe=
r of available interrupts, not the num-
ber assigned. The number assigned for an IOA may be obtained by Function 0 =
(Query only) of the ibm,change-msi
RTAS call.
prop-encoded-array: Maximum number of interrupts encoded as with encode-int.

IIUC, the PHB is given ibm,pe-total-#msi MSIs that it can assign to devices.

But we currently have only one global allocator in the machine, so having
each PHB advertising the full range of the allocator still looks weird.

Shouldn't this be divided by the number of PHBs ? Or should we have one
separate allocator for each PHB ?

> Thanks,
>=20
> C.
>=20
> C=C3=A9dric Le Goater (3):
>   spapr: introduce a spapr_irq class 'nr_msis' attribute
>   spapr: increase the size of the IRQ number space
>   spapr_pci: fix "ibm,pe-total-#msi" value
>=20
>  include/hw/ppc/spapr_irq.h |  2 ++
>  include/hw/ppc/xics.h      |  2 --
>  hw/ppc/spapr.c             |  1 +
>  hw/ppc/spapr_irq.c         | 22 ++++++++++++++++++++--
>  hw/ppc/spapr_pci.c         |  5 +++--
>  5 files changed, 26 insertions(+), 6 deletions(-)
>=20
