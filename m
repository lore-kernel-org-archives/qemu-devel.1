Received: from eggs.gnu.org ([2001:4830:134:3::10]:45491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mhocko@kernel.org>) id 1djfyq-0005O2-NF
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 02:14:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mhocko@kernel.org>) id 1djfyn-0000sw-Hg
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 02:14:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:47053 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mhocko@kernel.org>) id 1djfyn-0000sn-An
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 02:14:29 -0400
Date: Mon, 21 Aug 2017 08:14:23 +0200
From: Michal Hocko <mhocko@kernel.org>
Message-ID: <20170821061421.GA13724@dhcp22.suse.cz>
References: <1502940416-42944-1-git-send-email-wei.w.wang@intel.com>
	<1502940416-42944-5-git-send-email-wei.w.wang@intel.com>
	<20170818134650.GC18499@dhcp22.suse.cz>
	<599A79DF.2000707@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <599A79DF.2000707@intel.com>
Subject: Re: [Qemu-devel] [PATCH v14 4/5] mm: support reporting free page
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

On Mon 21-08-17 14:12:47, Wei Wang wrote:
> On 08/18/2017 09:46 PM, Michal Hocko wrote:
[...]
> >>+/**
> >>+ * walk_free_mem_block - Walk through the free page blocks in the system
> >>+ * @opaque1: the context passed from the caller
> >>+ * @min_order: the minimum order of free lists to check
> >>+ * @visit: the callback function given by the caller
> >The original suggestion for using visit was motivated by a visit design
> >pattern but I can see how this can be confusing. Maybe a more explicit
> >name wold be better. What about report_free_range.
> 
> 
> I'm afraid that name would be too long to fit in nicely.
> How about simply naming it "report"?

I do not have a strong opinion on this. I wouldn't be afraid of using
slightly longer name here for the clarity sake, though.
 
> >>+ *
> >>+ * The function is used to walk through the free page blocks in the system,
> >>+ * and each free page block is reported to the caller via the @visit callback.
> >>+ * Please note:
> >>+ * 1) The function is used to report hints of free pages, so the caller should
> >>+ * not use those reported pages after the callback returns.
> >>+ * 2) The callback is invoked with the zone->lock being held, so it should not
> >>+ * block and should finish as soon as possible.
> >I think that the explicit note about zone->lock is not really need. This
> >can change in future and I would even bet that somebody might rely on
> >the lock being held for some purpose and silently get broken with the
> >change. Instead I would much rather see something like the following:
> >"
> >Please note that there are no locking guarantees for the callback
> 
> Just a little confused with this one:
> 
> The callback is invoked within zone->lock, why would we claim it "no
> locking guarantees for the callback"?

Because we definitely do not want anybody to rely on that fact and
(ab)use it. This might change in future and it would be better to be
clear about that.
-- 
Michal Hocko
SUSE Labs
