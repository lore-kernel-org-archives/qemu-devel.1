Received: from eggs.gnu.org ([2001:4830:134:3::10]:47123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1cfqPE-00049I-2L
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 11:01:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1cfqP9-0004K6-5t
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 11:01:40 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:30162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1cfqP8-0004JZ-UU
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 11:01:35 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OLO006N9KIHFW90@mailout1.w1.samsung.com> for
	qemu-devel@nongnu.org; Mon, 20 Feb 2017 16:01:29 +0000 (GMT)
Date: Mon, 20 Feb 2017 19:01:26 +0300
From: Alexey Perevalov <a.perevalov@samsung.com>
Message-id: <20170220160118.GA11004@aperevalov-ubuntu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
In-reply-to: <20170217164730.GU25530@redhat.com>
References: <20170206173306.20603-1-dgilbert@redhat.com>
	<20170206174529.GI2524@work-vm>
	<CGME20170213171108eucas1p147999fc8b6980ff89a67626b78b12e44@eucas1p1.samsung.com>
	<20170213171058.GA4246@aperevalov-ubuntu>
	<20170213175722.GG25530@redhat.com>
	<20170214144817.GA4324@aperevalov-ubuntu>
	<20170217164730.GU25530@redhat.com>
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
Cc: qemu-devel@nongnu.org, Mike Kravetz <mike.kravetz@oracle.com>, kravetz@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, quintela@redhat.com

Hello Andrea,


On Fri, Feb 17, 2017 at 05:47:30PM +0100, Andrea Arcangeli wrote:
> Hello Alexey,
> 
> On Tue, Feb 14, 2017 at 05:48:25PM +0300, Alexey Perevalov wrote:
> > On Mon, Feb 13, 2017 at 06:57:22PM +0100, Andrea Arcangeli wrote:
> > > Hello,
> > > 
> > > On Mon, Feb 13, 2017 at 08:11:06PM +0300, Alexey Perevalov wrote:
> > > > Another one request.
> > > > QEMU could use mem_path in hugefs with share key simultaneously
> > > > (-object memory-backend-file,id=mem,size=${mem_size},mem-path=${mem_path},share=on) and vm
> > > > in this case will start and will properly work (it will allocate memory
> > > > with mmap), but in case of destination for postcopy live migration
> > > > UFFDIO_COPY ioctl will fail for
> > > > such region, in Arcangeli's git tree there is such prevent check
> > > > (if (!vma_is_shmem(dst_vma) && dst_vma->vm_flags & VM_SHARED).
> > > > Is it possible to handle such situation at qemu?
> > > 
> > > It'd be nice to lift this hugetlbfs !VM_SHARED restriction I agree, I
> > > already asked Mike (CC'ed) why is there, because I'm afraid it's a
> > > leftover from the anon version where VM_SHARED means a very different
> > > thing but it was already lifted for shmem. share=on should already
> > > work on top of tmpfs and also with THP on tmpfs enabled.
> > > 
> > > For hugetlbfs and shmem it should be generally more complicated to
> > > cope with private mappings than shared ones, shared is just the native
> > > form of the pseudofs without having to deal with private COWs aliases
> > > so it's hard to imagine something going wrong for VM_SHARED if the
> > > MAP_PRIVATE mapping already works fine. If it turns out to be
> > > superflous the check may be just turned into
> > > "vma_is_anonymous(dst_vma) && dst_vma->vm_flags & VM_SHARED".
> > 
> > Great, as I know  -netdev type=vhost-user requires share=on in
> > -object memory-backend in ovs-dpdk scenario
> > http://wiki.qemu-project.org/Documentation/vhost-user-ovs-dpdk
> 
> share=on should work now with current aa.git userfault branch, and the
> support is already included in -mm, it should all get merged upstream
> in kernel 4.11.
> 
> Could you test the current aa.git userfault branch to verify postcopy
> live migration works fine on hugetlbfs share=on?
>

Yes, I already checked with you suggestion of using another check
"vma_is_anonymous(dst_vma) && dst_vma->vm_flags & VM_SHARED", but in
this case dst page was anonymous after successfully passed ioctl.

There is no such bug in latest aa.git now.
"userfaultfd: hugetlbfs: add UFFDIO_COPY support for shared mappings"
solved issue with anonymous page after UFFDIO_COPY.


> Thanks!
> Andrea
> 

-- 

BR
Alexey
