Received: from eggs.gnu.org ([2001:4830:134:3::10]:34492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gVGk4-0003h0-Ug
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 09:04:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gVGjx-0000E1-0m
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 09:04:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39228
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1gVGjw-0000Ac-KL
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 09:04:24 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wB7E42NZ067623
	for <qemu-devel@nongnu.org>; Fri, 7 Dec 2018 09:04:23 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2p7ssght0y-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 07 Dec 2018 09:04:22 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Fri, 7 Dec 2018 14:04:20 -0000
Date: Fri, 7 Dec 2018 15:04:14 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <20181207141720.2264b06f.cohuck@redhat.com>
References: <20181205145131.28467-1-cohuck@redhat.com>
	<5d274f2c-23a2-0c4f-9f2d-07cbe529c5ac@de.ibm.com>
	<20181207132946.00df1f5a.cohuck@redhat.com>
	<20181207135253.10e3e021@oc2783563651>
	<20181207141720.2264b06f.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20181207150414.64ed9577@oc2783563651>
Subject: Re: [Qemu-devel] [PATCH RFC] vfio-ap: flag as compatible with
 balloon
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org

On Fri, 7 Dec 2018 14:17:20 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Fri, 7 Dec 2018 13:52:53 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > On Fri, 7 Dec 2018 13:29:46 +0100
> > Cornelia Huck <cohuck@redhat.com> wrote:
> > 
> > > On Fri, 7 Dec 2018 13:17:02 +0100
> > > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> > >   
> > > > On 05.12.2018 15:51, Cornelia Huck wrote:  
> > > > > vfio-ap devices do not pin any pages in the host. Therefore, they
> > > > > are belived to be compatible with memory ballooning.
> > > > > 
> > > > > Flag them as compatible, so both vfio-ap and a balloon can be
> > > > > used simultaneously.
> > > > > 
> > > > > Signed-off-by: Cornelia Huck <cohuck@redhat.com>    
> > 
> > With the comment stuff sorted out:
> > Reviewed-by: Halil Pasic <pasic@linux.ibm.com> 
> 
> So, do you agree with the comment change I suggested?
> 
> +    /*
> +     * vfio-ap devices operate in a way compatible with
> +     * memory ballooning, as no pages are pinned in the host.
> +     * This needs to be set before vfio_get_device() for vfio common to
> +     * handle the balloon inhibitor.
> +     */

I did some digging because my understanding of the problem was
completely insufficient -- now it is just plain insufficient. If I
understood it correctly the crux here seems to be that under certain
circumstances (IOMMU type, presence/absence of domain) vfio locks on
VFIO_IOMMU_MAP, and that vfio_get_group() basically maps it's address
space argument. But for s390x this pinning does not happen.

I mean vfio-ccw does pin pages in the host and is still safe. BTW do
we want to change the message for vfio-cccw?

I intend do some more digging and should I come to some remotely
satisfactory result, I intend to post a short write-up of my
findings here.

I agree to this patch with that commit message despite not having the
clarity, because not having it seems way worse than having it.


> 
> > 
> > @Connie: Just had a look at the MAINTAINERS file and hw/vfio/ap.c
> > is listed under Arch. support S90 with you as a maintainer, and under
> > vfio-ap with 4 maintainers listed one of them being me. The question
> > is who is going to post a PULL request for this?
> 
> General practice has been that I'm collecting everything s390x related.
> I have also pulled from others before (e.g. some bios changes from
> Thomas). While you could apply the patch, send it to me, and then I'd
> queue it to s390-next, I can also simply queue it directly with your
> ack :)
> 
> [Longer term, if you want to collect ap patches and then send me a pull
> request, I would also be happy to do that. For this single patch, it
> seems overkill.]
> 

I agree, it would be an overkill. I guess r-b qualifies as ack.

Regards,
Halil

> > 
> > > > 
> > > > Does it make sense to add cc stable for 3.1?  
> > > 
> > > Can do that, given that s390x systems really rely on the ballooner in
> > > general.
> > >   
> > 
> > I agree with cc stable.
> 
> Will add when applying.
> 
