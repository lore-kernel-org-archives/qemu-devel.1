Received: from eggs.gnu.org ([2001:4830:134:3::10]:41979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=66789f4f5=Paul.Durrant@citrix.com>)
	id 1fIxNI-0001mc-8M
	for qemu-devel@nongnu.org; Wed, 16 May 2018 10:25:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=66789f4f5=Paul.Durrant@citrix.com>)
	id 1fIxNG-00005X-I3
	for qemu-devel@nongnu.org; Wed, 16 May 2018 10:25:52 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Wed, 16 May 2018 14:22:59 +0000
Message-ID: <1bde7e04a484407ca7c4a3f2322e7b99@AMSPEX02CL03.citrite.net>
References: <1525461967-32174-1-git-send-email-paul.durrant@citrix.com>
	<1525461967-32174-4-git-send-email-paul.durrant@citrix.com>
	<20180516141424.GH2057@perard.uk.xensource.com>
In-Reply-To: <20180516141424.GH2057@perard.uk.xensource.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 3/8] xen: remove other open-coded use of
 libxengnttab
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony Perard <anthony.perard@citrix.com>
Cc: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefano Stabellini <sstabellini@kernel.org>, Greg
	Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

> -----Original Message-----
> From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> Sent: 16 May 2018 15:14
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: xen-devel@lists.xenproject.org; qemu-block@nongnu.org; qemu-
> devel@nongnu.org; Stefano Stabellini <sstabellini@kernel.org>; Greg Kurz
> <groug@kaod.org>; Paolo Bonzini <pbonzini@redhat.com>; Jason Wang
> <jasowang@redhat.com>; Gerd Hoffmann <kraxel@redhat.com>
> Subject: Re: [PATCH v3 3/8] xen: remove other open-coded use of
> libxengnttab
>=20
> On Fri, May 04, 2018 at 08:26:02PM +0100, Paul Durrant wrote:
> > Now that helpers are available in xen_backend, use them throughout all
> > Xen PV backends.
> >
> > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> > ---
> > diff --git a/hw/net/xen_nic.c b/hw/net/xen_nic.c
> > index 20c43a6..73d6f1b 100644
> > --- a/hw/net/xen_nic.c
> > +++ b/hw/net/xen_nic.c
> > @@ -160,9 +160,8 @@ static void net_tx_packets(struct XenNetDev
> *netdev)
> >                            (txreq.flags & NETTXF_more_data)      ? " mo=
re_data"      : "",
> >                            (txreq.flags & NETTXF_extra_info)     ? " ex=
tra_info"     : "");
> >
> > -            page =3D xengnttab_map_grant_ref(netdev->xendev.gnttabdev,
> > -                                           netdev->xendev.dom,
> > -                                           txreq.gref, PROT_READ);
> > +            page =3D xen_be_map_grant_refs(&netdev->xendev,
> > +                                         &txreq.gref, 1, PROT_READ);
>=20
> xen_be_map_grant_ref instead?
>=20

Yep.

> >              if (page =3D=3D NULL) {
> >                  xen_pv_printf(&netdev->xendev, 0,
> >                                "error: tx gref dereference failed (%d)\=
n",
> > @@ -183,7 +182,7 @@ static void net_tx_packets(struct XenNetDev
> *netdev)
> >                  qemu_send_packet(qemu_get_queue(netdev->nic),
> >                                   page + txreq.offset, txreq.size);
> >              }
> > -            xengnttab_unmap(netdev->xendev.gnttabdev, page, 1);
> > +            xen_be_unmap_grant_ref(&netdev->xendev, page);
> >              net_tx_response(netdev, &txreq, NETIF_RSP_OKAY);
> >          }
> >          if (!netdev->tx_work) {
> > @@ -254,9 +253,8 @@ static ssize_t net_rx_packet(NetClientState *nc,
> const uint8_t *buf, size_t size
> >      memcpy(&rxreq, RING_GET_REQUEST(&netdev->rx_ring, rc),
> sizeof(rxreq));
> >      netdev->rx_ring.req_cons =3D ++rc;
> >
> > -    page =3D xengnttab_map_grant_ref(netdev->xendev.gnttabdev,
> > -                                   netdev->xendev.dom,
> > -                                   rxreq.gref, PROT_WRITE);
> > +    page =3D xen_be_map_grant_refs(&netdev->xendev, &rxreq.gref, 1,
> > +                                 PROT_WRITE);
>=20
> xen_be_map_grant_ref instead?
>=20

And yep again.

> With that fix:
> Acked-by: Anthony PERARD <anthony.perard@citrix.com>
>=20

Thanks :-)

  Paul

> --
> Anthony PERARD
