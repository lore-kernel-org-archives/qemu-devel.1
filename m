Received: from eggs.gnu.org ([2001:4830:134:3::10]:48621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1djhVS-0006SQ-5s
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 03:52:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1djhVO-0001BU-9k
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 03:52:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1djhVO-0001BE-1O
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 03:52:14 -0400
From: Peter Xu <peterx@redhat.com>
Date: Mon, 21 Aug 2017 15:44:18 +0800
Message-Id: <1503301464-27886-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 0/6] monitor: allow per-monitor thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This is an extended work for migration postcopy recovery. This series
is tested with the following series to make sure it solves the monitor
hang problem that we have encountered for postcopy recovery:

  [RFC 00/29] Migration: postcopy failure recovery
  [RFC 0/6] migration: re-use migrate_incoming for postcopy recovery

The root problem is that, monitor commands are all handled in main
loop thread now, no matter how many monitors we specify. And, if main
loop thread hangs due to some reason, all monitors will be stuck.
This can be done in reversed order as well: if any of the monitor
hangs, it will hang the main loop, and the rest of the monitors (if
there is any).

That affects postcopy recovery, since the recovery requires user input
on destination side.  If monitors hang, the destination VM dies and
lose hope for even a final recovery.

So, sometimes we need to make sure the monitor be alive, at least one
of them.

The whole idea of this series is that instead if handling monitor
commands all in main loop thread, we do it separately in per-monitor
threads.  Then, even if main loop thread hangs at any point by any
reason, per-monitor thread can still survive.  Further, we add hint in
QMP/HMP to show whether a command can be executed without QMP, if so,
we avoid taking BQL when running that command.  It greatly reduced
contention of BQL.  Now the only user of that new parameter (currently
I call it "without-bql") is "migrate-incoming" command, which is the
only command to rescue a paused postcopy migration.

However, even with the series, it does not mean that per-monitor
threads will never hang.  One example is that we can still run "info
vcpus" in per-monitor threads during a paused postcopy (in that state,
page faults are never handled, and "info cpus" will never return since
it tries to sync every vcpus).  So to make sure it does not hang, we
not only need the per-monitor thread, the user should be careful as
well on how to use it.

For postcopy recovery, we may need dedicated monitor channel for
recovery.  In other words, a destination VM that supports postcopy
recovery would possibly need:

  -qmp MAIN_CHANNEL -qmp RECOVERY_CHANNEL

Here, the MAIN_CHANNEL can be MUXed and shared by other chardev
frontends, while the RECOVERY_CHANNEL should *ONLY* be used to input
the "migrate-incoming" command (similar thing applies to HMP
channels).  As long as we are following this rule, the
RECOVERY_CHANNEL can never hang.

Some details on each patch:

Patch 1: a simple cleanup only

Patch 2: allow monitors to create per-monitor thread to handle monitor
         command requests. Since monitor is only one type of chardev
         frontend, we only do this if the backend is dedicated, say,
         if MUX is not turned on (if MUX is on, it's still using main
         loop thread).

Patch 3: based on patch 2, this patch introduced a new parameter for
         QMP commands called "without-bql", it is a hint that the
         command does not need BQL.

Patch 4: Let QMP command "migrate-incoming" avoid taking BQL.

Patch 5: Introduced sister parameter for HMP "without_bql", which
         works just like QMP "without-bql".

Patch 6: Let HMP command "migrate-incoming" avoid taking BQL.

Please review. Thanks,

Peter Xu (6):
  monitor: move skip_flush into monitor_data_init
  monitor: allow monitor to create thread to poll
  QAPI: new QMP command option "without-bql"
  migration: qmp: migrate_incoming don't need BQL
  hmp: support "without_bql"
  migration: hmp: migrate_incoming don't need BQL

 docs/devel/qapi-code-gen.txt | 10 +++++-
 hmp-commands.hx              |  1 +
 include/qapi/qmp/dispatch.h  |  1 +
 monitor.c                    | 79 ++++++++++++++++++++++++++++++++++++++++----
 qapi-schema.json             |  3 +-
 qapi/qmp-dispatch.c          | 26 +++++++++++++++
 scripts/qapi-commands.py     | 18 +++++++---
 scripts/qapi-introspect.py   |  2 +-
 scripts/qapi.py              | 15 ++++++---
 scripts/qapi2texi.py         |  2 +-
 10 files changed, 137 insertions(+), 20 deletions(-)

-- 
2.7.4
