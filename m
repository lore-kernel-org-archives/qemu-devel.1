Received: from eggs.gnu.org ([2001:4830:134:3::10]:36812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dqAAK-0005uA-41
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 23:41:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dqAAF-0007q2-6p
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 23:41:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44339
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1dqAAE-0007pM-Tb
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 23:41:07 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v883dZnL126657
	for <qemu-devel@nongnu.org>; Thu, 7 Sep 2017 23:41:05 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cuc9mukht-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 23:41:05 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Thu, 7 Sep 2017 21:41:04 -0600
Date: Fri, 8 Sep 2017 11:41:00 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170905182546.00457332.cohuck@redhat.com>
	<fe102a7a-e998-8ebe-b94d-e653c4f66c39@linux.vnet.ibm.com>
	<20170906043108.GY31680@bjsdjshi@linux.vnet.ibm.com>
	<8946b1ec-4d14-c953-deab-aaded7cd2c9d@linux.vnet.ibm.com>
	<20170906162019.45eeec4a.cohuck@redhat.com>
	<cc6eab96-969d-eb66-91b5-cdb965c1bcbb@linux.vnet.ibm.com>
	<20170907085831.GF31680@bjsdjshi@linux.vnet.ibm.com>
	<20170907122400.5b2e3faa.cohuck@redhat.com>
	<27b2addf-0d1c-81d7-1e82-1a8cdac70231@linux.vnet.ibm.com>
	<20170907134134.00f387e8.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170907134134.00f387e8.cohuck@redhat.com>
Message-Id: <20170908034100.GH31680@bjsdjshi@linux.vnet.ibm.com>
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

* Cornelia Huck <cohuck@redhat.com> [2017-09-07 13:41:34 +0200]:

> On Thu, 7 Sep 2017 13:32:41 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
> > On 09/07/2017 12:24 PM, Cornelia Huck wrote:
> 
> > > So we would do an equipment check for the first two ("equipment", i.e.
> > > the software, is malfunctioning) and use a more appropriate way for the
> > > malformed idaw?
> > >   
> > 
> > You have probably missed my previous email where I state something very
> > similar (MID  <2aa8cf98-c331-fe5a-0a7e-1a553c6c5054@linux.vnet.ibm.com>).
> > There I say: if we change the kernel code, yes, if we don't I prefer a
> > program check.
> 
> Not missed, they crossed in mid-air.
> 
> But I agree, the decision is Dong Jia's.
> 
Let' me summarize here, in case I misunderstand things. Now we have
two ways to choose:

A. Kernel: no change.
   Qemu  : handle -EFAULT as option 2 by generating a program check.

B. Kernel: return -EFAULT
           +
           update the IRB area in the I/O region for option 1 to present
           a unit check SCSW (with proper sense byte ECW), and for option
           2 to present a program check.
   Qemu  : handle -EFAULT according to the information that the IRB area
           provided.

I think the difficult part is in the Qemu side. For either A or B, in
Qemu, we'd need to return a cc0 to indicate the channel program is
accepted successfully by the device, and then update the virtual IRB and
inject an I/O interrupt to notify the guest.

The question is, now we need to map -EFAULT to cc0? This is too odd...
And we need to find a proper place to do the interrupt injection. I
guess it could be in the sch_handle_start_func_passthrough().

If we do not like such modification in the Qemu side, then A is not the
way to go.

And for B, we need to update the IRB area of the I/O region in the three
cases listed in the former mail, and:
1. We need to set the ret_code as 0 for them, so that Qemu could map it
   to cc0.
2. We need to signal Qemu to fetch the IRB we generated with the checks.
All of these are doable I think.

Any comment for the above thoughts?

-- 
Dong Jia Shi
