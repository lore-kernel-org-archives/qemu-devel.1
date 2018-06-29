Received: from eggs.gnu.org ([2001:4830:134:3::10]:46574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fYkoA-0003hv-6P
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 00:14:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fYko9-0003o3-0J
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 00:14:54 -0400
Date: Fri, 29 Jun 2018 13:33:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180629033304.GA3422@umbus.fritz.box>
References: <20180626161921.27941-1-richard.henderson@linaro.org>
	<20180626161921.27941-3-richard.henderson@linaro.org>
	<20180628034955.GB23134@umbus.fritz.box>
	<15d41b89-b239-c082-f3c7-9c28a0c54958@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <15d41b89-b239-c082-f3c7-9c28a0c54958@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 02/13] target/ppc: Use atomic load for LQ
 and LQARX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 28, 2018 at 08:22:38AM -0700, Richard Henderson wrote:
> On 06/27/2018 08:49 PM, David Gibson wrote:
> >> +    /* High part of 128-bit helper return.  */
> >> +    uint64_t retxh;
> >> +
> >=20
> > Adding a temporary here is kind of gross.  I guess the helper
> > interface doesn't allow for 128-bit returns, but couldn't you pass a
> > register number into the helper and have it update the right GPR
> > without going through a temp?
>=20
> I could pass a pointer, but that would cause ...
>=20
> >> +#if defined(TARGET_PPC64) && defined(CONFIG_ATOMIC128)
> >> +DEF_HELPER_FLAGS_3(lq_le_parallel, TCG_CALL_NO_WG, i64, env, tl, i32)
> >> +DEF_HELPER_FLAGS_3(lq_be_parallel, TCG_CALL_NO_WG, i64, env, tl, i32)
>=20
> ... the helper definitions to lose TCG_CALL_NO_WG, because they *would* w=
rite
> to a global register.  Which would cause TCG to discard all of the global=
 guest
> registers cached within host registers.
>=20
> I've used this secondary memory return before, in target/s390,
> and to me it seems cleaner than pointers.

Ok, sounds reasonable, applied to ppc-for-3.0.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls1qG0ACgkQbDjKyiDZ
s5Kd4Q/9Fx6CTCnDYI3fAB+CNc2XZXt7enbKrqDy7An88XffCj8ViUvzqObo7Rcu
x1rN14uI/Z5oGzIaIM71X+pPsqaAvtmA8QKyG2rcMovWI1Q/pZb6DFifKnURwPBo
yxhEDiU7nFxINYtWGc7aTwh/2lWl3nknxqqUZvWWew7OCNoI3CD1oa5g4Tz/Vg6R
g9ZaIKdUxHhq1pgyJshT7Ox7419WVXlZXXerFXpgzwPJY6+8hp5PZIHc9AAnl4/0
zhxBwzXmjG94ljUhHmWPO4GeWMUNewXrcmsqdBEm+MdaotN6hAAfm+lyv052eRUs
g9l959KOl2U8EmOcUBX3+RyD/2fa1xy6nsN4i+nzUT6NeBoYYIyQp1RgANXthIKp
FqtuWbiufr3Eu57+76gtYsejODLedyZ3j702/KC91v9WaLrUz68G78zHhfQIsucO
dbax/5EgAelPiDnrt4ozWAb378Sw6WiJ5+UEcSYhnbYsicBodoFCy2vTWCVAGBuD
Cotjbc+WAvEHumTfovXP+G+QwlIV8ZSe6lSUmIHP3cxO/aRDulkN7Gkmezcx5AHq
Y3w2ZiODSEh4aFy3uHTt19pC1gamxh+ObQby7l3aw23fQr+ldb/pJiajrDeu/LoP
UX6+ZfFMzYEJHz+SqtQFYSIO/5dXCSt0Tj/ZZ7SDh8pDGU3KvCg=
=ZWN3
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
