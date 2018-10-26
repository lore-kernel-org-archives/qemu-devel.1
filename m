Received: from eggs.gnu.org ([2001:4830:134:3::10]:54867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gGBcD-0006Ge-Gh
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 19:34:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gGBc8-0005uu-Dw
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 19:34:05 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:49209)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gGBc8-0005uK-4G
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 19:34:00 -0400
Date: Fri, 26 Oct 2018 19:33:54 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181026233354.GA31660@flamenco>
References: <20181016111006.629-1-xiaoguangrong@tencent.com>
	<20181016111006.629-3-xiaoguangrong@tencent.com>
	<873d9b11-3643-28d1-e7d8-44657402fa56@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873d9b11-3643-28d1-e7d8-44657402fa56@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] migration: introduce lockless
 multithreads model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: guangrong.xiao@gmail.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, quintela@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

On Wed, Oct 17, 2018 at 12:10:15 +0200, Paolo Bonzini wrote:
> On 16/10/2018 13:10, guangrong.xiao@gmail.com wrote:

> An idea: the total number of requests is going to be very small, and a
> PtrRing is not the nicest data structure for multiple producer/single
> consumer.  So you could instead:
(snip)
> - now that you have request indices, you can replace the completion
> ptr_ring with a bitmap, and set a bit in the bitmap with set_bit_atomic
> to report completion.  On the writer side you use find_next_bit to find
(snip)
> Emilio, can you review the above ideas?

Sorry it took me a while to go through this.

I like your suggestions. Just one nit; I'm not sure I understood
the use case very well, but I think using a bitmap to signal
completion might be suboptimal, since we'd have several
thread spinning on the same cacheline yet caring about
different bits.

Xiao: a couple of suggestions

- Since you'll be adding a generic module, make its commit and
  description self-contained. That is, mentioning in the
  log that this will be used for migration is fine, but please
  describe the module (and the assumptions it makes about its
  users) in general, so that someone that doesn't know anything
  about migration can still understand this module (and hopefully
  adopt it for other use cases).

- I'd like to see a simple test program (or rather, benchmark)
  that shows how this works. This benchmark would be completely
  unrelated to migration; it should just be a simple test of
  the performance/scalability of this module.
  Having this benchmark would help (1) discuss and quantitately
  evaluate modifications to the module, and (2) help others to
  quickly understand what the module does.
  See tests/qht-bench.c for an example.

Thanks,

		Emilio
