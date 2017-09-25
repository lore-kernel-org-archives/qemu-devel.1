Received: from eggs.gnu.org ([2001:4830:134:3::10]:36157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dwNsF-0005CH-Ph
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 03:32:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dwNsA-0001Kd-OM
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 03:32:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1dwNsA-0001KA-Ft
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 03:32:10 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8P7T90E136460
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 03:32:06 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d6p5xttxs-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 03:32:06 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Mon, 25 Sep 2017 03:32:05 -0400
Date: Mon, 25 Sep 2017 15:31:59 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <8946b1ec-4d14-c953-deab-aaded7cd2c9d@linux.vnet.ibm.com>
	<20170906162019.45eeec4a.cohuck@redhat.com>
	<cc6eab96-969d-eb66-91b5-cdb965c1bcbb@linux.vnet.ibm.com>
	<20170907085831.GF31680@bjsdjshi@linux.vnet.ibm.com>
	<20170907122400.5b2e3faa.cohuck@redhat.com>
	<27b2addf-0d1c-81d7-1e82-1a8cdac70231@linux.vnet.ibm.com>
	<20170907134134.00f387e8.cohuck@redhat.com>
	<20170908034100.GH31680@bjsdjshi@linux.vnet.ibm.com>
	<381cb778-5679-634c-9d3d-7276f877da3a@linux.vnet.ibm.com>
	<20170908115950.56996cc6.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170908115950.56996cc6.cohuck@redhat.com>
Message-Id: <20170925073159.GR11080@bjsdjshi@linux.vnet.ibm.com>
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, qemu-devel@nongnu.org

* Cornelia Huck <cohuck@redhat.com> [2017-09-08 11:59:50 +0200]:

> On Fri, 8 Sep 2017 11:21:57 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
> > On 09/08/2017 05:41 AM, Dong Jia Shi wrote:
> > > Let' me summarize here, in case I misunderstand things. Now we have
> > > two ways to choose:
> > > 
> > > A. Kernel: no change.
> > >    Qemu  : handle -EFAULT as option 2 by generating a program check.
> > > 
> > > B. Kernel: return -EFAULT
> > >            +
> > >            update the IRB area in the I/O region for option 1 to present
> > >            a unit check SCSW (with proper sense byte ECW), and for option
> > >            2 to present a program check.
> > >    Qemu  : handle -EFAULT according to the information that the IRB area
> > >            provided.  
> > 
> > This is not what I was trying to say. You got my message regarding A, but
> > B was supposed to be understood like this.
> > 
> > Keep the current handling for option 1, that is return -EFAULT. For option
> > 2 do what the spec says, execute the program until the bad address and then
> > generate a program-check (SCSW) once the bad stuff has it's turn. Thus
> > the only change in QEMU would be handling -EFAULT with an unit check (because
> > now it's just option 1).
Let me adding some context information here by copying some words from the
previous mail in this thread:
The only option 2 case in the kernel is ccwchain_fetch_idal() finding a
bad idaw_iova.

What you propose to do for this case is (correct me if I get it wrong):
In ccwchain_fetch_idal(), we do not return -EFAULT, instead we return 0,
and issuing the incompletely translated channel program with the bad
address to the physical device. And QEMU will eventually get the SCSW
with the program-check from the physical device I/O result, and inject
it to guest for further handling.

Is this understanding right? If so, I'm fine with that, and I can
provide the fix in the kernel.

> 
> That makes sense to me.
> 

-- 
Dong Jia Shi
