Received: from eggs.gnu.org ([2001:4830:134:3::10]:40263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cqW6f-0003pr-Lp
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 22:34:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cqW6a-00029L-OK
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 22:34:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1cqW6a-000294-Eo
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 22:34:32 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2M2XpHQ114051
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 22:34:29 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29b9vrqx80-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 22:34:29 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Tue, 21 Mar 2017 22:34:28 -0400
Date: Wed, 22 Mar 2017 10:34:22 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170317031743.40128-1-bjsdjshi@linux.vnet.ibm.com>
	<20170317031743.40128-15-bjsdjshi@linux.vnet.ibm.com>
	<20170321124716.19f90fd6@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170321124716.19f90fd6@t450s.home>
Message-Id: <20170322023422.GP10704@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 14/16] docs: add documentation for
 vfio-ccw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

* Alex Williamson <alex.williamson@redhat.com> [2017-03-21 12:47:16 -0600]:

[...]

> > +vfio-ccw I/O region
> > +-------------------
> > +
> > +An I/O region is used to accept channel program request from user
> > +space and store I/O interrupt result for user space to retrieve. The
> > +defination of the region is:
> > +
> > +struct ccw_io_region {
> > +#define ORB_AREA_SIZE 12
> > +	__u8	orb_area[ORB_AREA_SIZE];
> > +#define SCSW_AREA_SIZE 12
> > +	__u8	scsw_area[SCSW_AREA_SIZE];
> > +#define IRB_AREA_SIZE 96
> > +	__u8	irb_area[IRB_AREA_SIZE];
> > +	__u32	ret_code;
> > +} __packed;
> > +
> > +While starting an I/O request, orb_area should be filled with the
> > +guest ORB, and scsw_area should be filled with the SCSW of the Virtual
> > +Subchannel.
> > +
> > +irb_area stores the I/O result.
> > +
> > +ret_code stores a return code for each access of the region.
Hi Alex,

> 
> Pardon if these questions expose my lack of familiarity with S390:
> 
> So I/O requests are asynchronous, the user is notified via interrupt
> when completed, can more than one request be queued at a time?
The answer is no. The subchannel will stay in a state that prohibiting
from a new request if there is processing for a previous request
ongoing. And we need to issue an explit I/O instruction to retrieve and
(or) clear the pending interruption before issue another I/O request.

> The communication format doesn't seem like it'd easily support that.
> Is it possible?  A future enhancement that we should design for now?
As the above statements said, it's not possible.

> 
> I'm also a little unclear what sort of I/O a user has access to via
> this interface and how the kernel polices that access. For instance,
> are multiple tape or disk devices available through a single I/O
> channel?
No. An I/O subchannel is dedicated to one device, and...

> How does the user configure which devices a user has access to when
> creating the vfio-ccw device?
...this mapping is usually determined/configured before the machine
startup by the administrtor of the upper level hypervisor. So when
creating the vfio-ccw device, we do not configure/modify this mapping.
When the guest I/O subchannel driver probing, it will issue a SENSE
command on the subchannel to recognize/find what kind of device is
behind the subchannel, and then it uses corresponding CCW device driver
serving the I/O device.

@Conny, please correct me if my understanding is not right.

> 
> Otherwise I think the interface looks great.  Thanks,
This is good news. :>

Thanks!
> 
> Alex
> 

-- 
Dong Jia Shi
