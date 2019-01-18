Received: from eggs.gnu.org ([209.51.188.92]:53809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gkUad-0003rD-JL
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:53:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gkUac-0001vJ-KV
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:53:43 -0500
Date: Fri, 18 Jan 2019 14:53:23 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190118145323.0734fdaa.cohuck@redhat.com>
In-Reply-To: <a9eb4e42-536e-efa4-7097-c05492078fb0@linux.ibm.com>
References: <20181122165432.4437-1-cohuck@redhat.com>
	<20181122165432.4437-4-cohuck@redhat.com>
	<b5066f7a-7024-ac3e-a91d-938fd845e1d9@linux.ibm.com>
	<20181128100249.72d4299a.cohuck@redhat.com>
	<25021742-a7a8-a90c-a2a3-eb8a78bf1fb0@linux.ibm.com>
	<20181128155201.5be1d582.cohuck@redhat.com>
	<1feb66c0-ce80-2853-1522-e7d787471fd3@linux.ibm.com>
	<20181128163547.7eb33873.cohuck@redhat.com>
	<a9eb4e42-536e-efa4-7097-c05492078fb0@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] vfio-ccw: add handling for asnyc
 channel instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Wed, 28 Nov 2018 10:55:11 -0500
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 11/28/2018 10:35 AM, Cornelia Huck wrote:

> > I hacked up the following (still untested):
> > 
> >  From e771c8dc5abbfbd19688b452096bab9d032e0df5 Mon Sep 17 00:00:00 2001
> > From: Cornelia Huck <cohuck@redhat.com>
> > Date: Wed, 28 Nov 2018 16:30:51 +0100
> > Subject: [PATCH] vfio-ccw: make it safe to access channel programs
> > 
> > When we get a solicited interrupt, the start function may have
> > been cleared by a csch, but we still have a channel program
> > structure allocated. Make it safe to call the cp accessors in
> > any case, so we can call them unconditionally.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >   drivers/s390/cio/vfio_ccw_cp.c  | 9 ++++++++-
> >   drivers/s390/cio/vfio_ccw_cp.h  | 2 ++
> >   drivers/s390/cio/vfio_ccw_drv.c | 3 +--
> >   3 files changed, 11 insertions(+), 3 deletions(-)

Hm, this one seems to have fallen through the cracks; but it still does
look useful, especially if we want to allow concurrent handling of
channel operations.

> > 
> > diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> > index 70a006ba4d05..35f87514276b 100644
> > --- a/drivers/s390/cio/vfio_ccw_cp.c
> > +++ b/drivers/s390/cio/vfio_ccw_cp.c
> > @@ -335,6 +335,7 @@ static void cp_unpin_free(struct channel_program *cp)
> >   	struct ccwchain *chain, *temp;
> >   	int i;
> >   
> > +	cp->initialized = false;
> >   	list_for_each_entry_safe(chain, temp, &cp->ccwchain_list, next) {
> >   		for (i = 0; i < chain->ch_len; i++) {
> >   			pfn_array_table_unpin_free(chain->ch_pat + i,
> > @@ -701,6 +702,8 @@ int cp_init(struct channel_program *cp, struct device *mdev, union orb *orb)
> >   	 */
> >   	cp->orb.cmd.c64 = 1;
> >   
> > +	cp->initialized = true;
> > +
> >   	return ret;
> >   }
> >   
> > @@ -715,7 +718,8 @@ int cp_init(struct channel_program *cp, struct device *mdev, union orb *orb)
> >    */
> >   void cp_free(struct channel_program *cp)
> >   {
> > -	cp_unpin_free(cp);
> > +	if (cp->initialized)
> > +		cp_unpin_free(cp);
> >   }
> >   
> >   /**
> > @@ -831,6 +835,9 @@ void cp_update_scsw(struct channel_program *cp, union scsw *scsw)
> >   	u32 cpa = scsw->cmd.cpa;
> >   	u32 ccw_head, ccw_tail;
> >   
> > +	if (!cp->initialized)
> > +		return;
> > +
> >   	/*
> >   	 * LATER:
> >   	 * For now, only update the cmd.cpa part. We may need to deal with
> > diff --git a/drivers/s390/cio/vfio_ccw_cp.h b/drivers/s390/cio/vfio_ccw_cp.h
> > index a4b74fb1aa57..3c20cd208da5 100644
> > --- a/drivers/s390/cio/vfio_ccw_cp.h
> > +++ b/drivers/s390/cio/vfio_ccw_cp.h
> > @@ -21,6 +21,7 @@
> >    * @ccwchain_list: list head of ccwchains
> >    * @orb: orb for the currently processed ssch request
> >    * @mdev: the mediated device to perform page pinning/unpinning
> > + * @initialized: whether this instance is actually initialized
> >    *
> >    * @ccwchain_list is the head of a ccwchain list, that contents the
> >    * translated result of the guest channel program that pointed out by
> > @@ -30,6 +31,7 @@ struct channel_program {
> >   	struct list_head ccwchain_list;
> >   	union orb orb;
> >   	struct device *mdev;
> > +	bool initialized;
> >   };
> >   
> >   extern int cp_init(struct channel_program *cp, struct device *mdev,
> > diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
> > index 890c588a3a61..83d6f43792b6 100644
> > --- a/drivers/s390/cio/vfio_ccw_drv.c
> > +++ b/drivers/s390/cio/vfio_ccw_drv.c
> > @@ -79,8 +79,7 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
> >   	private = container_of(work, struct vfio_ccw_private, io_work);
> >   	irb = &private->irb;
> >   
> > -	if (scsw_is_solicited(&irb->scsw) &&
> > -	    (scsw_fctl(&irb->scsw) & SCSW_FCTL_START_FUNC)) {
> > +	if (scsw_is_solicited(&irb->scsw)) {
> >   		cp_update_scsw(&private->cp, &irb->scsw);
> >   		cp_free(&private->cp);
> >   	}
> >   
> 
> The changes look good to me.

Thanks!

> 
> Thanks
> Farhan
> 
