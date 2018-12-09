Received: from eggs.gnu.org ([2001:4830:134:3::10]:33230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gW4u0-0000Oh-Lm
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gW4tv-0004wQ-Ua
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:08 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:46521)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gW4tv-0004rP-Gu
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:03 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun,  9 Dec 2018 14:37:11 -0500
Message-Id: <20181209193749.12277-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v2 00/38] Plugin support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

v1: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg05682.html

Changes since v1:

- Drop the 2-pass translation. Instead, empty instrumentation
  is injected during translation. If it turns out that this
  empty instrumentation is not needed, it is removed from
  the output. For this, add 2 TCG ops that mark the beginning
  and end of this empty instrumentation.

  This is cleaner than 2-pass translation, although it
  ends up being quite a bit more code, since we have
  to copy backend TCG ops, which is tedious. Performance-wise,
  it is at worst ~9% slower (~1.3% avg) than 2-pass for SPEC06int:

    https://imgur.com/a/bUNox3H

  This is for an "empty" plugin (also added to tests/plugin/empty.c).
  That is, it subscribes to TB translation events and does nothing
  with them (i.e. no execution-time subscriptions).
  This means the empty instrumentation has to be injected and then
  removed, which is the worst-case scenario since all the injection
  work is wasted.

- Add QTAILQ_REMOVE_SEVERAL, which helps speed up the removal
  of empty instrumentation.

- Drop the "TCG runtime helper" support. We do not need it
  for empty instrumentation; we just replace the function pointer
  in the copied "call" op directly.
  + To detect when an instruction uses helpers, just strncmp
  the helper's name against "plugin_".

- Drop tb->plugin_mask. Instead, read cpu->plugin_mask from
  translator_loop.

- Drop the xxhash patches, since I submitted those as a separate
  series.

- Move a lot of plugin-related code from translator.c to
  plugin-gen.c, leaving only a few function calls in translator.c.

- Add support for only subscribing to an instruction's reads or
  writes. This is implemented via a flag added to the memory
  registration functions of the public API.

- Disentangle callbacks into separate arrays. Instead of just
  having 3 arrays (tb, insn and mem callbacks), have 5 arrays
  (tb, insn, virt. mem, hostaddr mem) of 2 arrays each (udata_cb
  and inline). This takes a bit more space per TB, but note that
  this struct is allocated only once in each TCGContext. OTOH,
  it makes the code much simpler. The union in struct dyn_cb
  remains, since for instrumenting memory accesses from helpers
  we still coalesce all types of memory callbacks into a single
  array.

- Add get_page_addr_code_hostp to get the host address of code
  from common code. Use this to export the host address of
  instructions (qemu_plugin_insn_haddr() added to the public API).

- Define TCGMemOp MO_HADDR. If set, the TCG backend copies on
  a TLB hit the corresponding host address to env->hostaddr.
  This allows us to only do this copy when needed.

- Use helpers for reading and setting env->hostaddr, so that
  we minimize the use of #ifdef CONFIG_PLUGIN.

- Only define env->hostaddr if CONFIG_PLUGIN.

- Drop the trailing 'S' in CONFIG_PLUGINS: it is now CONFIG_PLUGIN.

- Drop a few optional features from the RFC:
  + lockstep execution
  + plugin-chan + guest hooks
  + virtual clock control

- Define translator_ld* helpers and use them, as suggested
  by Alex and rth. All target ISAs that use translator_loop
  have been converted, except s390x and mips.

- Do not bloat TCGContext if !CONFIG_PLUGIN.

- Define TCGContext.plugin_tb as a pointer, instead of the
  whole struct.

- Test on 32-bit and 64-bit hosts (i386, x86_64, ppc64, aarch64).

- Add cpu_in_exclusive_work_context() and use it in tb_flush(),
  as suggested by Alex.

- configure fixes, including MacOSX builds thanks to Roman's help.

- Remove macros in atomic_template.h, as suggested by Alex.
  Turns out they aren't needed, inlines are enough.

