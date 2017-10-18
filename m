Received: from eggs.gnu.org ([2001:4830:134:3::10]:49470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e4rjB-0000d2-DS
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 13:02:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e4rj7-0004OL-I4
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 13:01:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e4rj7-0004N4-BA
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 13:01:53 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 18 Oct 2017 18:01:31 +0100
Message-Id: <20171018170138.19078-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/7] migration: pause-before-switchover
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kwolf@redhat.com, jdenemar@redhat.com, wangjie88@huawei.com, quintela@redhat.com, peterx@redhat.com, mreitz@redhat.com
Cc: berrange@redhat.com, eblake@redhat.com, fuweiwei2@huawei.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi,
  This set attempts to make a race condition between migration and
drive-mirror (and other block users) soluble by allowing the migration
to be paused after the source qemu releases the block devices but
before the serialisation of the device state.

The symptom of this failure, as reported by Wangjie, is a:
   _co_do_pwritev: Assertion `!(bs->open_flags & 0x0800)' failed

and the source qemu dieing; so the problem is pretty nasty.
This has only been seen on 2.9 onwards, but the theory is that
prior to 2.9 it might have been happening anyway and we were
perhaps getting unreported corruptions (lost writes); so this
really needs fixing.

This flow came from discussions between Kevin and me, and we can't
see a way of fixing it without exposing a new state to the management
layer.

The flow is now:

(qemu) migrate_set_capability pause-before-switchover on
(qemu) migrate -d ...
(qemu) info migrate
...
Migration status: pre-switchover
...
<< issue commands to clean up any block jobs>>

(qemu) migrate_continue pre-switchover
(qemu) info migrate
...
Migration status: completed

This set has been _very_ lightly tested just at the normal migration
code, without the addition of the drive mirror; so this is a first
cut.  I'd appreciate some feedback from libvirt whether the inteface
is OK and ideally a hack to test it in a full libvirt setup to see
if we hit any other issues.

The precopy flow is:
active->pre-switchover->device->completed

The postcopy flow is:
active->pre-switchover->postcopy-active->completed

Although the behaviour with postcopy only gets interesting when
we add something like Max's active-sync.

Dave

--
v2
  Pause *before* block inactivation (thanks Peter)
  Rename state and capability to Dan+KWolf's combined suggestion

Dr. David Alan Gilbert (7):
  migration: Add 'pause-before-switchover' capability
  migration: Add 'pre-switchover' and 'device' statuses
  migration: Wait for semaphore before completing migration
  migration: migrate-continue
  migrate: HMP migate_continue
  migration: allow cancel to unpause
  migration: pause-before-switchover for postcopy

 hmp-commands.hx       | 12 +++++++
 hmp.c                 | 13 ++++++++
 hmp.h                 |  1 +
 migration/migration.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++++--
 migration/migration.h |  4 +++
 qapi/migration.json   | 30 ++++++++++++++++--
 6 files changed, 144 insertions(+), 4 deletions(-)

-- 
2.13.6
