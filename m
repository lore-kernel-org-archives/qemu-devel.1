Received: from eggs.gnu.org ([2001:4830:134:3::10]:42537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cxxvC-0007qt-0v
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:41:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cxxv8-0000Sj-V2
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:41:34 -0400
Received: from 9.mo173.mail-out.ovh.net ([46.105.72.44]:49551)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cxxv8-0000S1-OM
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:41:30 -0400
Received: from player778.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id B61C1314F0
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 17:41:28 +0200 (CEST)
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
	<1491396106-26376-20-git-send-email-clg@kaod.org>
	<20170410055951.GR27571@umbus>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c1eceb4a-cae7-819e-c07e-e5190f4a6dd3@kaod.org>
Date: Tue, 11 Apr 2017 17:41:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170410055951.GR27571@umbus>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 19/21] pci: Don't call pci_irq_handler()
 for a negative intx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 04/10/2017 07:59 AM, David Gibson wrote:
> On Wed, Apr 05, 2017 at 02:41:44PM +0200, C=E9dric Le Goater wrote:
>> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>
>> Under some circumstances, pci_intx() can return -1 (when the interrupt
>> pin in the config space is 0 which normally means no interrupt).
>>
>> I have seen cases of pci_set_irq() being called on such devices, in
>> turn causing pci_irq_handler() to be called with "-1" as an argument
>> which doesn't seem like a terribly good idea.
>>
>> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> [clg: updated for qemu-2.9 ]
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> This looks like a real bug fix which should go to Michael independent
> of the rest of the series.

Michael,

Do you want a resend or can you pick it up from this series ?

Thanks,

C.

>=20
>> ---
>>  hw/pci/pci.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index 817ad14ed987..bfd65461348c 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -1419,7 +1419,9 @@ qemu_irq pci_allocate_irq(PCIDevice *pci_dev)
>>  void pci_set_irq(PCIDevice *pci_dev, int level)
>>  {
>>      int intx =3D pci_intx(pci_dev);
>> -    pci_irq_handler(pci_dev, intx, level);
>> +    if (intx >=3D 0) {
>> +        pci_irq_handler(pci_dev, intx, level);
>> +    }
>>  }
>> =20
>>  /* Special hooks used by device assignment */
>=20
