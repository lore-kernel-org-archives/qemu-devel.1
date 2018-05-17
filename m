Received: from eggs.gnu.org ([2001:4830:134:3::10]:48013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1fJOtr-0008Hu-A1
	for qemu-devel@nongnu.org; Thu, 17 May 2018 15:49:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1fJOto-0007Pu-5D
	for qemu-devel@nongnu.org; Thu, 17 May 2018 15:49:19 -0400
Received: from outprodmail02.cc.columbia.edu ([128.59.72.51]:57281)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jl4312@columbia.edu>) id 1fJOtn-0007NI-W2
	for qemu-devel@nongnu.org; Thu, 17 May 2018 15:49:16 -0400
Received: from hazelnut (hazelnut.cc.columbia.edu [128.59.213.250])
	by outprodmail02.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w4HJjton047097
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 15:49:10 -0400
Received: from hazelnut (localhost.localdomain [127.0.0.1])
	by hazelnut (Postfix) with ESMTP id 24F5499
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 15:49:10 -0400 (EDT)
Received: from sendprodmail02.cc.columbia.edu (sendprodmail02.cc.columbia.edu
	[128.59.72.14]) by hazelnut (Postfix) with ESMTP id 6D5C3AC
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 15:49:09 -0400 (EDT)
Received: from mail-wm0-f71.google.com (mail-wm0-f71.google.com [74.125.82.71])
	by sendprodmail02.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w4HJn89U014819
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 15:49:09 -0400
Received: by mail-wm0-f71.google.com with SMTP id f188-v6so2589066wme.2
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 12:49:09 -0700 (PDT)
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com.
	[74.125.82.54]) by smtp.gmail.com with ESMTPSA id
	y17-v6sm2955155edl.49.2018.05.17.12.49.06 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 17 May 2018 12:49:06 -0700 (PDT)
Received: by mail-wm0-f54.google.com with SMTP id o78-v6so11221059wmg.0
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 12:49:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180517085927.24925-1-peterx@redhat.com>
References: <20180517085927.24925-1-peterx@redhat.com>
From: Jintack Lim <jintack@cs.columbia.edu>
Date: Thu, 17 May 2018 15:49:05 -0400
Message-ID: <CAHyh4xhP+ERYmSee+ybFtFEKyiHTUcEnUviCDRtKAXebancKLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 00/12] intel-iommu: nested vIOMMU,
 cleanups, bug fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>, Tian Kevin <kevin.tian@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Jason Wang <jasowang@redhat.com>

On Thu, May 17, 2018 at 4:59 AM, Peter Xu <peterx@redhat.com> wrote:
> (Hello, Jintack, Feel free to test this branch again against your scp
>  error case when you got free time)

Hi Peter,

>
> I rewrote some of the patches in V3.  Major changes:
>
> - Dropped mergable interval tree, instead introduced IOVA tree, which
>   is even simpler.
>
> - Fix the scp error issue that Jintack reported.  Please see patches
>   for detailed information.  That's the major reason to rewrite a few
>   of the patches.  We use replay for domain flushes are possibly
>   incorrect in the past.  The thing is that IOMMU replay has an
>   "definition" that "we should only send MAP when new page detected",
>   while for shadow page syncing we actually need something else than
>   that.  So in this version I started to use a new
>   vtd_sync_shadow_page_table() helper to do the page sync.

I checked that the scp problem I had (i.e. scp from the host to the
guest having virtual IOMMU and an assigned network device) was gone
with this patch series. Cool!

Please feel free to move this tag if this is not the right place!
Tested-by: Jintack Lim <jintack@cs.columbia.edu>

Thanks,
Jintack

