Received: from eggs.gnu.org ([2001:4830:134:3::10]:40419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKp-0006hz-9i
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjJk-0008Om-OH
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:11 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:33465)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFjJk-0008Nx-Eq
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:08 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 13:20:09 -0400
Message-Id: <20181025172057.20414-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 00/48] Plugin support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>

For those of you who need some context: "plugins" are dynamic
libraries that are loaded at run-time. These plugins can
subscribe to interesting events (e.g. instruction execution)
via an API, to then do something interesting with them. This
functionality is similar to what other instrumentation tools (e.g.
Pin and DynamoRIO) provide, although since QEMU is full-system
we have some additional features.

As an example application, I've been using this plugin implementation
for the last year or so to implement a parallel computer simulator
that uses QEMU as its execution frontend.

The key features of this plugin implementation are:

- Support for an arbitrary number of plugins

- Focus on speed. "Dynamic" callbacks are used for frequent events,
  such as memory callbacks, to call the plugin code directly, i.e.
  without going through an intermediate helper. This provides
  an average 1.33x speedup for SPEC06 over using helpers with a list
  of subscribers, and it becomes more important as more subscribers
  are added. I can share more detailed numbers if you want them.

- Instruction-granularity instrumentation. Getting callbacks
  on *all* TBs/mem accesses/instructions is not flexible. Consider
  a plugin that just wants to get callbacks on the specific memory
  accesses of a set of instructions (e.g. cmpxchg); the API
  must provide a way for the plugin to subscribe to those events
  *only*, instead of giving it all events (e.g. all mem accesses)
  for the plugin to then discard 99.9% of them.

- 2-pass translation. Once a "TB translation" callback is called,
  the plugin must know the span of the TB. We should not
  force plugins to guess where the TB will end; that is strictly
  QEMU's job, and can change any time. A TB is thus a sequence
  of instructions of whatever length the particular QEMU
  implementation decides. Thus, for each TB, a 3-step process
  is followed: (1) the plugin layer keeps a copy of the contents
  of the current TB, (2) once the TB is well-defined, its
  descriptor and contents are passed to plugins, which then
  register their desired instrumentation (e.g. "call me back
  on this particular instruction", or "call me back when
  the whole TB executes"); note that plugins can use a disassembler
  like capstone to decide what to do with each instruction; they
  can also allocate memory and then get a pointer to it passed
  back from the callbacks. And finally, (3) the target translator
  is called again to generate the final instrumented translated TB.
  This is what I called the "2-pass translation", since we go
  twice over the translation loop in translator.c. Note that the
  2-pass approach has virtually no overhead (0.40% for SPEC06int);
  translation is much cheaper than execution. But anyway, if no
  plugins have subscribed to TB translation, we only do one pass.

- Support for inlining instrumentation. This is done via an
  explicit API, i.e. we do not export TCG ops, which are internal
  to QEMU. For now, I just have support for incrementing a u64
  with an immediate, e.g. to increment a counter.

- Treating the plugins as "malicious", in that we don't export
  any pointers to key QEMU data structures (CPUState, TB).
  I implemented this after a comment from Stefan, but maybe it is
  a bit overkill.

- Other features that go beyond passively getting callbacks (I need
  these for the simulator):
  + Control of the virtual clock from plugins
  + CPU lockstep execution, where plugins decide when CPUs must
    synchronize to reduce their execution skew. This can be understood
    as a "parallel icount" mode, although plugins can decide to
    synchronize whenever they want, not whenever a certain amount of
    instructions have execution. For instance, I am using this to
    synchronize CPUs every X number of simulated cycles, thereby
    having the ability to limit skew while maintaining parallelism.
    When a CPU is idle, then we assume its "execution window" (aka
    "time slice") has expired.
  + Guest hooks. Instead of using "magic" instructions, export a
    PCI device and let plugins determine what encoding to follow.
    I'm using this to mark regions of interest in guest programs,
    so that in the simulator I start/stop recording simulation events.

- Things I haven't included here:
  + Ability to emulate devices from plugins. I'm using this to
    simulate peripherals. These are devices whose timing is important
    to overall performance (e.g. 'accelerators' to which the main
    CPU offloads computation, e.g. a JPEG encoder).

The design I'm showing here shares nothing with the tracing infrastructure.
While it is true that some features (e.g. syscall callbacks) are
identical, some others (instruction-granularity instrumentation,
2-pass translation, lockstep execution) are not. So I'm open to
discussing where we could save code (e.g. having a single trace+plugin
generator, e.g. for syscalls), as long as performance and/or the
ability to instrument aren't compromise.

Peter: I remember you asked for an API first. I am including that as
a single patch in patch 14; see also patches 40, 45 and 47.

The first 10 or so patches in the series are preliminary work,
including the support of runtime TCG helpers. I think a subset
of this could be in a proper patch series, particularly the
xxhash patches. Then I've added plugin-related patches, trying
to break this down my original 80-or-so patches into something
a little easier to review. The "core" plugin code is perhaps the last
place to look, because when it is added nothing is calling it yet.
The last patch in the series adds some example plugins just for
discussion's sake.

This series applies on top of my cpu-lock-v4 series. You can fetch
it from:
  https://github.com/cota/qemu/tree/plugin

Cheers,

		Emilio
