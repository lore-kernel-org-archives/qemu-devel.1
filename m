Received: from eggs.gnu.org ([2001:4830:134:3::10]:46233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fadPX-0001AF-Vo
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 04:45:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fadPU-0005j9-Po
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 04:45:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34358 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fadPU-0005ix-Jw
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 04:45:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9800340201C7
	for <qemu-devel@nongnu.org>; Wed,  4 Jul 2018 08:45:11 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  4 Jul 2018 16:44:58 +0800
Message-Id: <20180704084507.14560-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 0/9] monitor: enable OOB by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Based-on: <20180703085358.13941-1-armbru@redhat.com>

This work is based on Markus's latest out-of-band fixes:
  "[PATCH v2 00/32] ] qmp: Fixes and cleanups around OOB commands"

Major stuff: some cleanups that were previously suggested by Markus or
Eric.  Meanwhile fix up the flow control issue.  Since my proposal
here is to drop COMMAND_DROPPED event, then we don't need to introduce
per-monitor event emission API any more.  Though Markus told me that
he might use that code somewhere else, so I'll post that per-monitor
event code out separately as RFC later.

Patch 1-3: cleanups.

Patch 4-7: solve the flow control issue reported by Markus that
response queue might overflow even if we have limitation on the
request queue.  Firstly we drop the COMMAND_DROP event since that
won't work for response queue (since queuing an event will need to
append to the response queue itself), then we use monitor suspend and
resume to control the flow.  Last, we apply that to response queue
too.

Patch 8-9: the original patches to enable out-of-band by default.

Tests: I didn't write flow control tests for qtest, however I tested
the program with this tiny tool "slowread":

        #include <unistd.h>
        #include <assert.h>

        int main(void)
        {
                char c;
                ssize_t ret;

                while (1) {
                        ret = read(STDIN_FILENO, &c, 1);
                        if (ret != 1)
                                break;
                        write(STDOUT_FILENO, &c, 1);
                        usleep(1000);
                }

                return 0;
        }

Basically it limits the read speed to 1000Bps.  Then I prepare a
command list "cmd_list":

        {"execute": "qmp_capabilities", "arguments": {"enable": ["oob"]}}
        {"execute": "query-status"}
        {"execute": "query-status"}
        .....
        {"execute": "query-status"}
        {"execute": "query-status"}

Then I run this to make sure it works well:

  $ cat cmd_list | qemu-system-x86_64 -qmp stdio -nographic -nodefaults | slowread

Please review.  Thanks,

Peter Xu (9):
  monitor: simplify monitor_qmp_setup_handlers_bh
  qapi: allow build_params to return "void"
  qapi: remove error checks for event emission
  monitor: move need_resume flag into monitor struct
  monitor: suspend monitor instead of send CMD_DROP
  qapi: remove COMMAND_DROPPED event
  monitor: restrict response queue length too
  monitor: remove "x-oob", turn oob on by default
  Revert "tests: Add parameter to qtest_init_without_qmp_handshake"

 docs/devel/qapi-code-gen.txt |   6 +-
 qapi/misc.json               |  40 ---------
 include/monitor/monitor.h    |   1 -
 include/qapi/qmp-event.h     |   3 +-
 tests/libqtest.h             |   4 +-
 block/block-backend.c        |   8 +-
 block/qcow2.c                |   2 +-
 block/quorum.c               |   4 +-
 block/write-threshold.c      |   3 +-
 blockjob.c                   |  13 ++-
 cpus.c                       |   8 +-
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
 hw/watchdog/watchdog.c       |  15 ++--
 job.c                        |   2 +-
 migration/migration.c        |   4 +-
 migration/ram.c              |   2 +-
 monitor.c                    | 159 +++++++++++++++++++----------------
 scsi/pr-manager-helper.c     |   3 +-
 tests/libqtest.c             |  10 +--
 tests/qmp-test.c             |   6 +-
 tests/test-qmp-event.c       |  11 ++-
 ui/spice-core.c              |  10 +--
 ui/vnc.c                     |   7 +-
 vl.c                         |  21 ++---
 scripts/qapi/common.py       |   4 +-
 scripts/qapi/events.py       |  23 ++---
 35 files changed, 164 insertions(+), 232 deletions(-)

-- 
2.17.1
