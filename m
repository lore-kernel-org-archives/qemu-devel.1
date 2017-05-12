Received: from eggs.gnu.org ([2001:4830:134:3::10]:57672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1d9Afi-0005Ny-Ny
	for qemu-devel@nongnu.org; Fri, 12 May 2017 09:31:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1d9Afd-00071s-NC
	for qemu-devel@nongnu.org; Fri, 12 May 2017 09:31:54 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:20657)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1d9Afd-00070o-Dz
	for qemu-devel@nongnu.org; Fri, 12 May 2017 09:31:49 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OPU00GMPDKPLB10@mailout1.w1.samsung.com> for
	qemu-devel@nongnu.org; Fri, 12 May 2017 14:31:45 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Fri, 12 May 2017 16:31:17 +0300
Message-id: <1494595886-30912-1-git-send-email-a.perevalov@samsung.com>
References: <CGME20170512133144eucas1p23502fd953ee73bda5b2afb25e65604f9@eucas1p2.samsung.com>
Subject: [Qemu-devel] [PATCH V5 0/9] calculate blocktime for postcopy live
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, a.perevalov@samsung.com, i.maximets@samsung.com, peterx@redhat.com

The rationale for that idea is following:
vCPU could suspend during postcopy live migration until faulted
page is not copied into kernel. Downtime on source side it's a value -
time interval since source turn vCPU off, till destination start runnig
vCPU. But that value was proper value for precopy migration it really shows
amount of time when vCPU is down. But not for postcopy migration, because
several vCPU threads could susppend after vCPU was started. That is important
to estimate packet drop for SDN software.

This is 5th version of patch set. In previous was build error in mingw.
First version was tagged as RFC, second was without version tag, third with V3.

This patch set doesn't include improvements sugested by Peter Xu for
get_mem_fault_cpu_index, but I would prefer to do it. I think to introduce a
tree for fast CPUState lookup by thread_id, or general code, due to there are
places like qemu_get_cpu (cpus.c) with the similar lookup.

(V4 -> V5)
    - fill_destination_postcopy_migration_info empty stub was missed for none linux
build

(V3 -> V4)
    - get rid of Downtime as a name for vCPU waiting time during postcopy migration
    - PostcopyBlocktimeContext renamed (it was just BlocktimeContext)
    - atomic operations are used for dealing with fields of PostcopyBlocktimeContext
affected in both threads.
    - hardcoded function names in error_report were replaced to %s and __line__
    - this patch set includes postcopy-downtime capability, but it used on
destination, coupled with not possibility to return calculated downtime back
to source to show it in query-migrate, it looks like a big trade off
    - UFFD_API have to be sent notwithstanding need or not to ask kernel
for a feature, due to kernel expects it in any case (see patch comment)
    - postcopy_downtime included into query-migrate output
    - also this patch set includes trivial fix
migration: fix hardcoded function name in error report
maybe that is a candidate for qemu-trivial mailing list, but I already
sent "migration: Fixed code style" and it was unclaimed.


(V2 -> V3)
    - Downtime calculation approach was changed, thanks to Peter Xu
    - Due to previous point no more need to keep GTree as well as bitmap of cpus.
So glib changes aren't included in this patch set, it could be resent in
another patch set, if it will be a good reason for it.
    - No procfs traces in this patchset, if somebody wants it you could get it
from patchwork site to track down page fault initiators.
    - UFFD_FEATURE_THREAD_ID is requesting only when kernel supports it
    - It doesn't send back the downtime, just trace it

This patch set is based on master branch of git://git.qemu-project.org/qemu.git
base commit is commit ecc1f5adeec4e3324d1b695a7c54e3967c526949. That point is
after postcopy-ram.h movement.

It contains patch for kernel header, just for convinience of applying current
patch set, for testing until kernel headers arn't synced. At the moment of
posting this patch set, "userfaultfd: provide pid in userfault msg" wasn't yet
merged into upstream. 

Alexey Perevalov (9):
  userfault: add pid into uffd_msg & update UFFD_FEATURE_*
  migration: pass ptr to MigrationIncomingState into migration
    ufd_version_check & postcopy_ram_supported_by_host
  migration: fix hardcoded function name in error report
  migration: split ufd_version_check onto receive/request features part
  migration: introduce postcopy-blocktime capability
  migration: add postcopy vcpu blocktime context into
    MigrationIncomingState
  migration: calculate vCPU blocktime on dst side
  migration: add postcopy total blocktime into query-migrate
  migration: postcopy_blocktime documentation

 docs/migration.txt                |  10 ++
 include/migration/migration.h     |  13 ++
 include/migration/postcopy-ram.h  |   2 +-
 linux-headers/linux/userfaultfd.h |   5 +
 migration/migration.c             |  58 ++++++-
 migration/postcopy-ram.c          | 322 ++++++++++++++++++++++++++++++++++++--
 migration/savevm.c                |   2 +-
 migration/trace-events            |   6 +-
 qapi-schema.json                  |  11 +-
 9 files changed, 408 insertions(+), 21 deletions(-)

-- 
1.9.1
