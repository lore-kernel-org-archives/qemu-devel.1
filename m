Received: from eggs.gnu.org ([2001:4830:134:3::10]:39661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dXKCp-0006mQ-MA
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:33:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dXKCl-0005D0-Ox
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:33:55 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40747)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dXKCl-0005CA-Dc
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:33:51 -0400
Date: Tue, 18 Jul 2017 00:33:50 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170718043350.GA12960@flamenco>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-37-git-send-email-cota@braap.org>
	<9b862388-4b4a-1db6-6161-4cab02ae5051@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b862388-4b4a-1db6-6161-4cab02ae5051@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2 36/45] tcg: dynamically allocate
 optimizer globals + fold into TCGContext
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

On Mon, Jul 17, 2017 at 17:53:33 -1000, Richard Henderson wrote:
> On 07/16/2017 10:04 AM, Emilio G. Cota wrote:
> >Groundwork for supporting multiple TCG contexts.
(snip)
> >  struct TCGContext {
> >      uint8_t *pool_cur, *pool_end;
> >      TCGPool *pool_first, *pool_current, *pool_first_large;
> >@@ -717,6 +725,10 @@ struct TCGContext {
> >      TCGTempSet free_temps[TCG_TYPE_COUNT * 2];
> >      TCGTemp temps[TCG_MAX_TEMPS]; /* globals first, temps after */
> >+    /* optimizer */
> >+    struct tcg_temp_info *opt_temps;
> >+    TCGTempSet opt_temps_used;
> 
> I would prefer either
> 
>   (1) Dynamic allocation.  I know we eschew that most places during,
>       but surely this is the exact situation for which it's handy.
> 
>   (2) Make opt_temps an array of TCG_MAX_TEMPS and drop the pointer.

Originally I implemented (2). But the array is pretty large and
realised that the init ctx doesn't use it at all. So I made
the allocation dynamic, i.e. tcg_optimize will allocate the
array if the ctx doesn't have it yet.

But I guess that's not what you mean with (1)? You mean to allocate
every single time we call tcg_optimize, allocating only the space
we need on each call?

> I think the TCGTempSet should be a local within tcg_optimize.

Will do.

		E.
