Received: from eggs.gnu.org ([209.51.188.92]:59849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtlvu-0003F6-4R
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 23:14:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtlvs-0005CU-IZ
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 23:14:02 -0500
Date: Wed, 13 Feb 2019 14:27:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190213032739.GA1884@umbus.fritz.box>
References: <154999583316.690774.15072605479770041782.stgit@bahia.lan>
	<154999584656.690774.18352404495120358613.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mPYgjWmOFizS0g23"
Content-Disposition: inline
In-Reply-To: <154999584656.690774.18352404495120358613.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v4 02/15] xive: Only set source type for
 LSIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>


--mPYgjWmOFizS0g23
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 12, 2019 at 07:24:06PM +0100, Greg Kurz wrote:
> MSI is the default and LSI specific code is guarded by the
> xive_source_irq_is_lsi() helper. The xive_source_irq_set()
> helper is a nop for MSIs.
>=20
> Simplify the code by turning xive_source_irq_set() into
> xive_source_irq_set_lsi() and only call it for LSIs. The
> call to xive_source_irq_set(false) in spapr_xive_irq_free()
> is also a nop. Just drop it.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: C=E9dric Le Goater <clg@kaod.org>

Looks like a reasoanble cleanup regardless of the rest of the series.
Applied to ppc-for-4.0.

> ---
>  hw/intc/spapr_xive.c  |    7 +++----
>  include/hw/ppc/xive.h |    7 ++-----
>  2 files changed, 5 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index a0f5ff929447..290a290e43a5 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -489,20 +489,19 @@ bool spapr_xive_irq_claim(sPAPRXive *xive, uint32_t=
 lisn, bool lsi)
>      }
> =20
>      xive->eat[lisn].w |=3D cpu_to_be64(EAS_VALID);
> -    xive_source_irq_set(xsrc, lisn, lsi);
> +    if (lsi) {
> +        xive_source_irq_set_lsi(xsrc, lisn);
> +    }
>      return true;
>  }
> =20
>  bool spapr_xive_irq_free(sPAPRXive *xive, uint32_t lisn)
>  {
> -    XiveSource *xsrc =3D &xive->source;
> -
>      if (lisn >=3D xive->nr_irqs) {
>          return false;
>      }
> =20
>      xive->eat[lisn].w &=3D cpu_to_be64(~EAS_VALID);
> -    xive_source_irq_set(xsrc, lisn, false);
>      return true;
>  }
> =20
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index ec3bb2aae45a..13a487527b11 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -283,13 +283,10 @@ static inline bool xive_source_irq_is_lsi(XiveSourc=
e *xsrc, uint32_t srcno)
>      return test_bit(srcno, xsrc->lsi_map);
>  }
> =20
> -static inline void xive_source_irq_set(XiveSource *xsrc, uint32_t srcno,
> -                                       bool lsi)
> +static inline void xive_source_irq_set_lsi(XiveSource *xsrc, uint32_t sr=
cno)
>  {
>      assert(srcno < xsrc->nr_irqs);
> -    if (lsi) {
> -        bitmap_set(xsrc->lsi_map, srcno, 1);
> -    }
> +    bitmap_set(xsrc->lsi_map, srcno, 1);
>  }
> =20
>  void xive_source_set_irq(void *opaque, int srcno, int val);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mPYgjWmOFizS0g23
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxjjqsACgkQbDjKyiDZ
s5LSTBAAhwxrgioD+PRI2MiWOoelUiJY/w5uoN9338RBnKoKynN1gLgEzdR1gZtb
ilhB0FBcLYqCyEJeDiO/FNmEJ4NfAbQeQFAsNrxKt9zYOWxNWcvNi9FN0QbS7H2X
F04W215+3DOXQVABpJNuf+n9qT1pR5Oywm0AFOMGQ/g1G5UbFiZJRC8EO3hc0cbC
8zD6EndtVY367vfv7O/UU0fwJfDL8G8j5YWWwFi998Dl/YEtMg5hM7G91t8XFzBY
AJe8H1K9Fa216AVBaL2npVk87oZr8xPu+u1UuY/RRUfyeSgNk4jTi2qAoAl+JmNL
55fCF/YVDvORtTDsPh5dbJJe7/lS1oymPxLkLCLnxBzL4WPyLlczcVyfHMOF5Q/G
Ckw0MpL8b4DYLMIz67HglW487g5SVbbVAtlqZjwoVtRAicKhMbkhwynsAETrPbEO
tNcjYXVKbd66Te4D3L1kEeBwINzIFgNH8TF6YHe1zbcVhATGA5pIVG9D3fqZCD0v
TLsU2D19t8AuOdnrpdLfPaVE7nBlsINkvd+SAVG/2oWFXIRaX6wHU+/quJnO6iiu
uAslt64CqNgdtjjF02VdiGX94JSOAjNIvFUgbv7/nFrdsUUim6gMVYUqvbJjw6Vp
3mietoHP+fjnupXdXHwbyuecbCUNc5BiG+OYWco8OWfFMqhga/o=
=zPLp
-----END PGP SIGNATURE-----

--mPYgjWmOFizS0g23--
