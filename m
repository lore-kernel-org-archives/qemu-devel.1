Received: from eggs.gnu.org ([2001:4830:134:3::10]:59565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@antfield.fr>) id 1eEe3R-00018Y-GZ
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 11:27:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@antfield.fr>) id 1eEe3N-00040w-8U
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 11:27:17 -0500
References: <20171102103559.7382-1-luc.michel@git.antfield.fr>
	<20171102103559.7382-2-luc.michel@git.antfield.fr>
	<20171106061639.GA7813@umbus.fritz.box>
From: Luc Michel <luc.michel@antfield.fr>
Message-ID: <2f6bae4a-3489-5cb9-766c-5b8c6c447ac8@antfield.fr>
Date: Tue, 14 Nov 2017 17:28:48 +0100
MIME-Version: 1.0
In-Reply-To: <20171106061639.GA7813@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Hb4n75hCEVwgJqaT6TqBiVHCs1qjGgsqi"
Subject: Re: [Qemu-devel] [PATCH 1/1] target-ppc: Fix booke206 tlbwe TLB
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Luc MICHEL <luc.michel@git.antfield.fr>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Hb4n75hCEVwgJqaT6TqBiVHCs1qjGgsqi
From: Luc Michel <luc.michel@antfield.fr>
To: David Gibson <david@gibson.dropbear.id.au>,
 Luc MICHEL <luc.michel@git.antfield.fr>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>
Message-ID: <2f6bae4a-3489-5cb9-766c-5b8c6c447ac8@antfield.fr>
Subject: Re: [PATCH 1/1] target-ppc: Fix booke206 tlbwe TLB instruction
References: <20171102103559.7382-1-luc.michel@git.antfield.fr>
 <20171102103559.7382-2-luc.michel@git.antfield.fr>
 <20171106061639.GA7813@umbus.fritz.box>
In-Reply-To: <20171106061639.GA7813@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/06/2017 07:16 AM, David Gibson wrote:
> On Thu, Nov 02, 2017 at 11:35:59AM +0100, Luc MICHEL wrote:
>> When overwritting a valid TLB entry with a new one, the previous page
>> were not flushed in QEMU TLB, leading to incoherent mapping. This comm=
it
>> fixes this.
>=20
> I don't think this is right.  As a rule, overwriting a TLB entry
> doesn't necessarily invalidate the previous entry, even on real
> hardware.  I don't know exactly what the situation is on the various
> FSL BookE chips, but I know various other models have other caches
> ahead of the main TLB which can cache mappings that have been removed
> from it (e.g. the ERAT on server chips and the shadow TLBs on 4xx).
Indeed, e500 cores have a two-level TLB. tlbwe writes in L2, and L1 is
handled by the hardware and not visible to the user.

>=20
> To invalidate those other caches requires something other than simply
> a tlbwe (tlbie for the ERAT and an isync for the shadow TLBs).
Yes you are right. From "EREF 2.0: A Programmer=E2=80=99s Reference Manua=
l for
Freescale Power Architecture Processors, Rev. 0":

"A context synchronizing instruction is required after a tlbwe
instruction to ensure any subsequent instructions that will use the
updated TLB values execute in the new context."

Linux executes a msync followed by a isync after a tlbwe for BookE MMU
machines.

>=20
> The current behaviour won't exactly match what hardware does (and it's
> probably not practical to do so), but it should be within what's
> permitted by the architecture - and therefore good enough for correct
> guests.
>=20
> It's possible that we do need this for the BookE chips, but it'll need
> a more detailed rationale.
The one sentence from the "PowerPC e500 Core Family Reference Manual,
Rev. 1" document that makes my fix kind of correct is this one:

In 12.4.2 TLB Write Entry (tlbwe) Instruction:

"Note that when an L2 TLB entry is written, it may be displacing an
already valid entry in the same L2 TLB location (a victim). If a valid
L1 TLB entry corresponds to the L2 MMU victim entry, that L1 TLB entry
is automatically invalidated."

At least, it is as correct as the current tlb_flush in
"helper_booke206_tlbwe" function, since it does not wait for isync to
effectively invalidate the page.

