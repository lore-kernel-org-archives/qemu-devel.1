Received: from eggs.gnu.org ([2001:4830:134:3::10]:52830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUs2L-0005V7-VV
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:05:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUs2L-0004Uq-3L
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:04:57 -0400
Date: Tue, 11 Jul 2017 11:04:44 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170711100444.GL17792@stefanha-x1.localdomain>
References: <20170705133635.11850-1-famz@redhat.com>
	<20170705133635.11850-5-famz@redhat.com>
	<20170710145943.GI14195@stefanha-x1.localdomain>
	<a6ce3371-7d15-91fe-4232-bf8170c77c9d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rVkomL2febZOZtGQ"
Content-Disposition: inline
In-Reply-To: <a6ce3371-7d15-91fe-4232-bf8170c77c9d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 4/6] block/nvme: Implement .bdrv_dma_map
 and .bdrv_dma_unmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Keith Busch <keith.busch@intel.com>, Karl Rister <krister@redhat.com>


--rVkomL2febZOZtGQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2017 at 05:09:25PM +0200, Paolo Bonzini wrote:
> On 10/07/2017 16:59, Stefan Hajnoczi wrote:
> >> +static void nvme_dma_map(BlockDriverState *bs, void *host, size_t siz=
e)
> >> +{
> >> +    BDRVNVMeState *s =3D bs->opaque;
> >> +
> >> +    nvme_vfio_dma_map(s->vfio, host, size, false, NULL);
> > Since temporary=3Dfalse repeated calls to map/unmap will run out of spa=
ce
> > and stop working after some time?
>=20
> Yes, the point of bdrv_dma_map/unmap is to add a permanent mapping.
> Temporary mappings are only valid inside nvme.c, because the
> corresponding iova is not recorded anywhere.  Instead,
> bdrv_dma_map/unmap cache the iova just like we do for RAMBlock areas
> during system emulation.
>=20
> The solution is simply not to do that, just like img_bench only calls
> map/unmap once.  If it happens, things just become slower as the driver
> falls back to temporary mappings.

The constraints need to be documented.  Someone might try to use
blk_dma_map() and waste time debugging poor performance in the future.

Stefan

--rVkomL2febZOZtGQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZZKK8AAoJEJykq7OBq3PIO1EIALYIDr1SO2anajPFJ1J+o+N3
pNxR9qZZ0NLiBJ6xDdY0kv1CeWyWnatF8bpdi1nXTn5HUC8/KdOHzST0KqVqH7kL
egYEur3q9KBm0AP1Htt8kXQM08hXx1hY3sE22jNIqbqn3XUKUFs5nS58OzuLxYlv
g9IIO2XerBFCUxAiHCGOqW0x/NYOdoXyxvTWCgxw6vpD14A2NjSXk+I7srOOLvpd
S8UlBOFknJbrMOCLqF2BhxnBVpvup+VhzWaAnJKYlCIXUBY2kTdfAyG5eU7YJIBx
usrocPV3TEo14YLf8Z7GDUxg9CnBbRM5vcM2po4zBeWNeJmTWquX0DE6mLDbbBE=
=bo0v
-----END PGP SIGNATURE-----

--rVkomL2febZOZtGQ--
