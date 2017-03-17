Received: from eggs.gnu.org ([2001:4830:134:3::10]:56759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1corvI-0004wl-6F
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 09:28:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1corvE-0005Ey-0r
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 09:28:04 -0400
Received: from 3.mo69.mail-out.ovh.net ([188.165.52.203]:35400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1corvD-0005Eq-N5
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 09:27:59 -0400
Received: from player738.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 49FA41DEF1
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 14:27:58 +0100 (CET)
Date: Fri, 17 Mar 2017 14:27:50 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170317142750.5cb5e1c7@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <1489694518-16978-7-git-send-email-sstabellini@kernel.org>
References: <alpine.DEB.2.10.1703161241220.14378@sstabellini-ThinkPad-X260>
	<1489694518-16978-1-git-send-email-sstabellini@kernel.org>
	<1489694518-16978-7-git-send-email-sstabellini@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/F6m=5pM=I_noKIH=oDFtoR/";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v3 7/9] xen/9pfs: implement
 in/out_iov_from_pdu and vmarshal/vunmarshal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, jgross@suse.com, Stefano Stabellini <stefano@aporeto.com>, anthony.perard@citrix.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

--Sig_/F6m=5pM=I_noKIH=oDFtoR/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Mar 2017 13:01:56 -0700
Stefano Stabellini <sstabellini@kernel.org> wrote:

> Implement xen_9pfs_init_in/out_iov_from_pdu and
> xen_9pfs_pdu_vmarshal/vunmarshall by creating new sg pointing to the
> data on the ring.
>=20
> This is safe as we only handle one request per ring at any given time.
>=20
> Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
> CC: anthony.perard@citrix.com
> CC: jgross@suse.com
> CC: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> CC: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/xen-9p-backend.c | 92 ++++++++++++++++++++++++++++++++++++++++++=
++++--
>  1 file changed, 90 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> index f757591..0a1eb34 100644
> --- a/hw/9pfs/xen-9p-backend.c
> +++ b/hw/9pfs/xen-9p-backend.c
> @@ -58,12 +58,78 @@ typedef struct Xen9pfsDev {
>      Xen9pfsRing *rings;
>  } Xen9pfsDev;
> =20
> +static void xen_9pfs_in_sg(Xen9pfsRing *ring,
> +                           struct iovec *in_sg,
> +                           int *num,
> +                           uint32_t idx,
> +                           uint32_t size)
> +{
> +    RING_IDX cons, prod, masked_prod, masked_cons;
> +
> +    cons =3D ring->intf->in_cons;
> +    prod =3D ring->intf->in_prod;
> +    xen_rmb();
> +    masked_prod =3D xen_9pfs_mask(prod, XEN_9PFS_RING_SIZE);
> +    masked_cons =3D xen_9pfs_mask(cons, XEN_9PFS_RING_SIZE);
> +
> +    if (masked_prod < masked_cons) {
> +        in_sg[0].iov_base =3D ring->ring.in + masked_prod;
> +        in_sg[0].iov_len =3D masked_cons - masked_prod;
> +        *num =3D 1;
> +    } else {
> +        in_sg[0].iov_base =3D ring->ring.in + masked_prod;
> +        in_sg[0].iov_len =3D XEN_9PFS_RING_SIZE - masked_prod;
> +        in_sg[1].iov_base =3D ring->ring.in;
> +        in_sg[1].iov_len =3D masked_cons;
> +        *num =3D 2;
> +    }
> +}
> +
> +static void xen_9pfs_out_sg(Xen9pfsRing *ring,
> +                            struct iovec *out_sg,
> +                            int *num,
> +                            uint32_t idx)
> +{
> +    RING_IDX cons, prod, masked_prod, masked_cons;
> +
> +    cons =3D ring->intf->out_cons;
> +    prod =3D ring->intf->out_prod;
> +    xen_rmb();
> +    masked_prod =3D xen_9pfs_mask(prod, XEN_9PFS_RING_SIZE);
> +    masked_cons =3D xen_9pfs_mask(cons, XEN_9PFS_RING_SIZE);
> +
> +    if (masked_cons < masked_prod) {
> +        out_sg[0].iov_base =3D ring->ring.out + masked_cons;
> +        out_sg[0].iov_len =3D ring->out_size;
> +        *num =3D 1;
> +    } else {
> +        if (ring->out_size > (XEN_9PFS_RING_SIZE - masked_cons)) {
> +            out_sg[0].iov_base =3D ring->ring.out + masked_cons;
> +            out_sg[0].iov_len =3D XEN_9PFS_RING_SIZE - masked_cons;
> +            out_sg[1].iov_base =3D ring->ring.out;
> +            out_sg[1].iov_len =3D ring->out_size -
> +                                (XEN_9PFS_RING_SIZE - masked_cons);
> +            *num =3D 2;
> +        } else {
> +            out_sg[0].iov_base =3D ring->ring.out + masked_cons;
> +            out_sg[0].iov_len =3D ring->out_size;
> +            *num =3D 1;
> +        }
> +    }
> +}
> +
>  static ssize_t xen_9pfs_pdu_vmarshal(V9fsPDU *pdu,
>                                       size_t offset,
>                                       const char *fmt,
>                                       va_list ap)
>  {
> -    return 0;
> +    Xen9pfsDev *xen_9pfs =3D container_of(pdu->s, Xen9pfsDev, state);
> +    struct iovec in_sg[2];
> +    int num;
> +
> +    xen_9pfs_in_sg(&xen_9pfs->rings[pdu->tag % xen_9pfs->num_rings],
> +                   in_sg, &num, pdu->idx, ROUND_UP(offset + 128, 512));
> +    return v9fs_iov_vmarshal(in_sg, num, offset, 0, fmt, ap);
>  }
> =20
>  static ssize_t xen_9pfs_pdu_vunmarshal(V9fsPDU *pdu,
> @@ -71,13 +137,27 @@ static ssize_t xen_9pfs_pdu_vunmarshal(V9fsPDU *pdu,
>                                         const char *fmt,
>                                         va_list ap)
>  {
> -    return 0;
> +    Xen9pfsDev *xen_9pfs =3D container_of(pdu->s, Xen9pfsDev, state);
> +    struct iovec out_sg[2];
> +    int num;
> +
> +    xen_9pfs_out_sg(&xen_9pfs->rings[pdu->tag % xen_9pfs->num_rings],
> +                    out_sg, &num, pdu->idx);
> +    return v9fs_iov_vunmarshal(out_sg, num, offset, 0, fmt, ap);
>  }
> =20
>  static void xen_9pfs_init_out_iov_from_pdu(V9fsPDU *pdu,
>                                             struct iovec **piov,
>                                             unsigned int *pniov)
>  {
> +    Xen9pfsDev *xen_9pfs =3D container_of(pdu->s, Xen9pfsDev, state);
> +    Xen9pfsRing *ring =3D &xen_9pfs->rings[pdu->tag % xen_9pfs->num_ring=
s];
> +    struct iovec *sg =3D g_malloc0(sizeof(*sg) * 2);

I had overlooked in v2, sorry for that. Where does *sg gets freed ?

> +    int num;
> +
> +    xen_9pfs_out_sg(ring, sg, &num, pdu->idx);
> +    *piov =3D sg;
> +    *pniov =3D num;
>  }
> =20
>  static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *pdu,
> @@ -85,6 +165,14 @@ static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *pd=
u,
>                                            unsigned int *pniov,
>                                            size_t size)
>  {
> +    Xen9pfsDev *xen_9pfs =3D container_of(pdu->s, Xen9pfsDev, state);
> +    Xen9pfsRing *ring =3D &xen_9pfs->rings[pdu->tag % xen_9pfs->num_ring=
s];
> +    struct iovec *sg =3D g_malloc0(sizeof(*sg) * 2);

Same here.

> +    int num;
> +
> +    xen_9pfs_in_sg(ring, sg, &num, pdu->idx, size);
> +    *piov =3D sg;
> +    *pniov =3D num;
>  }
> =20
>  static void xen_9pfs_push_and_notify(V9fsPDU *pdu)


--Sig_/F6m=5pM=I_noKIH=oDFtoR/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAljL5FYACgkQAvw66wEB28LjNgCfZgwnmfHe8blXM8kxGoEmomGe
edsAnjgPaFx9eVI+hib/ayt17rVz7mkK
=tzlV
-----END PGP SIGNATURE-----

--Sig_/F6m=5pM=I_noKIH=oDFtoR/--
