Received: from eggs.gnu.org ([2001:4830:134:3::10]:36488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgm1B-0003JV-Bn
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 00:32:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgm1A-0003Rm-BD
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 00:32:41 -0500
Date: Thu, 23 Feb 2017 16:32:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170223053230.GC12616@umbus.fritz.box>
References: <1487763883-4877-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487763883-4877-4-git-send-email-nikunj@linux.vnet.ibm.com>
	<20170223032118.GD12577@umbus.fritz.box>
	<87d1e9trvo.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MnLPg7ZWsaic7Fhd"
Content-Disposition: inline
In-Reply-To: <87d1e9trvo.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH v3 03/10] target/ppc: support for 32-bit
 carry and overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, rth@twiddle.net, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com


--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 23, 2017 at 10:39:47AM +0530, Nikunj A Dadhania wrote:
> David Gibson <david@gibson.dropbear.id.au> writes:
> >>=20
> >> diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
> >> index de3004b..89c1ccb 100644
> >> --- a/target/ppc/cpu.c
> >> +++ b/target/ppc/cpu.c
> >> @@ -23,8 +23,15 @@
> >> =20
> >>  target_ulong cpu_read_xer(CPUPPCState *env)
> >>  {
> >> -    return env->xer | (env->so << XER_SO) | (env->ov << XER_OV) |
> >> +    target_ulong xer;
> >> +
> >> +    xer =3D env->xer | (env->so << XER_SO) | (env->ov << XER_OV) |
> >>          (env->ca << XER_CA);
> >> +
> >> +    if (is_isa300(env)) {
> >> +        xer |=3D (env->ov32 << XER_OV32) | (env->ca32 << XER_CA32);
> >> +    }
> >> +    return xer;
> >>  }
> >> =20
> >>  void cpu_write_xer(CPUPPCState *env, target_ulong xer)
> >> @@ -32,5 +39,13 @@ void cpu_write_xer(CPUPPCState *env, target_ulong x=
er)
> >>      env->so =3D (xer >> XER_SO) & 1;
> >>      env->ov =3D (xer >> XER_OV) & 1;
> >>      env->ca =3D (xer >> XER_CA) & 1;
> >> -    env->xer =3D xer & ~((1u << XER_SO) | (1u << XER_OV) | (1u << XER=
_CA));
> >> +    if (is_isa300(env)) {
> >> +        env->ov32 =3D (xer >> XER_OV32) & 1;
> >> +        env->ca32 =3D (xer >> XER_CA32) & 1;
> >
> > I think these might as well be unconditional - as long as the read_xer
> > doesn't read the bits back, the guest won't care that we track them in
> > internal state.
>=20
> Sure.
>=20
>=20
> > I'm also wondering if it might be worth adding a xer_mask to the env,
> > instead of explicitly checking isa300 all over the place.
>=20
> Let me try that out.
>=20
> Can we also update ov32/ca32 in all the arithmetic operations as if its
> supported. And as you suggested, whenever there is a read attempted,
> only give relevant bits back(xer_mask). This would save lot of
> conditions in translations (couple of more tcg-ops for non-isa300)

So if it was a straight trade-off between conditions and math
operations, I'd pick the extra math every time.  However, in this case
we're trading off math on every execution, versus a condition only on
translation, which should occur less often.  So in this case I suspect
it's worth keeping the conditional.

> >> +        env->xer =3D xer & ~((1ul << XER_SO) |
> >> +                           (1ul << XER_OV) | (1ul << XER_CA) |
> >> +                           (1ul << XER_OV32) | (1ul << XER_CA32));
> >> +    } else {
> >> +        env->xer =3D xer & ~((1u << XER_SO) | (1u << XER_OV) | (1u <<=
 XER_CA));
> >> +    }
> >
> > And you can definitely use the stricer mask for both archs.  If it's
> > ISA300, you've stashed them elsewhere, if it's not those bits are
> > invalid anyway,
> >
> > (Incidentally given the modern balance between the cost of
> > instructions and cachelines, I wonder if all these split out bits of
> > the XER are a good idea in any case, but that would be a big change
> > out  of scope for what you're attempting here)
>=20
> Will have a look at this after finishing isa300. I have faced issues
> with RISU wrt having the state stashed in different tcg variables.

Thanks.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MnLPg7ZWsaic7Fhd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYrnPtAAoJEGw4ysog2bOSvXEQAJ11JYD9K7avzFCChsj16I+B
s/x8XxIovN3R7E/nrPnynOMhLfqdpXpTzdffjm0RyRa78aopJcV/5q8V/YP5WRc1
+8B9vjU68dN8N6uMBGPI7X18mITYt47kZPeNLXUJa/xqWUuuIhdVxWG8w0FLVVcC
rcordlTzXgT4a2RWFMXxEOyZ3haXY/DCLRMQemowYs1G1OF31nEVqNByDYeV3B/Z
KZh5o5Y7Q0oyBW8KD3Dxy0zMzA6pxQbc7VUsOwtWMT56P8Fejw1s6YuLnJwTe3O6
CdLLdVfD1Pvb6tHyjlicZ9utNX/4QDcWReCadySD9YSQDAyB2h6kFnhrWgoinf12
0uVT/WXEMG+qMrNkIezY04yeQ8akxN5Lihpt+yimLcVx+SFZElyCnrSqNP7/aQ7C
va1Hqk2QNkqVfSnR1juw1z4F76Hu8jDKx4vnQ18n8z30L6PdQbp8XaW2LZg7Bbw9
QODNxOWzUVMUaiGh304Hxuvert+AGcNJeQzYIrzOjls3+4iIXojZKqfUf1sJl2kz
s1KQpXMfMgV4kRCBfdRQoY0mqiGq31pux5XsHlGJ8aL3pXB5hA6gJuAAp5gYWvH8
F65HnxMNv2ORPvn5vJf/xtnvalMYxl2GIfudoi0/uVx+pZ04NU0u48ABPe8fyiH4
Rz5ffc14ZN2lP9uvktUa
=Hmyf
-----END PGP SIGNATURE-----

--MnLPg7ZWsaic7Fhd--
