Received: from eggs.gnu.org ([2001:4830:134:3::10]:48029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dUiYt-0006Xn-M3
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 19:57:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dUiYq-0008GB-LR
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 19:57:55 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:56251)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dUiYq-0008Fz-DG
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 19:57:52 -0400
Date: Mon, 10 Jul 2017 19:57:51 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170710235751.GA16131@flamenco>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-10-git-send-email-cota@braap.org>
	<cb152594-248b-85fb-180a-fb83eecf4998@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb152594-248b-85fb-180a-fb83eecf4998@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 09/22] exec-all: shrink tb->invalid to
 uint8_t
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

On Sun, Jul 09, 2017 at 10:11:21 -1000, Richard Henderson wrote:
> On 07/08/2017 09:50 PM, Emilio G. Cota wrote:
> >To avoid wasting a byte. I don't have any use in mind for this byte,
> >but I think it's good to leave this byte explicitly free for future use.
> >See this discussion for how the u16 came to be:
> >   https://lists.gnu.org/archive/html/qemu-devel/2016-07/msg04564.html
> >We could use a bool but in some systems that would take > 1 byte.
> >
> >Signed-off-by: Emilio G. Cota<cota@braap.org>
> >---
> >  include/exec/exec-all.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> What I would prefer to do is generalize tb->cflags.  Those values *do*
> affect how we compile the TB, and yet we don't take them into account.  So I
> think it would be a good idea to feed that into the TB hash.

I'm having trouble seeing how this could work.
Where do we get the "current" values from the current state, i.e.
the ones we need to generate the hash and perform comparisons?
In particular:
- CF_COUNT_MASK: just use CF_COUNT_MASK?
- CF_LAST_IO: ?
- CF_NOCACHE: always 0 I guess
- CF_USE/IGNORE_ICOUNT: ?

Or should we just mask these out for hashing/cmp purposes?

> At present we use 18 bits of the uint32_t.  That leaves plenty of room for:
> 
> * the compile-time value of parallel_cpus, so we don't have to keep flushing
> the TBs that we create for cpu_exec_step_atomic.

This makes sense, yes.

> * invalid, which no TB within the hashtable would have set.

Agreed.

		E.
