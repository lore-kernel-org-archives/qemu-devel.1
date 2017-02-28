Received: from eggs.gnu.org ([2001:4830:134:3::10]:35932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ciewB-0004xu-AL
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:23:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ciewA-0005WB-Ah
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:23:19 -0500
References: <1485900317-3256-1-git-send-email-joserz@linux.vnet.ibm.com>
	<23319194-73e8-8edd-32e5-a8543b91fca9@vivier.eu>
	<20170228010905.GM17615@umbus.fritz.box>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <227638f2-d9fc-c56d-78d1-09d6ee21a600@vivier.eu>
Date: Tue, 28 Feb 2017 11:22:54 +0100
MIME-Version: 1.0
In-Reply-To: <20170228010905.GM17615@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4R2WblvN6OdBNtIF5hVjvDLqc01RM03av"
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, qemu-devel@nongnu.org, riku.voipio@iki.fi, qemu-ppc@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4R2WblvN6OdBNtIF5hVjvDLqc01RM03av
From: Laurent Vivier <laurent@vivier.eu>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 riku.voipio@iki.fi, qemu-ppc@nongnu.org
Message-ID: <227638f2-d9fc-c56d-78d1-09d6ee21a600@vivier.eu>
Subject: Re: [Qemu-ppc] [Qemu-devel] [PATCH] linux-user: fill target
 sigcontext struct accordingly
References: <1485900317-3256-1-git-send-email-joserz@linux.vnet.ibm.com>
 <23319194-73e8-8edd-32e5-a8543b91fca9@vivier.eu>
 <20170228010905.GM17615@umbus.fritz.box>
In-Reply-To: <20170228010905.GM17615@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le 28/02/2017 =C3=A0 02:09, David Gibson a =C3=A9crit :
> On Wed, Feb 01, 2017 at 09:43:57PM +0100, Laurent Vivier wrote:
>> Le 31/01/2017 =C3=A0 23:05, Jose Ricardo Ziviani a =C3=A9crit :
>>> A segfault is noticed when an emulated program uses any of ucontext
>>> regs fields. Risu detected this issue in the following operation when=

>>> handling a signal:
>>>   ucontext_t *uc =3D (ucontext_t*)uc;
>>>   uc->uc_mcontext.regs->nip +=3D 4;
>>>
>>> but this works fine:
>>>   uc->uc_mcontext.gp_regs[PT_NIP] +=3D 4;
>>>
>>> This patch set regs to a valid location as well as other sigcontext
>>> fields.
>>>
>>> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
>>> ---
>>>  linux-user/signal.c | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/linux-user/signal.c b/linux-user/signal.c
>>> index 5064de0..8209539 100644
>>> --- a/linux-user/signal.c
>>> +++ b/linux-user/signal.c
>>> @@ -5155,6 +5155,7 @@ static void setup_rt_frame(int sig, struct targ=
et_sigaction *ka,
>>>      target_ulong rt_sf_addr, newsp =3D 0;
>>>      int i, err =3D 0;
>>>  #if defined(TARGET_PPC64)
>>> +    struct target_sigcontext *sc =3D 0;
>>>      struct image_info *image =3D ((TaskState *)thread_cpu->opaque)->=
info;
>>>  #endif
>>> =20
>>> @@ -5183,6 +5184,10 @@ static void setup_rt_frame(int sig, struct tar=
get_sigaction *ka,
>>>  #if defined(TARGET_PPC64)
>>>      mctx =3D &rt_sf->uc.tuc_sigcontext.mcontext;
>>>      trampptr =3D &rt_sf->trampoline[0];
>>> +
>>> +    sc =3D &rt_sf->uc.tuc_sigcontext;
>>> +    __put_user(h2g(mctx), &sc->regs);
>>> +    __put_user(sig, &sc->signal);
>>>  #else
>>>      mctx =3D &rt_sf->uc.tuc_mcontext;
>>>      trampptr =3D (uint32_t *)&rt_sf->uc.tuc_mcontext.tramp;
>>>
>>
>> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
>>
>> This is correct, but QEMU and kernel implementation are really
>> different.
>=20

Hi David,

> Laurent, I'm a bit clear on what the upshot is here.
>=20
> Should I merge the patch above?

I've already included this patch in a linux-user pull request a couple
of weeks ago, and it is now in the master.

So you have nothing to do :)

Thanks,
Laurent


--4R2WblvN6OdBNtIF5hVjvDLqc01RM03av
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYtU9+AAoJEPMMOL0/L748rlYQAJKoFPpSizZN6ZfniWciAKIe
bIBbLHfH2jmOkMTQ3oaXWwGvs52a+4vI6Nr5+eTmxFrptPSfnNcRdmIU8X0qWm4/
4z3dXNN5Y5CTKW74Rmhvik4pOZYOqQpiBtzybnGGo0PoEH/t2yZRLpbby/C+upJV
nKR0rLX6HCrdJTEOSyC4mwK10MLOaIwMceLZ/keu8TCvol2IUxaL4a60hix2SeDP
/Xn0GznuDsx14kdJ3ZYCeW9+7gLiJ+eR8zssGlrle1iuVEMkuWMtwz6peaBCLGLA
LaZVIT5ll+3UqSOeLYRlnMuvgc8MhMuek93RMcDIRCUrRegefxXqBpxx1xO8mEXh
lqox3ccuScJPzzUWEa9L4ktH1DHZowbv99Kqpo8zh6pD4CRfA17vpTP8bl44LRgv
d5OjQq8waQPHSHDacN267y2mWow4BVr2vTNlSUzU6yiNgW5QwAoEmaBb/+mjVYVk
xZ5ZVFyZF6x/3PG/Zx/rxNFz0Yj/OBAm7Cy4NB0oDLa9XfooP1pqGzhC6loSuSLu
7200+eXrGjJ5KIque351Y0AsbtC0ADczU9a67DTpp+timmEpx68oIkarxdLL6tQB
pLlQYImTMeEw8xfO5nP4Y9T4wCVm3ARJztlh99o3YVe5O8vCuBWn988Q+5uhDsUl
Ck3LzUMjHSL6LxsaRsfs
=XZXe
-----END PGP SIGNATURE-----

--4R2WblvN6OdBNtIF5hVjvDLqc01RM03av--
