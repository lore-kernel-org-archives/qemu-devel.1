Received: from eggs.gnu.org ([2001:4830:134:3::10]:38549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mhocko@kernel.org>) id 1dmKju-00005I-8z
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 10:10:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mhocko@kernel.org>) id 1dmKjq-0005tQ-Ae
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 10:10:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:43916 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mhocko@kernel.org>) id 1dmKjq-0005t1-4K
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 10:10:02 -0400
Date: Mon, 28 Aug 2017 16:09:58 +0200
From: Michal Hocko <mhocko@kernel.org>
Message-ID: <20170828140958.GO17097@dhcp22.suse.cz>
References: <1503914913-28893-1-git-send-email-wei.w.wang@intel.com>
	<1503914913-28893-5-git-send-email-wei.w.wang@intel.com>
	<20170828133326.GN17097@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170828133326.GN17097@dhcp22.suse.cz>
Subject: Re: [Qemu-devel] [PATCH v15 4/5] mm: support reporting free page
 blocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com

On Mon 28-08-17 15:33:26, Michal Hocko wrote:
> On Mon 28-08-17 18:08:32, Wei Wang wrote:
> > This patch adds support to walk through the free page blocks in the
> > system and report them via a callback function. Some page blocks may
> > leave the free list after zone->lock is released, so it is the caller's
> > responsibility to either detect or prevent the use of such pages.
> > 
> > One use example of this patch is to accelerate live migration by skipping
> > the transfer of free pages reported from the guest. A popular method used
> > by the hypervisor to track which part of memory is written during live
> > migration is to write-protect all the guest memory. So, those pages that
> > are reported as free pages but are written after the report function
> > returns will be captured by the hypervisor, and they will be added to the
> > next round of memory transfer.
> 
> OK, looks much better. I still have few nits.
> 
> > +extern void walk_free_mem_block(void *opaque,
> > +				int min_order,
> > +				bool (*report_page_block)(void *, unsigned long,
> > +							  unsigned long));
> > +
> 
> please add names to arguments of the prototype

And one more thing. Your callback returns bool and true usually means a
success while you are using it to break out from the loop. This is
rather confusing. I would expect iterating until false is returned so
the opposite than what you have. You could also change this to int and
return 0 on success and < 0 to break out. 

-- 
Michal Hocko
SUSE Labs
