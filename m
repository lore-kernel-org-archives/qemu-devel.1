Received: from eggs.gnu.org ([2001:4830:134:3::10]:42085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dUg17-0006hQ-HR
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 17:14:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dUg12-00079L-FL
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 17:14:53 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:49013)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dUg12-000799-3m
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 17:14:48 -0400
Date: Mon, 10 Jul 2017 17:14:46 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170710211446.GA25777@flamenco>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-22-git-send-email-cota@braap.org>
	<e69fe832-f4e8-f59d-e0dd-3472f498c04e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e69fe832-f4e8-f59d-e0dd-3472f498c04e@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On Mon, Jul 10, 2017 at 14:05:01 +0200, Paolo Bonzini wrote:
> On 09/07/2017 09:50, Emilio G. Cota wrote:
> > User-mode is kept out of this: contention due to concurrent translation
> > is more commonly found in full-system mode.
> 
> Out of curiosity, is it harder or you just didn't try?  It would be nice
> if the commit message mentioned the problems (if any) in addition to the
> reason why you didn't do it.
> 
> Having similar policies for user and softmmu emulation is much more
> maintainable (for an earlier example, see the unification of user mode
> emulation's start/end_exclusive logic with softmmu's "safe work").

I agree that it would be nice to have the same mechanism for all.

The main hurdle I see is how to allow for concurrent code generation while
minimizing flushes of the single, fixed-size[*] code_gen_buffer.
In user-mode this is tricky because there is no way to bound the number
of threads that might be spawned by the guest code (I don't think reading
/proc/sys/kernel/threads-max is a viable solution here).

Switching to a "__thread *tcg_ctx_ptr" model will help minimize
user-mode/softmmu differences though. The only remaining difference would be
that user-mode would need tb_lock() around tb_gen_code, whereas softmmu
wouldn't, but everything else would be the same.

		E.

[*] Note that in user-mode we use code_gen_buffer defined at compile-time
as a static buffer[].
