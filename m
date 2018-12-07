Received: from eggs.gnu.org ([2001:4830:134:3::10]:41178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gVCXA-0000rM-05
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 04:34:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gVCX5-0005eQ-1c
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 04:34:55 -0500
Date: Fri, 7 Dec 2018 10:34:41 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181207103441.70b6a527.cohuck@redhat.com>
In-Reply-To: <7c88b304-aced-8330-a750-0765e0bd721a@linux.ibm.com>
References: <20181122165432.4437-1-cohuck@redhat.com>
	<20181204133810.66e8cfe5@oc2783563651>
	<20181204141130.06496b9b.cohuck@redhat.com>
	<20181204160236.54de2784@oc2783563651>
	<20181205135402.33c2b22d.cohuck@redhat.com>
	<aa190e90-f832-7958-aa83-1486e570bf40@linux.ibm.com>
	<20181206153917.59e8e291.cohuck@redhat.com>
	<bb6c992e-ac03-ce3e-fba8-283e392f1543@linux.ibm.com>
	<20181206172155.6a7dd69e.cohuck@redhat.com>
	<7c88b304-aced-8330-a750-0765e0bd721a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] vfio-ccw: support hsch/csch (kernel
 part)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, "Jason J
	. Herne" <jjherne@linux.ibm.com>

On Thu, 6 Dec 2018 12:50:50 -0500
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 12/06/2018 11:21 AM, Cornelia Huck wrote:
> > On Thu, 6 Dec 2018 10:26:12 -0500
> > Farhan Ali <alifm@linux.ibm.com> wrote:
> >   
> >> On 12/06/2018 09:39 AM, Cornelia Huck wrote:  
> >>> On Wed, 5 Dec 2018 13:34:11 -0500
> >>> Farhan Ali <alifm@linux.ibm.com> wrote:
> >>>      
> >>>> On 12/05/2018 07:54 AM, Cornelia Huck wrote:  
> >>>>>> Yeah, that is perfectly clear, but it ain't the complete story. E.g.
> >>>>>> are subsequent commands blocking until the preceding command finishes
> >>>>>> is part of the interface. And what is good implementation depends on the
> >>>>>> answer. What I mean, I first need to understand how things are supposed
> >>>>>> to work (together) so I can double check that against the
> >>>>>> implementation. Otherwise all I can do is nitpicking.
> >>>>>>
> >>>>>> To get more tangible: we are in the middle of processing an SSCH request
> >>>>>> (e.g. doing the translation) when a HSCH comes in. What should happen?
> >>>>>> Should we start processing HSCH after he instruction part of SSCH is
> >>>>>> done -- which currently includes translation? Or should we -EBUSY? Or do
> >>>>>> we abort START related activities and do the HALT stuff?  
> >>>>> I think most of the sorting-out-the-operations stuff should be done by
> >>>>> the hardware itself, and we should not really try to enforce anything
> >>>>> special in our vfio code.
> >>>>>
> >>>>> For your example, it might be best if a hsch is always accepted and
> >>>>> send on towards the hardware. Probably best to reflect back -EAGAIN if
> >>>>> we're currently processing another instruction from another vcpu, so
> >>>>> that the user space caller can retry. Same for ssch, if another ssch is
> >>>>> already being processed. We*could*  reflect cc 2 if the fctl bit is
> >>>>> already set, but that won't do for csch, so it is probably best to have
> >>>>> the hardware figure that out in any case.
> >>>>>
> >>>>> If I read the code correctly, we currently reflect -EBUSY and not
> >>>>> -EAGAIN if we get a ssch request while already processing another one.
> >>>>> QEMU hands that back to the guest as a cc 2, which is not 100% correct.
> >>>>> In practice, we don't see this with Linux guests due to locking.
> >>>>>         
> >>>>
> >>>> If we have a ssch and a csch immediately afterwards from userspace, will
> >>>> we end up issuing csch first and then ssch to the hardware?
> >>>>
> >>>> If I understand correctly, the ccw translation as part of the ssch can
> >>>> be a slow operation so it might be possible we issue the csch first?
> >>>> In that case we won't actually clear the original start function as
> >>>> intended.  
> >>>
> >>> When we start processing the ssch request (translation and so on), we
> >>> set the state to BUSY. This means that any csch request will get a
> >>> -EBUSY, no overtaking possible. (I think maybe I'll need to check what
> >>> this series looks like if I rebase it on top of Pierre's rework, as he
> >>> did some changes in the state machine.)  
> >>
> >> I think you meant the state is set to BOXED? otherwise the patch 3 says
> >> if state is BUSY and CLEAR event request comes in, we issue the clear
> >> instruction, no?  
> > 
> > That's what I meant with "need to rebase" :) The BOXED state is gone; I
> > just had not rebased on top of it. There's more changes in the state
> > machine; if we are on the same page as to what should happen, I can
> > start massaging the patches.
> > 
> >   
> 
> Sorry maybe I missed it, but are you referring to Pierre's latest 
> cleanup patches? I don't see him removing the BOXED state.

The "remove BOXED state" patch is currently on my vfio-ccw-staging
branch. (That reminds me, will need to move it to my vfio-ccw branch
and possibly send a pull request. I had hoped to collect more patches
for the next release...)

> 
> I think returning -EAGAIN and asking the userspace to retry the 
> operation sounds reasonable to me.
> 
> But how do we handle the issue of protecting the cmd_region from 
> simultaneous hsch and csch calls? Do we agree on Pierre's method of 
> making write calls mutually exclusive?

That's in his patch series, right? I did not yet have time to look at
it...
