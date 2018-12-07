Received: from eggs.gnu.org ([2001:4830:134:3::10]:55583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gVJOr-0004Lf-0C
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:54:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gVJOn-00053I-Pj
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:54:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1gVJOn-0004wt-Ee
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:54:45 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wB7GscrM134972
	for <qemu-devel@nongnu.org>; Fri, 7 Dec 2018 11:54:44 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2p7tq6xrsf-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 07 Dec 2018 11:54:42 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Fri, 7 Dec 2018 16:54:30 -0000
Date: Fri, 7 Dec 2018 17:54:23 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <20181207110529.3b293124.cohuck@redhat.com>
References: <20181122165432.4437-1-cohuck@redhat.com>
	<20181204133810.66e8cfe5@oc2783563651>
	<20181204141130.06496b9b.cohuck@redhat.com>
	<20181204160236.54de2784@oc2783563651>
	<20181205135402.33c2b22d.cohuck@redhat.com>
	<20181206194714.31e9f43a@oc2783563651>
	<20181207110529.3b293124.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20181207175423.6c45621f@oc2783563651>
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, kvm@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>, qemu-s390x@nongnu.org, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Fri, 7 Dec 2018 11:05:29 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> > > I think most of the sorting-out-the-operations stuff should be done by
> > > the hardware itself, and we should not really try to enforce anything
> > > special in our vfio code.
> > >     
> > 
> > Sounds very reasonable to me. Does this mean you are against Pierre's
> > '[PATCH v3 6/6] vfio: ccw: serialize the write system calls' as it does
> > not let HW sort out stuff, but enforces sequencing?  
> 
> I have not yet had time to look at that, sorry.
> 
> > 
> >   
> > > For your example, it might be best if a hsch is always accepted and
> > > send on towards the hardware.    
> > 
> > Nod.
> >   
> > > Probably best to reflect back -EAGAIN if
> > > we're currently processing another instruction from another vcpu, so
> > > that the user space caller can retry.    
> > 
> > Hm, not sure how this works together with your previous sentence.  
> 
> The software layering. We have the kernel layer
> (drivers/s390/cio/vfio_ccw_*) that interacts with the hardware more or
> less directly, and the QEMU layer, which does some writes on regions.
> In the end, the goal is to act on behalf of the guest issuing a
> ssch/hsch/csch, which is from the guest's view a single instruction. We
> should not have the individual "instructions" compete with each other
> so that they run essentially in parallel (kernel layer), but we should
> also not try to impose an artificial ordering as to when instructions
> executed by different vcpus are executed (QEMU layer). Therefore, don't
> try to run an instruction in the kernel when another one is in progress
> for the same subchannel (exclusivity in the kernel), but retry in QEMU
> if needed (no ordering between vcpus imposed).
> 
> In short, don't create strange concurrency issues in the "instruction"
> handling, but make it possible to execute instructions in a
> non-predictable order if the guest does not care about enforcing
> ordering on its side.
> 

I'm neither sold on this, nor am I violently opposing it. Will try to
meditate on it some more if any spare cycles arise. Currently I don't
see the benefit of the non-predictable order over plain FCFS. For
example, let's assume we have a ssch "instruction" that 1 second to
complete. Since normally ssch instruction  does not have to process the
channel program, and is thus kind of a constant time operation (now we
do the translation and the pinning as a part of the "instruction), our
strange guest gets jumpy and does a csch after T+0.2s. And on T+0.8 in
desperation follows the whole up with a hsch. If I understand your
proposal correctly, both userspace handlers would spin on -EAGAIN until
T+1. When ssch is done the csch and the hsch would race for who can
be the next. I don't quite get the value of that.

> >   
> > > Same for ssch, if another ssch is
> > > already being processed. We *could* reflect cc 2 if the fctl bit is
> > > already set, but that won't do for csch, so it is probably best to have
> > > the hardware figure that out in any case.
> > >     
> > 
> > We just need to be careful about avoiding races if we let hw sort out
> > things. If an ssch is issued with the start function pending the correct
> > response is cc 2.   
> 
> But sending it on to the hardware will give us that cc 2, no?
> 
> >   
> > > If I read the code correctly, we currently reflect -EBUSY and not
> > > -EAGAIN if we get a ssch request while already processing another one.
> > > QEMU hands that back to the guest as a cc 2, which is not 100% correct.
> > > In practice, we don't see this with Linux guests due to locking.
> > >     
> > 
> > Nod, does not happen because of BQL. We currently do the user-space
> > counterpart of vfio_ccw_mdev_write() in BQL context or (i.e. we hold
> > BQL until translation is done and our host ssch() comes back)?  
> 
> The Linux kernel uses the subchannel lock to enforce exclusivity for
> subchannel instructions, so we won't see Linux guests issue
> instructions on different vcpus in parallel, that's what I meant.
>

That is cool. Yet I think the situation with the BQL is relevant. Because
while BQL is held, not only IO instructions on a single vfio-ccw device
are mutually exclusive. AFAIU no other instruction QEMU instruction
handler can engage. And a store subchannel for device A having to wait
until the translation for the start subchannel on device B is done is
not the most scary thing I can imagine.
 
> > 
> > I think -EBUSY is the correct response for ssch while start pending set.
> > I think we set start pending in QEMU before we issue 'start command/io
> > request' to the kernel. I don't think -EAGAIN is a good idea. AFAIU we
> > would expect user-space to loop on -EAGAIN e.g. at least until the
> > processing of a 'start command' is done and the (fist) ssch by the host
> > is issued. And then what?  Translate the second channel program issue
> > the second ssch in the host and probably get a non-zero cc? Or return
> > -EBUSY? Or keep returning -EAGAIN?  
> 
> My idea was:
> - return -EAGAIN if we're already processing a channel instruction
> - continue returning -EBUSY etc. if the instruction gets the respective
>   return code from the hardware
> 
> So, the second ssch would first get a -EAGAIN and then a -EBUSY if the
> first ssch is done, but the subchannel is still doing the start
> function. Just as you would expect when you do a ssch while your last
> request has not finished yet.
> 

But before you can issue the second ssch you have to do the translation
for it. And we must assume the IO corresponding to the first ssch is not
done yet -- so we still need the translated channel program of the first
ssch. That is if we insist on doing the -EBUSY based on a return code
from the hardware. I'm not sure we end up with a big simplification from
making the "instructions" mutex on vfio-ccw device level in kernel as
proposed above. But I'm not against it. If you have the time to write
the patches I will find time to review them.

Regards,
Halil
