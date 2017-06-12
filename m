Received: from eggs.gnu.org ([2001:4830:134:3::10]:37792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dKW2S-0006EA-1g
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 16:34:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dKW2N-00007Q-4v
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 16:34:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:8797)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dKW2M-000075-V4
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 16:34:11 -0400
Date: Mon, 12 Jun 2017 23:34:06 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170612194438-mutt-send-email-mst@kernel.org>
References: <1497004901-30593-1-git-send-email-wei.w.wang@intel.com>
	<1497004901-30593-5-git-send-email-wei.w.wang@intel.com>
	<b92af473-f00e-b956-ea97-eb4626601789@intel.com>
	<20170612181354-mutt-send-email-mst@kernel.org>
	<9d0900f3-9df5-ac63-4069-2d796f2a5bc7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d0900f3-9df5-ac63-4069-2d796f2a5bc7@intel.com>
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
To: Dave Hansen <dave.hansen@intel.com>
Cc: Wei Wang <wei.w.wang@intel.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, david@redhat.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com

On Mon, Jun 12, 2017 at 09:42:36AM -0700, Dave Hansen wrote:
> On 06/12/2017 09:28 AM, Michael S. Tsirkin wrote:
> > 
> >> The hypervisor is going to throw away the contents of these pages,
> >> right?
> > It should be careful and only throw away contents that was there before
> > report_unused_page_block was invoked.  Hypervisor is responsible for not
> > corrupting guest memory.  But that's not something an mm patch should
> > worry about.
> 
> That makes sense.  I'm struggling to imagine how the hypervisor makes
> use of this information, though.  Does it make the pages read-only
> before this, and then it knows if there has not been a write *and* it
> gets notified via this new mechanism that it can throw the page away?

Yes, and specifically, this is how it works for migration.  Normally you
start by migrating all of memory, then send updates incrementally if
pages have been modified.  This mechanism allows skipping some pages in
the 1st stage, if they get changed they will be migrated in the 2nd
stage.

-- 
MST
