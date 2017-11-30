Received: from eggs.gnu.org ([2001:4830:134:3::10]:40419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eKP7G-0007aa-In
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 08:43:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eKP7B-0006ye-2u
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 08:43:02 -0500
Received: from www262.sakura.ne.jp ([2001:e42:101:1:202:181:97:72]:39372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eKP7A-0004oe-Kh
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 08:42:57 -0500
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <1511963726-34070-1-git-send-email-wei.w.wang@intel.com>
	<1511963726-34070-6-git-send-email-wei.w.wang@intel.com>
	<201711301934.CDC21800.FSLtJFFOOVQHMO@I-love.SAKURA.ne.jp>
In-Reply-To: <201711301934.CDC21800.FSLtJFFOOVQHMO@I-love.SAKURA.ne.jp>
Message-Id: <201711302235.FAJ57385.OFJHOVQOFtMSFL@I-love.SAKURA.ne.jp>
Date: Thu, 30 Nov 2017 22:35:03 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Qemu-devel] [PATCH v18 05/10] xbitmap: add more operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wei.w.wang@intel.com
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com

Tetsuo Handa wrote:
> > +
> > +			if (ebit >= BITS_PER_LONG)
> > +				continue;
> 
> (I don't understand how radix tree works, but generally this patchset looks fuzzy
> to me about boundary cases. Thus, I want to confirm that this is not an overlook.)
> Why is making "ebit >= BITS_PER_LONG" (e.g. start == 62) case a no-op correct?
> Aren't there bits which should have been cleared in this case?

According to xb_set_bit(), it seems to me that we are trying to avoid memory allocation
for "struct ida_bitmap" when all set bits within a 1024-bits bitmap reside in the first
61 bits.

But does such saving help? Is there characteristic bias that majority of set bits resides
in the first 61 bits, for "bit" is "unsigned long" which holds a page number (isn't it)?
If no such bias, wouldn't eliminating radix_tree_exception() case and always storing
"struct ida_bitmap" simplifies the code (and make the processing faster)?
