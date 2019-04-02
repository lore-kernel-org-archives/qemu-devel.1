Received: from eggs.gnu.org ([209.51.188.92]:32897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hBFdw-0002Dw-Ra
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 05:23:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hBFPb-00088k-BM
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 05:08:57 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53086)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1hBFPY-00081u-2X
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 05:08:53 -0400
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <461676dd-8a04-3d3e-86c0-76e143fa27b9@redhat.com>
Date: Tue, 2 Apr 2019 12:08:42 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <47EDAADB-151A-43DC-B137-6E6DCD11BB64@oracle.com>
References: <20190402080215.10747-1-vkuznets@redhat.com>
	<7B2302D0-7277-4C14-9FEA-DDAE70EF005E@oracle.com>
	<461676dd-8a04-3d3e-86c0-76e143fa27b9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] ioapic: allow buggy guests mishandling
 level-triggered interrupts to make progress
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>



> On 2 Apr 2019, at 12:06, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> On 02/04/19 10:23, Liran Alon wrote:
>>> +#define SUCCESSIVE_IRQ_MAX_COUNT 10000
>>> +
>>> +static void ioapic_timer(void *opaque)
>> I suggest rename method to something such as =
=E2=80=9Cdelayed_ioapic_service_timer_handler()=E2=80=9D.
>>=20
>=20
> I renamed them to delayed_ioapic_service_{timer,cb} and queued the =
patch.

Thanks.

>=20
>>>=20
>>> +            if (((entry & IOAPIC_VECTOR_MASK) !=3D vector) ||
>>> +                !(entry & IOAPIC_LVT_REMOTE_IRR)) {
>>> +                continue;
>>> +            }
>>> +
>>> +            trace_ioapic_clear_remote_irr(n, vector);
>>> +            s->ioredtbl[n] =3D entry & ~IOAPIC_LVT_REMOTE_IRR;
>>=20
>> remote-irr is only set for level-triggered interrupt.
>> Thus, I think in the =E2=80=9Cif=E2=80=9D above you should =
=E2=80=9Ccontinue;=E2=80=9D in case trigger-mode !=3D =
IOAPIC_TRIGGER_LEVEL.
>> i.e. Replace condition "!(entry & IOAPIC_LVT_REMOTE_IRR)=E2=80=9D =
with =E2=80=9Ctrigger-mode !=3D IOAPIC_TRIGGER_LEVEL=E2=80=9D.
>> Then you can also remove the =E2=80=9Cif=E2=80=9D below.
>=20
> Like this?
>=20
> @@ -232,19 +232,18 @@ void ioapic_eoi_broadcast(int vector)
>         for (n =3D 0; n < IOAPIC_NUM_PINS; n++) {
>             entry =3D s->ioredtbl[n];
>=20
> -            if (((entry & IOAPIC_VECTOR_MASK) !=3D vector) ||
> -                !(entry & IOAPIC_LVT_REMOTE_IRR)) {
> +            if ((entry & IOAPIC_VECTOR_MASK) !=3D vector ||
> +                ((entry >> IOAPIC_LVT_TRIGGER_MODE_SHIFT) & 1) !=3D =
IOAPIC_TRIGGER_LEVEL) {
>                 continue;
>             }
>=20
> -            trace_ioapic_clear_remote_irr(n, vector);
> -            s->ioredtbl[n] =3D entry & ~IOAPIC_LVT_REMOTE_IRR;
> -
> -            if (((entry >> IOAPIC_LVT_TRIGGER_MODE_SHIFT) & 1) !=3D
> -                IOAPIC_TRIGGER_LEVEL) {
> +            if (!(entry & IOAPIC_LVT_REMOTE_IRR)) {
>                 continue;
>             }

I think above =E2=80=9Cif=E2=80=9D of checking remote-irr should just be =
removed.
But the rest seems good :)

>=20
> +            trace_ioapic_clear_remote_irr(n, vector);
> +            s->ioredtbl[n] =3D entry & ~IOAPIC_LVT_REMOTE_IRR;
> +
>             if (!(entry & IOAPIC_LVT_MASKED) && (s->irr & (1 << n))) {
>                 ++s->irq_eoi[vector];
>                 if (s->irq_eoi[vector] >=3D SUCCESSIVE_IRQ_MAX_COUNT) =
{
>=20
>=20
> Paolo
