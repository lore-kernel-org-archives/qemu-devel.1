Received: from eggs.gnu.org ([2001:4830:134:3::10]:34526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dZkpD-0006EP-D6
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:23:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dZkpB-0003UJ-Rb
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:23:35 -0400
Date: Mon, 24 Jul 2017 17:23:27 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170724212327.GA24963@flamenco>
References: <DM2PR21MB0060EFC1F6B9F0883A1792369EBB0@DM2PR21MB0060.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM2PR21MB0060EFC1F6B9F0883A1792369EBB0@DM2PR21MB0060.namprd21.prod.outlook.com>
Subject: Re: [Qemu-devel] Torn read/write possible on aarch64/x86-64 MTTCG?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Baumann <Andrew.Baumann@microsoft.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Andrey Shedel <ashedel@microsoft.com>, Richard Henderson <rth@twiddle.net>, Alex =?utf-8?B?QmVubu+/vWU=?= <alex.bennee@linaro.org>, Pranith Kumar <bobby.prani@gmail.com>

(Adding some Cc's)

On Mon, Jul 24, 2017 at 19:05:33 +0000, Andrew Baumann via Qemu-devel wrote:
> Hi all,
>
> I'm trying to track down what appears to be a translation bug in either
> the aarch64 target or x86_64 TCG (in multithreaded mode). The symptoms
> are entirely consistent with a torn read/write -- that is, a 64-bit
> load or store that was translated to two 32-bit loads and stores --
> but that's obviously not what happens in the common path through the
> translation for this code, so I'm wondering: are there any cases in
> which qemu will split a 64-bit memory access into two 32-bit accesses?

That would be a bug in MTTCG.

> The code: Guest CPU A writes a 64-bit value to an aligned memory
> location that was previously 0, using a regular store; e.g.:
>	f9000034 str	     x20,[x1]
>
> Guest CPU B (who is busy-waiting) reads a value from the same location:
>	f9400280 ldr	     x0,[x20]
>
> The symptom: CPU B loads a value that is neither NULL nor the value
> written. Instead, x0 gets only the low 32-bits of the value written
> (high bits are all zero). By the time this value is dereferenced (a
> few instructions later) and the exception handlers run, the memory
> location from which it was loaded has the correct 64-bit value with
> a non-zero upper half.
>
> Obviously on a real ARM memory barriers are critical, and indeed
> the code has such barriers in it, but I'm assuming that any possible
> mistranslation of the barriers is irrelevant because for a 64-bit load
> and a 64-bit store you should get all or nothing. Other clues that may
> be relevant: the code is _near_ a LDREX/STREX pair (the busy-waiting
> is used to resolve a race when updating another variable), and the
> busy-wait loop has a yield instruction in it (although those appear
> to be no-ops with MTTCG).

This might have to do with how ldrex/strex is emulated; are you relying
on the exclusive pair detecting ABA? If so, your code won't work in
QEMU since it uses cmpxchg to emulate ldrex/strex.

> The bug repros more easily with more guest VCPUs, and more load on the
> host (i.e. more context switching to expose the race). It doesn't repro
> for the single-threaded TCG. Unfortunately it's hard to get detailed
> trace information, because the bug only repros roughly every one in 40
> attempts, and it's a long way into the guest OS boot before it arises.
>
> I'm not yet 100% convinced this is a qemu bug -- the obvious path
> through the translator for those instructions does 64-bit memory
> accesses on the host -- but at the same time, it has never been seen
> outside qemu, and after staring long and hard at the guest code, we're
> pretty sure it's correct. It's also extremely unlikely to be a wild
> write, given that it occurs on a wide variety of guest call-stacks,
> and the memory is later inconsistent with what was loaded.
>
> Any clues or debugging suggestions appreciated!

- Pin the QEMU-MTTCG process to a single CPU. Can you repro then?

- Force the emulation of cmpxchg via EXCP_ATOMIC with:

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 87f673e..771effe5 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2856,7 +2856,7 @@ void tcg_gen_atomic_cmpxchg_i64(TCGv_i64 retv, TCGv addr, TCGv_i64 cmpv,
         }
         tcg_temp_free_i64(t1);
     } else if ((memop & MO_SIZE) == MO_64) {
-#ifdef CONFIG_ATOMIC64
+#if 0
         gen_atomic_cx_i64 gen;

         gen = table_cmpxchg[memop & (MO_SIZE | MO_BSWAP)];

This will halt all other vCPUs before the calling vCPU performs
the cmpxchg. Can you reproduce then?

		Emilio
