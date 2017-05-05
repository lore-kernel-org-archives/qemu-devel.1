Received: from eggs.gnu.org ([2001:4830:134:3::10]:51940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d6lOu-0005yb-VB
	for qemu-devel@nongnu.org; Fri, 05 May 2017 18:08:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d6lOq-0008EU-Gk
	for qemu-devel@nongnu.org; Fri, 05 May 2017 18:08:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1d6lOq-0008AI-82
	for qemu-devel@nongnu.org; Fri, 05 May 2017 18:08:32 -0400
Date: Sat, 6 May 2017 01:08:30 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170506010644-mutt-send-email-mst@kernel.org>
References: <286AC319A985734F985F78AFA26841F7391FDD30@shsmsx102.ccr.corp.intel.com>
	<056500d7-6a91-12e5-be1d-2b2beebd0430@redhat.com>
	<590C1353.7070501@intel.com>
	<6b96612b-2fd9-cf65-023e-f72561ec936a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6b96612b-2fd9-cf65-023e-f72561ec936a@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [virtio-dev] Re: virtio-net: configurable TX queue
 size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>, Stefan Hajnoczi <stefanha@gmail.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Jan Scheurich <jan.scheurich@ericsson.com>

On Fri, May 05, 2017 at 05:20:07PM +0800, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B405=E6=9C=8805=E6=97=A5 13:53, Wei Wang wrote:
> > On 05/05/2017 10:27 AM, Jason Wang wrote:
> > >=20
> > >=20
> > > On 2017=E5=B9=B405=E6=9C=8804=E6=97=A5 18:58, Wang, Wei W wrote:
> > > > Hi,
> > > >=20
> > > > I want to re-open the discussion left long time ago:
> > > > https://lists.gnu.org/archive/html/qemu-devel/2015-11/msg06194.ht=
ml
> > > > , and discuss the possibility of changing the hardcoded (256) TX =
 queue
> > > > size to be configurable between 256 and 1024.
> > >=20
> > > Yes, I think we probably need this.
> >=20
> > That's great, thanks.
> >=20
> > >=20
> > > >=20
> > > > The reason to propose this request is that a severe issue of
> > > > packet drops in
> > > > TX direction was observed with the existing hardcoded 256 queue s=
ize,
> > > > which causes performance issues for packet drop sensitive guest
> > > > applications that cannot use indirect descriptor tables. The
> > > > issue goes away
> > > > with 1K queue size.
> > >=20
> > > Do we need even more, what if we find 1K is even not sufficient in
> > > the future? Modern nics has size up to ~8192.
> >=20
> > Yes. Probably, we can also set the RX queue size to 8192 (currently i=
t's
> > 1K) as well.
> >=20
> > >=20
> > > >=20
> > > > The concern mentioned in the previous discussion (please check th=
e link
> > > > above) is that the number of chained descriptors would exceed
> > > > UIO_MAXIOV (1024) supported by the Linux.
> > >=20
> > > We could try to address this limitation but probably need a new
> > > feature bit to allow more than UIO_MAXIOV sgs.
> >=20
> > I think we should first discuss whether it would be an issue below.
> >=20
> > >=20
> > > >=20
> > > >  From the code,  I think the number of the chained descriptors
> > > > is limited to
> > > > MAX_SKB_FRAGS + 2 (~18), which is much less than UIO_MAXIOV.
> > >=20
> > > This is the limitation of #page frags for skb, not the iov limitati=
on.
> >=20
> > I think the number of page frags are filled into the same number of
> > descriptors
> > in the virtio-net driver (e.g. use 10 descriptors for 10 page frags).=
 On
> > the other
> > side, the virtio-net backend uses the same number of iov for the
> > descriptors.
> >=20
> > Since the number of page frags is limited to 18, I think there wouldn=
't
> > be more
> > than 18 iovs to be passed to writev, right?
>=20
> Looks not, see skb_copy_datagram_from_iter().
>=20
> Thanks

Besides, guests don't all use linux drivers. Some use e.g.
dpdk pmd ones. It's best not to make assumptions outside
the spec - if you need to make an assumption, it's
best to add a flag to specify it.

> >=20
> > Best,
> > Wei
> >=20
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> >=20
