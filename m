Received: from eggs.gnu.org ([209.51.188.92]:50608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h3Rmg-0002TV-T1
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:44:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h3Rmg-0002ZH-3E
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:44:30 -0400
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:38823)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h3Rmf-0002Yb-Nt
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:44:30 -0400
Received: from player692.ha.ovh.net (unknown [10.109.160.153])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id D542B18510B
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 21:44:27 +0100 (CET)
References: <20190222131322.26079-1-clg@kaod.org>
	<20190222131322.26079-4-clg@kaod.org>
	<20190225234927.GB6872@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <3c56afd5-460c-acfb-f67a-4115b27d73cf@kaod.org>
Date: Mon, 11 Mar 2019 21:44:22 +0100
MIME-Version: 1.0
In-Reply-To: <20190225234927.GB6872@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 03/13] spapr/xive: activate KVM support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 2/26/19 12:49 AM, David Gibson wrote:
> On Fri, Feb 22, 2019 at 02:13:12PM +0100, C=E9dric Le Goater wrote:
>> All is in place for KVM now. State synchronization and migration will
>> come next.
>=20
> As with the kernel side capability, this should be moved later in the
> series to avoid breaking bisections.

I am not sure to understand. At this stage of the patchset, the XIVE
exploitation mode is operational. We can not synchronise the state=20
or migrate but it runs.

Should we move XIVE activation after the migration patch ?=20

C.=20

=20
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/ppc/spapr_irq.c | 9 ---------
>>  1 file changed, 9 deletions(-)
>>
>> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
>> index 6e1c36dc62ca..1ad57582a403 100644
>> --- a/hw/ppc/spapr_irq.c
>> +++ b/hw/ppc/spapr_irq.c
>> @@ -263,19 +263,10 @@ sPAPRIrq spapr_irq_xics =3D {
>>  static void spapr_irq_init_xive(sPAPRMachineState *spapr, int nr_irqs=
,
>>                                  Error **errp)
>>  {
>> -    MachineState *machine =3D MACHINE(spapr);
>>      uint32_t nr_servers =3D spapr_max_server_number(spapr);
>>      DeviceState *dev;
>>      int i;
>> =20
>> -    /* KVM XIVE device not yet available */
>> -    if (kvm_enabled()) {
>> -        if (machine_kernel_irqchip_required(machine)) {
>> -            error_setg(errp, "kernel_irqchip requested. no KVM XIVE s=
upport");
>> -            return;
>> -        }
>> -    }
>> -
>>      dev =3D qdev_create(NULL, TYPE_SPAPR_XIVE);
>>      qdev_prop_set_uint32(dev, "nr-irqs", nr_irqs);
>>      /*
>=20
