Received: from eggs.gnu.org ([2001:4830:134:3::10]:35519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYKmx-00035a-2O
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 19:23:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYKmt-0002kq-V0
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 19:23:23 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:58651)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dYKmt-0002kX-OL
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 19:23:19 -0400
Date: Thu, 20 Jul 2017 19:23:18 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170720232318.GA5548@flamenco>
References: <1500520169-23367-1-git-send-email-cota@braap.org>
	<1500520169-23367-43-git-send-email-cota@braap.org>
	<8f18a24d-01f8-7b57-33ef-f89939acd3c6@twiddle.net>
	<20170720205041.GA8754@flamenco>
	<b1ab270d-2812-a11b-a6c7-fda0b8d0b42e@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1ab270d-2812-a11b-a6c7-fda0b8d0b42e@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v3 42/43] tcg: introduce regions to split
 code_gen_buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org

On Thu, Jul 20, 2017 at 11:22:10 -1000, Richard Henderson wrote:
> >Perhaps we should then enlarge both the first and last regions so that we
> >fully use the buffer.
> 
> I really like the idea.  That's a lot of space recovered for 64k page hosts.
> 
> I do think we can make the computation clearer.  How about

(snip)
> 
> static inline void tcg_region_bounds(TCGContext *s, size_t curr_region,
>                                      void **pstart, void **pend)
> {
>   void *start, *end;
> 
>   /* ??? Maybe store "aligned" precomputed.  */
>   start = QEMU_ALIGN_PTR_UP(region.start, qemu_real_host_page_size);
>   /* ??? Maybe store "stride" precomputed.  */
>   start += curr_region * (region.size + qemu_real_host_page_size);
>   end = start + region.size;
> 
>   if (curr_region == 0) {
>     start = region.start;
>   }
>   if (curr_region == region.n - 1) {
>     end = region.end;
>   }
> 
>   *pstart = start;
>   *pend = end;
> }

That's a nice helper -- will do it this way.

For v4, should I send all patches again, or just the handful of patches
that are changing from v3?

		E.
