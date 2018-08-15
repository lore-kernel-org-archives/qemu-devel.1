Received: from eggs.gnu.org ([2001:4830:134:3::10]:60300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fpw05-0002Mi-Gi
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 09:38:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fpvzp-0002Mm-6o
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 09:38:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50938 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fpvzo-0002Lk-TU
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 09:37:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7F73E4023461
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 13:37:56 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 15 Aug 2018 21:37:34 +0800
Message-Id: <20180815133747.25032-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v6 00/13] monitor: enable OOB by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Hi, Markus, Marc-Andre,

I didn't follow up the latest discussions on the response queue or
monitor changes.  For now this series still makes sense to me, so I'm
just rebasing the series to master and repost (with some additional
changes/patches to address Markus's concerns). Please let me know if
you have made any conclusion that I'm not aware of, or if this work
needs any further rebasing.

v6 (previous version of the series might be incorrect; from this
version, I continued to use the old version counts):
- collect r-bs
- use Markus's version of build_params() [Markus]
- use \' instead of \" in Python codes [Markus]
- in qapi_event_send_*() still pass in &error_abort instead of NULL
  [Markus]
- remove COMMAND_DROPPED from document too
- add missing pieces for test-qmp-cmds [Markus]
- add one patch to remove as much different code path for oob as
  possible [Markus]

TODO:
- flow control test is still missing; I still didn't consider it much,
  also we possibly need to touch up monitor_puts() to use limited
  sized buffer to complete the flow control of QMP channel

Please review.  Thanks,

Markus Armbruster (1):
  qapi: Fix build_params() for empty parameter list

Peter Xu (12):
  monitor: simplify monitor_qmp_setup_handlers_bh
  qapi: remove error checks for event emission
  monitor: move need_resume flag into monitor struct
  monitor: suspend monitor instead of send CMD_DROP
  qapi: remove COMMAND_DROPPED event
  monitor: restrict response queue length too
  monitor: remove "x-oob", turn oob on by default
  Revert "tests: Add parameter to qtest_init_without_qmp_handshake"
  monitor: add traces for qmp queues
  tests: remove "0.15" prefix for test-qmp-cmds
  tests: add oob functional test for test-qmp-cmds
  monitor: reduce different code path for oob

 block/block-backend.c        |   8 +-
 block/qcow2.c                |   2 +-
 block/quorum.c               |   4 +-
 block/write-threshold.c      |   3 +-
 blockjob.c                   |  13 +--
 cpus.c                       |   8 +-
 docs/devel/qapi-code-gen.txt |   6 +-
 docs/interop/qmp-spec.txt    |   5 +-
 dump.c                       |   3 +-
 hw/acpi/core.c               |   2 +-
 hw/acpi/cpu.c                |   2 +-
 hw/acpi/memory_hotplug.c     |   5 +-
 hw/char/virtio-console.c     |   3 +-
 hw/core/qdev.c               |   3 +-
 hw/net/virtio-net.c          |   2 +-
 hw/ppc/spapr_rtc.c           |   2 +-
 hw/timer/mc146818rtc.c       |   2 +-
 hw/virtio/virtio-balloon.c   |   3 +-
 hw/watchdog/watchdog.c       |  15 ++-
 include/monitor/monitor.h    |   1 -
 include/qapi/qmp-event.h     |   3 +-
 job.c                        |   2 +-
 migration/migration.c        |   4 +-
 migration/ram.c              |   2 +-
 monitor.c                    | 194 +++++++++++++++++++----------------
 qapi/misc.json               |  40 --------
 scripts/qapi/common.py       |  10 +-
 scripts/qapi/events.py       |  23 ++---
 scsi/pr-manager-helper.c     |   3 +-
 tests/libqtest.c             |  10 +-
 tests/libqtest.h             |   4 +-
 tests/qmp-test.c             |   6 +-
 tests/test-qmp-cmds.c        |  26 ++++-
 tests/test-qmp-event.c       |  11 +-
 trace-events                 |   4 +
 ui/spice-core.c              |  10 +-
 ui/vnc.c                     |   7 +-
 vl.c                         |  21 ++--
 38 files changed, 210 insertions(+), 262 deletions(-)

-- 
2.17.1
