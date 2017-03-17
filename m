Received: from eggs.gnu.org ([2001:4830:134:3::10]:39289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cogaC-0001pt-Vo
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 21:21:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1coga9-0001FU-S9
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 21:21:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1coga9-0001FF-Ll
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 21:21:29 -0400
Date: Fri, 17 Mar 2017 03:21:21 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170317023556-mutt-send-email-mst@kernel.org>
References: <1489648127-37282-1-git-send-email-wei.w.wang@intel.com>
	<1489648127-37282-4-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1489648127-37282-4-git-send-email-wei.w.wang@intel.com>
Subject: Re: [Qemu-devel] [PATCH kernel v8 3/4] mm: add inerface to offer
 info about unused pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, david@redhat.com, dave.hansen@intel.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com

On Thu, Mar 16, 2017 at 03:08:46PM +0800, Wei Wang wrote:
> +/*
> + * The record_unused_pages() function is used to record the system unused
> + * pages. The unused pages can be skipped to transfer during live migration.
> + * Though the unused pages are dynamically changing, dirty page logging
> + * mechanisms are able to capture the newly used pages though they were
> + * recorded as unused pages via this function.

You will keep confusing people as long as you keep using
this terminology which only makes sense in a very specific
use and a very specific implementation.

How does guest developer know this does the right thing wrt locking etc?
Look at hypervisor spec and try to figure it all out together?

So stop saying what caller should do, describe what does the *API* does.

You want something like this:

	Get a list of pages in the system that are unused at some point between
	record_unused_pages is called and before it returns, implying that any
	data that was present in these pages before record_unused_pages was
	called is safe to discard. Pages can be used immediately after
	this point and any data written after this point is not safe to discard,
	it is caller's responsibility to either prevent the use or
	detect such pages.

-- 
MST
