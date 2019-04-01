Received: from eggs.gnu.org ([209.51.188.92]:40506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hAxF1-0004fE-8x
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 09:44:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hAxF0-0000OB-44
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 09:44:47 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41605)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hAxEz-0000MY-Eh
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 09:44:45 -0400
Received: by mail-qt1-f196.google.com with SMTP id w30so10554386qta.8
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 06:44:44 -0700 (PDT)
Date: Mon, 1 Apr 2019 09:44:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190401093414-mutt-send-email-mst@kernel.org>
References: <20190325035613.18192-1-jasowang@redhat.com>
	<20190325074939-mutt-send-email-mst@kernel.org>
	<92955c79-8389-85d5-cc1a-545c35aceb74@redhat.com>
	<20190326084809-mutt-send-email-mst@kernel.org>
	<54169022-3b92-a49b-88b9-076e64a22e10@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54169022-3b92-a49b-88b9-076e64a22e10@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V2 RFT] vhost_net: don't set backend for
 the uninitialized virtqueue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: yuri.benditovich@daynix.com, qemu-devel@nongnu.org

On Wed, Mar 27, 2019 at 10:27:01AM +0800, Jason Wang wrote:
> 
> On 2019/3/26 下午8:49, Michael S. Tsirkin wrote:
> > On Tue, Mar 26, 2019 at 02:59:19PM +0800, Jason Wang wrote:
> > > On 2019/3/25 下午8:32, Michael S. Tsirkin wrote:
> > > > On Mon, Mar 25, 2019 at 11:56:13AM +0800, Jason Wang wrote:
> > > > > We used to set backend unconditionally, this won't work for some
> > > > > guests (e.g windows driver) who may not initialize all virtqueues. For
> > > > > kernel backend, this will fail since it may try to validate the rings
> > > > > during setting backend.
> > > > > 
> > > > > Fixing this by simply skipping the backend set when we find desc is
> > > > > not ready.
> > > > > 
> > > > > Signed-off-by: Jason Wang<jasowang@redhat.com>
> > > > > ---
> > > > >    hw/net/vhost_net.c | 15 +++++++++++++++
> > > > >    1 file changed, 15 insertions(+)
> > > > > 
> > > > > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> > > > > index be3cc88370..04fd924d15 100644
> > > > > --- a/hw/net/vhost_net.c
> > > > > +++ b/hw/net/vhost_net.c
> > > > > @@ -221,6 +221,7 @@ static int vhost_net_start_one(struct vhost_net *net,
> > > > >                                   VirtIODevice *dev)
> > > > >    {
> > > > >        struct vhost_vring_file file = { };
> > > > > +    hwaddr a;
> > > > >        int r;
> > > > >        net->dev.nvqs = 2;
> > > > > @@ -244,6 +245,13 @@ static int vhost_net_start_one(struct vhost_net *net,
> > > > >            qemu_set_fd_handler(net->backend, NULL, NULL, NULL);
> > > > >            file.fd = net->backend;
> > > > >            for (file.index = 0; file.index < net->dev.nvqs; ++file.index) {
> > > > > +            a = virtio_queue_get_desc_addr(dev,
> > > > > +                                           net->dev.vq_index +
> > > > > +                                           file.index);
> > > > > +            if (a == 0) {
> > > > > +                /* Queue might not be ready for start */
> > > > > +                continue;
> > > > > +            }
> > > > >                r = vhost_net_set_backend(&net->dev, &file);
> > > > >                if (r < 0) {
> > > > >                    r = -errno;
> > > > > @@ -256,6 +264,13 @@ fail:
> > > > >        file.fd = -1;
> > > > >        if (net->nc->info->type == NET_CLIENT_DRIVER_TAP) {
> > > > >            while (file.index-- > 0) {
> > > > > +            a = virtio_queue_get_desc_addr(dev,
> > > > > +                                           net->dev.vq_index +
> > > > > +                                           file.index);
> > > > > +            if (a == 0) {
> > > > > +                /* Queue might not be ready for start */
> > > > > +                continue;
> > > > > +            }
> > > > >                int r = vhost_net_set_backend(&net->dev, &file);
> > > > >                assert(r >= 0);
> > > > >            }
> > > > I think we want an API that explicitly says "queue is enabled".
> > > > For 0.X it will return !!addr. For 1.X it will return enabled.
> > > For 1.x, desc.addr won't be set until queue_enabled is set through
> > > virtio_queue_set_vrings(). And it looks to me ccw did something similar of
> > > CMD_SET_VQ.
> > > 
> > > So we're ok actually?
> > > 
> > > Thanks
> > > 
> > OK maybe but why can't we use an explicit API?
> > 0.X can use addr != 0 trick since there's no queue_enabled.
> > 
> 
> If I understand correctly, you want something similar to what V1 did? A bus
> specific queue_enable() method.
> 
> Thanks

For now all I am asking for is simply:
	virtio_queue_is_enabled() {
		/* desc is only set when queue is enabled */
		return vdev->vq[n].vring.desc != 0;
}

and then we can look at moving the enabled flag into
struct VRing longer term.


-- 
MST
