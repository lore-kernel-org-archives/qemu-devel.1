Received: from eggs.gnu.org ([2001:4830:134:3::10]:37822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dZdsy-0002Ly-5Z
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 09:59:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dZdsv-0002nU-JX
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 09:59:00 -0400
Received: from 8.mo3.mail-out.ovh.net ([87.98.172.249]:51129)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dZdsv-0002lK-9O
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 09:58:57 -0400
Received: from player732.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 7A2DF123F2E
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 15:58:55 +0200 (CEST)
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-12-git-send-email-clg@kaod.org>
	<20170724051334.GH17228@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <6d7e80d4-5a8f-15e6-6395-72cb86ad4e5c@kaod.org>
Date: Mon, 24 Jul 2017 15:58:50 +0200
MIME-Version: 1.0
In-Reply-To: <20170724051334.GH17228@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 11/26] ppc/xics: introduce a
 print_info() handler to the ICS and ICP objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 07/24/2017 07:13 AM, David Gibson wrote:
> On Wed, Jul 05, 2017 at 07:13:24PM +0200, C=E9dric Le Goater wrote:
>> This handler will be used to customize the ouput of the XIVE interrupt
>> source and presenter objects.
>=20
> I'm not really happy with this without having a clear idea of where
> this is heading - are you trying to share ICP and or ICS object
> classes between XICS and XIVE, or will they eventually be separated
> again?

Because of the XICSFabric interface of the sPAPR machine, we need=20
to use ICPState and ICSState objects.=20

sPAPR is strongly tied to ICPState and it is complex to introduce=20
a new ICPState class for the sPAPR machine. We did introduce a new=20
class in the past but that was for a new machine : PowerNV.
So I think we should just add a couple of attributes to ICPState
to support XIVE. That is not what the patchset does but I have
made progress since with hotplug and migration and came to that
conclusion. The consequence is that the print_info() handler is=20
now obsolete for ICPs and we will need to find another way to=20
customize the output.

For the interrupt source, the constraints are less strong, adding=20
a new ICSState class seems like a good option and so does the=20
print_info() handler.

Thanks,

C.=20


>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/intc/xics.c        | 36 ++++++++++++++++++++++++------------
>>  include/hw/ppc/xics.h |  2 ++
>>  2 files changed, 26 insertions(+), 12 deletions(-)
>>
>> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
>> index faa5c631f655..7837c2022b4a 100644
>> --- a/hw/intc/xics.c
>> +++ b/hw/intc/xics.c
>> @@ -40,18 +40,26 @@
>> =20
>>  void icp_pic_print_info(ICPState *icp, Monitor *mon)
>>  {
>> +    ICPStateClass *k =3D ICP_GET_CLASS(icp);
>>      int cpu_index =3D icp->cs ? icp->cs->cpu_index : -1;
>> =20
>>      if (!icp->output) {
>>          return;
>>      }
>> -    monitor_printf(mon, "CPU %d XIRR=3D%08x (%p) PP=3D%02x MFRR=3D%02=
x\n",
>> -                   cpu_index, icp->xirr, icp->xirr_owner,
>> -                   icp->pending_priority, icp->mfrr);
>> +
>> +    monitor_printf(mon, "CPU %d ", cpu_index);
>> +    if (k->print_info) {
>> +        k->print_info(icp, mon);
>> +    } else {
>> +        monitor_printf(mon, "XIRR=3D%08x (%p) PP=3D%02x MFRR=3D%02x\n=
",
>> +                       icp->xirr, icp->xirr_owner,
>> +                       icp->pending_priority, icp->mfrr);
>> +    }
>>  }
>> =20
>>  void ics_pic_print_info(ICSState *ics, Monitor *mon)
>>  {
>> +    ICSStateClass *k =3D ICS_BASE_GET_CLASS(ics);
>>      uint32_t i;
>> =20
>>      monitor_printf(mon, "ICS %4x..%4x %p\n",
>> @@ -61,17 +69,21 @@ void ics_pic_print_info(ICSState *ics, Monitor *mo=
n)
>>          return;
>>      }
>> =20
>> -    for (i =3D 0; i < ics->nr_irqs; i++) {
>> -        ICSIRQState *irq =3D ics->irqs + i;
>> +    if (k->print_info) {
>> +        k->print_info(ics, mon);
>> +    } else {
>> +        for (i =3D 0; i < ics->nr_irqs; i++) {
>> +            ICSIRQState *irq =3D ics->irqs + i;
>> =20
>> -        if (!(irq->flags & XICS_FLAGS_IRQ_MASK)) {
>> -            continue;
>> +            if (!(irq->flags & XICS_FLAGS_IRQ_MASK)) {
>> +                continue;
>> +            }
>> +            monitor_printf(mon, "  %4x %s %02x %02x\n",
>> +                           ics->offset + i,
>> +                           (irq->flags & XICS_FLAGS_IRQ_LSI) ?
>> +                           "LSI" : "MSI",
>> +                           irq->priority, irq->status);
>>          }
>> -        monitor_printf(mon, "  %4x %s %02x %02x\n",
>> -                       ics->offset + i,
>> -                       (irq->flags & XICS_FLAGS_IRQ_LSI) ?
>> -                       "LSI" : "MSI",
>> -                       irq->priority, irq->status);
>>      }
>>  }
>> =20
>> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
>> index 28d248abad61..902f3bfd0e33 100644
>> --- a/include/hw/ppc/xics.h
>> +++ b/include/hw/ppc/xics.h
>> @@ -69,6 +69,7 @@ struct ICPStateClass {
>>      void (*pre_save)(ICPState *icp);
>>      int (*post_load)(ICPState *icp, int version_id);
>>      void (*reset)(ICPState *icp);
>> +    void (*print_info)(ICPState *icp, Monitor *mon);
>>  };
>> =20
>>  struct ICPState {
>> @@ -119,6 +120,7 @@ struct ICSStateClass {
>>      void (*reject)(ICSState *s, uint32_t irq);
>>      void (*resend)(ICSState *s);
>>      void (*eoi)(ICSState *s, uint32_t irq);
>> +    void (*print_info)(ICSState *s, Monitor *mon);
>>  };
>> =20
>>  struct ICSState {
>=20
