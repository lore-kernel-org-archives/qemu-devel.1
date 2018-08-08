Received: from eggs.gnu.org ([2001:4830:134:3::10]:36415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fnJqk-0004sV-Le
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 04:29:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fnJqg-0000bf-Oi
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 04:29:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40480 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fnJqg-0000bT-KA
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 04:29:42 -0400
Date: Wed, 8 Aug 2018 09:29:38 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180808082937.GA2734@work-vm>
References: <1533031278-5615-1-git-send-email-wei.w.wang@intel.com>
	<20180807073905.GA7265@xz-mi> <5B69567B.8050309@intel.com>
	<20180807095337.GD2556@work-vm> <5B6A48AF.7010906@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B6A48AF.7010906@intel.com>
Subject: Re: [Qemu-devel] [PATCH v2] bitmap: fix BITMAP_LAST_WORD_MASK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com, mst@redhat.com

* Wei Wang (wei.w.wang@intel.com) wrote:
> On 08/07/2018 05:53 PM, Dr. David Alan Gilbert wrote:
> > * Wei Wang (wei.w.wang@intel.com) wrote:
> > > On 08/07/2018 03:39 PM, Peter Xu wrote:
> > > > On Tue, Jul 31, 2018 at 06:01:18PM +0800, Wei Wang wrote:
> > > > > When "nbits = 0", which means no bits to mask, this macro is expected to
> > > > > return 0, instead of 0xffffffff. This patch changes the macro to return
> > > > > 0 when there is no bit needs to be masked.
> > > > > 
> > > > > Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> > > > > CC: Juan Quintela <quintela@redhat.com>
> > > > > CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > > > CC: Peter Xu <peterx@redhat.com>
> > > > Reviewed-by: Peter Xu <peterx@redhat.com>
> > > > 
> > > > Is there any existing path that can trigger this nbits==0?
> > > Not sure about other bitmap APIs which call this macro. But it happens in
> > > the patches we are working on, which use bitmap_count_one.
> > > It would be good to have the macro itself handle this corner case, so that
> > > callers won't need to worry about that.
> > Given that I see you're having a similar discussion on the kernel list
> > we should see how that pans out before making qemu changes.
> 
> OK.
> The situation is a little different in Linux, because all the callers there
> have already taken the responsibilities to avoid the "nbits=0" corner case,
> that's also the reason that they want to stick with the old way. Here in
> QEMU, most callers (e.g. bitmap_count_one, bitmap_fill, bitmap_intersects)
> haven't checked that, so fixing the macro itself might be a better choice
> here.

Where we have macros or functions that have the same name as the kernel
then we should keep them consistent with the kernel unless we have a
VERY good reason to make them differ;  that's especially true if the
difference is a small subtle difference like this;  otherwise it would
be too easy for someone used to QEMU or the kernel to introduce a bad
mistake in the other one because they think they're using the same
thing.

Dave


> Best,
> Wei
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
