Received: from eggs.gnu.org ([209.51.188.92]:60258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anatoly.trosinenko@gmail.com>) id 1ggYMw-0007n2-12
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 12:07:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anatoly.trosinenko@gmail.com>) id 1ggYMu-0005Rk-S8
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 12:07:18 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136]:40591)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anatoly.trosinenko@gmail.com>)
	id 1ggYMu-0005JT-C6
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 12:07:16 -0500
Received: by mail-lf1-x136.google.com with SMTP id v5so823387lfe.7
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 09:07:13 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QWPfJWB0pZXRAxMPa1K4g21NnhL97SzY3RLFh306W2EGg@mail.gmail.com>
In-Reply-To: <CAJSP0QWPfJWB0pZXRAxMPa1K4g21NnhL97SzY3RLFh306W2EGg@mail.gmail.com>
From: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Date: Mon, 7 Jan 2019 20:07:01 +0300
Message-ID: <CAE5jQCfLLRyT5fZ24jbFw52wa2d2kfi7B_47cq_sgB=O0=4prA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Building QEMU for WebAssembly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Jim Mussared <jim@groklearning.com>

Hello, Stefan,

> Multi-threading is not yet available in WebAssembly.  Hopefully this
> will change soon because multi-threading and related infrastructure
> like atomics are used at the core of several areas in QEMU.

Technically, I have managed to serialize the QEMU code to the extent
that it was successfully running QEMU (v2.4.1 IIRC) with some
glitches.

It would be great to have some stub extension points upstreamed, such
as converting

void *thread_entry_function(void *) {
    // some initialization
    while (true) {
        // do some work
    }
}

into separate initialization, work and glue functions, so it would
behave as previously in the upstream QEMU, but can be textually
patched by merely fully removing only the **glue** function (or even
just its invocation) and writing "serializing" somewhere else (but
that's another story). I am not sure, though, it will not introduce
any performance issues at all, so it may be worth manually reapplying
this patch once a year when merging with upstream.

> Stack-switching is not supported so QEMU's coroutines won't work.
> This mostly affects the block layer, which depends heavily on
> coroutines.

Emscripten has its own coroutines: the old approach was to instrument
affected code paths so they can be restarted from the middle
(Asyncify, it generates huge code and is now unsupported) and the new
one -- Emterpretify, it generates bytecode instead of the affected
code and runs it in its own interpreter but, after all, what you want
from hard disk emulated in a browser. ;)

> Self-modifying code is not really supported.  Runtime code generation
> is possible (if you jump back into Javascript) but it doesn't seem
> designed for JIT compilers.  This makes TCG difficult.

I had implemented a proof-of-concept TCI-to-Asm.JS JIT that was run
after several executions of particular Translation Block.

All of the above can be tried here:
https://atrosinenko.github.io/qemujs-demo/ -- it is an old demo using
Asm.JS and QEMU 2.4.1.

Now I am completely rewriting this port to make proper implementation
of WebAssembly backend:
repo: https://github.com/atrosinenko/qemujs/tree/qemujs-v2
discussion: https://github.com/WebAssembly/binaryen/issues/1494

The main issues I have faced so far is to properly select functions
for Emterpretifying and linking the TBs compiled to WASM in the
efficient way -- both these issues are on the Emscripten side.

Another my concern is the scale of software that can be run inside
this emulator. When run with -accel tcg, QEMU runs many times slower
than when run in the KVM mode on Linux. Hardly we can outperform
native TCG mode in browser on the same hardware (**technically** the
WASM engine itself can perform some very aggressive optimizations, but
this looks like some very optimistic assumption).

Best regards
Anatoly

=D0=BF=D0=BD, 7 =D1=8F=D0=BD=D0=B2. 2019 =D0=B3. =D0=B2 19:36, Stefan Hajno=
czi <stefanha@gmail.com>:
>
> As part of the QEMU micro:bit project we considered how end users will
> consume QEMU.  The most convenient option is to run emulation directly
> in the user's web browser - where their IDE also lives.
>
> Here are my thoughts after a brief investigation into WebAssembly.
> Basically the idea is to compile a subset of QEMU with emscripten
> (https://kripken.github.io/emscripten-site/) to produce the
> WebAssembly binaries that can run in modern web browsers.
>
> The main challenges?  Emscripten and WebAssembly do not offer a full
> POSIX environment, so key pieces of QEMU will not compile.
>
> Multi-threading is not yet available in WebAssembly.  Hopefully this
> will change soon because multi-threading and related infrastructure
> like atomics are used at the core of several areas in QEMU.
>
> Stack-switching is not supported so QEMU's coroutines won't work.
> This mostly affects the block layer, which depends heavily on
> coroutines.
>
> Self-modifying code is not really supported.  Runtime code generation
> is possible (if you jump back into Javascript) but it doesn't seem
> designed for JIT compilers.  This makes TCG difficult.
>
> Unicorn.js (https://alexaltea.github.io/unicorn.js/) takes TCI without
> device emulation and builds it with emscripten.  So there's proof this
> can work, but the challenge will be getting more QEMU components to
> compile to WebAssembly.
>
> I think we could build QEMU for machine types that do not have block
> devices and other unsupported I/O devices, but it would require
> invasive changes to QEMU.  Right now this project seems too risky and
> hacky to do in qemu.git, but I wanted to raise the issue in case
> others are interested.
>
> Stefan
