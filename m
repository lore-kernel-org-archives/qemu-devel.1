Received: from eggs.gnu.org ([209.51.188.92]:49067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gm16r-0006Ev-Dy
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:49:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gm16n-0006oW-LO
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:49:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1gm16n-0006dR-4x
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:49:13 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0MCdp1H119674
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 07:46:22 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q6278kcd2-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 07:46:21 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Tue, 22 Jan 2019 12:46:19 -0000
Date: Tue, 22 Jan 2019 13:46:12 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <20190122125322.4bb04921.cohuck@redhat.com>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-3-cohuck@redhat.com>
	<20190121212018.4e377e59@oc2783563651>
	<20190122112926.4ff54f9f.cohuck@redhat.com>
	<20190122121737.49c3f900@oc2783563651>
	<20190122125322.4bb04921.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190122134612.40a7745e@oc2783563651>
Subject: Re: [Qemu-devel] [PATCH v2 2/5] vfio-ccw: concurrent I/O handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Tue, 22 Jan 2019 12:53:22 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Tue, 22 Jan 2019 12:17:37 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > On Tue, 22 Jan 2019 11:29:26 +0100
> > Cornelia Huck <cohuck@redhat.com> wrote:
> > 
> > > On Mon, 21 Jan 2019 21:20:18 +0100
> > > Halil Pasic <pasic@linux.ibm.com> wrote:
> > >   
> > > > On Mon, 21 Jan 2019 12:03:51 +0100
> > > > Cornelia Huck <cohuck@redhat.com> wrote:
> > > >   
> > > > > Rework handling of multiple I/O requests to return -EAGAIN if
> > > > > we are already processing an I/O request. Introduce a mutex
> > > > > to disallow concurrent writes to the I/O region.
> > > > > 
> > > > > The expectation is that userspace simply retries the operation
> > > > > if it gets -EAGAIN.
> > > > > 
> > > > > We currently don't allow multiple ssch requests at the same
> > > > > time, as we don't have support for keeping channel programs
> > > > > around for more than one request.
> > > > > 
> > > > > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > > > > ---    
> > > > 
> > > > [..]
> > > >   
> > > > >  static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
> > > > > @@ -188,25 +192,30 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
> > > > >  {
> > > > >  	struct vfio_ccw_private *private;
> > > > >  	struct ccw_io_region *region;
> > > > > +	int ret;
> > > > >  
> > > > >  	if (*ppos + count > sizeof(*region))
> > > > >  		return -EINVAL;
> > > > >  
> > > > >  	private = dev_get_drvdata(mdev_parent_dev(mdev));
> > > > > -	if (private->state != VFIO_CCW_STATE_IDLE)
> > > > > +	if (private->state == VFIO_CCW_STATE_NOT_OPER ||
> > > > > +	    private->state == VFIO_CCW_STATE_STANDBY)
> > > > >  		return -EACCES;
> > > > > +	if (!mutex_trylock(&private->io_mutex))
> > > > > +		return -EAGAIN;
> > > > >  
> > > > >  	region = private->io_region;
> > > > > -	if (copy_from_user((void *)region + *ppos, buf, count))
> > > > > -		return -EFAULT;
> > > > > +	if (copy_from_user((void *)region + *ppos, buf, count)) {    
> > > > 
> > > > This might race with vfio_ccw_sch_io_todo() on
> > > > private->io_region->irb_area, or?  
> > > 
> > > Ah yes, this should also take the mutex (should work because we're on a
> > > workqueue).
> > >   
> > 
> > I'm not sure that will do the trick (assumed I understood the
> > intention correctly). Let's say the things happen in this order:
> > 1) vfio_ccw_sch_io_todo() goes first, I guess updates
> > private->io_region->irb_area and releases the mutex.
> > 2) Then vfio_ccw_mdev_write() destroys the irb_area by zeriong it out,
> > and finally,
> > 3) userspace reads the destroyed irb_area using vfio_ccw_mdev_read().
> > 
> > Or am I misunderstanding something? 
> 
> You're not, but dealing with that race is outside the scope of this
> patch. If userspace submits a request and then tries to get the old
> data for a prior request, I suggest that userspace needs to fix their
> sequencing.
> 

I tend to disagree, because I think this would be a degradation compared
to what we have right now.

Let me explain. I guess the current idea is that the private->state !=
VFIO_CCW_STATE_IDLE check safeguards against this. Yes we lack proper
synchronization (atomic/interlocked access or locks) that would guarantee
that different thread observe state transitions as required -- no
splint brain. But if state were atomic the scenario I have in mind can
not happen, because we get the solicited interrupt in BUSY state (and
set IDLE in vfio_ccw_sch_io_todo()). Unsolicited interrupts are another
piece of cake -- I have no idea how may of those do we get. And because
of this the broken sequencing in userspace could actually be the kernels
fault.

Regards,
Halil
