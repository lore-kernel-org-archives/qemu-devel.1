Received: from eggs.gnu.org ([2001:4830:134:3::10]:46661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fYkoT-0003xy-J1
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 00:15:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fYkoR-0004IF-Va
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 00:15:13 -0400
Date: Fri, 29 Jun 2018 14:15:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180629041503.GE3422@umbus.fritz.box>
References: <20180626161921.27941-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BZaMRJmqxGScZ8Mx"
Content-Disposition: inline
In-Reply-To: <20180626161921.27941-1-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 00/13] target/ppc improve atomic operations
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


--BZaMRJmqxGScZ8Mx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 26, 2018 at 09:19:08AM -0700, Richard Henderson wrote:
> In another patch set this week, I had noticed the old linux-user
> do_store_exclusive code was still present.  I had thought that was
> dead code that simply hadn't been removed, but it turned out that
> we had not completed the transition to tcg atomics for linux-user.
>=20
> In the process, I discovered that we weren't using atomic operations
> for the 128-bit lq, lqarx, and stqcx insns.  These would have simply
> produced incorrect results for -smp in system mode.
>=20
> I tidy the code a bit by making use of MO_ALIGN, which means that
> we don't need a separate explicit alignment check.
>=20
> I use the new min/max atomic operations I added recently for
> ARMv8.2-Atomics and RISC-V.
>=20
> Finally, Power9 has some *really* odd atomic operations in its
> l[wd]at and st[wd]at instructions.  We were generating illegal
> instruction for these.  I implement them for serial context and
> force parallel context to grab the exclusive lock and try again.
>=20
> Except for the trivial linux-user ll/sc case, I do not have any
> code that exercises these instructions.  Perhaps the IBM folk
> have something that can test the others?

I've now applied the whole series to ppc-for-3.0.

>=20
>=20
> r~
>=20
>=20
> Richard Henderson (13):
>   target/ppc: Add do_unaligned_access hook
>   target/ppc: Use atomic load for LQ and LQARX
>   target/ppc: Use atomic store for STQ
>   target/ppc: Use atomic cmpxchg for STQCX
>   target/ppc: Remove POWERPC_EXCP_STCX
>   target/ppc: Tidy gen_conditional_store
>   target/ppc: Split out gen_load_locked
>   target/ppc: Split out gen_ld_atomic
>   target/ppc: Split out gen_st_atomic
>   target/ppc: Use MO_ALIGN for EXIWX and ECOWX
>   target/ppc: Use atomic min/max helpers
>   target/ppc: Implement the rest of gen_ld_atomic
>   target/ppc: Implement the rest of gen_st_atomic
>=20
>  target/ppc/cpu.h                |   8 +-
>  target/ppc/helper.h             |  11 +
>  target/ppc/internal.h           |   5 +
>  linux-user/ppc/cpu_loop.c       | 123 ++----
>  target/ppc/excp_helper.c        |  18 +-
>  target/ppc/mem_helper.c         |  72 +++-
>  target/ppc/translate.c          | 648 ++++++++++++++++++++------------
>  target/ppc/translate_init.inc.c |   1 +
>  8 files changed, 539 insertions(+), 347 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BZaMRJmqxGScZ8Mx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls1skcACgkQbDjKyiDZ
s5Lduw/+ImSbmrwN4fs4WLK1yzEi1J8MCscdHzXJaQew5nHM25zDxNPVzicXplZH
Z1Ee/rhocXVWvpdoORnRqXxbRlGTp07yT0qYQjQWnkqvIFHsuXzEyQYJZFbwbGOR
wpRUK9D46Fxbl2/A+E6oejH/5PLotOfvZZuetdikLURf3NewUjE7aMRUI30YBKuK
GwXzWczeChAjZj7AxGvNG8SvS5VnZpIbX0AQpzJSh5LYQrIVzPf3KQrbYbx3MML0
+ogAohRoGutyaWIV4Qh/wqmpMZxAzrrZANVSd5d3Cd1mVAQCmtD/nNYn14FOtkXW
VphzrijBUcfu9XuC1HHAgyzhOoRvGYDZNj8NJgSyKJO6LZOm2zNbwLROTwhRTrAf
0LfD6DVVZONxgvn7FgMKAheTWFLlaUZE34YmXUXooM/HblJc57p4Y0gyXe+7Xae3
wLCJzjPeRIZKBTKYEacqj/rdfITz4YceBv9R8NTYahfqJdfcsiVGJOGKjEnmBqUC
33N+xWxpZVZaIlVE5mvNtU/W/GNSpOHJvXxrRzXALqwgtKl9vmZDdmfxpXpnCn3Z
cIyuHY0JMumaqINN6Zl6yA+JnWY0dQVlVutX4W2lKfJVFpTyFiyiPP+97SSKdiXn
L3XHTfIIavxt0pFLPxja5pCoTaxD6UnEPWeQzA87IgNvETBlAe8=
=Hldo
-----END PGP SIGNATURE-----

--BZaMRJmqxGScZ8Mx--