>=20
>>
>> Signed-off-by: Luc MICHEL <luc.michel@git.antfield.fr>
>> ---
>>  target/ppc/mmu_helper.c | 23 ++++++++++++++++++-----
>>  1 file changed, 18 insertions(+), 5 deletions(-)
>>
>> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
>> index 2a1f9902c9..c2c89239b4 100644
>> --- a/target/ppc/mmu_helper.c
>> +++ b/target/ppc/mmu_helper.c
>> @@ -2570,6 +2570,17 @@ void helper_booke_setpid(CPUPPCState *env, uint=
32_t pidn, target_ulong pid)
>>      tlb_flush(CPU(cpu));
>>  }
>> =20
>> +static inline void flush_page(CPUPPCState *env, ppcmas_tlb_t *tlb)
>> +{
>> +    PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
>> +
>> +    if (booke206_tlb_to_page_size(env, tlb) =3D=3D TARGET_PAGE_SIZE) =
{
>> +        tlb_flush_page(CPU(cpu), tlb->mas2 & MAS2_EPN_MASK);
>> +    } else {
>> +        tlb_flush(CPU(cpu));
>> +    }
>> +}
>> +
>>  void helper_booke206_tlbwe(CPUPPCState *env)
>>  {
>>      PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
>> @@ -2628,6 +2639,12 @@ void helper_booke206_tlbwe(CPUPPCState *env)
>>      if (msr_gs) {
>>          cpu_abort(CPU(cpu), "missing HV implementation\n");
>>      }
>> +
>> +    if (tlb->mas1 & MAS1_VALID) {
>> +        /* Invalidate the page in QEMU TLB if it was a valid entry */=

>> +        flush_page(env, tlb);
>> +    }
>> +
>>      tlb->mas7_3 =3D ((uint64_t)env->spr[SPR_BOOKE_MAS7] << 32) |
>>          env->spr[SPR_BOOKE_MAS3];
>>      tlb->mas1 =3D env->spr[SPR_BOOKE_MAS1];
>> @@ -2663,11 +2680,7 @@ void helper_booke206_tlbwe(CPUPPCState *env)
>>          tlb->mas1 &=3D ~MAS1_IPROT;
>>      }
>> =20
>> -    if (booke206_tlb_to_page_size(env, tlb) =3D=3D TARGET_PAGE_SIZE) =
{
>> -        tlb_flush_page(CPU(cpu), tlb->mas2 & MAS2_EPN_MASK);
>> -    } else {
>> -        tlb_flush(CPU(cpu));
>> -    }
>> +    flush_page(env, tlb);
>>  }
>> =20
>>  static inline void booke206_tlb_to_mas(CPUPPCState *env, ppcmas_tlb_t=
 *tlb)
>=20


--Hb4n75hCEVwgJqaT6TqBiVHCs1qjGgsqi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAloLGcYACgkQd8knW3Qn
Tr5r8w/3fjokvLjGAjv7935brBK+mRKWDA3U5xmbbXPJlVXBCGf/47V6uOPgoes2
MR8fNrYgtKvWVXhDNVYwjpBhwaUTSWAkxYdXa8Z/6vnxxvtzW37JE54jwVOs9NL8
ATKI2GIZhwfrUbunUOFYaGShiDviDbDOyffZHeFBQhXDNcoumQJmCNk+j3sJXa7K
U8KhLPjlRYvv9Rr+DO8vDEMckwm68U+sUTIHZFUd3EplmoZG/fGmeQ/pyjOmEto0
DyGQji3j2QwJRurHed7LTQmKim8IugVBURHXNwp2rpudPKSfBEXYBvWJpun6S8So
MzmY/A3b/Dh+IqRzWyYvg9EyR0RIKc+ClftDPJ0XnNkb6DhTQLwXU8SBJkd/nDSZ
gaJVXsOXuddul3CCc4KrDXlFFmoTA6bY/hg1fpyKvnDymY9xAPNXByHEBYkDywmf
OxrXjd0bQcU05jaM5kFDi0Hp8c5ob6f5zNoWEimIyyZ00aaIE+dJSpKIXdnkzCvO
iXcRSQeLShIP+Khi0z3UxHlKLrDG2fORHrMDZOwwRMmSPFeC+Qqcq59Y4ivrTbsJ
IvVTX/pTw+UoapBC3xS/ZMv6lCoa10D8NbMI3/nvrbrs7kfDpcWfXkiC7ZlPXzVk
0RFsWWv/NuwurUsEN8F+6K2+LxzAW/8jBnvaGv/8i1VRncc9HQ==
=GjcY
-----END PGP SIGNATURE-----

--Hb4n75hCEVwgJqaT6TqBiVHCs1qjGgsqi--
