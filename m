Received: from eggs.gnu.org ([2001:4830:134:3::10]:35088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gUuoN-0005Av-SJ
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 09:39:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gUuoI-0006Oj-QE
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 09:39:31 -0500
Date: Thu, 6 Dec 2018 15:39:17 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181206153917.59e8e291.cohuck@redhat.com>
In-Reply-To: <aa190e90-f832-7958-aa83-1486e570bf40@linux.ibm.com>
References: <20181122165432.4437-1-cohuck@redhat.com>
	<20181204133810.66e8cfe5@oc2783563651>
	<20181204141130.06496b9b.cohuck@redhat.com>
	<20181204160236.54de2784@oc2783563651>
	<20181205135402.33c2b22d.cohuck@redhat.com>
	<aa190e90-f832-7958-aa83-1486e570bf40@linux.ibm.com>
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

On Wed, 5 Dec 2018 13:34:11 -0500
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 12/05/2018 07:54 AM, Cornelia Huck wrote:
> >> Yeah, that is perfectly clear, but it ain't the complete story. E.g.
> >> are subsequent commands blocking until the preceding command finishes
> >> is part of the interface. And what is good implementation depends on the
> >> answer. What I mean, I first need to understand how things are supposed
> >> to work (together) so I can double check that against the
> >> implementation. Otherwise all I can do is nitpicking.
> >>
> >> To get more tangible: we are in the middle of processing an SSCH request
> >> (e.g. doing the translation) when a HSCH comes in. What should happen?
> >> Should we start processing HSCH after he instruction part of SSCH is
> >> done -- which currently includes translation? Or should we -EBUSY? Or do
> >> we abort START related activities and do the HALT stuff?  
> > I think most of the sorting-out-the-operations stuff should be done by
> > the hardware itself, and we should not really try to enforce anything
> > special in our vfio code.
> > 
> > For your example, it might be best if a hsch is always accepted and
> > send on towards the hardware. Probably best to reflect back -EAGAIN if
> > we're currently processing another instruction from another vcpu, so
> > that the user space caller can retry. Same for ssch, if another ssch is
> > already being processed. We*could*  reflect cc 2 if the fctl bit is
> > already set, but that won't do for csch, so it is probably best to have
> > the hardware figure that out in any case.
> > 
> > If I read the code correctly, we currently reflect -EBUSY and not
> > -EAGAIN if we get a ssch request while already processing another one.
> > QEMU hands that back to the guest as a cc 2, which is not 100% correct.
> > In practice, we don't see this with Linux guests due to locking.
> >   
> 
> If we have a ssch and a csch immediately afterwards from userspace, will 
> we end up issuing csch first and then ssch to the hardware?
> 
> If I understand correctly, the ccw translation as part of the ssch can 
> be a slow operation so it might be possible we issue the csch first?
> In that case we won't actually clear the original start function as 
> intended.

When we start processing the ssch request (translation and so on), we
set the state to BUSY. This means that any csch request will get a
-EBUSY, no overtaking possible. (I think maybe I'll need to check what
this series looks like if I rebase it on top of Pierre's rework, as he
did some changes in the state machine.)

My idea above was to return -EAGAIN instead of -EBUSY, so that user
space can retry the operation.
