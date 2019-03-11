Received: from eggs.gnu.org ([209.51.188.92]:54467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1h3HQF-0008Ua-7o
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:40:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1h3HQD-00005I-VI
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:40:39 -0400
Received: from 8.mo178.mail-out.ovh.net ([46.105.74.227]:58842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1h3HQD-0008VU-KI
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:40:37 -0400
Received: from player746.ha.ovh.net (unknown [10.109.146.175])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 34F4A58350
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 10:40:35 +0100 (CET)
Date: Mon, 11 Mar 2019 10:40:25 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190311104025.1e62250a@bahia.lan>
In-Reply-To: <20190306031622.GI19715@umbus.fritz.box>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
	<20190226045304.25618-31-david@gibson.dropbear.id.au>
	<CAFEAcA_S+Sq_5fMbVvXnSLsWzzVxKYA2zs8QH02H_xAAb+1+kA@mail.gmail.com>
	<20190306031622.GI19715@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/LFNiTp7Qk7KhnCEy63lOP.4";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PULL 30/50] spapr: Generate FDT fragment for LMBs
 at configure connector time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, groug@kaod.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>

--Sig_/LFNiTp7Qk7KhnCEy63lOP.4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

Just back from vacation.

On Wed, 6 Mar 2019 14:16:23 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Mar 05, 2019 at 04:10:20PM +0000, Peter Maydell wrote:
> > On Tue, 26 Feb 2019 at 04:53, David Gibson <david@gibson.dropbear.id.au=
> wrote: =20
> > >
> > > From: Greg Kurz <groug@kaod.org> =20
> >=20
> >=20
> > Hi -- Coverity points out a possible overflow here (CID 1399145):
> >  =20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 00eb3b643c..b92deee771 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -3333,14 +3333,26 @@ static void spapr_nmi(NMIState *n, int cpu_in=
dex, Error **errp)
> > >      }
> > >  }
> > >
> > > +int spapr_lmb_dt_populate(sPAPRDRConnector *drc, sPAPRMachineState *=
spapr,
> > > +                          void *fdt, int *fdt_start_offset, Error **=
errp)
> > > +{
> > > +    uint64_t addr;
> > > +    uint32_t node;
> > > +
> > > +    addr =3D spapr_drc_index(drc) * SPAPR_MEMORY_BLOCK_SIZE; =20
> >=20
> > This multiplication is done as a 32x32, which might overflow and
> > be truncated before the result is put into the 64-bit result.
> > Casting one side or the other to uint64_t would fix this. =20
>=20

Oops... I missed that :-\

> I've applied the following fix to my tree and will include it in the
> next pull request:
>=20
> From 07d93b239203f4fb655e42f6a8a194a4f9eb40a2 Mon Sep 17 00:00:00 2001
> From: David Gibson <david@gibson.dropbear.id.au>
> Date: Wed, 6 Mar 2019 14:15:26 +1100
> Subject: [PATCH] spapr: Force SPAPR_MEMORY_BLOCK_SIZE to be a hwaddr (64-=
bit)
>=20
> SPAPR_MEMORY_BLOCK_SIZE is logically a difference in memory addresses, and
> hence of type hwaddr which is 64-bit.  Previously it wasn't marked as such
> which means that it could be treated as 32-bit.  That will work in some
> circumstances but if multiplied by another 32-bit value it could lead to
> a 32-bit overflow and an incorrect result.
>=20
> One specific instance of this in spapr_lmb_dt_populate() was spotted by
> Coverity (CID 1399145).
>=20
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Thanks for the fix :-)

>  include/hw/ppc/spapr.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index ff1bd60615..1311ebe28e 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -792,7 +792,7 @@ int spapr_rtc_import_offset(sPAPRRTCState *rtc, int64=
_t legacy_offset);
> =20
>  #define TYPE_SPAPR_RNG "spapr-rng"
> =20
> -#define SPAPR_MEMORY_BLOCK_SIZE (1 << 28) /* 256MB */
> +#define SPAPR_MEMORY_BLOCK_SIZE ((hwaddr)1 << 28) /* 256MB */
> =20
>  /*
>   * This defines the maximum number of DIMM slots we can have for sPAPR


--Sig_/LFNiTp7Qk7KhnCEy63lOP.4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlyGLQkACgkQcdTV5YIv
c9aNTQ//YmRnqLHjlXOhTBTp540+oi13FxjwR9aFKUOCkF2M44E+1PaPQTiSAZ1F
DyPjwjcYBbTmv19L8jOb1A1SZDnVYALxg9EXuRHzTHAg5bILz4JM2rH6oXaL+Vci
WEARDOnNhmSU7b+FAmQtob6n85wvR/JN31p+BuCS9zSBEVq+lAXXB9G67FVWTR3/
IdvO2l8aLS4APBSBpdKO5V+q4JUVuv51LfwmHyYu8p/oc297K6Fmx/69eQj9tB1H
8/OGol3LLkAbHOQ16DunPzyrhCNkitY0og2rFdrlLAaZmlfPUZRt0vySk5sTBjJW
zfWzCy19eQhcpOFo9FDt76ypI23zIVr2bPWHaiB/mpXec8NOstywCYE/QeGupbqw
UYJycjSK7iN54hXldbkT/R+RZ7nXs95nECgqGUi0TDBfsvkkgteiIcPI0ORVQB8Y
t4VxFji5qOA1b6FkysDFXQX7g2fZvATwgac1ZtyOUwWpNzL4B73qkC7eB06AYWs8
GR8AnMKCZ8xnMPKEaiCEsz29tIGcgM/fqtGiE8ysT8M8AzjW2U3eGgLwffkw2Hw7
EuVnMgF6/XXSRy1RMAIYj02t7Ly5WVXrk/NvEoSCbjiejepofXnLPL5Ikbi+zMGe
vM0KwlOOtS/l2p78z2qeqG/2G7BgIHh6xBgnAMTrC/a2jIX0qXk=
=X5HG
-----END PGP SIGNATURE-----

--Sig_/LFNiTp7Qk7KhnCEy63lOP.4--
