Received: from eggs.gnu.org ([2001:4830:134:3::10]:48470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gVHck-0002Gv-RD
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 10:01:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gVHce-0002w4-Dl
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 10:01:01 -0500
Date: Fri, 7 Dec 2018 16:00:47 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181207160047.68ed4db3.cohuck@redhat.com>
In-Reply-To: <20181207150414.64ed9577@oc2783563651>
References: <20181205145131.28467-1-cohuck@redhat.com>
	<5d274f2c-23a2-0c4f-9f2d-07cbe529c5ac@de.ibm.com>
	<20181207132946.00df1f5a.cohuck@redhat.com>
	<20181207135253.10e3e021@oc2783563651>
	<20181207141720.2264b06f.cohuck@redhat.com>
	<20181207150414.64ed9577@oc2783563651>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org

On Fri, 7 Dec 2018 15:04:14 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Fri, 7 Dec 2018 14:17:20 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > On Fri, 7 Dec 2018 13:52:53 +0100
> > Halil Pasic <pasic@linux.ibm.com> wrote:
> >   
> > > On Fri, 7 Dec 2018 13:29:46 +0100
> > > Cornelia Huck <cohuck@redhat.com> wrote:
> > >   
> > > > On Fri, 7 Dec 2018 13:17:02 +0100
> > > > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> > > >     
> > > > > On 05.12.2018 15:51, Cornelia Huck wrote:    
> > > > > > vfio-ap devices do not pin any pages in the host. Therefore, they
> > > > > > are belived to be compatible with memory ballooning.
> > > > > > 
> > > > > > Flag them as compatible, so both vfio-ap and a balloon can be
> > > > > > used simultaneously.
> > > > > > 
> > > > > > Signed-off-by: Cornelia Huck <cohuck@redhat.com>      
> > > 
> > > With the comment stuff sorted out:
> > > Reviewed-by: Halil Pasic <pasic@linux.ibm.com>   
> > 
> > So, do you agree with the comment change I suggested?
> > 
> > +    /*
> > +     * vfio-ap devices operate in a way compatible with
> > +     * memory ballooning, as no pages are pinned in the host.
> > +     * This needs to be set before vfio_get_device() for vfio common to
> > +     * handle the balloon inhibitor.
> > +     */  
> 
> I did some digging because my understanding of the problem was
> completely insufficient -- now it is just plain insufficient. If I
> understood it correctly the crux here seems to be that under certain
> circumstances (IOMMU type, presence/absence of domain) vfio locks on
> VFIO_IOMMU_MAP, and that vfio_get_group() basically maps it's address
> space argument. But for s390x this pinning does not happen.
> 
> I mean vfio-ccw does pin pages in the host and is still safe. BTW do
> we want to change the message for vfio-cccw?

If you have a better wording, feel free to do so :)

> I intend do some more digging and should I come to some remotely
> satisfactory result, I intend to post a short write-up of my
> findings here.
> 
> I agree to this patch with that commit message despite not having the
> clarity, because not having it seems way worse than having it.

Yes.

> > > @Connie: Just had a look at the MAINTAINERS file and hw/vfio/ap.c
> > > is listed under Arch. support S90 with you as a maintainer, and under
> > > vfio-ap with 4 maintainers listed one of them being me. The question
> > > is who is going to post a PULL request for this?  
> > 
> > General practice has been that I'm collecting everything s390x related.
> > I have also pulled from others before (e.g. some bios changes from
> > Thomas). While you could apply the patch, send it to me, and then I'd
> > queue it to s390-next, I can also simply queue it directly with your
> > ack :)
> > 
> > [Longer term, if you want to collect ap patches and then send me a pull
> > request, I would also be happy to do that. For this single patch, it
> > seems overkill.]
> >   
> 
> I agree, it would be an overkill. I guess r-b qualifies as ack.

I've always seen r-b as a superset of a-b.
