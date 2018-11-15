Received: from eggs.gnu.org ([2001:4830:134:3::10]:46805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gNMhU-0007wA-C0
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 13:49:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gNMhR-0005xQ-2L
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 13:49:12 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:36541)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gNMhI-0005D2-PG
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 13:49:04 -0500
Date: Thu, 15 Nov 2018 13:48:27 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181115184827.GA12024@flamenco>
References: <20181112214503.22941-1-richard.henderson@linaro.org>
	<20181114010014.GA19024@flamenco>
	<d15fa143-ab52-3de9-29f0-ff794cec6ac3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d15fa143-ab52-3de9-29f0-ff794cec6ac3@linaro.org>
Subject: Re: [Qemu-devel] [PATCH for-4.0 00/17] tcg: Move softmmu out-of-line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org

On Thu, Nov 15, 2018 at 12:32:00 +0100, Richard Henderson wrote:
> On 11/14/18 2:00 AM, Emilio G. Cota wrote:
> > The following might be related: I'm seeing segfaults with -smp 8
> > and beyond when doing bootup+shutdown of an aarch64 guest on
> > an x86-64 host.
> 
> I'm not seeing that.  Anything else special on the command-line?
> Are the segv in the code_gen_buffer or elsewhere?

I just spent some time on this. I've noticed two issues:

- All TCG contexts end up using the same hash table, since
  we only allocate one table in tcg_context_init. This leads
  to memory corruption.
  This fixes it (confirmed that there aren't races with helgrind):

--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -763,6 +763,14 @@ void tcg_register_thread(void)
     err = tcg_region_initial_alloc__locked(tcg_ctx);
     g_assert(!err);
     qemu_mutex_unlock(&region.lock);
+
+#ifdef TCG_TARGET_NEED_LDST_OOL_LABELS
+    /* if n == 0, keep the hash table we allocated in tcg_context_init */
+    if (n) {
+        /* Both key and value are raw pointers.  */
+        s->ldst_ool_thunks = g_hash_table_new(NULL, NULL);
+    }
+#endif
 }
 #endif /* !CONFIG_USER_ONLY */

- Segfault in code_gen_buffer. This one I don't have a fix for,
  but it's *much* easier to reproduce when -tb-size is very small,
  e.g. "-tb-size 5 -smp 2" (BTW it crashes with x86_64 guests too.)
  So at first I thought the code cache flushing was the problem,
  but I don't see how that could be, at least from a TCGContext
  viewpoint -- I agree that clearing the hash table in
  tcg_region_assign is a good place to do so.

Thanks,

		Emilio
