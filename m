Received: from eggs.gnu.org ([2001:4830:134:3::10]:55084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mike.kravetz@oracle.com>) id 1cdOkQ-0003HW-Ht
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 17:05:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mike.kravetz@oracle.com>) id 1cdOkN-00050H-7n
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 17:05:26 -0500
Received: from userp1050.oracle.com ([156.151.31.82]:37966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mike.kravetz@oracle.com>)
	id 1cdOkM-0004Ly-UR
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 17:05:23 -0500
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
	by userp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id v1DM3rmJ009625
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 22:03:54 GMT
References: <20170206173306.20603-1-dgilbert@redhat.com>
	<20170206174529.GI2524@work-vm>
	<CGME20170213171108eucas1p147999fc8b6980ff89a67626b78b12e44@eucas1p1.samsung.com>
	<20170213171058.GA4246@aperevalov-ubuntu>
	<20170213175722.GG25530@redhat.com>
	<20170213181028.GH25530@redhat.com>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <bded76ef-50be-dd93-1e77-fefaa7212fa2@oracle.com>
Date: Mon, 13 Feb 2017 13:59:47 -0800
MIME-Version: 1.0
In-Reply-To: <20170213181028.GH25530@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 00/16] Postcopy: Hugepage support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Arcangeli <aarcange@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com

On 02/13/2017 10:10 AM, Andrea Arcangeli wrote:
> On Mon, Feb 13, 2017 at 06:57:22PM +0100, Andrea Arcangeli wrote:
>> Hello,
>>
>> On Mon, Feb 13, 2017 at 08:11:06PM +0300, Alexey Perevalov wrote:
>>> Another one request.
>>> QEMU could use mem_path in hugefs with share key simultaneously
>>> (-object memory-backend-file,id=mem,size=${mem_size},mem-path=${mem_path},share=on) and vm
>>> in this case will start and will properly work (it will allocate memory
>>> with mmap), but in case of destination for postcopy live migration
>>> UFFDIO_COPY ioctl will fail for
>>> such region, in Arcangeli's git tree there is such prevent check
>>> (if (!vma_is_shmem(dst_vma) && dst_vma->vm_flags & VM_SHARED).
>>> Is it possible to handle such situation at qemu?
>>
>> It'd be nice to lift this hugetlbfs !VM_SHARED restriction I agree, I
>> already asked Mike (CC'ed) why is there, because I'm afraid it's a
> 
> Cc'ed not existent email, mail client autocompletion error, corrected
> the CC.
> 
>> leftover from the anon version where VM_SHARED means a very different
>> thing but it was already lifted for shmem. share=on should already
>> work on top of tmpfs and also with THP on tmpfs enabled.
>>
>> For hugetlbfs and shmem it should be generally more complicated to
>> cope with private mappings than shared ones, shared is just the native
>> form of the pseudofs without having to deal with private COWs aliases
>> so it's hard to imagine something going wrong for VM_SHARED if the
>> MAP_PRIVATE mapping already works fine. If it turns out to be
>> superflous the check may be just turned into
>> "vma_is_anonymous(dst_vma) && dst_vma->vm_flags & VM_SHARED".
>>
>> Thanks,
>> Andrea

Sorry, I did not see e-mail earlier.

Andrea is correct in that the VM_SHARED restriction for hugetlbfs was there
to make the code common with the anon version.  The use case I had was to
simply 'catch' no page hugetlbfs faults private -or- shared.  That is why
you can register hugetlbfs shared regions.

I can take a look at what it would take to enable copy, and agree with Andrea
that it should be relatively easy.

-- 
Mike Kravetz