>
> - Some other refines after the refactoring.
>
> I'll add unit test for the IOVA tree after this series merged to make
> sure we won't switch to another new tree implementaion...
>
> The element size in the new IOVA tree should be around
> sizeof(GTreeNode + IOMMUTLBEntry) ~= (5*8+4*8) = 72 bytes.  So the
> worst case usage ratio would be 72/4K=2%, which still seems acceptable
> (it means 8G L2 guest will use 8G*2%=160MB as metadata to maintain the
> mapping in QEMU).
>
> I did explicit test with scp this time, copying 1G sized file for >10
> times on each of the following case:
>
> - L1 guest, with vIOMMU and with assigned device
> - L2 guest, without vIOMMU and with assigned device
> - L2 guest, with vIOMMU (so 3-layer nested IOMMU) and with assigned device
>
> Please review.  Thanks,
>
> (Below are old content from previous cover letter)
>
> ==========================
>
> v2:
> - fix patchew code style warnings
> - interval tree: postpone malloc when inserting; simplify node remove
>   a bit where proper [Jason]
> - fix up comment and commit message for iommu lock patch [Kevin]
> - protect context cache too using the iommu lock [Kevin, Jason]
> - add vast comment in patch 8 to explain the modify-PTE problem
>   [Jason, Kevin]
>
> Online repo:
>
>   https://github.com/xzpeter/qemu/tree/fix-vtd-dma
>
> This series fixes several major problems that current code has:
>
> - Issue 1: when getting very big PSI UNMAP invalidations, the current
>   code is buggy in that we might skip the notification while actually
>   we should always send that notification.
>
> - Issue 2: IOTLB is not thread safe, while block dataplane can be
>   accessing and updating it in parallel.
>
> - Issue 3: For devices that only registered with UNMAP-only notifiers,
>   we don't really need to do page walking for PSIs, we can directly
>   deliver the notification down.  For example, vhost.
>
> - Issue 4: unsafe window for MAP notified devices like vfio-pci (and
>   in the future, vDPA as well).  The problem is that, now for domain
>   invalidations we do this to make sure the shadow page tables are
>   correctly synced:
>
>   1. unmap the whole address space
>   2. replay the whole address space, map existing pages
>
>   However during step 1 and 2 there will be a very tiny window (it can
>   be as big as 3ms) that the shadow page table is either invalid or
>   incomplete (since we're rebuilding it up).  That's fatal error since
>   devices never know that happending and it's still possible to DMA to
>   memories.
>
> Patch 1 fixes issue 1.  I put it at the first since it's picked from
> an old post.
>
> Patch 2 is a cleanup to remove useless IntelIOMMUNotifierNode struct.
>
> Patch 3 fixes issue 2.
>
> Patch 4 fixes issue 3.
>
> Patch 5-9 fix issue 4.  Here a very simple interval tree is
> implemented based on Gtree.  It's different with general interval tree
> in that it does not allow user to pass in private data (e.g.,
> translated addresses).  However that benefits us that then we can
> merge adjacent interval leaves so that hopefully we won't consume much
> memory even if the mappings are a lot (that happens for nested virt -
> when mapping the whole L2 guest RAM range, it can be at least in GBs).
>
> Patch 10 is another big cleanup only can work after patch 9.
>
> Tests:
>
> - device assignments to L1, even L2 guests.  With this series applied
>   (and the kernel IOMMU patches: https://lkml.org/lkml/2018/4/18/5),
>   we can even nest vIOMMU now, e.g., we can specify vIOMMU in L2 guest
>   with assigned devices and things will work.  We can't before.
>
> - vhost smoke test for regression.
>
> Please review.  Thanks,
>
> Peter Xu (12):
>   intel-iommu: send PSI always even if across PDEs
>   intel-iommu: remove IntelIOMMUNotifierNode
>   intel-iommu: add iommu lock
>   intel-iommu: only do page walk for MAP notifiers
>   intel-iommu: introduce vtd_page_walk_info
>   intel-iommu: pass in address space when page walk
>   intel-iommu: trace domain id during page walk
>   util: implement simple iova tree
>   intel-iommu: maintain per-device iova ranges
>   intel-iommu: simplify page walk logic
>   intel-iommu: new vtd_sync_shadow_page_table_range
>   intel-iommu: new sync_shadow_page_table
>
>  include/hw/i386/intel_iommu.h |  19 +-
>  include/qemu/iova-tree.h      | 134 ++++++++++++
>  hw/i386/intel_iommu.c         | 381 +++++++++++++++++++++++++---------
>  util/iova-tree.c              | 114 ++++++++++
>  MAINTAINERS                   |   6 +
>  hw/i386/trace-events          |   5 +-
>  util/Makefile.objs            |   1 +
>  7 files changed, 556 insertions(+), 104 deletions(-)
>  create mode 100644 include/qemu/iova-tree.h
>  create mode 100644 util/iova-tree.c
>
> --
> 2.17.0
>
>
