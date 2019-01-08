Received: from eggs.gnu.org ([209.51.188.92]:47889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ggrXE-00068s-RG
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 08:35:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ggrXD-0007WI-HH
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 08:35:12 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:45026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ggrXD-0007B2-8G
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 08:35:11 -0500
Received: by mail-wr1-x42f.google.com with SMTP id z5so4031800wrt.11
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 05:35:07 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QWPfJWB0pZXRAxMPa1K4g21NnhL97SzY3RLFh306W2EGg@mail.gmail.com>
	<CAE5jQCfLLRyT5fZ24jbFw52wa2d2kfi7B_47cq_sgB=O0=4prA@mail.gmail.com>
In-Reply-To: <CAE5jQCfLLRyT5fZ24jbFw52wa2d2kfi7B_47cq_sgB=O0=4prA@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 8 Jan 2019 13:34:54 +0000
Message-ID: <CAJSP0QUTMsB4RfH6v3MeR7P_1bFDVecMeht049QOWLs-LZFzkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Building QEMU for WebAssembly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Jim Mussared <jim@groklearning.com>

On Mon, Jan 7, 2019 at 5:07 PM Anatoly Trosinenko
<anatoly.trosinenko@gmail.com> wrote:
> > Multi-threading is not yet available in WebAssembly.  Hopefully this
> > will change soon because multi-threading and related infrastructure
> > like atomics are used at the core of several areas in QEMU.
>
> Technically, I have managed to serialize the QEMU code to the extent
> that it was successfully running QEMU (v2.4.1 IIRC) with some
> glitches.

Cool :).  Great to hear that you've been looking into this.

> It would be great to have some stub extension points upstreamed, such
> as converting
>
> void *thread_entry_function(void *) {
>     // some initialization
>     while (true) {
>         // do some work
>     }
> }
>
> into separate initialization, work and glue functions, so it would
> behave as previously in the upstream QEMU, but can be textually
> patched by merely fully removing only the **glue** function (or even
> just its invocation) and writing "serializing" somewhere else (but
> that's another story). I am not sure, though, it will not introduce
> any performance issues at all, so it may be worth manually reapplying
> this patch once a year when merging with upstream.

QEMU has relied more and more on multi-threading over time (it's only
natural so we can take advantage of multi-core hosts!).  My hope was
that multi-threaded WebAssembly would land in major browsers soon and
that empscripten would offer pthreads-like APIs.

> > Stack-switching is not supported so QEMU's coroutines won't work.
> > This mostly affects the block layer, which depends heavily on
> > coroutines.
>
> Emscripten has its own coroutines: the old approach was to instrument
> affected code paths so they can be restarted from the middle
> (Asyncify, it generates huge code and is now unsupported) and the new
> one -- Emterpretify, it generates bytecode instead of the affected
> code and runs it in its own interpreter but, after all, what you want
> from hard disk emulated in a browser. ;)

Interesting, I didn't know about that!

> > Self-modifying code is not really supported.  Runtime code generation
> > is possible (if you jump back into Javascript) but it doesn't seem
> > designed for JIT compilers.  This makes TCG difficult.
>
> I had implemented a proof-of-concept TCI-to-Asm.JS JIT that was run
> after several executions of particular Translation Block.
>
> All of the above can be tried here:
> https://atrosinenko.github.io/qemujs-demo/ -- it is an old demo using
> Asm.JS and QEMU 2.4.1.
>
> Now I am completely rewriting this port to make proper implementation
> of WebAssembly backend:
> repo: https://github.com/atrosinenko/qemujs/tree/qemujs-v2
> discussion: https://github.com/WebAssembly/binaryen/issues/1494
>
> The main issues I have faced so far is to properly select functions
> for Emterpretifying and linking the TBs compiled to WASM in the
> efficient way -- both these issues are on the Emscripten side.
>
> Another my concern is the scale of software that can be run inside
> this emulator. When run with -accel tcg, QEMU runs many times slower
> than when run in the KVM mode on Linux. Hardly we can outperform
> native TCG mode in browser on the same hardware (**technically** the
> WASM engine itself can perform some very aggressive optimizations, but
> this looks like some very optimistic assumption).

Yes, performance will be poor.  It would be neat if hardware
virtualization APIs (e.g. KVM) were made available to the WebAssembly
world now that all major OSes (Linux, Windows, Mac) have standard APIs
(KVM, WHPX, Hypervisor.framework).  But it would probably require a
lot of muscle from influential organizations to get that accepted into
the web standards ;-).

Stefan
