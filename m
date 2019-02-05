Received: from eggs.gnu.org ([209.51.188.92]:51253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gr3c0-0004BS-6p
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:30:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gr3bz-0003Qq-0F
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:30:16 -0500
Date: Tue, 5 Feb 2019 17:29:59 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190205172959.29868870.cohuck@redhat.com>
In-Reply-To: <34836353-1c5b-4013-f0ff-6172bf493618@linux.ibm.com>
References: <20190130132212.7376-1-cohuck@redhat.com>
	<20190130132212.7376-2-cohuck@redhat.com>
	<9b35717e-8994-cde9-2afe-243ab80c371a@linux.ibm.com>
	<20190205130344.30b8279f.cohuck@redhat.com>
	<34836353-1c5b-4013-f0ff-6172bf493618@linux.ibm.com>
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

On Tue, 5 Feb 2019 09:41:15 -0500
Eric Farman <farman@linux.ibm.com> wrote:

> On 02/05/2019 07:03 AM, Cornelia Huck wrote:
> > On Mon, 4 Feb 2019 14:25:34 -0500
> > Eric Farman <farman@linux.ibm.com> wrote:
> >   
> >> On 01/30/2019 08:22 AM, Cornelia Huck wrote:  

> >>> @@ -760,6 +764,10 @@ int cp_prefetch(struct channel_program *cp)
> >>>    	struct ccwchain *chain;
> >>>    	int len, idx, ret;
> >>>    
> >>> +	/* this is an error in the caller */
> >>> +	if (!cp || !cp->initialized)
> >>> +		return -EINVAL;
> >>> +
> >>>    	list_for_each_entry(chain, &cp->ccwchain_list, next) {
> >>>    		len = chain->ch_len;
> >>>    		for (idx = 0; idx < len; idx++) {
> >>> @@ -795,6 +803,10 @@ union orb *cp_get_orb(struct channel_program *cp, u32 intparm, u8 lpm)
> >>>    	struct ccwchain *chain;
> >>>    	struct ccw1 *cpa;
> >>>    
> >>> +	/* this is an error in the caller */
> >>> +	if (!cp || !cp->initialized)
> >>> +		return NULL;
> >>> +
> >>>    	orb = &cp->orb;
> >>>    
> >>>    	orb->cmd.intparm = intparm;
> >>> @@ -831,6 +843,9 @@ void cp_update_scsw(struct channel_program *cp, union scsw *scsw)
> >>>    	u32 cpa = scsw->cmd.cpa;
> >>>    	u32 ccw_head, ccw_tail;
> >>>    
> >>> +	if (!cp->initialized)
> >>> +		return;
> >>> +
> >>>    	/*
> >>>    	 * LATER:
> >>>    	 * For now, only update the cmd.cpa part. We may need to deal with
> >>> @@ -869,6 +884,9 @@ bool cp_iova_pinned(struct channel_program *cp, u64 iova)
> >>>    	struct ccwchain *chain;
> >>>    	int i;
> >>>    
> >>> +	if (!cp->initialized)  
> >>
> >> So, two of the checks added above look for a nonzero cp pointer prior to
> >> checking initialized, while two don't.  I guess cp can't be NULL, since
> >> it's embedded in the private struct directly and that's only free'd when
> >> we do vfio_ccw_sch_remove() ... But I guess some consistency in how we
> >> look would be nice.  
> > 
> > The idea was: In which context is this called? Is there a legitimate
> > reason for the caller to pass in an uninitialized cp, or would that
> > mean the caller had messed up (and we should not trust cp to be !NULL
> > either?)
> > 
> > But you're right, that does look inconsistent. Always checking for
> > cp != NULL probably looks least odd, although it is overkill. Opinions?  
> 
> My opinion?  Since cp is embedded in vfio_ccw_private, rather than a 
> pointer to a separately malloc'd struct, we pass &private->cp to those 
> functions.  So a check for !cp doesn't really buy us anything because 
> what we are actually concerned about is whether or not private is NULL, 
> which only changes on the probe/remove boundaries.

I guess if we pass in crap (or NULL) instead of &private->cp, it's our
own fault and we can disregard fencing that case. The probe/remove path
does not really bother me, for the reasons you said.
