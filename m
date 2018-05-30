Received: from eggs.gnu.org ([2001:4830:134:3::10]:39297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fO0Vs-0007m7-8J
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:47:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fO0Vp-0000B9-J3
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:47:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41526 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fO0Vp-0000Al-CS
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:47:33 -0400
Date: Wed, 30 May 2018 15:47:31 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180530154325-mutt-send-email-mst@kernel.org>
References: <1524550428-27173-1-git-send-email-wei.w.wang@intel.com>
	<1524550428-27173-5-git-send-email-wei.w.wang@intel.com>
	<20180529181221-mutt-send-email-mst@kernel.org>
	<5B0E6AE9.2030505@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B0E6AE9.2030505@intel.com>
Subject: Re: [Qemu-devel] [PATCH v7 4/5] virtio-balloon:
 VIRTIO_BALLOON_F_FREE_PAGE_HINT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com, zhang.zhanghailiang@huawei.com

On Wed, May 30, 2018 at 05:12:09PM +0800, Wei Wang wrote:
> On 05/29/2018 11:24 PM, Michael S. Tsirkin wrote:
> > On Tue, Apr 24, 2018 at 02:13:47PM +0800, Wei Wang wrote:
> > > +/*
> > > + * Balloon will report pages which were free at the time of this call. As the
> > > + * reporting happens asynchronously, dirty bit logging must be enabled before
> > > + * this call is made.
> > > + */
> > > +void balloon_free_page_start(void)
> > > +{
> > > +    balloon_free_page_start_fn(balloon_opaque);
> > > +}
> > Please create notifier support, not a single global.
> 
> OK. The start is called at the end of bitmap_sync, and the stop is called at
> the beginning of bitmap_sync. In this case, we will need to add two
> migration states, MIGRATION_STATUS_BEFORE_BITMAP_SYNC and
> MIGRATION_STATUS_AFTER_BITMAP_SYNC, right?

If that's the way you do it, you need to ask migration guys, not me.

> 
> > 
> > +static void virtio_balloon_poll_free_page_hints(void *opaque)
> > +{
> > +    VirtQueueElement *elem;
> > +    VirtIOBalloon *dev = opaque;
> > +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> > +    VirtQueue *vq = dev->free_page_vq;
> > +    uint32_t id;
> > +    size_t size;
> > +
> > +    while (1) {
> > +        qemu_mutex_lock(&dev->free_page_lock);
> > +        while (dev->block_iothread) {
> > +            qemu_cond_wait(&dev->free_page_cond, &dev->free_page_lock);
> > +        }
> > +
> > +        /*
> > +         * If the migration thread actively stops the reporting, exit
> > +         * immediately.
> > +         */
> > +        if (dev->free_page_report_status == FREE_PAGE_REPORT_S_STOP) {
> > Please refactor this : move loop body into a function so
> > you can do lock/unlock in a single place.
> 
> Sounds good.
> 
> > 
> > +
> > +static bool virtio_balloon_free_page_support(void *opaque)
> > +{
> > +    VirtIOBalloon *s = opaque;
> > +    VirtIODevice *vdev = VIRTIO_DEVICE(s);
> > +
> > +    return virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT);
> > or if poison is negotiated.
> 
> Will make it
> return virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT) &&
> !virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)


I mean the reverse:
	virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT) ||
	virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)


If poison has been negotiated you must migrate the
guest supplied value even if you don't use it for hints.


> 
> 
> Best,
> Wei
