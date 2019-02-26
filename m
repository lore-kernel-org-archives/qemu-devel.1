Received: from eggs.gnu.org ([209.51.188.92]:51858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUBb-00005O-La
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:17:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUBY-0003c7-4I
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:17:41 -0500
Date: Tue, 26 Feb 2019 15:17:22 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190226041722.GO6872@umbus.fritz.box>
References: <20190222131322.26079-1-clg@kaod.org>
	<20190222131322.26079-14-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="djJN5oi3zFpblwUd"
Content-Disposition: inline
In-Reply-To: <20190222131322.26079-14-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 13/13] spapr/xive: fix device hotplug
 when VM is stopped
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--djJN5oi3zFpblwUd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2019 at 02:13:22PM +0100, C=E9dric Le Goater wrote:
> Instead of switching off the sources, set their state to PENDING to
> possibly catch a hotplug event occuring while the VM is stopped. At
> resume, check the previous state and if an interrupt was queued,
> generate a trigger.

First, I think it would be better to fold this fix into the patch
introducing the state change handlers.

Second, IIUC this would handle any instance of an irq being triggered
while the VM is stopped.  Hotplug interrupts is one obvious case of
that, but I'm not sure its the only one.  VFIO devices could interrupt
while the VM is stopped, I think.  Maybe even emulated devices
depending on how their synchronization with the cpu run state works.
There might be other cases.  Does that sound right to you?

> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/spapr_xive_kvm.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index 99a829fb3f60..64d160babb26 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -500,8 +500,16 @@ static void kvmppc_xive_change_state_handler(void *o=
paque, int running,
>      if (running) {
>          for (i =3D 0; i < xsrc->nr_irqs; i++) {
>              uint8_t pq =3D xive_source_esb_get(xsrc, i);
> -            if (xive_esb_read(xsrc, i, XIVE_ESB_SET_PQ_00 + (pq << 8)) !=
=3D 0x1) {
> -                error_report("XIVE: IRQ %d has an invalid state", i);
> +            uint8_t old_pq;
> +
> +            old_pq =3D xive_esb_read(xsrc, i, XIVE_ESB_SET_PQ_00 + (pq <=
< 8));
> +
> +            /*
> +             * If an interrupt was queued (hotplug event) while VM was
> +             * stopped, generate a trigger.
> +             */
> +            if (pq =3D=3D XIVE_ESB_RESET && old_pq =3D=3D XIVE_ESB_QUEUE=
D) {
> +                xive_esb_trigger(xsrc, i);
>              }
>          }
> =20
> @@ -515,7 +523,15 @@ static void kvmppc_xive_change_state_handler(void *o=
paque, int running,
>       * migration is in progress.
>       */
>      for (i =3D 0; i < xsrc->nr_irqs; i++) {
> -        uint8_t pq =3D xive_esb_read(xsrc, i, XIVE_ESB_SET_PQ_01);
> +        uint8_t pq =3D xive_esb_read(xsrc, i, XIVE_ESB_GET);
> +
> +        /*
> +         * PQ is set to PENDING to possibly catch a hotplug event
> +         * occuring while the VM is stopped.
> +         */
> +        if (pq !=3D XIVE_ESB_OFF) {
> +            pq =3D xive_esb_read(xsrc, i, XIVE_ESB_SET_PQ_10);
> +        }
>          xive_source_esb_set(xsrc, i, pq);
>      }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--djJN5oi3zFpblwUd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx0vdIACgkQbDjKyiDZ
s5IR1g//ZsbDP1snrbrNjUc5rzZ818iZ7xjd/HbGCkEk81Hp3//sOll4FInXRR76
uSx2gsSq1YkF+kqnNc6OwB+GtuVzLfohzlV3srWAH3MpwWIOtpmYn9SbIRf+2lsw
4AK+e+JS3tmEO7qtcID6zX35J9rLZcuQO/ShxwxwWLrTjVFRNIGsnh+w0BGwZpmf
WyAr1OdavrHCnT4oVTC14IuLDzZZrsahDoinIo6Ghn9R53DgLvLJDvRH2DD1EuQL
n/oM0A0fzoEgypiFzd00uEGZ1AIvkWQHItJe4mXm6SXdUD0GPVhY3FTDISXZE8oe
CTsP+TJ0wXr3iBYB6QJ17Eva88Ez+FiWij/TmnhRUNBVp/w3zSoNvUDNs547XOBK
dKzeorqSZy/gTfJUpQNMPSzlQF7bxnBjbRox+h7ChuHGFOl5zffb57xH9TVyVGNO
HjsLaVmKPbe5x/jK4Ead84TsND7CQ4rDdNrGQPiYgWRM3/YGcF2TUiGl3pavnQvW
+JkL2a2EeX5CtvUPCo2XGoR82S0kdG4/1BY7xYUz2tvIgNm9Rbq4rroAiWrQ9fuZ
yfjSHr1bXIeLrf8Rv/6nks2RYIsli0ahQVd41aEDwhuq83v8Brw3thOo6hVxYK87
d0RsEctFT0pSfWYBYOuwJoioAA1UINLowsFWyMYmObZiKX2Quhg=
=ksvE
-----END PGP SIGNATURE-----

--djJN5oi3zFpblwUd--
