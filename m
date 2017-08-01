Received: from eggs.gnu.org ([2001:4830:134:3::10]:54003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dcQGi-00065a-Aw
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 02:03:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dcQGd-0002M6-D2
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 02:03:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dcQGd-0002LJ-6L
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 02:02:55 -0400
Date: Tue, 1 Aug 2017 14:02:48 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170801060248.GG15697@pxdev.xzpeter.org>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-2-git-send-email-peterx@redhat.com>
	<20170731163414.GB2122@work-vm>
	<CGME20170801021152epcas1p28d9b21ba2ddcddd0c1f3d6f9df4b04f1@epcas1p2.samsung.com>
	<20170801021137.GA15697@pxdev.xzpeter.org>
	<11b966a9-529f-eb17-d40d-e32be54bfd87@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <11b966a9-529f-eb17-d40d-e32be54bfd87@samsung.com>
Subject: Re: [Qemu-devel] [RFC 01/29] migration: fix incorrect postcopy
 recved_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

On Tue, Aug 01, 2017 at 08:48:18AM +0300, Alexey Perevalov wrote:
> On 08/01/2017 05:11 AM, Peter Xu wrote:
> >On Mon, Jul 31, 2017 at 05:34:14PM +0100, Dr. David Alan Gilbert wrote:
> >>* Peter Xu (peterx@redhat.com) wrote:
> >>>The bitmap setup during postcopy is incorrectly when the pgaes are huge
> >>>pages. Fix it.
> >>>
> >>>Signed-off-by: Peter Xu <peterx@redhat.com>
> >>>---
> >>>  migration/postcopy-ram.c | 2 +-
> >>>  migration/ram.c          | 8 ++++++++
> >>>  migration/ram.h          | 2 ++
> >>>  3 files changed, 11 insertions(+), 1 deletion(-)
> >>>
> >>>diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> >>>index 276ce12..952b73a 100644
> >>>--- a/migration/postcopy-ram.c
> >>>+++ b/migration/postcopy-ram.c
> >>>@@ -578,7 +578,7 @@ static int qemu_ufd_copy_ioctl(int userfault_fd, void *host_addr,
> >>>          ret = ioctl(userfault_fd, UFFDIO_ZEROPAGE, &zero_struct);
> >>>      }
> >>>      if (!ret) {
> >>>-        ramblock_recv_bitmap_set(host_addr, rb);
> >>>+        ramblock_recv_bitmap_set_range(rb, host_addr, pagesize / getpagesize());
> >>isn't that   pagesize / qemu_target_page_size() ?
> >>
> >>Other than that it looks OK.
> >Yes, I should have fixed this before.
> >
> >I guess Alexey will handle this change (along with the copied bitmap
> >series)?  Anyway, I'll fix it as well in my series, until Alexey post
> >the new version that I can rebase to.  Thanks,
> >
> I'll squash it, and I'll resend it today.
> Are you agree to add
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> to my patch?

Firstly, if you are squashing the patch, fixing the issue that Dave
has pointed out, please feel free to add my R-b on the patch.

I don't know whether it would be suitable to add my S-o-b here - since
most of the patch content is written by you, not me. But I'm totally
fine if you want to include that (btw, thanks for the offer :).

So either one R-b or S-o-b is okay to me.  Thanks,

-- 
Peter Xu
