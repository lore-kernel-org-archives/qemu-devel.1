Received: from eggs.gnu.org ([2001:4830:134:3::10]:47531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fzPvp-0005o4-DF
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 13:25:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fzPvj-00048H-To
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 13:25:01 -0400
Received: from 9.mo69.mail-out.ovh.net ([46.105.56.78]:54668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fzPvj-00046m-Ie
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 13:24:55 -0400
Received: from player697.ha.ovh.net (unknown [10.109.146.76])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id F2C9627436
	for <qemu-devel@nongnu.org>; Mon, 10 Sep 2018 19:24:53 +0200 (CEST)
References: <20180910110222.8162-1-clg@kaod.org>
	<20180910170253.50f4cd88@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <90b8c81e-bd7b-8516-7e27-69d77ba59b72@kaod.org>
Date: Mon, 10 Sep 2018 19:24:47 +0200
MIME-Version: 1.0
In-Reply-To: <20180910170253.50f4cd88@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Greg Kurz <groug@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 09/10/2018 05:02 PM, Greg Kurz wrote:
> On Mon, 10 Sep 2018 13:02:19 +0200
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>> Hello,
>>
>> This series adds a new sPAPRIrq backend increasing the number of
>> available IRQ numbers in pseries-3.1 machines. This change is an
>> opportunity to also fix the "ibm,pe-total-#msi" and remove the old
>> XICS_IRQS_SPAPR definition.
>>
>=20
> This cleanup looks sane but I still have a concern with the semantics o=
f
> "ibm,pe-total-#msi".
>=20
> According to LoPAPR:
>=20
> "ibm,pe-total-#msi"
>=20
> property name defines the maximum number of Message Signaled Interrupts=
 (MSI plus MSI-X) that are available
> to the PE below this device tree node. This number only indicates the n=
umber of available interrupts, not the num-
> ber assigned. The number assigned for an IOA may be obtained by Functio=
n 0 (Query only) of the ibm,change-msi
> RTAS call.
> prop-encoded-array: Maximum number of interrupts encoded as with encode=
-int.
>=20
> IIUC, the PHB is given ibm,pe-total-#msi MSIs that it can assign to dev=
ices.
>=20
> But we currently have only one global allocator in the machine, so havi=
ng
> each PHB advertising the full range of the allocator still looks weird.

yes. Multiple PHBs share the same IRQ number space and in this
case the advertised number "ibm,pe-total-#msi" does not reflect=20
the maximum number of allocatable interrupts per PHB.

The patch improves only the value for one PHB and, as of today,=20
it is still wrong when Multiple PHBs are involved.

> Shouldn't this be divided by the number of PHBs ? Or should we have one
> separate allocator for each PHB ?

That would mean segmenting the IRQ number space and I am not=20
fond of this solution because we have plenty of space to share:

	0xd00 MSIs

When we find a scenario reaching this limit, I think what we=20
should do is to dynamically extend the IRQ number space in QEMU=20
and in KVM. It should not be a problem.

We could also downsize "ibm,pe-total-#msi". It is quite big
today. some controllers do have a lot of IRQs but no more=20
that a hundred. I might be wrong.=20

C.

>> Thanks,
>>
>> C.
>>
>> C=C3=A9dric Le Goater (3):
>>   spapr: introduce a spapr_irq class 'nr_msis' attribute
>>   spapr: increase the size of the IRQ number space
>>   spapr_pci: fix "ibm,pe-total-#msi" value
>>
>>  include/hw/ppc/spapr_irq.h |  2 ++
>>  include/hw/ppc/xics.h      |  2 --
>>  hw/ppc/spapr.c             |  1 +
>>  hw/ppc/spapr_irq.c         | 22 ++++++++++++++++++++--
>>  hw/ppc/spapr_pci.c         |  5 +++--
>>  5 files changed, 26 insertions(+), 6 deletions(-)
>>
>=20
