Received: from eggs.gnu.org ([2001:4830:134:3::10]:56674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SM5-0006XM-AM
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SLz-00065T-FU
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:28 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:41147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g8SLs-0005zF-9v
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:19 -0400
Received: by mail-wr1-x433.google.com with SMTP id x12-v6so14040562wru.8
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 08:49:13 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  5 Oct 2018 16:48:49 +0100
Message-Id: <20181005154910.3099-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH  00/21] Trace updates and plugin RFC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel.Dovgaluk@ispras.ru, vilanova@ac.upc.edu, cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

This series is a combination of general clean-ups to logging and
tracing and a RFC for extending the tracepoint API by the addition of
plugins. An example usage would be:

  ./aarch64-linux-user/qemu-aarch64 -d plugin,nochain -plugin file=trace/plugins/hotblocks.so,args=5 ./aarch64-linux-user/tests/sha1
  SHA1=15dd99a1991e0b3826fede3deffc1feba42278e6
  trace/plugins/hotblocks.so: collected 858d entries in the hash table
    pc: 0x00000000400260 (64004 hits) 4257 ns between returns
    pc: 0x00000000419280 (64004 hits) 4256 ns between returns
    pc: 0x00000000419290 (64003 hits) 4063 ns between returns
    pc: 0x000000004192d4 (64002 hits) 4063 ns between returns
    pc: 0x000000004192f0 (64002 hits) 4062 ns between returns

After reviewing Pavel's series I wondered if we could re-use the
trace-point API as potential hooks for a plugin API. Trace points
already exist as a series of interesting places in QEMU exposing
information that can be used for analysis. By re-using them we avoid
potential duplication of concerns. Adding new hook points becomes a
simple case of adding a new trace point.

This also allows us to simplify some of the facilities provided to the
plugins. I currently envision two types of plugin:

  Filter plugins

  These are plugins that sit at a trace point and return true/false to
  the trace code. This would short-circuit the trace from continuing,
  essentially filtering out unwanted information. The final data is still
  exported the usual way using trace APIs many output modes.

  Analysis plugins

  These are plugins that aggregate data in real-time to provide some
  sort of analysis as they go. They may or may not pass on the trace
  events to the other trace sub-systems. The example hotblocks plugin
  is such and example.

While the first set up plugins can re-use the existing trace
infrastructure to output information the second type needs a
reporting mechanism. As a result I have added a plugin_status()
function which can either report on the monitor or in linux-user be
called on program exit. In both cases the function simply returns a
string and leaves the details of where it gets output to QEMU itself.

=Further Work=

==Known Limitations==

Currently there is only one hook allowed per trace event. We could
make this more flexible or simply just error out if two plugins try
and hook to the same point. What are the expectations of running
multiple plugins hooking into the same point in QEMU?

==TCG Hooks==

Thanks to Lluís' work the trace API already splits up TCG events into
translation time and exec time events and provides the machinery for
hooking a trace helper into the translation stream. Currently that
helper is unconditionally added although perhaps we could expand the
call convention a little for TCG events to allow the translation time
event to filter out planting the execution time helper?

Any serious analysis tool should allow for us to track all memory
accesses so I think the guest_mem_before trace point should probably
be split into guest_mem_before_store and guest_mem_after_load. We
could go the whole hog and add potential trace points for start/end of
all memory operations.

I did start down this road but the code quickly got ugly when dealing
with our macrofied access functions. I plan to fish out the
de-macrofication of softmmu series I posted earlier this year:

  https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg03403.html

And see if that can be applied to all our access functions.

===Instruction Tracing===

Pavel's series had a specific hook for instrumenting individual
instructions. I have not yet added it to this series but I think it be
done in a slightly cleaner way now we have the ability to insert TCG
ops into the instruction stream. If we add a tracepoint for post
instruction generation which passes a buffer with the instruction
translated and method to insert a helper before or after the
instruction. This would avoid exposing the cpu_ldst macros to the
plugins.

So what do people think? Could this be a viable way to extend QEMU
with plugins?

Alex.


Aaron Lindsay (1):
  trace: add linux-user plugin support

Alex Bennée (19):
  util/log: allow -dfilter to stack
  util/log: add qemu_dfilter_append_range()
  linux-user: add -dfilter progtext shortcut
  trace: enable the exec_tb trace events
  trace: keep a count of trace-point hits
  trace: show trace point counts in the monitor
  accel/tcg/cputlb: convert tlb_flush debugging into trace events
  accel/tcg/cputlb: convert remaining tlb_debug() to trace events
  trace: suppress log output of trace points
  qom/cpu: add a cpu_exit trace event
  trace: expose a plugin fn pointer in TraceEvent
  configure: expose a plugin to the trace-backends
  tracetool: generate plugin snippets
  trace: add infrastructure for building plugins
  hmp: expose status of plugins to the monitor
  linux-user: allow dumping of plugin status at end of run
  plugins: add an example hotblocks plugin
  plugins: add hotness summary to hotblocks
  plugin: add tlbflush stats plugin

Pavel Dovgalyuk (1):
  trace: add support for plugin infrastructure

 Makefile                            |   5 +-
 accel/tcg/cputlb.c                  |  99 +++++-----
 accel/tcg/trace-events              |  30 ++-
 configure                           |   6 +
 hmp-commands-info.hx                |  17 ++
 include/plugins/plugins.h           |  14 ++
 include/qemu/log.h                  |   2 +
 include/qemu/plugins.h              |  19 ++
 linux-user/exit.c                   |  12 ++
 linux-user/main.c                   |  31 ++-
 monitor.c                           |  19 +-
 qapi/trace.json                     |   3 +-
 qemu-options.hx                     |  10 +
 qom/cpu.c                           |   3 +
 qom/trace-events                    |   4 +
 scripts/tracetool/backend/plugin.py |  79 ++++++++
 scripts/tracetool/backend/simple.py |   2 +
 tests/test-logging.c                |  14 ++
 trace/Makefile.objs                 |  25 +++
 trace/control-internal.h            |   6 +
 trace/event-internal.h              |   4 +
 trace/plugins.c                     | 154 +++++++++++++++
 trace/plugins/Makefile.plugins      |  32 ++++
 trace/plugins/hotblocks/hotblocks.c | 100 ++++++++++
 trace/plugins/tlbflush/tlbflush.c   | 283 ++++++++++++++++++++++++++++
 trace/qmp.c                         |   1 +
 util/log.c                          |  34 +++-
 vl.c                                |  26 ++-
 28 files changed, 962 insertions(+), 72 deletions(-)
 create mode 100644 include/plugins/plugins.h
 create mode 100644 include/qemu/plugins.h
 create mode 100644 scripts/tracetool/backend/plugin.py
 create mode 100644 trace/plugins.c
 create mode 100644 trace/plugins/Makefile.plugins
 create mode 100644 trace/plugins/hotblocks/hotblocks.c
 create mode 100644 trace/plugins/tlbflush/tlbflush.c

-- 
2.17.1
