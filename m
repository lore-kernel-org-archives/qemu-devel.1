Received: from eggs.gnu.org ([2001:4830:134:3::10]:52556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gRLwk-0008OI-NE
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 13:49:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gRLwh-0000pR-If
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 13:49:26 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:60127)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gRLwh-0000pJ-7H
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 13:49:23 -0500
Date: Mon, 26 Nov 2018 13:49:19 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181126184919.GA6688@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <122f7c3b-ebaf-a2c0-3181-cce82d857058@gmail.com>
	<60635ba4-7db8-c0c0-6ce2-23f6fab8ac25@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/5] util: introduce threaded workqueue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@gmail.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, quintela@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

On Mon, Nov 26, 2018 at 16:06:37 +0800, Xiao Guangrong wrote:
> > > +    /* after the user fills the request, the bit is flipped. */
> > > +    uint64_t request_fill_bitmap QEMU_ALIGNED(SMP_CACHE_BYTES);
> > > +    /* after handles the request, the thread flips the bit. */
> > > +    uint64_t request_done_bitmap QEMU_ALIGNED(SMP_CACHE_BYTES);
> > 
> > Use DECLARE_BITMAP, otherwise you'll get type errors as David
> > pointed out.
> 
> If we do it, the field becomes a pointer... that complicates the
> thing.

Not necessarily, see below.

On Mon, Nov 26, 2018 at 16:18:24 +0800, Xiao Guangrong wrote:
> On 11/24/18 8:17 AM, Emilio G. Cota wrote:
> > On Thu, Nov 22, 2018 at 15:20:25 +0800, guangrong.xiao@gmail.com wrote:
> > > +static uint64_t get_free_request_bitmap(Threads *threads, ThreadLocal *thread)
> > > +{
> > > +    uint64_t request_fill_bitmap, request_done_bitmap, result_bitmap;
> > > +
> > > +    request_fill_bitmap = atomic_rcu_read(&thread->request_fill_bitmap);
> > > +    request_done_bitmap = atomic_rcu_read(&thread->request_done_bitmap);
> > > +    bitmap_xor(&result_bitmap, &request_fill_bitmap, &request_done_bitmap,
> > > +               threads->thread_requests_nr);
> > 
> > This is not wrong, but it's a big ugly. Instead, I would:
> > 
> > - Introduce bitmap_xor_atomic in a previous patch
> > - Use bitmap_xor_atomic here, getting rid of the rcu reads
> 
> Hmm, however, we do not need atomic xor operation here... that should be slower than
> just two READ_ONCE calls.

If you use DECLARE_BITMAP, you get an in-place array. On a 64-bit
host, that'd be
	unsigned long foo[1]; /* [2] on 32-bit */

Then again on 64-bit hosts, bitmap_xor_atomic would reduce
to 2 atomic reads:

static inline void bitmap_xor_atomic(unsigned long *dst,
const unsigned long *src1, const unsigned long *src2, long nbits)
{
    if (small_nbits(nbits)) {
        *dst = atomic_read(src1) ^ atomic_read(&src2);
    } else {
        slow_bitmap_xor_atomic(dst, src1, src2, nbits);
    }
}

So you can either do the above, or just define an unsigned long
instead of a u64 and keep doing what you're doing in this series,
but bearing in mind that the max on 32-bit hosts will be 32. But
that's no big deal since those machines won't have many cores
anyway.

		Emilio
