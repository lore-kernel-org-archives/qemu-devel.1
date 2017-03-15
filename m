Received: from eggs.gnu.org ([2001:4830:134:3::10]:38357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1co7V7-00019l-Be
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 07:53:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1co7V3-00061r-C8
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 07:53:57 -0400
Received: from 3.mo68.mail-out.ovh.net ([46.105.58.60]:48068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1co7V3-00061Z-5S
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 07:53:53 -0400
Received: from player763.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 913234509C
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 12:53:51 +0100 (CET)
Date: Wed, 15 Mar 2017 12:53:41 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170315125341.09f9c53e@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <1489449360-14411-6-git-send-email-sstabellini@kernel.org>
References: <alpine.DEB.2.10.1703131650550.21520@sstabellini-ThinkPad-X260>
	<1489449360-14411-1-git-send-email-sstabellini@kernel.org>
	<1489449360-14411-6-git-send-email-sstabellini@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/rl17adYDwk2V3yW/Q0ZhpfW";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v2 6/9] xen/9pfs: receive requests from the
 frontend
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

--Sig_/rl17adYDwk2V3yW/Q0ZhpfW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 13 Mar 2017 16:55:57 -0700
Stefano Stabellini <sstabellini@kernel.org> wrote:

> Upon receiving an event channel notification from the frontend, schedule
> the bottom half. From the bottom half, read one request from the ring,
> create a pdu and call pdu_submit to handle it.
>=20
> For now, only handle one request per ring at a time.
>=20
> Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
> CC: anthony.perard@citrix.com
> CC: jgross@suse.com
> CC: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> CC: Greg Kurz <groug@kaod.org>
> ---

Oops, one more remark I forgot in my the previous mail. See below.

>  hw/9pfs/xen-9p-backend.c | 47 ++++++++++++++++++++++++++++++++++++++++++=
+++++
>  1 file changed, 47 insertions(+)
>=20
> diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> index 0e4a133..741dd31 100644
> --- a/hw/9pfs/xen-9p-backend.c
> +++ b/hw/9pfs/xen-9p-backend.c
> @@ -94,12 +94,59 @@ static int xen_9pfs_init(struct XenDevice *xendev)
>      return 0;
>  }
> =20
> +static int xen_9pfs_receive(struct Xen9pfsRing *ring)
> +{
> +    struct xen_9pfs_header h;
> +    RING_IDX cons, prod, masked_prod, masked_cons;
> +    V9fsPDU *pdu;
> +
> +    if (ring->inprogress) {
> +        return 0;
> +    }
> +
> +    cons =3D ring->intf->out_cons;
> +    prod =3D ring->intf->out_prod;
> +    xen_rmb();
> +
> +    if (xen_9pfs_queued(prod, cons, XEN_9PFS_RING_SIZE) < sizeof(h)) {
> +        return 0;
> +    }
> +    ring->inprogress =3D true;
> +
> +    masked_prod =3D xen_9pfs_mask(prod, XEN_9PFS_RING_SIZE);
> +    masked_cons =3D xen_9pfs_mask(cons, XEN_9PFS_RING_SIZE);
> +
> +    xen_9pfs_read_packet(ring->ring.out, masked_prod, &masked_cons,
> +                         XEN_9PFS_RING_SIZE, (uint8_t*) &h, sizeof(h));
> +
> +    pdu =3D pdu_alloc(&ring->priv->state);
> +    pdu->size =3D h.size;

9P uses little-endian, so this should be:

    pdu->size =3D le32_to_cpu(h.size);

> +    pdu->id =3D h.id;
> +    pdu->tag =3D h.tag;

and:

    pdu->tag =3D le16_to_cpu(h.tag);

> +    ring->out_size =3D h.size;
> +    ring->out_cons =3D cons + h.size;

Same here.

> +
> +    qemu_co_queue_init(&pdu->complete);
> +    pdu_submit(pdu);
> +
> +    return 0;
> +}
> +
>  static void xen_9pfs_bh(void *opaque)
>  {
> +    struct Xen9pfsRing *ring =3D opaque;
> +    xen_9pfs_receive(ring);
>  }
> =20
>  static void xen_9pfs_evtchn_event(void *opaque)
>  {
> +    struct Xen9pfsRing *ring =3D opaque;
> +    evtchn_port_t port;
> +
> +    port =3D xenevtchn_pending(ring->evtchndev);
> +    xenevtchn_unmask(ring->evtchndev, port);
> +
> +    qemu_bh_schedule(ring->bh);
>  }
> =20
>  static int xen_9pfs_free(struct XenDevice *xendev)


--Sig_/rl17adYDwk2V3yW/Q0ZhpfW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAljJK0YACgkQAvw66wEB28LGrQCfViOLbbpo8xwXK9ECzkQk1njd
3DAAn0HGwyYuuVpyrtZpbo6cbLzaHWxO
=J2bg
-----END PGP SIGNATURE-----

--Sig_/rl17adYDwk2V3yW/Q0ZhpfW--
