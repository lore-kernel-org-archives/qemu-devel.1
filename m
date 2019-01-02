Received: from eggs.gnu.org ([208.118.235.92]:47585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1geXXl-0004ln-Cn
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 22:50:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1geXXh-000637-Bn
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 22:50:09 -0500
Received: from ozlabs.org ([203.11.71.1]:37417)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1geXXf-0005s4-8N
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 22:50:05 -0500
Date: Wed, 2 Jan 2019 13:36:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190102023609.GC27457@umbus.fritz.box>
References: <20181225140449.15786-1-fli@suse.com>
	<20181225140449.15786-11-fli@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
Content-Disposition: inline
In-Reply-To: <20181225140449.15786-11-fli@suse.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0 v9 10/16] qemu_thread: supplement
 error handling for h_resize_hpt_prepare
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <fli@suse.com>
Cc: qemu-devel@nongnu.org, shirley17fei@gmail.com, lifei1214@126.com, Markus Armbruster <armbru@redhat.com>


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 25, 2018 at 10:04:43PM +0800, Fei Li wrote:
> Add a local_err to hold the error, and return the corresponding
> error code to replace the temporary &error_abort.
>=20
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Fei Li <fli@suse.com>

This looks like a good change, but it no longer applies due to a
change in the qemu_thread_create() signature.

> ---
>  hw/ppc/spapr_hcall.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 5bc2cf4540..7c16ade04a 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -478,6 +478,7 @@ static target_ulong h_resize_hpt_prepare(PowerPCCPU *=
cpu,
>      sPAPRPendingHPT *pending =3D spapr->pending_hpt;
>      uint64_t current_ram_size;
>      int rc;
> +    Error *local_err =3D NULL;
> =20
>      if (spapr->resize_hpt =3D=3D SPAPR_RESIZE_HPT_DISABLED) {
>          return H_AUTHORITY;
> @@ -538,10 +539,13 @@ static target_ulong h_resize_hpt_prepare(PowerPCCPU=
 *cpu,
>      pending->shift =3D shift;
>      pending->ret =3D H_HARDWARE;
> =20
> -    /* TODO: let the further caller handle the error instead of abort() =
here */
> -    qemu_thread_create(&pending->thread, "sPAPR HPT prepare",
> -                       hpt_prepare_thread, pending,
> -                       QEMU_THREAD_DETACHED, &error_abort);
> +    if (!qemu_thread_create(&pending->thread, "sPAPR HPT prepare",
> +                            hpt_prepare_thread, pending,
> +                            QEMU_THREAD_DETACHED, &local_err)) {
> +        error_reportf_err(local_err, "failed to create hpt_prepare_threa=
d: ");
> +        g_free(pending);
> +        return H_RESOURCE;

I also think H_HARDWARE would be a better choice here.  Although the
failure is due to a resource constraint, it's not because the guest
asked for too much, just because the host is in dire straits.  From
the guest's point of view it's basically a hardware failure.

> +    }
> =20
>      spapr->pending_hpt =3D pending;
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwsI5kACgkQbDjKyiDZ
s5KpwQ/8Czna5/bLGh3M0nJDG9FmB/EzMm9MMMyIvCDF98HpaI7Dg95wbP92/8zN
lSQpyh6xxhuPsCGDWUIllvclTdAPJQvJRi5YqTBctx/wzs0aRwn9BZXYXgp8uVN8
lN2wwbU4UFPNNavKbfI2f0V85QkVZG4/YUfwnPdfXdUdiaKYkOZIlA0+qhiAsFUt
WbjMRxm82Cg1NNgQZcPUm8ksadN8vrnkUz8JrVKQGr0mJQveC3Al1B4nr5y4HvQG
Rw58xqUvp7LUa6dLdxCD5obff5bit/O4NAPVUGxn0RZoz2t7Lz4/0pEWrI/opt8N
VqgrMPmxxzA2wUGWpLbuKbZ4uvXh+XdTNl83IqRuqEnYi+aDStG7ydDvykAJdsEc
tfvGAU8dD0WS56+x492t5yNjNItkrzvI3xQTT60GeS1BFRKc1QSrs+73dYbWFgtH
mf8vZWx04eJchWSIJho9EtPsad+icAEECDdfyqbNF+7EdqQW/+1a3tlWyCC8PjXO
gxt8D35RyAw6CY4Pvrtm4GPLQIFoxZDLuOaZnEB0IV6FHtLdLYc7upMqEYX2kAQw
cvhMdZ6QLRA0m9Hn+HErkJg04n31pepZIawzicFp+H3lruk/Q1mJ04XmwtnCBLSu
zHAkS7wUmQ27reBy5dclwKZa5LkQvkBImFBldGtnBkyA8S4DJbw=
=PCjN
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--
