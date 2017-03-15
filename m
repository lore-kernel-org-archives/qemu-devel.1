Received: from eggs.gnu.org ([2001:4830:134:3::10]:50088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1co6ei-0003Bj-Lm
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 06:59:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1co6ee-0005Y9-PM
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 06:59:48 -0400
Received: from mo68.mail-out.ovh.net ([178.32.228.68]:33421)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1co6ee-0005Xf-IL
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 06:59:44 -0400
Received: from player763.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id DE03E461F9
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 11:59:42 +0100 (CET)
Date: Wed, 15 Mar 2017 11:59:35 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170315115935.5fab47c7@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <1489449360-14411-8-git-send-email-sstabellini@kernel.org>
References: <alpine.DEB.2.10.1703131650550.21520@sstabellini-ThinkPad-X260>
	<1489449360-14411-1-git-send-email-sstabellini@kernel.org>
	<1489449360-14411-8-git-send-email-sstabellini@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/+dFVkcGJYTB0qo7iNllCFF9";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v2 8/9] xen/9pfs: send responses back to
 the frontend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, anthony.perard@citrix.com, Stefano Stabellini <stefano@aporeto.com>, jgross@suse.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

--Sig_/+dFVkcGJYTB0qo7iNllCFF9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 13 Mar 2017 16:55:59 -0700
Stefano Stabellini <sstabellini@kernel.org> wrote:

> Once a request is completed, xen_9pfs_push_and_notify gets called. In
> xen_9pfs_push_and_notify, update the indexes (data has already been
> copied to the sg by the common code) and send a notification to the
> frontend.
>=20
> Schedule the bottom-half to check if we already have any other requests
> pending.
>=20
> Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
> CC: anthony.perard@citrix.com
> CC: jgross@suse.com
> CC: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> CC: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/xen-9p-backend.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> index d72a749..fed369f 100644
> --- a/hw/9pfs/xen-9p-backend.c
> +++ b/hw/9pfs/xen-9p-backend.c
> @@ -166,6 +166,22 @@ static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *p=
du,
> =20
>  static void xen_9pfs_push_and_notify(V9fsPDU *pdu)
>  {
> +    RING_IDX prod;
> +    struct Xen9pfsDev *priv =3D container_of(pdu->s, struct Xen9pfsDev, =
state);
> +    struct Xen9pfsRing *ring =3D &priv->rings[pdu->tag % priv->num_rings=
];
> +

Coding style for structured types.

> +    ring->intf->out_cons =3D ring->out_cons;
> +    xen_wmb();
> +
> +    prod =3D ring->intf->in_prod;
> +    xen_rmb();
> +    ring->intf->in_prod =3D prod + pdu->size;
> +    xen_wmb();
> +
> +    ring->inprogress =3D false;
> +    xenevtchn_notify(ring->evtchndev, ring->local_port);
> +
> +    qemu_bh_schedule(ring->bh);
>  }
> =20
>  static const struct V9fsTransport xen_9p_transport =3D {


--Sig_/+dFVkcGJYTB0qo7iNllCFF9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAljJHpcACgkQAvw66wEB28KoggCeMo+xve/8KoG4KxRsTfmLFhPn
DxIAn2uNwM5YmFQA8h4i3KgOTLjeq3XZ
=rbpD
-----END PGP SIGNATURE-----

--Sig_/+dFVkcGJYTB0qo7iNllCFF9--
