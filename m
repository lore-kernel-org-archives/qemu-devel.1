Received: from eggs.gnu.org ([2001:4830:134:3::10]:33288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1fZ8Os-00014G-Ht
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 01:26:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1fZ8On-0005pV-JQ
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 01:26:22 -0400
Received: from mout.web.de ([212.227.15.3]:60347)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.kiszka@web.de>) id 1fZ8On-0005o6-8R
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 01:26:17 -0400
References: <cover.1522769774.git.jan.kiszka@web.de>
	<fb0c41863e19c760eca91a71a86eb391147d083d.1522769774.git.jan.kiszka@web.de>
	<dff77a32-ef43-192f-2e36-16067052a60e@redhat.com>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <6d1d6901-3fc8-8d0d-68f4-2dcce8086018@web.de>
Date: Sat, 30 Jun 2018 07:25:53 +0200
MIME-Version: 1.0
In-Reply-To: <dff77a32-ef43-192f-2e36-16067052a60e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="8AaaYSTAfNEUyGX0a65AIoE6He5hzGiHz"
Subject: Re: [Qemu-devel] [PATCH v2 4/4] target-i386: Add NPT support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Valentine Sinitsyn <valentine.sinitsyn@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8AaaYSTAfNEUyGX0a65AIoE6He5hzGiHz
From: Jan Kiszka <jan.kiszka@web.de>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Valentine Sinitsyn <valentine.sinitsyn@gmail.com>
Message-ID: <6d1d6901-3fc8-8d0d-68f4-2dcce8086018@web.de>
Subject: Re: [PATCH v2 4/4] target-i386: Add NPT support
References: <cover.1522769774.git.jan.kiszka@web.de>
 <fb0c41863e19c760eca91a71a86eb391147d083d.1522769774.git.jan.kiszka@web.de>
 <dff77a32-ef43-192f-2e36-16067052a60e@redhat.com>
In-Reply-To: <dff77a32-ef43-192f-2e36-16067052a60e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-27 14:14, Paolo Bonzini wrote:
> On 03/04/2018 17:36, Jan Kiszka wrote:
>> =20
>> +static hwaddr get_hphys(CPUState *cs, hwaddr gphys, MMUAccessType acc=
ess_type,
>> +                        int *prot)
>> +{
>> +    CPUX86State *env =3D &X86_CPU(cs)->env;
>> +    uint64_t rsvd_mask =3D PG_HI_RSVD_MASK;
>> +    uint64_t ptep, pte;
>> +    uint64_t exit_info_1 =3D 0;
>> +    target_ulong pde_addr, pte_addr;
>> +    uint32_t page_offset;
>> +    int page_size;
>> +
>> +    if (likely(!(env->hflags & HF_NPT_MASK))) {
>> +        return gphys;
>> +    }
>=20
> hflags are a somewhat limited resource.  Can this go in hflags2?
>=20

Will have a look - I don't seen why not. Or is there any special
semantical difference between both fields?

>>
>> +
>> +        env->nested_pg_mode =3D 0;
>> +        if (env->cr[4] & CR4_PAE_MASK) {
>> +            env->nested_pg_mode |=3D SVM_NPT_PAE;
>> +        }
>> +        if (env->hflags & HF_LMA_MASK) {
>> +            env->nested_pg_mode |=3D SVM_NPT_LMA;
>> +        }
>> +        if (env->efer & MSR_EFER_NXE) {
>> +            env->nested_pg_mode |=3D SVM_NPT_NXE;
>> +        }
>> +    }
>> +
>=20
> This needs to be migrated.  You can put it in a subsection, conditional=

> on hflags & HF_SVMI_MASK.

OK.

>=20
> Also, do you need to flush the TLB unconditionally, even if CR0.PG is z=
ero?
Cannot follow you here yet. What flush are you referring to?

Also, CR0.PG would not reflect if NPT is on, which now also contributes
to our TLB.

>=20
> Otherwise looks good.  I have queued patches 1-3, but hopefully this on=
e
> can go in the next release too.  Sorry for the delayed review.

No problem.

Thanks,
Jan


--8AaaYSTAfNEUyGX0a65AIoE6He5hzGiHz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTKX4wA9fvIVGYBbICK1KxveuXnFAUCWzcUYQAKCRCK1KxveuXn
FOf+AJ49N2nsujg1GEZs8DN6b2JGt6yatQCgr5DdIRHaNYApsZgfYdaWzWsT2Vc=
=FofS
-----END PGP SIGNATURE-----

--8AaaYSTAfNEUyGX0a65AIoE6He5hzGiHz--
