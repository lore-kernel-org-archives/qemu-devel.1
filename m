Received: from eggs.gnu.org ([209.51.188.92]:41424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gn14A-0002fq-TQ
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 07:58:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gn143-0004vU-AC
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 07:58:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45436
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1gn13s-0004qg-39
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 07:58:21 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0PCrg81042635
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 07:58:15 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2q810p5wrf-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 07:58:15 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Fri, 25 Jan 2019 12:58:13 -0000
Date: Fri, 25 Jan 2019 13:58:07 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <2dac6201-9e71-b188-0385-d09d05071a1c@linux.ibm.com>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-3-cohuck@redhat.com>
	<2dac6201-9e71-b188-0385-d09d05071a1c@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190125135807.17c59cdd@oc2783563651>
Subject: Re: [Qemu-devel] [PATCH v2 2/5] vfio-ccw: concurrent I/O handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Farman <farman@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Thu, 24 Jan 2019 21:25:10 -0500
Eric Farman <farman@linux.ibm.com> wrote:

> >   	private = dev_get_drvdata(mdev_parent_dev(mdev));
> > -	if (private->state != VFIO_CCW_STATE_IDLE)
> > +	if (private->state == VFIO_CCW_STATE_NOT_OPER ||
> > +	    private->state == VFIO_CCW_STATE_STANDBY)
> >   		return -EACCES;
> > +	if (!mutex_trylock(&private->io_mutex))
> > +		return -EAGAIN;  
> 
> Ah, I see Halil's difficulty here.
> 
> It is true there is a race condition today, and that this doesn't 
> address it.  That's fine, add it to the todo list.  But even with that, 
> I don't see what the mutex is enforcing?  

It is protecting the io regions. AFAIU the idea was that only one
thread is accessing the io region(s) at a time to prevent corruption and
reading half-morphed data.

> Two simultaneous SSCHs will be 
> serialized (one will get kicked out with a failed trylock() call), while 
> still leaving the window open between cc=0 on the SSCH and the 
> subsequent interrupt.  In the latter case, a second SSCH will come 
> through here, do the copy_from_user below, and then jump to fsm_io_busy 
> to return EAGAIN.  Do we really want to stomp on io_region in that case?

I'm not sure I understood you correctly. The interrupt handler does not
take the lock before writing to the io_region. That is one race but it is
easy to fix.

The bigger problem is that between the interrupt handler has written IRB
area and userspace has read it we may end up destroying it by stomping on
it (to use your words). The userspace reading a wrong (given todays qemu
zeroed out) IRB could lead to follow on problems.
 
>   Why can't we simply return EAGAIN if state==BUSY?
> 

Sure we can. That would essentially go back to the old way of things:
if not idle return with error. Just the error code returned would change
form EACCESS to EAGAIN. Which Isn't necessarily a win, because
conceptually here should be never two interleaved io_requests/start
commands hitting the module.


> >   
> >   	region = private->io_region;
> > -	if (copy_from_user((void *)region + *ppos, buf, count))
> > -		return -EFAULT;
> > +	if (copy_from_user((void *)region + *ppos, buf, count)) {
> > +		ret = -EFAULT;
> > +		goto out_unlock;
> > +	}
