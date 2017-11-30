Received: from eggs.gnu.org ([2001:4830:134:3::10]:55847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1eKQ0W-0001cK-P6
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 09:40:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1eKQ0N-0000h3-7J
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 09:40:08 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:42228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <willy@infradead.org>) id 1eKQ0M-0000gT-Tl
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 09:39:59 -0500
Date: Thu, 30 Nov 2017 06:39:52 -0800
From: Matthew Wilcox <willy@infradead.org>
Message-ID: <20171130143952.GB12684@bombadil.infradead.org>
References: <1511963726-34070-1-git-send-email-wei.w.wang@intel.com>
	<1511963726-34070-6-git-send-email-wei.w.wang@intel.com>
	<201711301934.CDC21800.FSLtJFFOOVQHMO@I-love.SAKURA.ne.jp>
	<201711302235.FAJ57385.OFJHOVQOFtMSFL@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201711302235.FAJ57385.OFJHOVQOFtMSFL@I-love.SAKURA.ne.jp>
Subject: Re: [Qemu-devel] [PATCH v18 05/10] xbitmap: add more operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: wei.w.wang@intel.com, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com

On Thu, Nov 30, 2017 at 10:35:03PM +0900, Tetsuo Handa wrote:
> According to xb_set_bit(), it seems to me that we are trying to avoid memory allocation
> for "struct ida_bitmap" when all set bits within a 1024-bits bitmap reside in the first
> 61 bits.
> 
> But does such saving help? Is there characteristic bias that majority of set bits resides
> in the first 61 bits, for "bit" is "unsigned long" which holds a page number (isn't it)?
> If no such bias, wouldn't eliminating radix_tree_exception() case and always storing
> "struct ida_bitmap" simplifies the code (and make the processing faster)?

It happens all the time.  The vast majority of users of the IDA set
low bits.  Also, it's the first 62 bits -- going up to 63 bits with the
XArray rewrite.

I do plan to redo the xbitmap on top of the XArray; I'm just trying to
get the XArray merged first.  The IDA and xbitmap code will share much
more code when that happens.
