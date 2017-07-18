Received: from eggs.gnu.org ([2001:4830:134:3::10]:59959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dXGLy-0006HB-4E
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:27:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dXGLu-0001SV-3a
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:27:06 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42905)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dXGLt-0001S9-Ss
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:27:02 -0400
Date: Mon, 17 Jul 2017 20:27:00 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170718002700.GA7414@flamenco>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-11-git-send-email-cota@braap.org>
	<92056605-c95b-b19b-0216-5d83be64e13d@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92056605-c95b-b19b-0216-5d83be64e13d@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2 10/45] translate-all: guarantee that
 tb_hash only holds valid TBs
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

On Mon, Jul 17, 2017 at 12:55:03 -1000, Richard Henderson wrote:
> On 07/16/2017 10:03 AM, Emilio G. Cota wrote:
> >@@ -1073,13 +1073,17 @@ void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr)
> >      assert_tb_locked();
> >-    atomic_set(&tb->invalid, true);
> >-
> >      /* remove the TB from the hash list */
> >      phys_pc = tb->page_addr[0] + (tb->pc & ~TARGET_PAGE_MASK);
> >      h = tb_hash_func(phys_pc, tb->pc, tb->flags, tb->trace_vcpu_dstate);
> >      qht_remove(&tcg_ctx.tb_ctx.htable, tb, h);
> >+    /*
> >+     * Mark the TB as invalid *after* it's been removed from tb_hash, which
> >+     * eliminates the need to check this bit on lookups.
> >+     */
> >+    tb->invalid = true;
> 
> I believe you need atomic_store_release here.  Previously we were relying on
> the lock acquisition in qht_remove to provide the required memory barrier.
> 
> We definitely need to make sure this reaches memory before we zap the TB in
> the CPU_FOREACH loop.

After this patch tb->invalid is only read/set with tb_lock held, so no need for
atomics while accessing it.

		E.
