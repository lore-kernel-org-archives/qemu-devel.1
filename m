Received: from eggs.gnu.org ([2001:4830:134:3::10]:56418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1ePvZ4-0005QK-Ra
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 14:22:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1ePvZ0-0003Di-1r
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 14:22:34 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:38967)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <willy@infradead.org>) id 1ePvYy-0003Br-VW
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 14:22:29 -0500
Date: Fri, 15 Dec 2017 11:22:03 -0800
From: Matthew Wilcox <willy@infradead.org>
Message-ID: <20171215192203.GC27160@bombadil.infradead.org>
References: <5A311C5E.7000304@intel.com>
	<201712132316.EJJ57332.MFOSJHOFFVLtQO@I-love.SAKURA.ne.jp>
	<5A31F445.6070504@intel.com>
	<201712150129.BFC35949.FFtFOLSOJOQHVM@I-love.SAKURA.ne.jp>
	<20171214181219.GA26124@bombadil.infradead.org>
	<201712160121.BEJ26052.HOFFOOQFMLtSVJ@I-love.SAKURA.ne.jp>
	<20171215184915.GB27160@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171215184915.GB27160@bombadil.infradead.org>
Subject: Re: [Qemu-devel] [PATCH v19 3/7] xbitmap: add more operations
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

On Fri, Dec 15, 2017 at 10:49:15AM -0800, Matthew Wilcox wrote:
> Here's the API I'm looking at right now.  The user need take no lock;
> the locking (spinlock) is handled internally to the implementation.

I looked at the API some more and found some flaws:
 - how does xbit_alloc communicate back which bit it allocated?
 - What if xbit_find_set() is called on a completely empty array with
   a range of 0, ULONG_MAX -- there's no invalid number to return.
 - xbit_clear() can't return an error.  Neither can xbit_zero().
 - Need to add __must_check to various return values to discourage sloppy
   programming

So I modify the proposed API we compete with thusly:

bool xbit_test(struct xbitmap *, unsigned long bit);
int __must_check xbit_set(struct xbitmap *, unsigned long bit, gfp_t);
void xbit_clear(struct xbitmap *, unsigned long bit);
int __must_check xbit_alloc(struct xbitmap *, unsigned long *bit, gfp_t);

int __must_check xbit_fill(struct xbitmap *, unsigned long start,
                        unsigned long nbits, gfp_t);
void xbit_zero(struct xbitmap *, unsigned long start, unsigned long nbits);
int __must_check xbit_alloc_range(struct xbitmap *, unsigned long *bit,
                        unsigned long nbits, gfp_t);

bool xbit_find_clear(struct xbitmap *, unsigned long *start, unsigned long max);
bool xbit_find_set(struct xbitmap *, unsigned long *start, unsigned long max);

(I'm a little sceptical about the API accepting 'max' for the find
functions and 'nbits' in the fill/zero/alloc_range functions, but I think
that matches how people want to use it, and it matches how bitmap.h works)
