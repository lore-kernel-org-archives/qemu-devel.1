Received: from eggs.gnu.org ([209.51.188.92]:54065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h3S9A-0001B2-Iv
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 17:07:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h3S1N-0002Ka-0w
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:59:41 -0400
Received: from 5.mo173.mail-out.ovh.net ([46.105.40.148]:42117)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h3S1M-0002Ja-QC
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:59:40 -0400
Received: from player787.ha.ovh.net (unknown [10.109.143.208])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 51E40F90E6
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 21:59:38 +0100 (CET)
References: <20190222131322.26079-1-clg@kaod.org>
	<20190222131322.26079-14-clg@kaod.org>
	<20190226041722.GO6872@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <7955cb20-fcaf-744d-57a0-956ea1ab9474@kaod.org>
Date: Mon, 11 Mar 2019 21:59:32 +0100
MIME-Version: 1.0
In-Reply-To: <20190226041722.GO6872@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 13/13] spapr/xive: fix device hotplug
 when VM is stopped
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

On 2/26/19 5:17 AM, David Gibson wrote:
> On Fri, Feb 22, 2019 at 02:13:22PM +0100, C=E9dric Le Goater wrote:
>> Instead of switching off the sources, set their state to PENDING to
>> possibly catch a hotplug event occuring while the VM is stopped. At
>> resume, check the previous state and if an interrupt was queued,
>> generate a trigger.
>=20
> First, I think it would be better to fold this fix into the patch
> introducing the state change handlers.>=20
> Second, IIUC this would handle any instance of an irq being triggered
> while the VM is stopped.=20

yes.

> Hotplug interrupts is one obvious case of that, but I'm not sure its=20
> the only one. =20

Do we really need to support device hotplug when the VM is stopped ?=20
Is that a libvirt requirement ? =20

> VFIO devices could interrupt while the VM is stopped, I think.=20

If the guest has configured and mapped the IRQs, I would say yes.=20

> Maybe even emulated devices
> depending on how their synchronization with the cpu run state works.

The console is one example.

> There might be other cases.  Does that sound right to you?

yes.

Supporting interrupts while a VM is stopped seems like a weird=20
test scenario to me. Should we or should we not ?=20

Thanks,

C.

>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/intc/spapr_xive_kvm.c | 22 +++++++++++++++++++---
>>  1 file changed, 19 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
>> index 99a829fb3f60..64d160babb26 100644
>> --- a/hw/intc/spapr_xive_kvm.c
>> +++ b/hw/intc/spapr_xive_kvm.c
>> @@ -500,8 +500,16 @@ static void kvmppc_xive_change_state_handler(void=
 *opaque, int running,
>>      if (running) {
>>          for (i =3D 0; i < xsrc->nr_irqs; i++) {
>>              uint8_t pq =3D xive_source_esb_get(xsrc, i);
>> -            if (xive_esb_read(xsrc, i, XIVE_ESB_SET_PQ_00 + (pq << 8)=
) !=3D 0x1) {
>> -                error_report("XIVE: IRQ %d has an invalid state", i);
>> +            uint8_t old_pq;
>> +
>> +            old_pq =3D xive_esb_read(xsrc, i, XIVE_ESB_SET_PQ_00 + (p=
q << 8));
>> +
>> +            /*
>> +             * If an interrupt was queued (hotplug event) while VM wa=
s
>> +             * stopped, generate a trigger.
>> +             */
>> +            if (pq =3D=3D XIVE_ESB_RESET && old_pq =3D=3D XIVE_ESB_QU=
EUED) {
>> +                xive_esb_trigger(xsrc, i);
>>              }
>>          }
>> =20
>> @@ -515,7 +523,15 @@ static void kvmppc_xive_change_state_handler(void=
 *opaque, int running,
>>       * migration is in progress.
>>       */
>>      for (i =3D 0; i < xsrc->nr_irqs; i++) {
>> -        uint8_t pq =3D xive_esb_read(xsrc, i, XIVE_ESB_SET_PQ_01);
>> +        uint8_t pq =3D xive_esb_read(xsrc, i, XIVE_ESB_GET);
>> +
>> +        /*
>> +         * PQ is set to PENDING to possibly catch a hotplug event
>> +         * occuring while the VM is stopped.
>> +         */
>> +        if (pq !=3D XIVE_ESB_OFF) {
>> +            pq =3D xive_esb_read(xsrc, i, XIVE_ESB_SET_PQ_10);
>> +        }
>>          xive_source_esb_set(xsrc, i, pq);
>>      }
>> =20
>=20
