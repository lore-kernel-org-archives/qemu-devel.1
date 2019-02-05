Received: from eggs.gnu.org ([209.51.188.92]:59695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gqzaR-0005K8-Fg
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 07:12:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gqzSD-0001Xa-B6
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 07:03:59 -0500
Date: Tue, 5 Feb 2019 13:03:44 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190205130344.30b8279f.cohuck@redhat.com>
In-Reply-To: <9b35717e-8994-cde9-2afe-243ab80c371a@linux.ibm.com>
References: <20190130132212.7376-1-cohuck@redhat.com>
	<20190130132212.7376-2-cohuck@redhat.com>
	<9b35717e-8994-cde9-2afe-243ab80c371a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/6] vfio-ccw: make it safe to access
 channel programs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Farman <farman@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Mon, 4 Feb 2019 14:25:34 -0500
Eric Farman <farman@linux.ibm.com> wrote:

> On 01/30/2019 08:22 AM, Cornelia Huck wrote:
> > When we get a solicited interrupt, the start function may have
> > been cleared by a csch, but we still have a channel program
> > structure allocated. Make it safe to call the cp accessors in
> > any case, so we can call them unconditionally.
> > 
> > While at it, also make sure that functions called from other parts
> > of the code return gracefully if the channel program structure
> > has not been initialized (even though that is a bug in the caller).
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >   drivers/s390/cio/vfio_ccw_cp.c  | 20 +++++++++++++++++++-
> >   drivers/s390/cio/vfio_ccw_cp.h  |  2 ++
> >   drivers/s390/cio/vfio_ccw_fsm.c |  5 +++++
> >   3 files changed, 26 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> > index ba08fe137c2e..0bc0c38edda7 100644
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
> 
> Not seen in this hunk, but we call ccwchain_loop_tic() just prior to 
> this point.  If that returns non-zero, we call cp_unpin_free()[1] (and 
> set initailized to false), and then fall through to here.  So this is 
> going to set initialized to true, even though we're taking an error 
> path.  :-(

Eek, setting c64 unconditionally threw me off. This needs to check
for !ret, of course.

> 
> [1] Wait, why is it calling cp_unpin_free()?  Oh, I had proposed 
> squashing cp_free() and cp_unpin_free() back in November[2], got an r-b 
> from Pierre but haven't gotten back to tidy up the series for a v2. 
> Okay, I'll try to do that again soon.  :-)

:)

> [2] https://patchwork.kernel.org/patch/10675261/
> 
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
> > @@ -760,6 +764,10 @@ int cp_prefetch(struct channel_program *cp)
> >   	struct ccwchain *chain;
> >   	int len, idx, ret;
> >   
> > +	/* this is an error in the caller */
> > +	if (!cp || !cp->initialized)
> > +		return -EINVAL;
> > +
> >   	list_for_each_entry(chain, &cp->ccwchain_list, next) {
> >   		len = chain->ch_len;
> >   		for (idx = 0; idx < len; idx++) {
> > @@ -795,6 +803,10 @@ union orb *cp_get_orb(struct channel_program *cp, u32 intparm, u8 lpm)
> >   	struct ccwchain *chain;
> >   	struct ccw1 *cpa;
> >   
> > +	/* this is an error in the caller */
> > +	if (!cp || !cp->initialized)
> > +		return NULL;
> > +
> >   	orb = &cp->orb;
> >   
> >   	orb->cmd.intparm = intparm;
> > @@ -831,6 +843,9 @@ void cp_update_scsw(struct channel_program *cp, union scsw *scsw)
> >   	u32 cpa = scsw->cmd.cpa;
> >   	u32 ccw_head, ccw_tail;
> >   
> > +	if (!cp->initialized)
> > +		return;
> > +
> >   	/*
> >   	 * LATER:
> >   	 * For now, only update the cmd.cpa part. We may need to deal with
> > @@ -869,6 +884,9 @@ bool cp_iova_pinned(struct channel_program *cp, u64 iova)
> >   	struct ccwchain *chain;
> >   	int i;
> >   
> > +	if (!cp->initialized)  
> 
> So, two of the checks added above look for a nonzero cp pointer prior to 
> checking initialized, while two don't.  I guess cp can't be NULL, since 
> it's embedded in the private struct directly and that's only free'd when 
> we do vfio_ccw_sch_remove() ... But I guess some consistency in how we 
> look would be nice.

The idea was: In which context is this called? Is there a legitimate
reason for the caller to pass in an uninitialized cp, or would that
mean the caller had messed up (and we should not trust cp to be !NULL
either?)

But you're right, that does look inconsistent. Always checking for
cp != NULL probably looks least odd, although it is overkill. Opinions?

> 
> > +		return false;
> > +
> >   	list_for_each_entry(chain, &cp->ccwchain_list, next) {
> >   		for (i = 0; i < chain->ch_len; i++)
> >   			if (pfn_array_table_iova_pinned(chain->ch_pat + i,
