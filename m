Received: from eggs.gnu.org ([2001:4830:134:3::10]:57957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dKSCK-0003za-Rp
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 12:28:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dKSCH-0000jx-IA
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 12:28:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dKSCH-0000hu-9w
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 12:28:09 -0400
Date: Mon, 12 Jun 2017 19:28:03 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170612181354-mutt-send-email-mst@kernel.org>
References: <1497004901-30593-1-git-send-email-wei.w.wang@intel.com>
	<1497004901-30593-5-git-send-email-wei.w.wang@intel.com>
	<b92af473-f00e-b956-ea97-eb4626601789@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b92af473-f00e-b956-ea97-eb4626601789@intel.com>
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

On Mon, Jun 12, 2017 at 07:10:12AM -0700, Dave Hansen wrote:
> Please stop cc'ing me on things also sent to closed mailing lists
> (virtio-dev@lists.oasis-open.org).  I'm happy to review things on open
> lists, but I'm not fond of the closed lists bouncing things at me.
> 
> On 06/09/2017 03:41 AM, Wei Wang wrote:
> > Add a function to find a page block on the free list specified by the
> > caller. Pages from the page block may be used immediately after the
> > function returns. The caller is responsible for detecting or preventing
> > the use of such pages.
> 
> This description doesn't tell me very much about what's going on here.
> Neither does the comment.
> 
> "Pages from the page block may be used immediately after the
>  function returns".
> 
> Used by who?  Does the "may" here mean that it is OK, or is it a warning
> that the contents will be thrown away immediately?

I agree here. Don't tell callers what they should do, say what does the
function does. "offer" also confuses. Here's a better comment

--->
mm: support reporting free page blocks

This adds support for reporting blocks of pages on the free list
specified by the caller.

As pages can leave the free list during this call or immediately
afterwards, they are not guaranteed to be free after the function
returns. The only guarantee this makes is that the page was on the free
list at some point in time after the function has been invoked.

Therefore, it is not safe for caller to use any pages on the returned
block or to discard data that is put there after the function returns.
However, it is safe for caller to discard data that was in one of these
pages before the function was invoked.

---

And repeat the last part in a code comment:

 * Note: it is not safe for caller to use any pages on the returned
 * block or to discard data that is put there after the function returns.
 * However, it is safe for caller to discard data that was in one of these
 * pages before the function was invoked.


> The hypervisor is going to throw away the contents of these pages,
> right?

It should be careful and only throw away contents that was there before
report_unused_page_block was invoked.  Hypervisor is responsible for not
corrupting guest memory.  But that's not something an mm patch should
worry about.

>  As soon as the spinlock is released, someone can allocate a
> page, and put good data in it.  What keeps the hypervisor from throwing
> away good data?

API should require this explicitly. Hopefully above answers this question.

-- 
MST
