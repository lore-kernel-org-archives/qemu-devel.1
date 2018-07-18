Received: from eggs.gnu.org ([2001:4830:134:3::10]:41666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1ffmPv-0001fG-0b
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 09:22:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1ffmPt-000348-Rl
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 09:22:55 -0400
References: <20180714171601.5734-1-luc.michel@greensocs.com>
	<20180714171601.5734-13-luc.michel@greensocs.com>
	<CAFEAcA9dQEaONA3AkqnyY3PnkMHNcjc=MiBwoF99oHp-BJuRFA@mail.gmail.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <f2c6cd9a-0136-5a4c-64d8-854661f4278d@greensocs.com>
Date: Wed, 18 Jul 2018 15:22:35 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9dQEaONA3AkqnyY3PnkMHNcjc=MiBwoF99oHp-BJuRFA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eo7GDi919OnPI5oeRcSVxzYHrlrzVhuoe"
Subject: Re: [Qemu-devel] [PATCH v4 12/20] intc/arm_gic: Implement
 virtualization extensions in gic_(deactivate|complete_irq)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, Mark Burton <mark.burton@greensocs.com>, Jan Kiszka <jan.kiszka@web.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eo7GDi919OnPI5oeRcSVxzYHrlrzVhuoe
From: Luc Michel <luc.michel@greensocs.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>,
 Mark Burton <mark.burton@greensocs.com>, Jan Kiszka <jan.kiszka@web.de>
Message-ID: <f2c6cd9a-0136-5a4c-64d8-854661f4278d@greensocs.com>
Subject: Re: [PATCH v4 12/20] intc/arm_gic: Implement virtualization
 extensions in gic_(deactivate|complete_irq)
References: <20180714171601.5734-1-luc.michel@greensocs.com>
 <20180714171601.5734-13-luc.michel@greensocs.com>
 <CAFEAcA9dQEaONA3AkqnyY3PnkMHNcjc=MiBwoF99oHp-BJuRFA@mail.gmail.com>
In-Reply-To: <CAFEAcA9dQEaONA3AkqnyY3PnkMHNcjc=MiBwoF99oHp-BJuRFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 07/17/2018 03:32 PM, Peter Maydell wrote:
> On 14 July 2018 at 18:15, Luc Michel <luc.michel@greensocs.com> wrote:
>> Implement virtualization extensions in the gic_deactivate_irq() and
>> gic_complete_irq() functions.  When a guest tries to deactivat or end =
an
>=20
> "deactivate"
>=20
>> IRQ that does not exist in the LRs, the EOICount field of the virtual
>> interface HCR register is incremented by one, and the request is
>> ignored.
>>
>> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
>> ---
>>  hw/intc/arm_gic.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
>> index be9e2594d9..50cbbfbe24 100644
>> --- a/hw/intc/arm_gic.c
>> +++ b/hw/intc/arm_gic.c
>> @@ -590,6 +590,15 @@ static void gic_deactivate_irq(GICState *s, int c=
pu, int irq, MemTxAttrs attrs)
>>          return;
>>      }
>>
>> +    if (gic_is_vcpu(cpu) && !gic_virq_is_valid(s, irq, cpu)) {
>> +        /* This vIRQ does not have an LR entry which is either active=
 or
>> +         * pending and active. Increment EOICount and ignore the writ=
e.
>> +         */
>> +        int rcpu =3D gic_get_vcpu_real_id(cpu);
>> +        s->h_hcr[rcpu] +=3D 1 << R_GICH_HCR_EOICount_SHIFT;
>> +        return;
>> +    }
>=20
> It's a bit hard to tell from the amount of context in the diff,
> but I think this check is being done too late in this function.
> It needs to happen before we do any operations on the irq we're
> passed (eg checking which group it is).For operations on the IRQ, yes. =
But there is also the test on the
EOIMode bit in C_CTLR before that. Writing to C_DIR when EOIMode is 0 is
unpredictable. I was thinking of keeping the same behaviour we had until
then, which is to completely ignore the write.

