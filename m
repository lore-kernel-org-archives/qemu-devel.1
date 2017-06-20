Received: from eggs.gnu.org ([2001:4830:134:3::10]:48716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dNNr8-0001KD-GJ
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 14:26:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dNNr5-0002Tf-A1
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 14:26:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dNNr5-0002TR-1E
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 14:26:23 -0400
Date: Tue, 20 Jun 2017 21:26:15 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170620212107-mutt-send-email-mst@kernel.org>
References: <1497004901-30593-1-git-send-email-wei.w.wang@intel.com>
	<1497004901-30593-5-git-send-email-wei.w.wang@intel.com>
	<b92af473-f00e-b956-ea97-eb4626601789@intel.com>
	<1497977049.20270.100.camel@redhat.com>
	<7b626551-6d1b-c8d5-4ef7-e357399e78dc@redhat.com>
	<1497979740.20270.102.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1497979740.20270.102.camel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v11 4/6] mm: function to offer a page block
 on the free list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Rik van Riel <riel@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Dave Hansen <dave.hansen@intel.com>, Wei Wang <wei.w.wang@intel.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, Nitesh Narayan Lal <nilal@redhat.com>

On Tue, Jun 20, 2017 at 01:29:00PM -0400, Rik van Riel wrote:
> On Tue, 2017-06-20 at 18:49 +0200, David Hildenbrand wrote:
> > On 20.06.2017 18:44, Rik van Riel wrote:
> 
> > > Nitesh Lal (on the CC list) is working on a way
> > > to efficiently batch recently freed pages for
> > > free page hinting to the hypervisor.
> > > 
> > > If that is done efficiently enough (eg. with
> > > MADV_FREE on the hypervisor side for lazy freeing,
> > > and lazy later re-use of the pages), do we still
> > > need the harder to use batch interface from this
> > > patch?
> > > 
> > 
> > David's opinion incoming:
> > 
> > No, I think proper free page hinting would be the optimum solution,
> > if
> > done right. This would avoid the batch interface and even turn
> > virtio-balloon in some sense useless.
> 
> I agree with that.  Let me go into some more detail of
> what Nitesh is implementing:
> 
> 1) In arch_free_page, the being-freed page is added
>    to a per-cpu set of freed pages.
> 2) Once that set is full, arch_free_pages goes into a
>    slow path, which:
>    2a) Iterates over the set of freed pages, and
>    2b) Checks whether they are still free, and
>    2c) Adds the still free pages to a list that is
>        to be passed to the hypervisor, to be MADV_FREEd.
>    2d) Makes that hypercall.
> 
> Meanwhile all arch_alloc_pages has to do is make sure it
> does not allocate a page while it is currently being
> MADV_FREEd on the hypervisor side.
> 
> The code Wei is working on looks like it could be 
> suitable for steps (2c) and (2d) above. Nitesh already
> has code for steps 1 through 2b.
> 
> -- 
> All rights reversed


So my question is this: Wei posted these numbers for balloon
inflation times:
inflating 7GB of an 8GB idle guest:

	1) allocating pages (6.5%)
	2) sending PFNs to host (68.3%)
	3) address translation (6.1%)
	4) madvise (19%)

	It takes about 4126ms for the inflating process to complete.

It seems that this is an excessive amount of time to stay
under a lock. What are your estimates for Nitesh's work?

-- 
MST
