Received: from eggs.gnu.org ([2001:4830:134:3::10]:56319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fcb4i-0000W3-KV
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 14:39:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fcb4f-0004lv-DC
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 14:39:52 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43805)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fcb4f-0004kC-5q
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 14:39:49 -0400
Date: Mon, 9 Jul 2018 14:39:44 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180709183944.GA27708@flamenco>
References: <1530806837-5416-1-git-send-email-cota@braap.org>
	<CAFEAcA9otSLZzz++GJ1vVLa4k+5c7Xcdj6goSuSJ-dH+7ckwog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9otSLZzz++GJ1vVLa4k+5c7Xcdj6goSuSJ-dH+7ckwog@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] translate-all: honour CF_NOCACHE in
 tb_gen_code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>, Richard Henderson <richard.henderson@linaro.org>

On Mon, Jul 09, 2018 at 17:59:02 +0100, Peter Maydell wrote:
> Hi -- I've been having a look at getting QEMU to support execution
> from MMIO regions by doing a "generate a single-insn CF_NOCACHE TB".
> As part of that, rth and I ran into a question about this change:
> why does tb_link_page() still add a CF_NOCACHE TB to the page lists?
> That is, why does this patch guard the "add to the hash table" part
> of the function, rather than just saying "return doing nothing
> if CF_NOCACHE"?

I think either way would work, although I have not tried the
alternative you suggest.

I'd say from a correctness viewpoint it seems "more correct" to
add the TB to the TB list, if only for the serialization imposed
by the page locks in softmmu mode.

Think for instance of MTTCG, where you might have a NOCACHE
generation concurrent with an invalidation of the same page where
guest code will be read from. Having to go through the page
locks at least enforces some ordering, which seems reasonable.

That said, currently CF_NOCACHE is only used in icount (i.e. !MTTCG),
so the above is not a practical concern. But for your MMIO
use case, which AFAIK will be abled for all TCG modes, I'd rather
keep the serialization in.

> I'm pretty clueless about this bit of the code, so I'm quite
> probably missing something.

The original design was changed to support parallel code generation.
docs/devel/multi-thread-tcg.txt documents those changes, although
it assumes that the original design is known by the reader.

That design can be sketched as follows. TBs are tracked by:

1. pc_ptr: host address of the translated code, which
   is managed with tcg_tb_lookup/remove/insert, with lookups
   usually being called from cpu_restore_state. These lookups
   are rare; insertions are a lot more common (one per
   generated TB).

2. phys_pc, pc, flags, etc. (all from the guest's viewpoint).
   These guest TB lookups are very common, so we have private
   per-vCPU caches plus a global hash table.

3. PageDesc: each guest page is tracked in a radix tree, whose
   root is l1_map in translate-all.c. PageDesc's also keep
   a list of the associated guest TBs, so that we can selectively
   invalidate TBs at a page granularity (eventually calling
   tb_phys_invalidate for each TB).

Most of tb_gen_code is spent in code generation, which in
softmmu works exclusively on thread-local data since commit
3468b59 ("tcg: enable multiple TCG contexts in softmmu", 2017-10-24).
(in user-mode we have a single context protected by mmap_lock.)

Once the code is generated, tb_add_page does 2 and 3 above,
and then tb_gen_code does 1 at the very end.

Hope that helps a little bit. Thanks,

		Emilio