>=20
>> +
>>      if (gic_cpu_ns_access(s, cpu, attrs) && !group) {
>>          DPRINTF("Non-secure DI for Group0 interrupt %d ignored\n", ir=
q);
>>          return;
>> @@ -604,6 +613,15 @@ static void gic_complete_irq(GICState *s, int cpu=
, int irq, MemTxAttrs attrs)
>>      int group;
>>
>>      DPRINTF("EOI %d\n", irq);
>> +    if (gic_is_vcpu(cpu) && !gic_virq_is_valid(s, irq, cpu)) {
>> +        /* This vIRQ does not have an LR entry which is either active=
 or
>> +         * pending and active. Increment EOICount and ignore the writ=
e.
>> +         */
>> +        int rcpu =3D gic_get_vcpu_real_id(cpu);
>> +        s->h_hcr[rcpu] +=3D 1 << R_GICH_HCR_EOICount_SHIFT;
>> +        return;
>> +    }
>=20
> This isn't consistent with the deactivate code about whether we
> do this check before the "irq >=3D s->num_irq" check or after.
>=20
> I think the correct answer is "before", because the number of
> physical interrupts in the GIC shouldn't affect the valid
> range of virtual interrupts.
>=20
> There is also an edge case here: if the VIRQ written to the
> EOI or DIR registers is a special interrupt number (1020..1023),
> then should we increment the EOI count or not? The GICv2 spec
> is not entirely clear on this point, but it does say in the
> GICH_HCR.EOICount docs that "EOIs that do not clear a bit in
> the Active Priorities register GICH_APR do not cause an increment",
> and the GICv3 spec is clear so my recommendation is that for
> 1020..1023 we should ignore the write and not increment EOICount.
>=20
> That bit about "EOIs that do not clear a bit in GICH_APR do
> not increment EOICount" also suggests that our logic for DIR
> and EOI needs to be something like:
>=20
>   if (vcpu) {
>       if (irq > 1020) {
>           return;
>       }
>       clear GICH_HCR bit;
>       if (no bit cleared) {
>           return;
>       }
>       if (!gic_virq_is_valid()) {
>           increment EOICount;
>           return;
>       }
>       clear active bit in LR;
>   }
>=20
> ?
I agree for EOIR, but for DIR, it seems weird. A write to DIR never
causes a bit to be cleared in GICH_APR. It can only change the state of
the LR corresponding to the given vIRQ. So if we read the specification
this way, a write to DIR should never cause a EOICount increment.

However the part you quoted:

"EOIs that do not clear a bit in the Active Priorities register GICH_APR
do not cause an increment"

seems to apply to EOIs only, not to interrupt deactivations.

And in the DIR specification:
"If the specified Interrupt does not exist in the List registers, the
GICH_HCR.EOIcount field is incremented"

So I would suggest that we apply your reasoning for EOIR. For DIR, I
think something like this is sufficient:

   if (vcpu) {
       if (irq > 1020) {
           return;
       }
       if (!gic_virq_is_valid()) {
           increment EOICount;
           return;
       }
       clear active bit in LR;
   }


What do you think?


Thanks

Luc

>=20
>> +
>>      if (irq >=3D s->num_irq) {
>>          /* This handles two cases:
>>           * 1. If software writes the ID of a spurious interrupt [ie 1=
023]
>> --
>> 2.18.0
>>
>=20
> thanks
> -- PMM
>=20


--eo7GDi919OnPI5oeRcSVxzYHrlrzVhuoe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAltPPxsACgkQd8knW3Qn
Tr76yA/+MsiFEt7ra9Dd2jYXQmPAItqVkuPW2SkemHddAurcifwWJ9/MWMV3egm+
ieZLQ4wbvKvhLbnofAAtZLEMfrOv83uYdLcQcJl14SuOe5rvnQXftA4CPLc+Q3c3
07VOLScU8Sj/+9AlgNkJ5IPmCWbAg0jI41VCs/UzQtFwOrQCdE6nkhwSty2z6cbS
+mK1hawqeMnL+cI49FTFpHuGmVpIsxuk4QOOOFnddOewc4q2w0IamjliqtDDewEC
7UWdaXOIMf3SMgjywcgHUJ9hXMpNdMcC7VUJdR+1IupwRCX08HqcPGeli38jgrom
84KatfNnLuT8fc786wSz4ZBbFkD7jxaPkNBE4MJABRd9lo9+8pkMMpTt9thBzhI2
gnyzrM83HVEyScJSugJsrHPBQXrqth7mTrXRK3XuPs1peXrwfGxc8XC0KLKETJSm
JC4bSqPYz1ceyZJOmgfDlwy6wY4ZwzkTtcFUk5rIS8a+BVswkpfTZ1gkDZVUGxCL
qfESENh04l/FC63HCVxKwxUAh1RzSEiAnNbJHOCho0d+Gx/30SqhrnwbUQPfOE02
OHK3uzyFBOQVCZgfi70MKD/xPXRel6ib75j6QL66HBpFA1mRWe2CULbUb+DvuWpw
i3Pm0rKhoTE68YG30pRgP8qkhPQCcGK8lfGZMdMcw8GljQTS0Yk=
=9mY8
-----END PGP SIGNATURE-----

--eo7GDi919OnPI5oeRcSVxzYHrlrzVhuoe--
