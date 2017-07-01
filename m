Received: from eggs.gnu.org ([2001:4830:134:3::10]:41237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dR7c6-00042e-L7
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 21:54:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dR7c3-0007Mq-IU
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 21:54:22 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57399)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dR7c3-0007Lq-D8
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 21:54:19 -0400
Date: Fri, 30 Jun 2017 21:54:17 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170701015417.GA1320@flamenco>
References: <1498768109-4092-1-git-send-email-cota@braap.org>
	<1498768109-4092-7-git-send-email-cota@braap.org>
	<736ed9fa-219f-64e0-70ba-9e5ef1b63b14@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <736ed9fa-219f-64e0-70ba-9e5ef1b63b14@twiddle.net>
Subject: Re: [Qemu-devel] [RFC 6/7] [XXX] tcg: make TCGContext thread-local
 for softmmu
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

On Fri, Jun 30, 2017 at 01:18:58 -0700, Richard Henderson wrote:
> On 06/29/2017 01:28 PM, Emilio G. Cota wrote:
> >This will allow us to generate TCG code in parallel.
> >
> >User-mode is kept out of this: contention due to concurrent translation
> >is more commonly found in full-system mode (e.g. booting a many-core guest).
> >
> >XXX: For now, only convert arm/a64, since these are the only guests that
> >have proper MTTCG support.
> 
> Not true.  TCG_GUEST_DEFAULT_MO suggests we have 4.

Yes, sorry that was outdated. I'm testing arm/a64 because I can boot
many cores on a64.

> >XXX: This is calling prologue_init once per vCPU, i.e. each TCGContext
> >      gets a different prologue/epilogue (all of them with the same
> >      contents though). Far from ideal, but for an experiment it
> >      "should" work, right?
> 
> Um... sure.  But surely there's a better way.  Perhaps copying the main
> thread's tcg_ctx?  That'd be after prologue, and target globals are created.
> That would avoid the need to make all the target cpu_* globals be
> thread-local, for instance.
> 
> Of course, now that I think of it, this implies that my tcg patches to use
> pointers instead of indicies is not the Way Forward...

Didn't consider this, but after looking at the code (sans your patchset)
I don't see why this wouldn't work -- would be great to avoid touching
target code, as you point out below.

> >  /* Share the TCG temporaries common between 32 and 64 bit modes.  */
> >-extern TCGv_env cpu_env;
> >-extern TCGv_i32 cpu_NF, cpu_ZF, cpu_CF, cpu_VF;
> >-extern TCGv_i64 cpu_exclusive_addr;
> >-extern TCGv_i64 cpu_exclusive_val;
> >+extern TCG_THREAD TCGv_env cpu_env;
> >+extern TCG_THREAD TCGv_i32 cpu_NF, cpu_ZF, cpu_CF, cpu_VF;
> >+extern TCG_THREAD TCGv_i64 cpu_exclusive_addr;
> >+extern TCG_THREAD TCGv_i64 cpu_exclusive_val;
> 
> It would be Really Good if we could avoid this in the end.
> I see that it's the quickest way to test for now though.
> 
> >@@ -887,7 +893,7 @@ typedef struct TCGOpDef {
> >  #endif
> >  } TCGOpDef;
> >-extern TCGOpDef tcg_op_defs[];
> >+extern TCG_THREAD TCGOpDef tcg_op_defs[];
> 
> Why?  It's constant after startup.

I was just going for a mass conversion first to see whether this
could ever work. Will refine it.

Thanks,

		E.
