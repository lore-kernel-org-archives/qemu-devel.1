Received: from eggs.gnu.org ([209.51.188.92]:48424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ggXtF-0000Ny-Sc
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:36:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ggXtE-0001ZE-Pu
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:36:37 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:39016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ggXtE-0001Ha-IP
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:36:36 -0500
Received: by mail-wr1-x435.google.com with SMTP id t27so1081852wra.6
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 08:36:17 -0800 (PST)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 7 Jan 2019 16:36:05 +0000
Message-ID: <CAJSP0QWPfJWB0pZXRAxMPa1K4g21NnhL97SzY3RLFh306W2EGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Building QEMU for WebAssembly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>, anatoly.trosinenko@gmail.com, Jim Mussared <jim@groklearning.com>

As part of the QEMU micro:bit project we considered how end users will
consume QEMU.  The most convenient option is to run emulation directly
in the user's web browser - where their IDE also lives.

Here are my thoughts after a brief investigation into WebAssembly.
Basically the idea is to compile a subset of QEMU with emscripten
(https://kripken.github.io/emscripten-site/) to produce the
WebAssembly binaries that can run in modern web browsers.

The main challenges?  Emscripten and WebAssembly do not offer a full
POSIX environment, so key pieces of QEMU will not compile.

Multi-threading is not yet available in WebAssembly.  Hopefully this
will change soon because multi-threading and related infrastructure
like atomics are used at the core of several areas in QEMU.

Stack-switching is not supported so QEMU's coroutines won't work.
This mostly affects the block layer, which depends heavily on
coroutines.

Self-modifying code is not really supported.  Runtime code generation
is possible (if you jump back into Javascript) but it doesn't seem
designed for JIT compilers.  This makes TCG difficult.

Unicorn.js (https://alexaltea.github.io/unicorn.js/) takes TCI without
device emulation and builds it with emscripten.  So there's proof this
can work, but the challenge will be getting more QEMU components to
compile to WebAssembly.

I think we could build QEMU for machine types that do not have block
devices and other unsupported I/O devices, but it would require
invasive changes to QEMU.  Right now this project seems too risky and
hacky to do in qemu.git, but I wanted to raise the issue in case
others are interested.

Stefan
