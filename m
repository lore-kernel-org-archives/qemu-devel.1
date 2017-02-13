Received: from eggs.gnu.org ([2001:4830:134:3::10]:43879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aarcange@redhat.com>) id 1cdL57-0005bM-0J
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 13:10:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aarcange@redhat.com>) id 1cdL55-0002Z2-IE
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 13:10:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aarcange@redhat.com>) id 1cdL55-0002Yx-CA
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 13:10:31 -0500
Date: Mon, 13 Feb 2017 19:10:28 +0100
From: Andrea Arcangeli <aarcange@redhat.com>
Message-ID: <20170213181028.GH25530@redhat.com>
References: <20170206173306.20603-1-dgilbert@redhat.com>
	<20170206174529.GI2524@work-vm>
	<CGME20170213171108eucas1p147999fc8b6980ff89a67626b78b12e44@eucas1p1.samsung.com>
	<20170213171058.GA4246@aperevalov-ubuntu>
	<20170213175722.GG25530@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170213175722.GG25530@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/16] Postcopy: Hugepage support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com, Mike Kravetz <mike.kravetz@oracle.com>

On Mon, Feb 13, 2017 at 06:57:22PM +0100, Andrea Arcangeli wrote:
> Hello,
> 
> On Mon, Feb 13, 2017 at 08:11:06PM +0300, Alexey Perevalov wrote:
> > Another one request.
> > QEMU could use mem_path in hugefs with share key simultaneously
> > (-object memory-backend-file,id=mem,size=${mem_size},mem-path=${mem_path},share=on) and vm
> > in this case will start and will properly work (it will allocate memory
> > with mmap), but in case of destination for postcopy live migration
> > UFFDIO_COPY ioctl will fail for
> > such region, in Arcangeli's git tree there is such prevent check
> > (if (!vma_is_shmem(dst_vma) && dst_vma->vm_flags & VM_SHARED).
> > Is it possible to handle such situation at qemu?
> 
> It'd be nice to lift this hugetlbfs !VM_SHARED restriction I agree, I
> already asked Mike (CC'ed) why is there, because I'm afraid it's a

Cc'ed not existent email, mail client autocompletion error, corrected
the CC.

> leftover from the anon version where VM_SHARED means a very different
> thing but it was already lifted for shmem. share=on should already
> work on top of tmpfs and also with THP on tmpfs enabled.
> 
> For hugetlbfs and shmem it should be generally more complicated to
> cope with private mappings than shared ones, shared is just the native
> form of the pseudofs without having to deal with private COWs aliases
> so it's hard to imagine something going wrong for VM_SHARED if the
> MAP_PRIVATE mapping already works fine. If it turns out to be
> superflous the check may be just turned into
> "vma_is_anonymous(dst_vma) && dst_vma->vm_flags & VM_SHARED".
> 
> Thanks,
> Andrea
