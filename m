Received: from eggs.gnu.org ([209.51.188.92]:37230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1grsrZ-0000ts-RS
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 18:13:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1grsrT-0001Gd-8V
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 18:13:42 -0500
Date: Fri, 8 Feb 2019 10:06:47 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190207230647.GC518@umbus.fritz.box>
References: <154956051753.218871.1505640778712413716.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YD3LsXFS42OYHhNZ"
Content-Disposition: inline
In-Reply-To: <154956051753.218871.1505640778712413716.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] spapr_pci: Fix interrupt leak in
 rtas_ibm_change_msi() error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-stable@nongnu.org


--YD3LsXFS42OYHhNZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 07, 2019 at 06:28:37PM +0100, Greg Kurz wrote:
> Now that IRQ allocation has been split in two (first allocate IRQ numbers,
> then claim them), if the claiming fails, we must release the IRQs.
>=20
> Fixes: 4fe75a8ccd80 "spapr: split the IRQ allocation sequence"
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-4.0, thanks.

> ---
>  hw/ppc/spapr_pci.c |    6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 41d81f4a8500..6fe3c10c8d4c 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -393,6 +393,12 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPA=
PRMachineState *spapr,
>      for (i =3D 0; i < req_num; i++) {
>          spapr_irq_claim(spapr, irq + i, false, &err);
>          if (err) {
> +            if (i) {
> +                spapr_irq_free(spapr, irq, i + 1);
> +            }
> +            if (!smc->legacy_irq_allocation) {
> +                spapr_irq_msi_free(spapr, irq, req_num);
> +            }
>              error_reportf_err(err, "Can't allocate MSIs for device %x: ",
>                                config_addr);
>              rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--YD3LsXFS42OYHhNZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxcugUACgkQbDjKyiDZ
s5JKzg/+I0+yTf/J5XLrVUZRVQcGQ6DqPNN+znQqWROCMkaHVG1nlhNOgbxEkVbL
W28CxB9kC4DjvVnqy+3S+y+xeSMlwkrXz7vxhlwsbRzQRmm5otqB9UKyOzTwobw1
LiXErM2Opp6tky6nGosW9D6zgz5M0rOAj+ojbU5XsnAVDkaBeyxVWfUpggLYCEaI
RzuM/JMz0DFeDzE7E9JfFbFrBhNPfS6ob9/U5JcBXHN3+WgGlf/xDeh4MwDJx8SR
c2pGt5nxf2KB062mow1yJ/Ju2ykN2QwXACNDKejl20SEldy1xPABfNb58hVU7okc
q7Ojynmq92L9rru/dlCNdrj0uFMc/bu0vLek1kSm69+cFjXoZLuqfq3gOGdJCxQz
46+JhbV4G2o4Hau66kPde0yIvvWILXpAgRPKDIKqp5SBKZsmSBiuGpdytg2LkoFs
MFPGm3eQLgicCj7kjWC173ad014sqj3+MQrvDV5ae4fGgxrx0N9eqeI7T+ewUAkD
GkA+QmTKGQ2EGGx+CAJsHgqyhbquDPQPs6rqPBof4Y5F+mIIkxqvreBwSTXAXGoX
B8n9DnNVJzV+CsF6/hS50FS7Z4hN9J5m4vtJw5Dq2Kfr/A0oPn0w7JUc6VhThBEU
RIi+U5znqZETw+ysN28HykuT7fUEmPhvA/mRaGUDE7YoKPwIXQA=
=uKxo
-----END PGP SIGNATURE-----

--YD3LsXFS42OYHhNZ--
