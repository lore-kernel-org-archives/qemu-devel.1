Received: from eggs.gnu.org ([2001:4830:134:3::10]:43183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1g0LP6-0003pC-3t
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 02:47:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1g0LP4-0000ik-VT
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 02:47:04 -0400
Date: Thu, 13 Sep 2018 16:11:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180913061142.GW7978@umbus.fritz.box>
References: <20180910110222.8162-1-clg@kaod.org>
	<20180910110222.8162-2-clg@kaod.org>
	<20180911014821.GE7978@umbus.fritz.box>
	<e8f02b91-6e8f-9215-18c8-401049be5416@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bOC9TN0n4iVUZoxs"
Content-Disposition: inline
In-Reply-To: <e8f02b91-6e8f-9215-18c8-401049be5416@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 1/3] spapr: introduce a spapr_irq class
 'nr_msis' attribute
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>


--bOC9TN0n4iVUZoxs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 11, 2018 at 06:41:24AM +0200, C=E9dric Le Goater wrote:
> On 09/11/2018 03:48 AM, David Gibson wrote:
> > On Mon, Sep 10, 2018 at 01:02:20PM +0200, C=E9dric Le Goater wrote:
> > 11;rgb:ffff/ffff/ffff> The number of MSI interrupts a sPAPR machine can=
 allocate is in direct
> >> relation with the number of interrupts of the sPAPRIrq backend. Define
> >> statically this value at the sPAPRIrq class level.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  include/hw/ppc/spapr_irq.h | 1 +
> >>  hw/ppc/spapr_irq.c         | 9 +++++++--
> >>  2 files changed, 8 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> >> index 0e98c4474bb2..650f810ad2aa 100644
> >> --- a/include/hw/ppc/spapr_irq.h
> >> +++ b/include/hw/ppc/spapr_irq.h
> >> @@ -31,6 +31,7 @@ void spapr_irq_msi_reset(sPAPRMachineState *spapr);
> >> =20
> >>  typedef struct sPAPRIrq {
> >>      uint32_t    nr_irqs;
> >> +    uint32_t    nr_msis;
> >> =20
> >>      void (*init)(sPAPRMachineState *spapr, Error **errp);
> >>      int (*claim)(sPAPRMachineState *spapr, int irq, bool lsi, Error *=
*errp);
> >> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> >> index 0cbb5dd39368..d369ac96f5cd 100644
> >> --- a/hw/ppc/spapr_irq.c
> >> +++ b/hw/ppc/spapr_irq.c
> >> @@ -99,7 +99,7 @@ static void spapr_irq_init_xics(sPAPRMachineState *s=
papr, Error **errp)
> >> =20
> >>      /* Initialize the MSI IRQ allocator. */
> >>      if (!SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
> >> -        spapr_irq_msi_init(spapr, XICS_IRQ_BASE + nr_irqs - SPAPR_IRQ=
_MSI);
> >> +        spapr_irq_msi_init(spapr, smc->irq->nr_msis);
> >>      }
> >> =20
> >>      if (kvm_enabled()) {
> >> @@ -195,8 +195,13 @@ static void spapr_irq_print_info_xics(sPAPRMachin=
eState *spapr, Monitor *mon)
> >>      ics_pic_print_info(spapr->ics, mon);
> >>  }
> >> =20
> >> +#define SPAPR_IRQ_XICS_NR_IRQS     XICS_IRQS_SPAPR
> >> +#define SPAPR_IRQ_XICS_NR_MSIS     \
> >> +    (XICS_IRQ_BASE + SPAPR_IRQ_XICS_NR_IRQS - SPAPR_IRQ_MSI)
> >=20
> > Uh.. I'm not quite understanding how XICS_IRQ_BASE gets into this.
>=20
> because the IRQ ranges of the new static IRQ number space start at=20
> the sPAPR IRQ number offset.
>=20
> XICS_IRQ_BASE		0x1000
> SPAPR_IRQ_XICS_NR_IRQS	0x400
>=20
> SPAPR_IRQ_MSI		0x1300
>=20
> 0x1000 + 0x400 - 0x1300 =3D 0x100

Duh, sorry, that's kind of obvious.  Apparently my brain wasn't
working the other day.

> we could use SPAPR_IRQ_EPOW instead or some other value defining=20
> the IRQ0 number.

No, it's fine.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bOC9TN0n4iVUZoxs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluZ/50ACgkQbDjKyiDZ
s5IntQ//aXALcgZqksYpiiJTSmr8/XR5DryI60D4z34GwYFiRc4QlMV3s053czc2
vZ8g8io78EZxOIG/JoEoUri/Kmr7Y+1eLBidjPnjv/1GBHjvCQxsShsh4EYcTJcj
IPQcAJLhcN0oWxWKpImI1g7gsUnBE7Vb6zv4yRzcZbTH5ftbHI7NYOTj8Hf2tlu6
TspGSfkHBqFUOwNsClfv2hnDQ8hK6mymGg6ap94F7v0f0rrdj3s9r+DLl7vhr+cg
OW9VQ4Su81NWl28pUsOxYBGBDXZvKAxo8WTxZpDsdhyfPyHVzfHKa1xugIKrjwoH
o4bCMdr/XR8WJOylcUiaLhLByRiyGDOpKXkeXpX/8c2TB0UH1XIH16Esi+hFyHnC
K4puAbItP2ZJbJCCVWL8JQ7zzxSj6ri4zbdTmhjNIaurleGg6592z/12P1zzyVg4
cRvuIU0BUBAUCQLeTzkPEaW6FYhUJGG9ymKnRvsL5YlGzFnBydPmBbh5EmIjM4k7
+ol3QD8hdYZwkilRCG1qIr0ZWshvaDJxpkuVxdULtFqtVeYvUTM7MLiIDHJudDQz
zKFAxCUoqKqkyQzDvH0qqsmNh1i+GqZkPBOYiqEBL6xBWRkUkF9b/VUlPwFkxHku
Nt9wtYvbnq0S9km/+0jSX0vOG1Tx17qMUWlA+FtnZRXpmluMVLs=
=7v4I
-----END PGP SIGNATURE-----

--bOC9TN0n4iVUZoxs--
