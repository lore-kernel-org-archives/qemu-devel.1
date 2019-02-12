Received: from eggs.gnu.org ([209.51.188.92]:57133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gtS8v-0003H0-5J
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 02:06:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gtS8t-0005Rk-7N
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 02:06:08 -0500
Received: from 1.mo2.mail-out.ovh.net ([46.105.63.121]:47355)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gtS8s-0005LX-QQ
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 02:06:07 -0500
Received: from player692.ha.ovh.net (unknown [10.109.160.217])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 461E818423C
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 08:05:59 +0100 (CET)
References: <20190107183946.7230-1-clg@kaod.org>
	<20190107183946.7230-13-clg@kaod.org>
	<20190212010643.GG1884@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <adcd2479-7a31-ba7d-50c6-cfa9af909f2e@kaod.org>
Date: Tue, 12 Feb 2019 08:05:53 +0100
MIME-Version: 1.0
In-Reply-To: <20190212010643.GG1884@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 12/13] spapr/xics: ignore the lower 4K in
 the IRQ number space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 2/12/19 2:06 AM, David Gibson wrote:
> On Mon, Jan 07, 2019 at 07:39:45PM +0100, C=E9dric Le Goater wrote:
>> The IRQ number space of the XIVE and XICS interrupt mode are aligned
>> when using the dual interrupt mode for the machine. This means that
>> the ICS offset is set to zero in QEMU and that the KVM XICS device
>> should be informed of this new value. Unfortunately, there is now way
>> to do so and KVM still maintains the XICS_IRQ_BASE (0x1000) offset.
>>
>> Ignore the lower 4K which are not used under the XICS interrupt
>> mode. These IRQ numbers are only claimed by XIVE for the CPU IPIs.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/intc/xics_kvm.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
>> index 651bbfdf6966..1d21ff217b82 100644
>> --- a/hw/intc/xics_kvm.c
>> +++ b/hw/intc/xics_kvm.c
>> @@ -238,6 +238,15 @@ static void ics_get_kvm_state(ICSState *ics)
>>      for (i =3D 0; i < ics->nr_irqs; i++) {
>>          ICSIRQState *irq =3D &ics->irqs[i];
>> =20
>> +        /*
>> +         * The KVM XICS device considers that the IRQ numbers should
>> +         * start at XICS_IRQ_BASE (0x1000). Ignore the lower 4K
>> +         * numbers (only claimed by XIVE for the CPU IPIs).
>> +         */
>> +        if (i + ics->offset < XICS_IRQ_BASE) {
>> +            continue;
>> +        }
>> +
>=20
> This seems bogus to me.  The guest-visible irq numbers need to line up
> between xics and xive mode, yes, but that doesn't mean we need to keep
> around a great big array of unused array of ICS irq states, even in
> TCG mode.

This is because the qirqs[] array is under the machine and shared between=
=20
both interrupt modes, xics and xive.

C.

>=20
>>          kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURCES,
>>                            i + ics->offset, &state, false, &error_fata=
l);
>> =20
>> @@ -303,6 +312,15 @@ static int ics_set_kvm_state(ICSState *ics, int v=
ersion_id)
>>          ICSIRQState *irq =3D &ics->irqs[i];
>>          int ret;
>> =20
>> +        /*
>> +         * The KVM XICS device considers that the IRQ numbers should
>> +         * start at XICS_IRQ_BASE (0x1000). Ignore the lower 4K
>> +         * numbers (only claimed by XIVE for the CPU IPIs).
>> +         */
>> +        if (i + ics->offset < XICS_IRQ_BASE) {
>> +            continue;
>> +        }
>> +
>>          state =3D irq->server;
>>          state |=3D (uint64_t)(irq->saved_priority & KVM_XICS_PRIORITY=
_MASK)
>>              << KVM_XICS_PRIORITY_SHIFT;
>=20
