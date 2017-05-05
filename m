Received: from eggs.gnu.org ([2001:4830:134:3::10]:57396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d6jxw-0007sF-Rx
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:36:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d6jxt-0006Z0-KC
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:36:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1d6jxt-0006YF-DI
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:36:37 -0400
Date: Fri, 5 May 2017 23:36:33 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170505233541-mutt-send-email-mst@kernel.org>
References: <286AC319A985734F985F78AFA26841F7391FDD30@shsmsx102.ccr.corp.intel.com>
	<056500d7-6a91-12e5-be1d-2b2beebd0430@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <056500d7-6a91-12e5-be1d-2b2beebd0430@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] virtio-net: configurable TX queue size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: "Wang, Wei W" <wei.w.wang@intel.com>, Stefan Hajnoczi <stefanha@gmail.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Jan Scheurich <jan.scheurich@ericsson.com>

On Fri, May 05, 2017 at 10:27:13AM +0800, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B405=E6=9C=8804=E6=97=A5 18:58, Wang, Wei W wrote:
> > Hi,
> >=20
> > I want to re-open the discussion left long time ago:
> > https://lists.gnu.org/archive/html/qemu-devel/2015-11/msg06194.html
> > , and discuss the possibility of changing the hardcoded (256) TX  que=
ue
> > size to be configurable between 256 and 1024.
>=20
> Yes, I think we probably need this.
>=20
> >=20
> > The reason to propose this request is that a severe issue of packet d=
rops in
> > TX direction was observed with the existing hardcoded 256 queue size,
> > which causes performance issues for packet drop sensitive guest
> > applications that cannot use indirect descriptor tables. The issue go=
es away
> > with 1K queue size.
>=20
> Do we need even more, what if we find 1K is even not sufficient in the
> future? Modern nics has size up to ~8192.
>=20
> >=20
> > The concern mentioned in the previous discussion (please check the li=
nk
> > above) is that the number of chained descriptors would exceed
> > UIO_MAXIOV (1024) supported by the Linux.
>=20
> We could try to address this limitation but probably need a new feature=
 bit
> to allow more than UIO_MAXIOV sgs.

I'd say we should split the queue size and the sg size.

> >=20
> >  From the code,  I think the number of the chained descriptors is lim=
ited to
> > MAX_SKB_FRAGS + 2 (~18), which is much less than UIO_MAXIOV.
>=20
> This is the limitation of #page frags for skb, not the iov limitation.
>=20
> Thanks
>=20
> > Please point out if I missed anything. Thanks.
> >=20
> > Best,
> > Wei
> >=20
> >=20
