Received: from eggs.gnu.org ([2001:4830:134:3::10]:48891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dpse3-0000AD-A3
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:58:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dpse0-0001RA-8A
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:58:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1dpsdz-0001NK-Vy
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:58:40 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v878v5Ve007326
	for <qemu-devel@nongnu.org>; Thu, 7 Sep 2017 04:58:38 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cu21tbb0f-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 04:58:38 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Thu, 7 Sep 2017 04:58:37 -0400
Date: Thu, 7 Sep 2017 16:58:31 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
	<20170830163609.50260-5-pasic@linux.vnet.ibm.com>
	<20170831115535.1e4201d3.cohuck@redhat.com>
	<7540741b-d230-e7c4-50d3-036f31997c8b@linux.vnet.ibm.com>
	<20170905182546.00457332.cohuck@redhat.com>
	<fe102a7a-e998-8ebe-b94d-e653c4f66c39@linux.vnet.ibm.com>
	<20170906043108.GY31680@bjsdjshi@linux.vnet.ibm.com>
	<8946b1ec-4d14-c953-deab-aaded7cd2c9d@linux.vnet.ibm.com>
	<20170906162019.45eeec4a.cohuck@redhat.com>
	<cc6eab96-969d-eb66-91b5-cdb965c1bcbb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc6eab96-969d-eb66-91b5-cdb965c1bcbb@linux.vnet.ibm.com>
Message-Id: <20170907085831.GF31680@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 4/9] s390x: refactor error handling for
 SSCH and RSCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, qemu-devel@nongnu.org

* Halil Pasic <pasic@linux.vnet.ibm.com> [2017-09-06 16:43:42 +0200]:

> 
> 
> On 09/06/2017 04:20 PM, Cornelia Huck wrote:
> > On Wed, 6 Sep 2017 14:25:13 +0200
> > Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> > 
> >> We have basically two possibilities/options which ask for different
> >> handling:
> >> 1) EFAULT is due to a bug in the vfio-ccw implementation
> >> (can be QEMU or kernel).
> >> 2) EFAULT is due to buggy channel program.
> >>
> >> Option 2) is basically to be handled with a channel-program check and
> >> setting primary secondary and alert status. For reference see PoP page
> >> 15-59 ("Designation of Storage Area").  An exception may be an invalid
> >> channel program address in the ORB. There the channel-program check ain't
> >> explicitly stated (although) I would expect one. It may be implied by the
> >> things on page 15-59 though.
> >>
> >> Option 1) is however very similar to other we have figured out that the
> >> implementation is broken situations and should be handled consequently.
> >> The current state of the discussion is with a unit exception.
> >>
> >> Does that make sense?
> > 
> > I think the situation is slightly different here, though. For the orb
> > flags, we reject something out of hand because we have not implemented
> > it, and for that, unit exception sounds like a good fit. Processing
> > errors, however, are more similar to errors in the hardware, and as
> > such can probably be reported via something like equipment check.
> > 
> 
> Noted. Let's see what Dong Jia has to say, before we continuing a
> discussion on something (option 1) what may be irrelevant anyway.
> 
> >>
> >> Now, Dong Jia, I need your help to figure out do we have option 1 or
> >> option 2 here? After quick look at the kernel code, it appears to me that
> >> I've seen both option 1 and option 2 (I'm afraid) -- but my assessment
> >> was really very superficial.
There are three cases (all in the kernel) that generate a -EFAULT ret
code:
a. vfio_ccw_mdev_write: copy_from_user() fails.
  This is option 1.

b. ccwchain_fetch_tic
  It's mostly likely that the vfio-ccw driver processed the ccw chains
  wrongly. (Actually I can not think of any other reason.)
  This is option 1.

c. ccwchain_fetch_idal
  When we find that an IDAW contents an invalid address
  This is option 2.

> >>
> >> I would expect option 2 to be handled differently (kernel provides the
> >> SCSW) though.
> >>
> >> Regards,
> >> Halil
> >>
> > 
> > 

-- 
Dong Jia Shi
