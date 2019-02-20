Received: from eggs.gnu.org ([209.51.188.92]:32997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gwJC3-0001kC-Sf
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 23:09:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gwJ7E-00038t-Vq
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 23:04:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gwJ7D-000382-BR
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 23:04:11 -0500
Date: Wed, 20 Feb 2019 12:01:09 +0800
From: Wei Xu <wexu@redhat.com>
Message-ID: <20190220040109.GD23868@wei-ubt>
References: <1550118402-4057-1-git-send-email-wexu@redhat.com>
	<1550118402-4057-10-git-send-email-wexu@redhat.com>
	<1c16f234-af83-23c8-2194-94be63574299@redhat.com>
	<20190219105155.GD15343@wei-ubt>
	<b6469e59-0db7-5f6d-8b21-355ffdebb689@redhat.com>
	<20190220015441.GB23868@wei-ubt>
	<9a9751aa-0cfc-151a-890c-ae70a9a37d64@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9a9751aa-0cfc-151a-890c-ae70a9a37d64@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 09/11] virtio-net: update the head
 descriptor in a chain lastly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: tiwei.bie@intel.com, maxime.coquelin@redhat.com, qemu-devel@nongnu.org, jfreiman@redhat.com, mst@redhat.com

On Wed, Feb 20, 2019 at 10:34:32AM +0800, Jason Wang wrote:
>=20
> On 2019/2/20 =E4=B8=8A=E5=8D=889:54, Wei Xu wrote:
> >On Tue, Feb 19, 2019 at 09:09:33PM +0800, Jason Wang wrote:
> >>On 2019/2/19 =E4=B8=8B=E5=8D=886:51, Wei Xu wrote:
> >>>On Tue, Feb 19, 2019 at 03:23:01PM +0800, Jason Wang wrote:
> >>>>On 2019/2/14 =E4=B8=8B=E5=8D=8812:26, wexu@redhat.com wrote:
> >>>>>From: Wei Xu <wexu@redhat.com>
> >>>>>
> >>>>>This is a helper for packed ring.
> >>>>>
> >>>>>To support packed ring, the head descriptor in a chain should be u=
pdated
> >>>>>lastly since no 'avail_idx' like in packed ring to explicitly tell=
 the
> >>>>>driver side that all payload is ready after having done the chain,=
 so
> >>>>>the head is always visible immediately.
> >>>>>
> >>>>>This patch fills the header after done all the other ones.
> >>>>>
> >>>>>Signed-off-by: Wei Xu <wexu@redhat.com>
> >>>>It's really odd to workaround API issue in the implementation of de=
vice.
> >>>>Please introduce batched used updating helpers instead.
> >>>Can you elaborate a bit more? I don't get it as well.
> >>>
> >>>The exact batch as vhost-net or dpdk pmd is not supported by userspa=
ce
> >>>backend. The change here is to keep the header descriptor updated at
> >>>last in case of a chaining descriptors and the helper might not help
> >>>too much.
> >>>
> >>>Wei
> >>
> >>Of course we can add batching support why not?
> >It is always good to improve performance with anything, while probably
> >this could be done in another separate batch, also we need to bear
> >in mind that usually qemu userspace backend is not the first option fo=
r
> >performance oriented user.
>=20
>=20
> The point is to hide layout specific things from device emulation. If i=
t
> helps for performance, it could be treated as a good byproduct.
>=20
>=20
> >
> >AFAICT, virtqueue_fill() is a generic API for all relevant userspace v=
irtio
> >devices that do not support batching , without touching virtqueue_fill=
(),
> >supporting batching changes the meaning of the parameter 'idx' which s=
hould
> >be kept overall.
> >
> >To fix it, I got two proposals so far:
> >1). batching support(two APIs needed to keep compatibility)
> >2). save a head elem for a vq instead of caching an array of elems lik=
e vhost,
> >     and introduce a new API(virtqueue_chain_fill()) functioning with =
an
> >     additional parameter 'more' to the current virtqueue_fill() to in=
dicate if
> >     there are more descriptor(s) coming in a chain.
> >
> >Either way it changes the API somehow and it does not seem to be clean=
 and clear
> >as wanted.
>=20
>=20
> It's as simple as accepting an array of elems in e.g
> virtqueue_fill_batched()?

It is trivial for both, my concern is an array elements need to be alloca=
ted dynamically
due to vq size which no any other devices are using, a head would be enou=
gh for 2.

>=20
>=20
> >
> >Any better idea?
> >
> >>Your code assumes the device know the virtio layout specific assumpti=
on
> >>whih breaks the layer. Device should not care about the actual layout=
.
> >>
> >Good point, but anyway, change to virtio-net receiving code path is
> >unavoidable to support split and packed rings, and batching is like a =
new
> >feature somehow.
>=20
>=20
> It's ok to change the code as a result of introducing of generic helper=
 but
> it's bad to change to code for working around a bad API.

Agree.

Wei

>=20
> Thanks
>=20
>=20
> >
> >Wei
> >>Thanks
> >>
> >>
> >>>>Thanks
> >>>>
> >>>>
> >>>>>---
> >>>>>  hw/net/virtio-net.c | 11 ++++++++++-
> >>>>>  1 file changed, 10 insertions(+), 1 deletion(-)
> >>>>>
> >>>>>diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> >>>>>index 3f319ef..330abea 100644
> >>>>>--- a/hw/net/virtio-net.c
> >>>>>+++ b/hw/net/virtio-net.c
> >>>>>@@ -1251,6 +1251,8 @@ static ssize_t virtio_net_receive_rcu(NetCli=
entState *nc, const uint8_t *buf,
> >>>>>      struct virtio_net_hdr_mrg_rxbuf mhdr;
> >>>>>      unsigned mhdr_cnt =3D 0;
> >>>>>      size_t offset, i, guest_offset;
> >>>>>+    VirtQueueElement head;
> >>>>>+    int head_len =3D 0;
> >>>>>      if (!virtio_net_can_receive(nc)) {
> >>>>>          return -1;
> >>>>>@@ -1328,7 +1330,13 @@ static ssize_t virtio_net_receive_rcu(NetCl=
ientState *nc, const uint8_t *buf,
> >>>>>          }
> >>>>>          /* signal other side */
> >>>>>-        virtqueue_fill(q->rx_vq, elem, total, i++);
> >>>>>+        if (i =3D=3D 0) {
> >>>>>+            head_len =3D total;
> >>>>>+            head =3D *elem;
> >>>>>+        } else {
> >>>>>+            virtqueue_fill(q->rx_vq, elem, len, i);
> >>>>>+        }
> >>>>>+        i++;
> >>>>>          g_free(elem);
> >>>>>      }
> >>>>>@@ -1339,6 +1347,7 @@ static ssize_t virtio_net_receive_rcu(NetCli=
entState *nc, const uint8_t *buf,
> >>>>>                       &mhdr.num_buffers, sizeof mhdr.num_buffers)=
;
> >>>>>      }
> >>>>>+    virtqueue_fill(q->rx_vq, &head, head_len, 0);
> >>>>>      virtqueue_flush(q->rx_vq, i);
> >>>>>      virtio_notify(vdev, q->rx_vq);
>=20