- Fixed a bug by which cpu->plugin_mem was not being cleared
  if the instruction that used helpers was the last one in
  a TB (e.g. an exception). Fix it by adding checks (1) when
  returning from longjmp, and (2) when finishing a TB from
  tcg, so that we're sure to leave cpu->plugin_mem
  in a good state. (I noticed the bug by uninstalling a plugin
  that had registered memory callbacks, which resulted in
  callbacks to the uninstalled [dlclose'd] plugin.)

- Make sure tcg_ctx->plugin_mem_cb is always NULL after finishing
  the translation of a TB. This fixes a bug on uninstall.

- Do not abort when qemu_plugin_uninstall is called more than
  once. This is actually quite common, so just silently return
  on subsequent calls to uninstall.

- Drop the "qemu"/QEMU from some overly long function/macro
  names. This applies to qemu-internal files, of course.

- Keep the plugin's argument array in memory until the plugin
  is uninstalled, so that plugins don't have to strdup their
  arguments.

- Drop nargs argument from tcg_op_insert_before/after; it's
  unused.

- Rename plugin-api.h to qemu-plugin.h, which is the same name
  it gets in the final destination (after `make install').

- Add insn_inline function to the API.

- Add some sample plugins to tests/plugin.

You can fetch this series from:
  https://github.com/cota/qemu/tree/plugin-v2

Thanks,

		Emilio
---
 .gitignore                                |    2 +
 Makefile                                  |    8 +-
 Makefile.target                           |   18 +
 accel/tcg/Makefile.objs                   |    1 +
 accel/tcg/atomic_template.h               |  117 +++-
 accel/tcg/cpu-exec.c                      |    2 +
 accel/tcg/cputlb.c                        |   23 +-
 accel/tcg/plugin-gen.c                    | 1085 +++++++++++++++++++++++++++++
 accel/tcg/plugin-helpers.h                |    6 +
 accel/tcg/softmmu_template.h              |   43 +-
 accel/tcg/translate-all.c                 |   15 +-
 accel/tcg/translator.c                    |   16 +
 bsd-user/syscall.c                        |   12 +
 configure                                 |   86 ++-
 cpus-common.c                             |    2 +
 cpus.c                                    |   10 +
 exec.c                                    |    2 +
 include/exec/cpu-defs.h                   |    9 +
 include/exec/cpu_ldst.h                   |    9 +
 include/exec/cpu_ldst_template.h          |   43 +-
 include/exec/cpu_ldst_useronly_template.h |   42 +-
 include/exec/exec-all.h                   |   13 +
 include/exec/helper-gen.h                 |    1 +
 include/exec/helper-proto.h               |    1 +
 include/exec/helper-tcg.h                 |    1 +
 include/exec/plugin-gen.h                 |   75 ++
 include/exec/translator.h                 |   28 +
 include/qemu/plugin.h                     |  253 +++++++
 include/qemu/qemu-plugin.h                |  241 +++++++
 include/qemu/queue.h                      |   10 +
 include/qom/cpu.h                         |   19 +
 linux-user/exit.c                         |    1 +
 linux-user/main.c                         |   18 +
 linux-user/syscall.c                      |    3 +
 plugin.c                                  | 1030 +++++++++++++++++++++++++++
 qemu-options.hx                           |   17 +
 qemu-plugins.symbols                      |   34 +
 qom/cpu.c                                 |    2 +
 target/alpha/translate.c                  |    2 +-
 target/arm/translate-a64.c                |    2 +
 target/arm/translate.c                    |    8 +-
 target/hppa/translate.c                   |    2 +-
 target/i386/translate.c                   |   10 +-
 target/m68k/translate.c                   |    2 +-
 target/openrisc/translate.c               |    2 +-
 target/ppc/translate.c                    |    8 +-
 target/riscv/translate.c                  |    2 +-
 target/sh4/translate.c                    |    2 +-
 target/sparc/translate.c                  |    2 +-
 target/xtensa/translate.c                 |    4 +-
 tcg/README                                |    2 +-
 tcg/i386/tcg-target.inc.c                 |    7 +
 tcg/optimize.c                            |    4 +-
 tcg/tcg-op.c                              |   44 +-
 tcg/tcg-op.h                              |   16 +
 tcg/tcg-opc.h                             |    3 +
 tcg/tcg.c                                 |   27 +-
 tcg/tcg.h                                 |   32 +-
 tests/plugin/Makefile                     |   28 +
 tests/plugin/bb.c                         |   66 ++
 tests/plugin/empty.c                      |   30 +
 tests/plugin/insn.c                       |   63 ++
 tests/plugin/mem.c                        |   93 +++
 trace-events                              |    2 +-
 vl.c                                      |   11 +
 65 files changed, 3653 insertions(+), 119 deletions(-)
