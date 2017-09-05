Received: from eggs.gnu.org ([2001:4830:134:3::10]:56004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpG3P-0005Yk-BK
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:46:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpG3H-0005jG-Ix
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:46:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dpG3H-0005ib-Au
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:46:11 -0400
Date: Tue, 5 Sep 2017 17:46:06 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170905174606.1e0c6404.cohuck@redhat.com>
In-Reply-To: <bff0fcd2-4c1d-b5da-2d11-dc479d9d7275@linux.vnet.ibm.com>
References: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
	<20170830163609.50260-3-pasic@linux.vnet.ibm.com>
	<20170831111953.242ddc28.cohuck@redhat.com>
	<e805e756-495d-3125-eaf0-262635b9c545@linux.vnet.ibm.com>
	<20170905100234.7a92128e.cohuck@redhat.com>
	<bff0fcd2-4c1d-b5da-2d11-dc479d9d7275@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/9] s390x: fix invalid use of cc 1 for SSCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Tue, 5 Sep 2017 17:24:19 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> My problem with a program check (indicated by SCSW word 2 bit 10) is
> that, in my reading of the architecture, the semantic behind it is: The
> channel subsystem (not the cu or device) has detected, that the 
> the channel program (previously submitted as an ORB) is erroneous. Which
> programs are erroneous is specified by the architecture. What we have
> here does not qualify.
> 
> My idea was to rather blame the virtual hardware (device) and put no blame
> on the program nor he channel subsystem. This could be done using device
> status (unit check with command reject, maybe unit exception) or interface
> check. My train of thought was, the problem is not consistent across a
> device type, so it has to be device specific.

Unit exception might be a better way to express what is happening here.
At least, it moves us away from cc 1 and not towards cc 3 :)

> 
> Of course blaming the device could mislead the person encountering the
> problem, and make him believe it's an non-virtual hardware problem.
> 
> About the misleading, I think the best we can do is log out a message
> indicating what really happened.

Just document it in the code? If it doesn't happen with Linux as a
guest, it is highly unlikely to be seen in the wild.

> 
> In the end I don't care that deeply about vfio-ccw, and this problem
> already took me more time than I intended to spend on this. We have
> people driving this whole vfio-ccw stuff and I'm not one of them (I'm
> rather in the supporting role).
> 
> I'm also fine with me being credited with a reported-by once the
> more involved people figure out what to do, and keeping the vfio-ccw
> stuff as is. Should we go with that option? 

If converting the reporting to a device status is straightforward
enough, let's do that. I'm fine with postponing this and waiting for a
real fix as well (I don't really have spare cycles to actually write
vfio-ccw code currently...)

> >>>> @@ -1115,7 +1112,7 @@ static int do_subchannel_work(SubchDev *sch)
> >>>>      if (sch->do_subchannel_work) {
> >>>>          return sch->do_subchannel_work(sch);
> >>>>      } else {
> >>>> -        return -EINVAL;
> >>>> +        return -ENODEV;    
> >>>
> >>> This rather seems like a job for an assert? If we don't have a function
> >>> for the 'asynchronous' handling of the various functions assigned for a
> >>> subchannel, that looks like an internal error.
> >>>     
> >>
> >> IMHO it depends. Aborting qemu is heavy handed, and as an user I would not
> >> be happy about it. But certainly it is an assert situation.  We can look for
> >> an even better solution, but I think this is an improvement. The logic behind
> >> is that the device is broken and can't be talked to properly.  
> > 
> > We currently don't have a vast array of subchannel types (and are
> > unlikely to get more types that need a different handler function). We
> > know the current ones are fine, and an assert would catch programming
> > errors early.
> >   
> 
> Despite of that we already had a problem of this type: see 1728cff2ab
> ("s390x/3270: fix instruction interception handler", 2017-06-09) by 
> Dong Jia. If we had some automated testing covering all the asserts
> I would not think twice about using an assert here. But I don't think
> we do and I'm reluctant (not positive that assert is superior to what
> we have now). Maybe we could agree on reported by again.

Yes, we (as in generally 'we') are really lacking automated testing...
(it is somewhere on my todo list).

Either leave it as-is, or do an assert. -ENODEV just feels wrong.
