Received: from eggs.gnu.org ([2001:4830:134:3::10]:59308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dB20l-0004Va-RA
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:41:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dB20i-00043w-MH
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:41:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dB20i-00043o-DC
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:41:16 -0400
Date: Wed, 17 May 2017 19:41:02 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170517194008-mutt-send-email-mst@kernel.org>
References: <20170511123246.31308-1-maxime.coquelin@redhat.com>
	<20170511123246.31308-4-maxime.coquelin@redhat.com>
	<20170511202154-mutt-send-email-mst@kernel.org>
	<8101cc11-51b7-9361-6506-25986aa652c4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8101cc11-51b7-9361-6506-25986aa652c4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/6] vhost: Update rings information for
 IOTLB earlier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: peterx@redhat.com, marcandre.lureau@gmail.com, vkaplans@redhat.com, jasowang@redhat.com, wexu@redhat.com, yuanhan.liu@linux.intel.com, qemu-devel@nongnu.org, jfreiman@redhat.com

On Fri, May 12, 2017 at 01:21:18PM +0200, Maxime Coquelin wrote:
> 
> 
> On 05/11/2017 07:33 PM, Michael S. Tsirkin wrote:
> > On Thu, May 11, 2017 at 02:32:43PM +0200, Maxime Coquelin wrote:
> > > Vhost-kernel backend need to receive IOTLB entries for rings
> > > information early, but vhost-user need the same information
> > > earlier, before VHOST_USER_SET_VRING_ADDR is sent.
> > 
> > Weird. What does VHOST_USER_SET_VRING_ADDR have to do with it?
> > 
> > According to
> > 	Starting and stopping rings
> > in vhost user spec, vhost user does not access
> > anything until ring is started and enabled.
> > 
> > 
> > > This patch also trigger IOTLB miss for all rings informations
> > > for robustness, even if in practice these adresses are on the
> > > same page.
> 
> Actually, the DPDK vhost-user backend is compliant with the spec,
> but when handling VHOST_USER_SET_VRING_ADDR request, it translates the
> guest addresses into backend VAs, and check they are valid. I will make the
> commit message clearer about this in next revision.
> 
> The check could be done later, for example when the ring are started,
> but it wouldn't change the need to trigger a miss at some point.

I think it should be done later, yes. As long as ring is not
started addresses should not be interpreted.

> Or it could be done in the processing threads, the first time the
> addresses are used, but it would add a check for every burst of packets
> processed.

We don't want that, I agree.

> > > 
> > > Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> > > ---
> > >   hw/virtio/vhost.c | 19 +++++++++++--------
> > >   1 file changed, 11 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > > index 748e331..817f6d0 100644
> > > --- a/hw/virtio/vhost.c
> > > +++ b/hw/virtio/vhost.c
> > > @@ -799,7 +799,17 @@ static int vhost_virtqueue_set_addr(struct vhost_dev *dev,
> > >           .log_guest_addr = vq->used_phys,
> > >           .flags = enable_log ? (1 << VHOST_VRING_F_LOG) : 0,
> > >       };
> > > -    int r = dev->vhost_ops->vhost_set_vring_addr(dev, &addr);
> > > +    int r;
> > > +
> > > +    /* Update rings information for IOTLB to work correctly,
> > > +     * vhost-kernel & vhost-user backends require for this.*/
> > 
> > Any requirements must be in the spec. Pls add them there.
> > Pls fix comment style as you move code.
> Sure.
> 
> Thanks,
> Maxime
