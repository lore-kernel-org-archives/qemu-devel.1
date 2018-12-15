Received: from eggs.gnu.org ([2001:4830:134:3::10]:59199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gYPlQ-0005oi-Qn
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 01:18:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gYPlP-0008Q3-1x
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 01:18:56 -0500
Date: Sat, 15 Dec 2018 20:09:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181215090900.GQ29278@umbus.fritz.box>
References: <20181213040126.6768-1-david@gibson.dropbear.id.au>
	<CAFEAcA_4xV2M0Tgw6KSSQ7DOhv3r=FhETH_Yhmg2h0UT3AYS9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hIO1AjEoFJ7b3ahE"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_4xV2M0Tgw6KSSQ7DOhv3r=FhETH_Yhmg2h0UT3AYS9g@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/27] ppc-for-4.0 queue 20181213
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: gkurz@kaod.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Laurent Vivier <lvivier@redhat.com>, spopovyc@redhat.com, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>


--hIO1AjEoFJ7b3ahE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 14, 2018 at 04:03:08PM +0000, Peter Maydell wrote:
> On Thu, 13 Dec 2018 at 04:01, David Gibson <david@gibson.dropbear.id.au> =
wrote:
> >
> > The following changes since commit 4b3aab204204ca742836219b97b538d90584=
f4f2:
> >
> >   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-patches-pu=
ll-request' into staging (2018-12-11 22:26:44 +0000)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/dgibson/qemu.git tags/ppc-for-4.0-20181213
> >
> > for you to fetch changes up to 67888a17b6683600ae3fa64ca275c737ba8a9a45:
> >
> >   spapr/xive: use the VCPU id as a NVT identifier (2018-12-13 09:44:04 =
+1100)
> >
> > ----------------------------------------------------------------
> > ppc patch queue 2018-12-13
> >
> > Here's the first ppc and spapr pull request for 4.0.  Highlights are:
> >
> >  * The start of support for the POWER9 "XIVE" interrupt controller
> >    (not complete enough to use yet, but we're getting there)
> >  * A number of g_new vs. g_malloc cleanups
> >  * Some IRQ wiring cleanups
> >  * A fix for how we advertise NUMA nodes to the guest for pseries
> >
> > ---------------------------------------------------------------
>=20
>=20
> Compile errors in the windows cross-build. These look like
> they're assumptions that "long" is 64 bits, which it is not on Windows.
> For instance the PPC_BIT macro should be using the ULL suffix, not UL
> ("UL" is almost always a bug: either the constant is 32-bit, in
> which case "U" is what you want, or it's 64-bit and you need "ULL").

Bother, sorry.  I got sidetracked debugging some problems that turned
out to be in master and forgot to run the windows builds.


> Using __builtin_ffsl() directly in target/ppc/cpu.h also looks
> a bit dubious -- this should be rephrased to use ctz32() or ctz64()
> instead.
>=20
> In file included from /home/petmay01/qemu-for-merges/hw/intc/xive.c:13:0:
> /home/petmay01/qemu-for-merges/hw/intc/xive.c: In function 'xive_router_n=
otify':
> /home/petmay01/qemu-for-merges/target/ppc/cpu.h:76:33: error: overflow
> in implicit constant conversion [-Werror=3Doverflow]
>  #define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(b=
s))
>                                  ^
> /home/petmay01/qemu-for-merges/target/ppc/cpu.h:84:50: note: in
> definition of macro 'MASK_TO_LSH'
>  # define MASK_TO_LSH(m)          (__builtin_ffsl(m) - 1)
>                                                   ^
> /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:129:34:
> note: in expansion of macro 'GETFIELD'
>  #define GETFIELD_BE64(m, v)      GETFIELD(m, be64_to_cpu(v))
>                                   ^
> /home/petmay01/qemu-for-merges/hw/intc/xive.c:1366:28: note: in
> expansion of macro 'GETFIELD_BE64'
>                             GETFIELD_BE64(EAS_END_BLOCK, eas.w),
>                             ^
> /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:120:25:
> note: in expansion of macro 'PPC_BITMASK'
>  #define EAS_END_BLOCK   PPC_BITMASK(4, 7)        /* Destination END bloc=
k# */
>                          ^
> /home/petmay01/qemu-for-merges/hw/intc/xive.c:1366:42: note: in
> expansion of macro 'EAS_END_BLOCK'
>                             GETFIELD_BE64(EAS_END_BLOCK, eas.w),
>                                           ^
> /home/petmay01/qemu-for-merges/target/ppc/cpu.h:89:46: error: right
> shift count is negative [-Werror=3Dshift-count-negative]
>  #define GETFIELD(m, v)          (((v) & (m)) >> MASK_TO_LSH(m))
>                                               ^
> /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:129:34:
> note: in expansion of macro 'GETFIELD'
>  #define GETFIELD_BE64(m, v)      GETFIELD(m, be64_to_cpu(v))
>                                   ^
> /home/petmay01/qemu-for-merges/hw/intc/xive.c:1366:28: note: in
> expansion of macro 'GETFIELD_BE64'
>                             GETFIELD_BE64(EAS_END_BLOCK, eas.w),
>                             ^
> /home/petmay01/qemu-for-merges/target/ppc/cpu.h:76:33: error: overflow
> in implicit constant conversion [-Werror=3Doverflow]
>  #define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(b=
s))
>                                  ^
> /home/petmay01/qemu-for-merges/target/ppc/cpu.h:84:50: note: in
> definition of macro 'MASK_TO_LSH'
>  # define MASK_TO_LSH(m)          (__builtin_ffsl(m) - 1)
>                                                   ^
> /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:129:34:
> note: in expansion of macro 'GETFIELD'
>  #define GETFIELD_BE64(m, v)      GETFIELD(m, be64_to_cpu(v))
>                                   ^
> /home/petmay01/qemu-for-merges/hw/intc/xive.c:1367:28: note: in
> expansion of macro 'GETFIELD_BE64'
>                             GETFIELD_BE64(EAS_END_INDEX, eas.w),
>                             ^
> /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:121:25:
> note: in expansion of macro 'PPC_BITMASK'
>  #define EAS_END_INDEX   PPC_BITMASK(8, 31)       /* Destination END inde=
x */
>                          ^
> /home/petmay01/qemu-for-merges/hw/intc/xive.c:1367:42: note: in
> expansion of macro 'EAS_END_INDEX'
>                             GETFIELD_BE64(EAS_END_INDEX, eas.w),
>                                           ^
> /home/petmay01/qemu-for-merges/target/ppc/cpu.h:89:46: error: right
> shift count is negative [-Werror=3Dshift-count-negative]
>  #define GETFIELD(m, v)          (((v) & (m)) >> MASK_TO_LSH(m))
>                                               ^
> /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:129:34:
> note: in expansion of macro 'GETFIELD'
>  #define GETFIELD_BE64(m, v)      GETFIELD(m, be64_to_cpu(v))
>                                   ^
> /home/petmay01/qemu-for-merges/hw/intc/xive.c:1367:28: note: in
> expansion of macro 'GETFIELD_BE64'
>                             GETFIELD_BE64(EAS_END_INDEX, eas.w),
>                             ^
> /home/petmay01/qemu-for-merges/hw/intc/xive.c: In function
> 'xive_eas_pic_print_info':
> /home/petmay01/qemu-for-merges/target/ppc/cpu.h:76:33: error: overflow
> in implicit constant conversion [-Werror=3Doverflow]
>  #define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(b=
s))
>                                  ^
> /home/petmay01/qemu-for-merges/target/ppc/cpu.h:84:50: note: in
> definition of macro 'MASK_TO_LSH'
>  # define MASK_TO_LSH(m)          (__builtin_ffsl(m) - 1)
>                                                   ^
> /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:129:34:
> note: in expansion of macro 'GETFIELD'
>  #define GETFIELD_BE64(m, v)      GETFIELD(m, be64_to_cpu(v))
>                                   ^
> /home/petmay01/qemu-for-merges/hw/intc/xive.c:1400:31: note: in
> expansion of macro 'GETFIELD_BE64'
>                     (uint8_t)  GETFIELD_BE64(EAS_END_BLOCK, eas->w),
>                                ^
> /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:120:25:
> note: in expansion of macro 'PPC_BITMASK'
>  #define EAS_END_BLOCK   PPC_BITMASK(4, 7)        /* Destination END bloc=
k# */
>                          ^
> /home/petmay01/qemu-for-merges/hw/intc/xive.c:1400:45: note: in
> expansion of macro 'EAS_END_BLOCK'
>                     (uint8_t)  GETFIELD_BE64(EAS_END_BLOCK, eas->w),
>                                              ^
> /home/petmay01/qemu-for-merges/target/ppc/cpu.h:89:46: error: right
> shift count is negative [-Werror=3Dshift-count-negative]
>  #define GETFIELD(m, v)          (((v) & (m)) >> MASK_TO_LSH(m))
>                                               ^
> /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:129:34:
> note: in expansion of macro 'GETFIELD'
>  #define GETFIELD_BE64(m, v)      GETFIELD(m, be64_to_cpu(v))
>                                   ^
> /home/petmay01/qemu-for-merges/hw/intc/xive.c:1400:31: note: in
> expansion of macro 'GETFIELD_BE64'
>                     (uint8_t)  GETFIELD_BE64(EAS_END_BLOCK, eas->w),
>                                ^
> /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:120:25:
> note: in expansion of macro 'PPC_BITMASK'
>  #define EAS_END_BLOCK   PPC_BITMASK(4, 7)        /* Destination END bloc=
k# */
>                          ^
> /home/petmay01/qemu-for-merges/hw/intc/xive.c:1400:45: note: in
> expansion of macro 'EAS_END_BLOCK'
>                     (uint8_t)  GETFIELD_BE64(EAS_END_BLOCK, eas->w),
>                                              ^
> /home/petmay01/qemu-for-merges/target/ppc/cpu.h:89:46: error: right
> shift count is negative [-Werror=3Dshift-count-negative]
>  #define GETFIELD(m, v)          (((v) & (m)) >> MASK_TO_LSH(m))
>                                               ^
> /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:129:34:
> note: in expansion of macro 'GETFIELD'
>  #define GETFIELD_BE64(m, v)      GETFIELD(m, be64_to_cpu(v))
>                                   ^
> /home/petmay01/qemu-for-merges/hw/intc/xive.c:1400:31: note: in
> expansion of macro 'GETFIELD_BE64'
>                     (uint8_t)  GETFIELD_BE64(EAS_END_BLOCK, eas->w),
>                                ^
> /home/petmay01/qemu-for-merges/target/ppc/cpu.h:76:33: error: overflow
> in implicit constant conversion [-Werror=3Doverflow]
>  #define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(b=
s))
>                                  ^
> /home/petmay01/qemu-for-merges/target/ppc/cpu.h:84:50: note: in
> definition of macro 'MASK_TO_LSH'
>  # define MASK_TO_LSH(m)          (__builtin_ffsl(m) - 1)
>                                                   ^
> /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:129:34:
> note: in expansion of macro 'GETFIELD'
>  #define GETFIELD_BE64(m, v)      GETFIELD(m, be64_to_cpu(v))
>                                   ^
> /home/petmay01/qemu-for-merges/hw/intc/xive.c:1401:31: note: in
> expansion of macro 'GETFIELD_BE64'
>                     (uint32_t) GETFIELD_BE64(EAS_END_INDEX, eas->w),
>                                ^
> /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:121:25:
> note: in expansion of macro 'PPC_BITMASK'
>  #define EAS_END_INDEX   PPC_BITMASK(8, 31)       /* Destination END inde=
x */
>                          ^
> /home/petmay01/qemu-for-merges/hw/intc/xive.c:1401:45: note: in
> expansion of macro 'EAS_END_INDEX'
>                     (uint32_t) GETFIELD_BE64(EAS_END_INDEX, eas->w),
>                                              ^
> /home/petmay01/qemu-for-merges/target/ppc/cpu.h:89:46: error: right
> shift count is negative [-Werror=3Dshift-count-negative]
>  #define GETFIELD(m, v)          (((v) & (m)) >> MASK_TO_LSH(m))
>                                               ^
> /home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:129:34:
> note: in expansion of macro 'GETFIELD'
>  #define GETFIELD_BE64(m, v)      GETFIELD(m, be64_to_cpu(v))
>                                   ^
> /home/petmay01/qemu-for-merges/hw/intc/xive.c:1401:31: note: in
> expansion of macro 'GETFIELD_BE64'
>                     (uint32_t) GETFIELD_BE64(EAS_END_INDEX, eas->w),
>                                ^
>=20
>=20
> thanks
> -- PMM
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hIO1AjEoFJ7b3ahE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwUxKwACgkQbDjKyiDZ
s5Iz3BAAsi05f9vbQq9DAVHXe7hsFMUBOcxvE0Y9/UxNPkKt57dThnPvPqTRWKAx
S9DsU1WK4o6mSEQlx2cptUuA32yvIE3J+GsXq7Hphvn7ybZogYIy6YGmNU+JWUod
RzOcNPAwxk/tmEx6ueMS3yq8BOWB3a8bnTbWvmdLlj5VetKIbsGfoc1x7IySQE6X
LnXsavhXZr92Ul79zuqhQ+Aw4bVL06SQeTRACQakEN4aFWjJrAlvrgVWDzY78OVL
hu36nbfToD1VbxBGcg+JWMa7Hy2dI86fSaZZR+WafT7BWqBFxR3dktca/3ohY4fH
9wgwlRs5pgv6gaxD0d8dI2GbYdaKlJMjy5L2nk53SDiFEc/2Rs9wKGmX6LlBtGLf
cYervAZwTo354iImloL+VHB7rB7KgtCVJtxDtlLWbdl01aC60l4tZawfmaPMhs70
209dwkjGyxJJ61pQW3c9NGvKFjtr6WxWTkX8FNvn59sh+ZSdvFT5Tga8m/OWqSa1
cwS0wqO8UcQpkWHaaEhd558G8tu6IO2jD4xyFfiDhrUdcEsgMq12678d7QH4g0Td
VoIUOGa/uwvGQaPWCI9/O7UtM61/6msIZB1ZgfY0/vR30Edqo4R0UsdcBUjffU1u
LE4Im54hth2Q9yIzIq7JPM+p6AEmal9P6XeHsWg2Oe6LdvDDEFc=
=xLiW
-----END PGP SIGNATURE-----

--hIO1AjEoFJ7b3ahE--
