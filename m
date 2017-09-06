Received: from eggs.gnu.org ([2001:4830:134:3::10]:47845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dpVgJ-0007HY-RL
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 04:27:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dpVgF-0002Zk-Pu
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 04:27:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1dpVgF-0002Z4-GX
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 04:27:27 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v868QF0H136452
	for <qemu-devel@nongnu.org>; Wed, 6 Sep 2017 04:27:26 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ct76an3tg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 04:27:25 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Wed, 6 Sep 2017 04:27:24 -0400
Date: Wed, 6 Sep 2017 16:27:20 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
	<20170830163609.50260-3-pasic@linux.vnet.ibm.com>
	<20170831111953.242ddc28.cohuck@redhat.com>
	<e805e756-495d-3125-eaf0-262635b9c545@linux.vnet.ibm.com>
	<20170905100234.7a92128e.cohuck@redhat.com>
	<bff0fcd2-4c1d-b5da-2d11-dc479d9d7275@linux.vnet.ibm.com>
	<20170905174606.1e0c6404.cohuck@redhat.com>
	<24e87c3e-2674-8fc1-cd0a-94f4907ddc7d@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24e87c3e-2674-8fc1-cd0a-94f4907ddc7d@linux.vnet.ibm.com>
Message-Id: <20170906082720.GZ31680@bjsdjshi@linux.vnet.ibm.com>
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
Cc: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

* Halil Pasic <pasic@linux.vnet.ibm.com> [2017-09-05 19:20:43 +0200]:

> 
> 
> On 09/05/2017 05:46 PM, Cornelia Huck wrote:
> > On Tue, 5 Sep 2017 17:24:19 +0200
> > Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> > 
> >> My problem with a program check (indicated by SCSW word 2 bit 10) is
> >> that, in my reading of the architecture, the semantic behind it is: The
> >> channel subsystem (not the cu or device) has detected, that the 
> >> the channel program (previously submitted as an ORB) is erroneous. Which
> >> programs are erroneous is specified by the architecture. What we have
> >> here does not qualify.
> >>
> >> My idea was to rather blame the virtual hardware (device) and put no blame
> >> on the program nor he channel subsystem. This could be done using device
> >> status (unit check with command reject, maybe unit exception) or interface
> >> check. My train of thought was, the problem is not consistent across a
> >> device type, so it has to be device specific.
> > 
> > Unit exception might be a better way to express what is happening here.
> > At least, it moves us away from cc 1 and not towards cc 3 :)
> > 
> 
> I will do a follow up patch pursuing device exception.
> 
> >>
> >> Of course blaming the device could mislead the person encountering the
> >> problem, and make him believe it's an non-virtual hardware problem.
> >>
> >> About the misleading, I think the best we can do is log out a message
> >> indicating what really happened.
> > 
> > Just document it in the code? If it doesn't happen with Linux as a
> > guest, it is highly unlikely to be seen in the wild.
> > 
> 
> 
> Well we have two problems here:
> 1) Unit exception can be already defined by the device type for the
> command (reference: http://publibfp.dhe.ibm.com/cgi-bin/bookmgr/BOOKS/dz9ar110/2.6.10?DT=19920904110920).
> I think this one is what you mean. And I agree that's best handled
> with comment in code.
Using unit check, with bit 3 byte 0 of the sense data set to 1, to
indicate an 'Equipment check', sounds a bit more proper than unit
exception.

> 2) The poor user/programmer is trying to figure out why things
> don't work (why are we getting the unit exception)? I think that's
> best remedied with producing something for the log (maybe a warning
> with warn_report which states that the implementation vfio-ccw requires
> the given flags).
Fine with me.

[...]

-- 
Dong Jia Shi
