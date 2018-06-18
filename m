Received: from eggs.gnu.org ([2001:4830:134:3::10]:36163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fUsgG-0001AH-Ba
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 07:50:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fUsgE-0006Na-Uf
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 07:50:44 -0400
References: <20180606093101.30518-1-luc.michel@greensocs.com>
	<20180606093101.30518-4-luc.michel@greensocs.com>
	<CAFEAcA9Oh+faKrBwDb7LAG=drkQTtbtoOrV_WUqa7twJi974yQ@mail.gmail.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <1425bf1a-1502-b614-ffb1-b261cb24d1de@greensocs.com>
Date: Mon, 18 Jun 2018 13:50:26 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Oh+faKrBwDb7LAG=drkQTtbtoOrV_WUqa7twJi974yQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VQ3L0PP1UKY3x5qLVVr0vgOvQ6o1IqIai"
Subject: Re: [Qemu-devel] [PATCH 3/6] intc/arm_gic: Add the virtualization
 extensions to the GIC state
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
--VQ3L0PP1UKY3x5qLVVr0vgOvQ6o1IqIai
From: Luc Michel <luc.michel@greensocs.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>,
 Mark Burton <mark.burton@greensocs.com>, Jan Kiszka <jan.kiszka@web.de>
Message-ID: <1425bf1a-1502-b614-ffb1-b261cb24d1de@greensocs.com>
Subject: Re: [PATCH 3/6] intc/arm_gic: Add the virtualization extensions to
 the GIC state
References: <20180606093101.30518-1-luc.michel@greensocs.com>
 <20180606093101.30518-4-luc.michel@greensocs.com>
 <CAFEAcA9Oh+faKrBwDb7LAG=drkQTtbtoOrV_WUqa7twJi974yQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9Oh+faKrBwDb7LAG=drkQTtbtoOrV_WUqa7twJi974yQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/11/2018 03:38 PM, Peter Maydell wrote:
> On 6 June 2018 at 10:30,  <luc.michel@greensocs.com> wrote:
>> From: Luc MICHEL <luc.michel@greensocs.com>
>>
>> Add the necessary parts of the virtualization extensions state to the
>> GIC state. We choose to increase the size of the CPU interfaces state =
to
>> add space for the vCPU interfaces (the GIC_NCPU_VCPU macro). This way,=

>> we'll be able to reuse most of the CPU interface code for the vCPUs.
>>
>> The vCPUs are numbered from GIC_NCPU to (GIC_NCPU * 2) - 1. The
>> `gic_is_vcpu` function help to determine if a given CPU id correspond =
to
>> a physical CPU or a virtual one.
>>
>> The GIC VMState is updated to account for this modification. We add a
>> subsection for the virtual interface state. The virtual CPU interfaces=

>> state however cannot be put in the subsection because of some 2D array=
s
>> in the GIC state. This implies an increase in the VMState version id.
>>
>> For the in-kernel KVM VGIC, since the exposed VGIC does not implement
>> the virtualization extensions, we report an error if the corresponding=

>> property is set to true.
>>
>> Signed-off-by: Luc MICHEL <luc.michel@greensocs.com>
>> ---
>=20
>> +/* Note: We cannot put the vCPUs state in this subsection because of =
some 2D
>> + * arrays that mix CPU and vCPU states. */
>> +static const VMStateDescription vmstate_gic_virt_state =3D {
>> +    .name =3D "arm_gic_virt_state",
>> +    .version_id =3D 1,
>> +    .minimum_version_id =3D 1,
>> +    .needed =3D gic_virt_state_needed,
>> +    .fields =3D (VMStateField[]) {
>> +        /* Virtual interface */
>> +        VMSTATE_UINT32_ARRAY(h_hcr, GICState, GIC_NCPU),
>> +        VMSTATE_UINT32_ARRAY(h_misr, GICState, GIC_NCPU),
>> +        VMSTATE_UINT32_2DARRAY(h_lr, GICState, GIC_NR_LR, GIC_NCPU),
>> +        VMSTATE_UINT64_ARRAY(h_eisr, GICState, GIC_NCPU),
>> +        VMSTATE_UINT64_ARRAY(h_elrsr, GICState, GIC_NCPU),
>> +        VMSTATE_UINT32_ARRAY(h_apr, GICState, GIC_NCPU),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>>  static const VMStateDescription vmstate_gic =3D {
>>      .name =3D "arm_gic",
>> -    .version_id =3D 12,
>> -    .minimum_version_id =3D 12,
>> +    .version_id =3D 13,
>> +    .minimum_version_id =3D 13,
>=20
> This breaks migration compatibility, which we can't do for the GIC
> (it is used by some KVM VM configs, where we strongly care about
> compatibility).
>=20
>>      .pre_save =3D gic_pre_save,
>>      .post_load =3D gic_post_load,
>>      .fields =3D (VMStateField[]) {
>>          VMSTATE_UINT32(ctlr, GICState),
>> -        VMSTATE_UINT32_ARRAY(cpu_ctlr, GICState, GIC_NCPU),
>> +        VMSTATE_UINT32_ARRAY(cpu_ctlr, GICState, GIC_NCPU_VCPU),
>=20
> If you want to put the VCPU state in the same array as the CPU state
> like this, you need to use subarrays, so here
>            VMSTATE_UINT32_SUB_ARRAY(cpu_ctlr, GICState, 0, GIC_NCPU),
> and in the vmstate_gic_virt_state
>            VMSTATE_UINT32_SUB_ARRAY(cpu_ctlr, GICState, GIC_NCPU, GIC_N=
CPU)
>=20
> Similarly for the other arrays. You'll need a patch adding
> VMSTATE_UINT16_SUB_ARRAY to vmstate.h:
>=20
> #define VMSTATE_UINT16_SUB_ARRAY(_f, _s, _start, _num)                \=

>     VMSTATE_SUB_ARRAY(_f, _s, _start, _num, 0, vmstate_info_uint16, uin=
t16_t)
>=20
>>          VMSTATE_STRUCT_ARRAY(irq_state, GICState, GIC_MAXIRQ, 1,
>>                               vmstate_gic_irq_state, gic_irq_state),
>>          VMSTATE_UINT8_ARRAY(irq_target, GICState, GIC_MAXIRQ),
>>          VMSTATE_UINT8_2DARRAY(priority1, GICState, GIC_INTERNAL, GIC_=
NCPU),
>>          VMSTATE_UINT8_ARRAY(priority2, GICState, GIC_MAXIRQ - GIC_INT=
ERNAL),
>>          VMSTATE_UINT8_2DARRAY(sgi_pending, GICState, GIC_NR_SGIS, GIC=
_NCPU),
>> -        VMSTATE_UINT16_ARRAY(priority_mask, GICState, GIC_NCPU),
>> -        VMSTATE_UINT16_ARRAY(running_priority, GICState, GIC_NCPU),
>> -        VMSTATE_UINT16_ARRAY(current_pending, GICState, GIC_NCPU),
>> -        VMSTATE_UINT8_ARRAY(bpr, GICState, GIC_NCPU),
>> -        VMSTATE_UINT8_ARRAY(abpr, GICState, GIC_NCPU),
>> -        VMSTATE_UINT32_2DARRAY(apr, GICState, GIC_NR_APRS, GIC_NCPU),=

>> +        VMSTATE_UINT16_ARRAY(priority_mask, GICState, GIC_NCPU_VCPU),=

>> +        VMSTATE_UINT16_ARRAY(running_priority, GICState, GIC_NCPU_VCP=
U),
>> +        VMSTATE_UINT16_ARRAY(current_pending, GICState, GIC_NCPU_VCPU=
),
>> +        VMSTATE_UINT8_ARRAY(bpr, GICState, GIC_NCPU_VCPU),
>> +        VMSTATE_UINT8_ARRAY(abpr, GICState, GIC_NCPU_VCPU),
>> +        VMSTATE_UINT32_2DARRAY(apr, GICState, GIC_NR_APRS, GIC_NCPU_V=
CPU),
>=20
> The 2D array is more painful. You need to describe it as a set of
> 1D slices, something like
>            VMSTATE_UINT32_SUB_ARRAY(apr, GICState, 0, GIC_NCPU),
>            VMSTATE_UINT32_SUB_ARRAY(apr, GICState, GIC_NCPU_VCPU, GIC_N=
CPU),
>            VMSTATE_UINT32_SUB_ARRAY(apr, GICState, GIC_NCPU_VCPU * 2, G=
IC_NCPU),
>            [...]
>            VMSTATE_UINT32_SUB_ARRAY(apr, GICState, GIC_NCPU_VCPU * n, G=
IC_NCPU),
> where n is GIC_NR_APRS - 1
>=20
> and then the other slices in the vmstate_gic_virt_state.
>=20
> But conveniently the only 2D array is for the APR registers, which
> you don't actually want to have state for for the virtualization
> extensions anyway. The only state here is in the GICH_APR, and
> (as per the recommendation in the spec in the GICV_APRn documentation)
> the GICV_APRn should just be either RAZ/WI or aliases of GICH_APR,
> with no state of their own to migrate.
>=20
> More generally, there's something odd going on here. The way the
> GIC virtualization extensions are defined, there are registers
> which expose the state to the guest (the GIC virtual CPU interface),
> and there are registers which expose the state to the hypervisor
> (the GIC virtual interface), but the underlying state is identical.
> In the spec all the various fields in the virtual CPU interface
> are defined as aliases to register fields in the virtual interface
> (for instance GICV_PMR is an alias of GICH_VMCR.VMPriMask).
>=20
> So you don't want to be migrating the data twice -- depending on
> the implementation we either hold the state in struct fields that
> look like the CPU interface, and the virtual interface register
> read and write code does the mapping to access the right parts of
> those, or we can do it the other way round and store the state in
> struct fields matching the virtual interface registers, with the
> read and write functions for the virtual CPU interface doing the
> mapping. But we don't want struct fields and migration state
> descriptions for both.
Indeed you are right, h_apr is a leftover that is not used in my
implementation. I use apr[0] of the vCPU interface to store the APR
value. If it's ok like this, I can simply remove h_apr from the struct
and from the virt VMState.

The same goes for h_eisr and h_elrsr, which are in the struct as a
cached data, but that can be recomputed from the LRs, and thus don't
need to be stored in the VMState. In my implementation they are
recomputed in the VMState post_load function.

If you agree with that, I'm going to publish a v2 with migration
compatibility and without those three registers in the VMState.

Thanks,

--=20
Luc

>=20
>>          VMSTATE_UINT32_2DARRAY(nsapr, GICState, GIC_NR_APRS, GIC_NCPU=
),
>>          VMSTATE_END_OF_LIST()
>> +    },
>> +    .subsections =3D (const VMStateDescription * []) {
>> +        &vmstate_gic_virt_state,
>> +        NULL
>>      }
>>  };
>=20
> thanks
> -- PMM
>=20


--VQ3L0PP1UKY3x5qLVVr0vgOvQ6o1IqIai
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAlsnnIIACgkQd8knW3Qn
Tr55Fw//SOH07R6xhVYn/S8Dyhq36PWCiEbRt6rO/6dEZjl+XkNdLW6zGuNTi2Ut
JJ2sODWilc0lrOvaKYTfyunWjb2CGO9msRFF3ldhmRmQ0/aDj1+/2tA+fjWqdz2/
otSinWUJndfqLH/nNCgm+rSeZsb5Ls9Jcd0AweZ8imSgU2gr3L7UJ+SLGNILUp+j
3egAwQWXqZVjDY+3DAxCVWw54EjLTcwKGa6a2khE4HBTSww9fQJdRKJoTCJq2AkS
+vroPgztoLbGsYu+snZu47EmUNemvewyxJV2jvww0uaRawNBGsX6PRs+Dvz/qt7J
zFxudEn0EulnXay/CgNM3li0jIFnhqbqmM7SYzi9BQV7e9PEsJtIWiwAfQFqQ31R
gKbRHoJzBvsM48T8hxCCeiZJuYc4VZAxpE4FG5k0zp+39KN6uDuI7Hv8pKF96e9T
MiARqK83EIMLAPdyI/E2j6g09nQpF8o4J79o+k+LqLHrEzSOQSjpal6yK6Wdqv8u
BZ3hArdHXFg3OJFKBuFc4cR0C2f0nOCVeMFAwtdf8Ch00qyeiBHeW1+RchjQKoXs
jR6q8JPgqDEsUnLo+aXXeGjf1o8FocY0AJo3jX/qmhU78o4AtxjLIVihqAPLa7IY
GQaOmuaCru6KNcwhxqRlLCXaMGwCGuhoAPxKINhBMlzRcDHYD4w=
=922X
-----END PGP SIGNATURE-----

--VQ3L0PP1UKY3x5qLVVr0vgOvQ6o1IqIai--
