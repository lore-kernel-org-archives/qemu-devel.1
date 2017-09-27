Received: from eggs.gnu.org ([2001:4830:134:3::10]:32908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dx7Bs-0003mI-Sl
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:55:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dx7Bo-0000vS-3i
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:55:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40396)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1dx7Bn-0000s0-Lt
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:55:27 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8R7tEtj017098
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 03:55:22 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d808ad5x7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 03:55:22 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Wed, 27 Sep 2017 01:55:21 -0600
Date: Wed, 27 Sep 2017 15:55:17 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7755ca8-78f3-759e-f879-fea2f4fdadfc@linux.vnet.ibm.com>
Message-Id: <20170927075517.GB5870@bjsdjshi@linux.vnet.ibm.com>
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
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

* Halil Pasic <pasic@linux.vnet.ibm.com> [2017-09-25 12:57:31 +0200]:

[restored Cc:]

> 
> 
> On 09/25/2017 09:31 AM, Dong Jia Shi wrote:
> > * Cornelia Huck <cohuck@redhat.com> [2017-09-08 11:59:50 +0200]:
> > 
> >> On Fri, 8 Sep 2017 11:21:57 +0200
> >> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> >>
> >>> On 09/08/2017 05:41 AM, Dong Jia Shi wrote:
> >>>> Let' me summarize here, in case I misunderstand things. Now we have
> >>>> two ways to choose:
> >>>>
> >>>> A. Kernel: no change.
> >>>>    Qemu  : handle -EFAULT as option 2 by generating a program check.
> >>>>
> >>>> B. Kernel: return -EFAULT
> >>>>            +
> >>>>            update the IRB area in the I/O region for option 1 to present
> >>>>            a unit check SCSW (with proper sense byte ECW), and for option
> >>>>            2 to present a program check.
> >>>>    Qemu  : handle -EFAULT according to the information that the IRB area
> >>>>            provided.  
> >>>
> >>> This is not what I was trying to say. You got my message regarding A, but
> >>> B was supposed to be understood like this.
> >>>
> >>> Keep the current handling for option 1, that is return -EFAULT. For option
> >>> 2 do what the spec says, execute the program until the bad address and then
> >>> generate a program-check (SCSW) once the bad stuff has it's turn. Thus
> >>> the only change in QEMU would be handling -EFAULT with an unit check (because
> >>> now it's just option 1).
> > Let me adding some context information here by copying some words from the
> > previous mail in this thread:
> > The only option 2 case in the kernel is ccwchain_fetch_idal() finding a
> > bad idaw_iova.
> > 
> > What you propose to do for this case is (correct me if I get it wrong):
> > In ccwchain_fetch_idal(), we do not return -EFAULT, instead we return 0,
> > and issuing the incompletely translated channel program with the bad
> > address to the physical device. And QEMU will eventually get the SCSW
> > with the program-check from the physical device I/O result, and inject
> > it to guest for further handling.
> > 
> 
> I guess that would be the cleanest. I would also be fine with not making
> the physical device program-check (issuing a shortened channel program,
> and doing the program check in software) but that's probably more
> complicated to implement.
That's far more complicated. I will try the simple approach.

> > Is this understanding right? If so, I'm fine with that, and I can
> > provide the fix in the kernel.
> > 
> 
> That would be nice.
Ok.

-- 
Dong Jia Shi
