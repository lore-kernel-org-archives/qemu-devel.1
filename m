Received: from eggs.gnu.org ([2001:4830:134:3::10]:51406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dXWfj-0007Xa-Lo
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 13:52:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dXWfg-0003bV-Ju
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 13:52:35 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39135)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dXWfg-0003ak-DY
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 13:52:32 -0400
Date: Tue, 18 Jul 2017 13:52:31 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170718175231.GB31298@flamenco>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-46-git-send-email-cota@braap.org>
	<04004f7a-0e84-1b51-bc93-97c70213541d@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04004f7a-0e84-1b51-bc93-97c70213541d@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2 45/45] tcg: enable multiple TCG contexts
 in softmmu
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

On Mon, Jul 17, 2017 at 19:25:14 -1000, Richard Henderson wrote:
> On 07/16/2017 10:04 AM, Emilio G. Cota wrote:
> >+
> >+    /* claim the first free pointer in tcg_ctxs and increment n_tcg_ctxs */
> >+    for (i = 0; i < smp_cpus; i++) {
> >+        if (atomic_cmpxchg(&tcg_ctxs[i], NULL, s) == NULL) {
> >+            unsigned int n;
> >+
> >+            n = atomic_fetch_inc(&n_tcg_ctxs);
> 
> Surely this is too much effort.  The increment on n_tcg_ctxs is sufficient
> to produce an index for assignment.  We never free the contexts...
> 
> Which also suggests that it might be better to avoid an indirection in
> tcg_ctxs and allocate all of the structures in one big block?  I.e.
> 
> TCGContext *tcg_ctxs;
> 
> // At the end of tcg_context_init.
> #ifdef CONFIG_USER_ONLY
>     tcg_ctxs = s;
> #else
>     // No need to zero; we'll completely overwrite each structure
>     // during tcg_register_thread.
>     tcg_ctxs = g_new(TCGContext, smp_cpus);
> #endif

The primary reason is that at this point we don't know yet whether
we'll need smp_cpus contexts or just one context (!mttcg), since
qemu_tcg_mttcg_enabled() is set up after this function is called
(the path is: vl.c -> configure_accelerator() -> tcg_init_context ->
this function; quite a bit later, qemu_tcg_configure() is
called, setting up the bool behind qemu_tcg_mttcg_enabled().)

A secondary reason is to avoid false sharing of cachelines. But
it seems quite unlikely that the last cacheline of TCGContext
will ever be used, so this isn't really an issue.

		E.
