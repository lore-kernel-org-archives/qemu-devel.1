Received: from eggs.gnu.org ([2001:4830:134:3::10]:52406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQ5vy-0005z6-9Z
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 02:59:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQ5vv-0003mw-7K
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 02:59:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56448 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fQ5vv-0003mc-0g
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 02:59:07 -0400
Date: Tue, 5 Jun 2018 14:58:57 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180605065857.GC9216@xz-mi>
References: <1524550428-27173-1-git-send-email-wei.w.wang@intel.com>
	<1524550428-27173-5-git-send-email-wei.w.wang@intel.com>
	<20180529181221-mutt-send-email-mst@kernel.org>
	<5B0E6AE9.2030505@intel.com>
	<20180530154325-mutt-send-email-mst@kernel.org>
	<5B14F2A3.9010805@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5B14F2A3.9010805@intel.com>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com, zhang.zhanghailiang@huawei.com

On Mon, Jun 04, 2018 at 04:04:51PM +0800, Wei Wang wrote:
> On 05/30/2018 08:47 PM, Michael S. Tsirkin wrote:
> > On Wed, May 30, 2018 at 05:12:09PM +0800, Wei Wang wrote:
> > > On 05/29/2018 11:24 PM, Michael S. Tsirkin wrote:
> > > > On Tue, Apr 24, 2018 at 02:13:47PM +0800, Wei Wang wrote:
> > > > > +/*
> > > > > + * Balloon will report pages which were free at the time of this call. As the
> > > > > + * reporting happens asynchronously, dirty bit logging must be enabled before
> > > > > + * this call is made.
> > > > > + */
> > > > > +void balloon_free_page_start(void)
> > > > > +{
> > > > > +    balloon_free_page_start_fn(balloon_opaque);
> > > > > +}
> > > > Please create notifier support, not a single global.
> > > OK. The start is called at the end of bitmap_sync, and the stop is called at
> > > the beginning of bitmap_sync. In this case, we will need to add two
> > > migration states, MIGRATION_STATUS_BEFORE_BITMAP_SYNC and
> > > MIGRATION_STATUS_AFTER_BITMAP_SYNC, right?
> 
> Peter, do you have any thought about this?
> 
> Currently, the usage of free page optimization isn't limited to the first
> stage. It is used in each stage. A global call to start the free page
> optimization is made after bitmap sync, and another global call to stop the
> optimization is made before bitmap sync. It is simple to just use global
> calls.
> 
> If we change the implementation to use notifiers, I think we will need to
> add two new MigrationStatus as above. Would you think that is worthwhile for
> some reason?

I'm a bit confused.  Could you elaborate why we need those extra
states?

Or, to ask a more general question - could you elaborate a bit on how
you order these operations?  I would be really glad if you can point
me to some documents for the feature.  Is there any latest virtio
document that I can refer to (or old cover letter links)?  It'll be
good if the document could mention about things like:

- why we need this feature? Is that purely for migration purpose?  Or
  it can be used somewhere else too?
- high level stuff about how this is implemented, e.g.:
  - the protocol of the new virtio queues
  - how we should get the free page hints (please see below)

For now, what I see is that we do:

(1) stop hinting
(2) sync bitmap
(3) start hinting

Why this order?  My understanding is that obviously there is a race
between the page hinting thread and the dirty bitmap tracking part
(which is done in KVM).  How do we make sure there is no race?

An direct question is that, do we need to make sure step (1) must be
before step (2)?  Asked since I see that currently step (1) is an
async operation (taking a lock, set status, then return).  Then would
such an async operation satisfy any ordering requirement after all?

Btw, I would appreciate if you can push your new trees (both QEMU and
kernel) to the links you mentioned in the cover letter - I noticed
that they are not the same as what you have posted on the list.

Thanks,

-- 
Peter Xu
