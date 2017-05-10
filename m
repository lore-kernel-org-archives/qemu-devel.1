Received: from eggs.gnu.org ([2001:4830:134:3::10]:33460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d8XtB-0000Yv-OK
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:07:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d8Xt8-0007AP-FA
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:07:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1d8Xt8-0007AC-5W
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:07:10 -0400
Date: Wed, 10 May 2017 23:07:07 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170510230621-mutt-send-email-mst@kernel.org>
References: <286AC319A985734F985F78AFA26841F7391FDD30@shsmsx102.ccr.corp.intel.com>
	<056500d7-6a91-12e5-be1d-2b2beebd0430@redhat.com>
	<20170505233541-mutt-send-email-mst@kernel.org>
	<286AC319A985734F985F78AFA26841F7391FFC13@shsmsx102.ccr.corp.intel.com>
	<5912E2D7.1030705@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5912E2D7.1030705@intel.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [virtio-dev] RE: virtio-net: configurable TX queue
 size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Jan Scheurich <jan.scheurich@ericsson.com>

On Wed, May 10, 2017 at 05:52:23PM +0800, Wei Wang wrote:
> On 05/07/2017 12:39 PM, Wang, Wei W wrote:
> > On 05/06/2017 04:37 AM, Michael S. Tsirkin wrote:
> > > On Fri, May 05, 2017 at 10:27:13AM +0800, Jason Wang wrote:
> > > >=20
> > > > On 2017=E5=B9=B405=E6=9C=8804=E6=97=A5 18:58, Wang, Wei W wrote:
> > > > > Hi,
> > > > >=20
> > > > > I want to re-open the discussion left long time ago:
> > > > > https://lists.gnu.org/archive/html/qemu-devel/2015-11/msg06194.=
html
> > > > > , and discuss the possibility of changing the hardcoded (256) T=
X
> > > > > queue size to be configurable between 256 and 1024.
> > > > Yes, I think we probably need this.
> > > >=20
> > > > > The reason to propose this request is that a severe issue of pa=
cket
> > > > > drops in TX direction was observed with the existing hardcoded =
256
> > > > > queue size, which causes performance issues for packet drop
> > > > > sensitive guest applications that cannot use indirect descripto=
r
> > > > > tables. The issue goes away with 1K queue size.
> > > > Do we need even more, what if we find 1K is even not sufficient i=
n the
> > > > future? Modern nics has size up to ~8192.
> > > >=20
> > > > > The concern mentioned in the previous discussion (please check =
the
> > > > > link
> > > > > above) is that the number of chained descriptors would exceed
> > > > > UIO_MAXIOV (1024) supported by the Linux.
> > > > We could try to address this limitation but probably need a new
> > > > feature bit to allow more than UIO_MAXIOV sgs.
> > > I'd say we should split the queue size and the sg size.
> > >=20
>=20
> I'm still doing some investigation about this, one question (or issue) =
I
> found from the implementation is that the virtio-net device changes
> the message layout when the vnet_hdr needs an endianness swap
> (i.e. virtio_needs_swap()). This change adds one more iov to the
> iov[]-s passed from the driver.
>=20
> To be more precise, the message from the driver could be in one
> of the two following layout:
> Layout1:
> iov[0]: vnet_hdr + data
>=20
> Layout2:
> iov[0]: vnet_hdr
> iov[1]: data
>=20
> If the driver passes the message in Layout1, and the following code
> from the device changes the message from Layout1 to Layout2:
>=20
> if (n->needs_vnet_hdr_swap) {
>                 virtio_net_hdr_swap(vdev, (void *) &mhdr);
>                 sg2[0].iov_base =3D &mhdr;
>                 sg2[0].iov_len =3D n->guest_hdr_len;
>                 out_num =3D iov_copy(&sg2[1], ARRAY_SIZE(sg2) - 1,
>                                    out_sg, out_num,
>                                    n->guest_hdr_len, -1);
>                 if (out_num =3D=3D VIRTQUEUE_MAX_SIZE) {
>                     goto drop;
>                 }
>                 out_num +=3D 1;
>                 out_sg =3D sg2;
>             }
>=20
> sg2[0] is the extra one, which potentially causes the off-by-one
> issue. I didn't find other possibilities that can cause the issue.
>=20
> Could we keep the original layout by just copying the swapped
> "mhdr" back to original out_sg[0].iov_base?
>=20
> Best,
> Wei

We can't because that data should be read-only by host.

>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
