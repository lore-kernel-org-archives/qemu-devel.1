Received: from eggs.gnu.org ([2001:4830:134:3::10]:47580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1citDc-0003XL-5m
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 20:38:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1citDb-0001XU-6J
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 20:38:16 -0500
Date: Wed, 1 Mar 2017 11:12:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170301001207.GA12571@umbus.fritz.box>
References: <1485900317-3256-1-git-send-email-joserz@linux.vnet.ibm.com>
	<23319194-73e8-8edd-32e5-a8543b91fca9@vivier.eu>
	<20170228010905.GM17615@umbus.fritz.box>
	<227638f2-d9fc-c56d-78d1-09d6ee21a600@vivier.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <227638f2-d9fc-c56d-78d1-09d6ee21a600@vivier.eu>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] linux-user: fill target
 sigcontext struct accordingly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, qemu-devel@nongnu.org, riku.voipio@iki.fi, qemu-ppc@nongnu.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 28, 2017 at 11:22:54AM +0100, Laurent Vivier wrote:
> Le 28/02/2017 =E0 02:09, David Gibson a =E9crit :
> > On Wed, Feb 01, 2017 at 09:43:57PM +0100, Laurent Vivier wrote:
> >> Le 31/01/2017 =E0 23:05, Jose Ricardo Ziviani a =E9crit :
> >>> A segfault is noticed when an emulated program uses any of ucontext
> >>> regs fields. Risu detected this issue in the following operation when
> >>> handling a signal:
> >>>   ucontext_t *uc =3D (ucontext_t*)uc;
> >>>   uc->uc_mcontext.regs->nip +=3D 4;
> >>>
> >>> but this works fine:
> >>>   uc->uc_mcontext.gp_regs[PT_NIP] +=3D 4;
> >>>
> >>> This patch set regs to a valid location as well as other sigcontext
> >>> fields.
> >>>
> >>> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> >>> ---
> >>>  linux-user/signal.c | 5 +++++
> >>>  1 file changed, 5 insertions(+)
> >>>
> >>> diff --git a/linux-user/signal.c b/linux-user/signal.c
> >>> index 5064de0..8209539 100644
> >>> --- a/linux-user/signal.c
> >>> +++ b/linux-user/signal.c
> >>> @@ -5155,6 +5155,7 @@ static void setup_rt_frame(int sig, struct targ=
et_sigaction *ka,
> >>>      target_ulong rt_sf_addr, newsp =3D 0;
> >>>      int i, err =3D 0;
> >>>  #if defined(TARGET_PPC64)
> >>> +    struct target_sigcontext *sc =3D 0;
> >>>      struct image_info *image =3D ((TaskState *)thread_cpu->opaque)->=
info;
> >>>  #endif
> >>> =20
> >>> @@ -5183,6 +5184,10 @@ static void setup_rt_frame(int sig, struct tar=
get_sigaction *ka,
> >>>  #if defined(TARGET_PPC64)
> >>>      mctx =3D &rt_sf->uc.tuc_sigcontext.mcontext;
> >>>      trampptr =3D &rt_sf->trampoline[0];
> >>> +
> >>> +    sc =3D &rt_sf->uc.tuc_sigcontext;
> >>> +    __put_user(h2g(mctx), &sc->regs);
> >>> +    __put_user(sig, &sc->signal);
> >>>  #else
> >>>      mctx =3D &rt_sf->uc.tuc_mcontext;
> >>>      trampptr =3D (uint32_t *)&rt_sf->uc.tuc_mcontext.tramp;
> >>>
> >>
> >> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> >>
> >> This is correct, but QEMU and kernel implementation are really
> >> different.
> >=20
>=20
> Hi David,
>=20
> > Laurent, I'm a bit clear on what the upshot is here.
> >=20
> > Should I merge the patch above?
>=20
> I've already included this patch in a linux-user pull request a couple
> of weeks ago, and it is now in the master.
>=20
> So you have nothing to do :)

Excellent, thanks for the clarification.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYthHUAAoJEGw4ysog2bOSHX0QAOBqemeEydRh4wPOWNXueKzN
HijgkEXwlgfDsrAwjw+FiT516sibAysgW+6gtCmUefdTm1v32el6B1LVaEYrcC8n
bNasyPaz5LNAgQxS7516q9kPClPmPH8Tsg5f07EPKYqadQhVyC+Q4xzurygjIVIc
x8jyNbRnGlt+nf0hJPGgotpr1z7p6CII1fHRjzFjD9+causzz+XxMxLPHGkSyJ0h
c6//f+STSifobavaAQMxBg7zYr5ziV170hmc8+uaKkwYheQlYterg8zRBO+UmBxa
R8SNixmnKnOju6foSKZ4o51LMKrzgZDFZ2BcBt32d4ElDNok95wFi6K8eTVjf7zd
L5+5/mXm7Aww+GX9JQAZYCMSy6FXJZYEy4Qd8kydUMUoOYpuJh5MFuG29aD0GqJL
npGiYT7fkoNvqzfiIpeCtfvUabO1DPVWfJIRHwrBe6T5TTQz7NO0dwH0rLqrJdC/
L38vYudt6g+rwsLzSMd4JOTZHqHNGAjrv60IA8fNxP9e2j4AgnwB03fMKfo6vPxL
s6mgz76JEUjEKmOwOdz7MjYLQecaE8msCHxvryUT04TvLk6dTuPjRiYuvlcaYVJb
8e2HvMqzynLfQMgBm2+lUzBxlh11Pa3liJ1SFKpnrqwnkOp028B0Y9TU0ZSSwjt8
CG1xjKEmY4YCp+1BYT+i
=TbmU
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
