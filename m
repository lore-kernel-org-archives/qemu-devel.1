Received: from eggs.gnu.org ([209.51.188.92]:45708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gvsQj-0006mR-C2
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 18:34:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gvsQf-0003Fk-PI
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 18:34:32 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43881)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gvsQd-0003Dh-GH
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 18:34:28 -0500
Received: by mail-qt1-f195.google.com with SMTP id y4so21133882qtc.10
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 15:34:25 -0800 (PST)
Date: Mon, 18 Feb 2019 18:34:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190218183353-mutt-send-email-mst@kernel.org>
References: <20190213145116.20654-1-yuri.benditovich@daynix.com>
	<0801b4b7-ac54-1374-3d97-a59a10579218@redhat.com>
	<CAOEp5Od-1AY=6ARRD9J=W2ZhYqEgKpmMBMcm1fiqSCjLRVREyA@mail.gmail.com>
	<20190218113447-mutt-send-email-mst@kernel.org>
	<CAOEp5OdVUcXTXmEFYyU6iFxd--P+4o5wkAjOr76EUG6eEne+KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOEp5OdVUcXTXmEFYyU6iFxd--P+4o5wkAjOr76EUG6eEne+KA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] virtio-net: do not start queues that are
 not enabled by the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Yan Vugenfirer <yan@daynix.com>

On Mon, Feb 18, 2019 at 10:49:08PM +0200, Yuri Benditovich wrote:
> On Mon, Feb 18, 2019 at 6:39 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Feb 18, 2019 at 11:58:51AM +0200, Yuri Benditovich wrote:
> > > On Mon, Feb 18, 2019 at 5:49 AM Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > >
> > > > On 2019/2/13 下午10:51, Yuri Benditovich wrote:
> > > > > https://bugzilla.redhat.com/show_bug.cgi?id=1608226
> > > > > On startup/link-up in multiqueue configuration the virtio-net
> > > > > tries to starts all the queues, including those that the guest
> > > > > will not enable by VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET.
> > > > > If the guest driver does not allocate queues that it will not
> > > > > use (for example, Windows driver does not) and number of actually
> > > > > used queues is less that maximal number supported by the device,
> > > >
> > > >
> > > > Is this a requirement of e.g NDIS? If not, could we simply allocate all
> > > > queues in this case. This is usually what normal Linux driver did.
> > > >
> > > >
> > > > > this causes vhost_net_start to fail and actually disables vhost
> > > > > for all the queues, reducing the performance.
> > > > > Current commit fixes this: initially only first queue is started,
> > > > > upon VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET started all the queues
> > > > > requested by the guest.
> > > > >
> > > > > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > > > > ---
> > > > >   hw/net/virtio-net.c | 7 +++++--
> > > > >   1 file changed, 5 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > > > > index 3f319ef723..d3b1ac6d3a 100644
> > > > > --- a/hw/net/virtio-net.c
> > > > > +++ b/hw/net/virtio-net.c
> > > > > @@ -174,7 +174,7 @@ static void virtio_net_vhost_status(VirtIONet *n, uint8_t status)
> > > > >   {
> > > > >       VirtIODevice *vdev = VIRTIO_DEVICE(n);
> > > > >       NetClientState *nc = qemu_get_queue(n->nic);
> > > > > -    int queues = n->multiqueue ? n->max_queues : 1;
> > > > > +    int queues = n->multiqueue ? n->curr_queues : 1;
> > > > >
> > > > >       if (!get_vhost_net(nc->peer)) {
> > > > >           return;
> > > > > @@ -1016,9 +1016,12 @@ static int virtio_net_handle_mq(VirtIONet *n, uint8_t cmd,
> > > > >           return VIRTIO_NET_ERR;
> > > > >       }
> > > > >
> > > > > -    n->curr_queues = queues;
> > > > >       /* stop the backend before changing the number of queues to avoid handling a
> > > > >        * disabled queue */
> > > > > +    virtio_net_set_status(vdev, 0);
> > > >
> > > >
> > > > Any reason for doing this?
> > >
> > > I think there are 2 reasons:
> > > 1. The spec does not require guest SW to allocate unused queues.
> > > 2. We spend guest's physical memory to just make vhost happy when it
> > > touches queues that it should not use.
> > >
> > > Thanks,
> > > Yuri Benditovich
> >
> > The spec also says:
> >         queue_enable The driver uses this to selectively prevent the device from executing requests from this
> >         virtqueue. 1 - enabled; 0 - disabled.
> >
> > While this is not a conformance clause this strongly implies that
> > queues which are not enabled are never accessed by device.
> >
> > Yuri I am guessing you are not enabling these unused queues right?
> 
> Of course, we (Windows driver) do not.
> The code of virtio-net passes max_queues to vhost and this causes
> vhost to try accessing all the queues, fail on unused ones and finally
> leave vhost disabled at all.


Jason, at least for 1.0 accessing disabled queues looks like a spec
violation. What do you think?

> >
> >
> >
> > > >
> > > > Thanks
> > > >
> > > >
> > > > > +
> > > > > +    n->curr_queues = queues;
> > > > > +
> > > > >       virtio_net_set_status(vdev, vdev->status);
> > > > >       virtio_net_set_queues(n);
> > > > >
