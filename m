Received: from eggs.gnu.org ([2001:4830:134:3::10]:53625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fwgX4-00069h-3d
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 00:32:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fwgX0-0000Bz-Qx
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 00:32:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57422 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fwgX0-0000BL-Fc
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 00:32:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8784687A6F
	for <qemu-devel@nongnu.org>; Mon,  3 Sep 2018 04:32:03 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon,  3 Sep 2018 12:31:42 +0800
Message-Id: <20180903043149.4076-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v7 0/7] monitor: enable OOB by default
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

(this series is based on Markus's monitor-next tree so if patchew
 spits something out with "apply failure" then it's expected)

v7:
- use Markus's commit message for patch "qapi: Drop
  qapi_event_send_FOO()'s Error ** argument" [Markus]
- update commit message for "qapi: remove COMMAND_DROPPED event" since
  QEMU 3.0 is released [Eric/Dave]
- rebase to Markus's monitor-next tree:
  http://repo.or.cz/qemu/armbru.git/shortlog/refs/heads/monitor-next
  the patch "monitor: suspend monitor instead of send CMD_DROP"
  re-written since people prefer to drop need_resume flag so now I
  hand-made it.  Dropped a few patches since not appliable any more.

Please review.  Thanks,

Markus Armbruster (1):
  qapi: Fix build_params() for empty parameter list

Peter Xu (6):
  qapi: Drop qapi_event_send_FOO()'s Error ** argument
  monitor: suspend monitor instead of send CMD_DROP
  qapi: remove COMMAND_DROPPED event
  monitor: remove "x-oob", turn oob on by default
  Revert "tests: Add parameter to qtest_init_without_qmp_handshake"
  tests: add oob functional test for test-qmp-cmds

 block/block-backend.c        |  8 ++---
 block/qcow2.c                |  2 +-
 block/quorum.c               |  4 +--
 block/write-threshold.c      |  3 +-
 blockjob.c                   | 13 ++++----
 cpus.c                       |  8 ++---
 docs/devel/qapi-code-gen.txt |  6 ++--
 docs/interop/qmp-spec.txt    |  5 ++--
 dump.c                       |  3 +-
 hw/acpi/core.c               |  2 +-
 hw/acpi/cpu.c                |  2 +-
 hw/acpi/memory_hotplug.c     |  5 ++--
 hw/char/virtio-console.c     |  3 +-
 hw/core/qdev.c               |  3 +-
 hw/net/virtio-net.c          |  2 +-
 hw/ppc/spapr_rtc.c           |  2 +-
 hw/timer/mc146818rtc.c       |  2 +-
 hw/virtio/virtio-balloon.c   |  3 +-
 hw/watchdog/watchdog.c       | 15 +++++-----
 include/monitor/monitor.h    |  1 -
 include/qapi/qmp-event.h     |  3 +-
 job.c                        |  2 +-
 migration/migration.c        |  4 +--
 migration/ram.c              |  2 +-
 monitor.c                    | 58 ++++++++++++++----------------------
 qapi/misc.json               | 40 -------------------------
 scripts/qapi/common.py       | 10 +++----
 scripts/qapi/events.py       | 23 ++++----------
 scsi/pr-manager-helper.c     |  3 +-
 tests/libqtest.c             | 10 +++----
 tests/libqtest.h             |  4 +--
 tests/qmp-test.c             |  6 ++--
 tests/test-qmp-cmds.c        | 16 ++++++++++
 tests/test-qmp-event.c       | 11 ++++---
 ui/spice-core.c              | 10 +++----
 ui/vnc.c                     |  7 ++---
 vl.c                         | 21 +++++--------
 37 files changed, 120 insertions(+), 202 deletions(-)

-- 
2.17.1
