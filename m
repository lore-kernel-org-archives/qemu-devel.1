Received: from eggs.gnu.org ([2001:4830:134:3::10]:47888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1d5kEI-0003xm-0C
	for qemu-devel@nongnu.org; Tue, 02 May 2017 22:41:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1d5kED-0003we-SD
	for qemu-devel@nongnu.org; Tue, 02 May 2017 22:41:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1d5kED-0003wB-Jr
	for qemu-devel@nongnu.org; Tue, 02 May 2017 22:41:21 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v432cg8t016553
	for <qemu-devel@nongnu.org>; Tue, 2 May 2017 22:41:19 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a76c70fs8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 22:41:19 -0400
Received: from localhost
	by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Tue, 2 May 2017 23:41:16 -0300
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
	by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v432fD9n34078918
	for <qemu-devel@nongnu.org>; Tue, 2 May 2017 23:41:14 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
	by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v432fDFI024522
	for <qemu-devel@nongnu.org>; Tue, 2 May 2017 23:41:13 -0300
Date: Tue, 2 May 2017 23:41:01 -0300
From: joserz@linux.vnet.ibm.com
References: <1492631083-23965-1-git-send-email-joserz@linux.vnet.ibm.com>
	<a8eb495d-7c03-2d6f-c8df-3970f08bc05d@twiddle.net>
	<20170420100301.51a7f10c@t450s.home>
	<07d71898-c392-c14a-9901-87ad4287bd5d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <07d71898-c392-c14a-9901-87ad4287bd5d@redhat.com>
Message-Id: <20170503024101.GA31494@pacoca>
Subject: Re: [Qemu-devel] [PATCH 0/2] VFIO: Make 8-byte accesses atomic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com

On Fri, Apr 21, 2017 at 12:06:15PM +0200, Paolo Bonzini wrote:
> 
> 
> On 20/04/2017 18:03, Alex Williamson wrote:
> > On Thu, 20 Apr 2017 00:19:23 -0700
> > Richard Henderson <rth@twiddle.net> wrote:
> > 
> >> On 04/19/2017 12:44 PM, Jose Ricardo Ziviani wrote:
> >>> This patchset has two patches:
> >>> [1] 8-byte writes to non-mapped MMIO are broken into pairs of 4-byte writes, this patch makes such pairs atomic.
> >>>
> >>> [2] Enable 8-byte accesses in vfio_region_write and vfio_region_read.
> >>>
> >>> Patches based on master.
> >>>
> >>> Jose Ricardo Ziviani (2):
> >>>   vfio: Set MemoryRegionOps:max_access_size and min_access_size
> >>>   vfio: enable 8-byte reads/writes to vfio
> >>>
> >>>  hw/vfio/common.c | 14 ++++++++++++++
> >>>  1 file changed, 14 insertions(+)
> >>>  
> >>
> >> I think these patches need to be squashed to be bisectable.
> > 
> > No, I think it's fine.  The point of patch 1/2 is to indicate that the
> > hardware supports 8-byte accesses, which will still be broken into 2
> > 4-byte accesses because we don't yet set the implemented width beyond
> > the default.  The important part is that the mutex will now group the 4
> > byte access pair together rather than letting them get re-ordered.
> > Patch 2/2 then implements native 8-byte access.  I appreciate them
> > being separate for this subtle nuance, but maybe I'm not seeing the
> > same issue as you.  Thanks,
> '
> I agree, the patches looks fine as is.
> 
> Paolo
> 

Hello!

Thank you all for your review but I have a quick question: is it ok for
merge? :)

Thanks
