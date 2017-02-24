Received: from eggs.gnu.org ([2001:4830:134:3::10]:60708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1chJc9-0000zP-8i
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:25:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1chJc6-0004Z3-KE
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:25:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1chJc6-0004Yo-E7
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:25:02 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8F2DD3D948
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 17:25:02 +0000 (UTC)
References: <20170206173306.20603-1-dgilbert@redhat.com>
	<20170206173306.20603-10-dgilbert@redhat.com>
	<4c0083ac-7b1d-ace6-d8f0-dfaa1686bd3b@redhat.com>
	<20170224154606.GJ8830@work-vm>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <6428f5cf-946e-d7d6-de59-4805b3a4e48b@redhat.com>
Date: Fri, 24 Feb 2017 18:24:59 +0100
MIME-Version: 1.0
In-Reply-To: <20170224154606.GJ8830@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 09/16] postcopy: Use temporary for
 placing zero huge pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, aarcange@redhat.com

On 24/02/2017 16:46, Dr. David Alan Gilbert wrote:
> * Laurent Vivier (lvivier@redhat.com) wrote:
>> On 06/02/2017 18:32, Dr. David Alan Gilbert (git) wrote:
>>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>>
>>> The kernel can't do UFFDIO_ZEROPAGE for huge pages, so we have
>>> to allocate a temporary (always zero) page and use UFFDIO_COPYPAGE
>>> on it.
>>>
>>> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>>> ---
...
>> Are you sure the kernel doesn't support UFFDIO_ZEROPAGE for huge page.
>> It seems __mcopy_atomic() manages HUGETLB vma (it is called by
>> mfill_zeropage(), called by userfaultfd_zeropage())?
> 
> That's as I understand it from Andrea; and I think it does fail if you try it.

Found the answer in kernel log:

    commit 7a0c4cf85b856430af62a907dd65dfc51438d24f
    Author: Andrea Arcangeli <aarcange@redhat.com>
    Date:   Wed Feb 22 15:44:10 2017 -0800

        userfaultfd: selftest: test UFFDIO_ZEROPAGE on all memory types

        This will verify -EINVAL is returned with hugetlbfs/shmem and
        it'll do a functional test of UFFDIO_ZEROPAGE on anonymous
        memory.

Thanks,
Laurent
