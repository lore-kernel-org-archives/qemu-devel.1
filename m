Received: from eggs.gnu.org ([2001:4830:134:3::10]:37624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dUJlT-0003UL-1W
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 17:29:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dUJlP-0004xV-UF
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 17:29:15 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45941)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dUJlP-0004xC-In
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 17:29:11 -0400
Date: Sun, 9 Jul 2017 17:29:10 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170709212910.GA3027@flamenco>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-22-git-send-email-cota@braap.org>
	<3fabc9d4-86b5-9d01-9499-3468bd2f2e5e@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fabc9d4-86b5-9d01-9499-3468bd2f2e5e@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 21/22] tcg: enable per-thread TCG for
 softmmu
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

On Sun, Jul 09, 2017 at 11:19:37 -1000, Richard Henderson wrote:
> On 07/08/2017 09:50 PM, Emilio G. Cota wrote:
> >This allows us to generate TCG code in parallel. MTTCG already uses
> >it, although the next commit pushes down a lock to actually
> >perform parallel generation.
> >
> >User-mode is kept out of this: contention due to concurrent translation
> >is more commonly found in full-system mode.
> 
> Um, why do you believe that?  Are you suggesting that a multi-threaded
> user-only guest is much more likely to share TBs and do much less code
> generation total?

Exactly. Also, in user-mode "vCPU threads" (i.e. host threads) come and
go all the time, so this doesn't work well with having a single
code_gen_buffer, which I assumed was non-negotiable.

> At the moment I think it's just a confusing distinction.  As proven by some
> of the comment adjustments you made.
> 
> >-TCGContext tcg_ctx;
> >+TCG_THREAD TCGContext tcg_ctx;
> 
> This is a really large structure, and it's not needed by any of the I/O
> threads.  We're probably better off dynamically allocating this ourselves
> and do something like
(snip)

Agreed, will look into this.

		E.
