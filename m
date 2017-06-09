Received: from eggs.gnu.org ([2001:4830:134:3::10]:51680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dJ9cC-0000Y5-55
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 22:25:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dJ9c8-00069U-UQ
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 22:25:32 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:32831)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dJ9c8-00068J-DN
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 22:25:28 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu,  8 Jun 2017 22:25:15 -0400
Message-Id: <1496975122-16999-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 0/7] trace: [tcg] Optimize per-vCPU tracing
 states
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Stefan Hajnoczi <stefanha@redhat.com>

This is my own respin of Lluís' v7:
  https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg02741.html

Changes from v7:

- Ported to current dev tree.

- Allocate cpu->trace_dstate statically. This
  * allows us to drop the event_count inline patch.
  * simplifies and improves the performance of accessing cpu->trace_dstate:
    we just need to dereference, instead of going through bitmap_copy and
    an intermediate unsigned long.

- If we try to register more CPU events than the max we support (there's a constant
  for it), drop the event and tell the user with error_report. But really this
  is a bug, since we control what CPU events are traceable. Should we abort()
  as well?

- Added rth's R-b tag

- Addressed my own comments:
  * rename tb->trace_vcpu_dstate to the shorter tb->trace_ds
  * use uint32_t for tb->trace_ds instead of a typedef
  * add BUILD_BUG_ON check to make sure tb->trace_ds is big enough
  * fix xxhash

- Do not add trace_dstate to tb_htable_lookup, since we can grab it from
  cpu->trace_dstate.

This patchset applies cleanly on top of rth's tcg-next (a01792e1e).

Thanks,

		Emilio

Emilio G. Cota (1):
  cpu: allocate cpu->trace_dstate in place

Lluís Vilanova (6):
  exec: [tcg] Refactor flush of per-CPU virtual TB cache
  trace: [tcg] Delay changes to dynamic state when translating
  exec: [tcg] Use different TBs according to the vCPU's dynamic tracing
    state
  trace: [tcg] Do not generate TCG code to trace dinamically-disabled
    events
  trace: [tcg, trivial] Re-align generated code
  trace: [trivial] Statically enable all guest events

 cpu-exec.c                               |  8 ++++++--
 cputlb.c                                 |  2 +-
 include/exec/exec-all.h                  |  9 +++++++++
 include/exec/tb-hash-xx.h                |  7 +++++--
 include/exec/tb-hash.h                   |  5 +++--
 include/qom/cpu.h                        | 12 ++++++------
 qom/cpu.c                                |  8 --------
 scripts/tracetool/__init__.py            |  3 ++-
 scripts/tracetool/backend/dtrace.py      |  4 ++--
 scripts/tracetool/backend/ftrace.py      | 20 ++++++++++----------
 scripts/tracetool/backend/log.py         | 19 ++++++++++---------
 scripts/tracetool/backend/simple.py      |  4 ++--
 scripts/tracetool/backend/syslog.py      |  6 +++---
 scripts/tracetool/backend/ust.py         |  4 ++--
 scripts/tracetool/format/h.py            | 26 +++++++++++++++++++-------
 scripts/tracetool/format/tcg_h.py        | 21 +++++++++++++++++----
 scripts/tracetool/format/tcg_helper_c.py |  5 +++--
 tcg-runtime.c                            |  3 ++-
 tests/qht-bench.c                        |  2 +-
 trace-events                             |  6 +++---
 trace/control-target.c                   | 22 +++++++++++++++++++---
 trace/control.c                          |  9 ++++++++-
 trace/control.h                          |  3 +++
 translate-all.c                          | 25 ++++++++++++++++++-------
 24 files changed, 154 insertions(+), 79 deletions(-)

-- 
2.7.4
