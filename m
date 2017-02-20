Received: from eggs.gnu.org ([2001:4830:134:3::10]:42574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cfiyo-0001Td-JD
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 03:05:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cfiyh-0006dh-1C
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 03:05:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1cfiyg-0006dS-N1
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 03:05:46 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1K84Ojd041812
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 03:05:43 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28ppce39a7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 03:05:43 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 20 Feb 2017 03:05:42 -0500
References: <0f8f3bd3-04d2-7213-2afb-ea75507eced6@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 20 Feb 2017 09:05:38 +0100
MIME-Version: 1.0
In-Reply-To: <0f8f3bd3-04d2-7213-2afb-ea75507eced6@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Message-Id: <be5d706e-edd8-3428-971d-59f9df5b91d1@de.ibm.com>
Subject: Re: [Qemu-devel] Error handling for KVM_GET_DIRTY_LOG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Janosch Frank <frankja@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 02/16/2017 03:51 PM, Janosch Frank wrote:
> While trying to fix a bug in the s390 migration code, I noticed that
> QEMU ignores practically all errors returned from that VM ioctl. QEMU
> behaves as specified in the KVM api and only processes -1 (-EPERM) as an
> error.
> 
> Unfortunately the documentation is wrong/old and KVM may return -EFAULT,
> -EINVAL, -ENOTSUPP (BookE) and -ENOENT. This bugs me, as I found a case
> where I want to return -EFAULT because of guest memory problems and QEMU
> will still happily migrate the VM.
> 
> I currently don't see a reason why we continue to migrate on EFAULT and
> EINVAL. But returning -error from kvm_physical_sync_dirty_bitmap might
> also a bit hard, as it kills QEMU.
> 
> Do we want to fix this and if, how do we want it done?
> If not we at least have a definitive mail to point to when the next one
> comes around. I also have a KVM patch to update the api documentation if
> wanted (maybe we should dust that off a bit anyhow).

I think we want to handle _ALL_ error of that ioctl. Instead of aborting
QEMU we might just want to abort the migration  in that case?


> 
> 
> This has been brought up in 2009 [1] the first time and was more or less
> fixed and then reverted in 2014 [2].
> 
> The reason in [1] was that PPC hadn't settled yet on a valid return code.
> 
> In [2] it was too close to the v2 to handle it properly.
> 
> 
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2009-07/msg01772.html
> 
> [2] https://lists.nongnu.org/archive/html/qemu-devel/2014-04/msg01993.html

So back then it was just too close to 2.0 and should have been revisited for 
2.1. Lets now fix it for 2.9?
