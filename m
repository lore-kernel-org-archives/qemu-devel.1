Received: from eggs.gnu.org ([2001:4830:134:3::10]:55399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1cdePF-0007wH-NP
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 09:48:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1cdePC-0001EA-K5
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 09:48:37 -0500
Received: from mailout4.w1.samsung.com ([210.118.77.14]:64689)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1cdePC-0001D8-Dh
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 09:48:34 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout4.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OLD0007JD4SU840@mailout4.w1.samsung.com> for
	qemu-devel@nongnu.org; Tue, 14 Feb 2017 14:48:28 +0000 (GMT)
Date: Tue, 14 Feb 2017 17:48:25 +0300
From: Alexey Perevalov <a.perevalov@samsung.com>
Message-id: <20170214144817.GA4324@aperevalov-ubuntu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
In-reply-to: <20170213175722.GG25530@redhat.com>
References: <20170206173306.20603-1-dgilbert@redhat.com>
	<20170206174529.GI2524@work-vm>
	<CGME20170213171108eucas1p147999fc8b6980ff89a67626b78b12e44@eucas1p1.samsung.com>
	<20170213171058.GA4246@aperevalov-ubuntu>
	<20170213175722.GG25530@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/16] Postcopy: Hugepage support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Arcangeli <aarcange@redhat.com>
Cc: quintela@redhat.com, kravetz@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org

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

Great, as I know  -netdev type=vhost-user requires share=on in
-object memory-backend in ovs-dpdk scenario
http://wiki.qemu-project.org/Documentation/vhost-user-ovs-dpdk

> 
> Thanks,
> Andrea
>

BR,
Alexey
