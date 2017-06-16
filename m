Received: from eggs.gnu.org ([2001:4830:134:3::10]:49595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dLwfT-000782-DR
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 15:12:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dLwfO-0007Oy-ED
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 15:12:27 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:12198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dLwfO-0007Og-54
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 15:12:22 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0ORN00KTNMOJHC40@mailout2.w1.samsung.com> for
	qemu-devel@nongnu.org; Fri, 16 Jun 2017 20:12:19 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Fri, 16 Jun 2017 22:11:57 +0300
Message-id: <1497640325-10960-1-git-send-email-a.perevalov@samsung.com>
References: <CGME20170616191218eucas1p2bcc5ece2b03593f16ab599c4f12eaa5e@eucas1p2.samsung.com>
Subject: [Qemu-devel] [PATCH v9 0/8] calculate blocktime for postcopy live
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
Cc: Alexey Perevalov <a.perevalov@samsung.com>, peterx@redhat.com, i.maximets@samsung.com, quintela@redhat.com, dgilbert@redhat.com

This is 9th version.

The rationale for that idea is following:
vCPU could suspend during postcopy live migration until faulted
page is not copied into kernel. Downtime on source side it's a value -
time interval since source turn vCPU off, till destination start runnig
vCPU. But that value was proper value for precopy migration it really shows
amount of time when vCPU is down. But not for postcopy migration, because
several vCPU threads could susppend after vCPU was started. That is important
to estimate packet drop for SDN software.

(V8 -> V9)
    - rebase
    - traces

(V7 -> V8)
    - just one comma in
"migration: fix hardcoded function name in error report"
It was really missed, but fixed in futher patch.

(V6 -> V7)
    - copied bitmap was placed into RAMBlock as another migration
related bitmaps.
    - Ordering of mark_postcopy_blocktime_end call and ordering
of checking copied bitmap were changed.
    - linewrap style defects
    - new patch "postcopy_place_page factoring out"
    - postcopy_ram_supported_by_host accepts
MigrationIncomingState in qmp_migrate_set_capabilities
    - minor fixes of documentation. 
    and huge description of get_postcopy_total_blocktime was
moved. Davids comment.

(V5 -> V6)
    - blocktime was added into hmp command. Comment from David.
    - bitmap for copied pages was added as well as check in *_begin/_end
functions. Patch uses just introduced RAMBLOCK_FOREACH. Comment from David.
    - description of receive_ufd_features/request_ufd_features. Comment from David.
    - commit message headers/@since references were modified. Comment from Eric.
    - also typos in documentation. Comment from Eric.
    - style and description of field in MigrationInfo. Comment from Eric.
    - ufd_check_and_apply (former ufd_version_check) is calling twice,
so my previous patch contained double allocation of blocktime context and
as a result memory leak. In this patch series it was fixed.

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
    - No procfs traces in this patchset, if somebody wants it, you could get it
from patchwork site to track down page fault initiators.
    - UFFD_FEATURE_THREAD_ID is requesting only when kernel supports it
    - It doesn't send back the downtime, just trace it

This patch set is based on commit
[PATCH v3 0/3] Add bitmap for received pages in postcopy migration


Alexey Perevalov (8):
  userfault: add pid into uffd_msg & update UFFD_FEATURE_*
  migration: pass MigrationIncomingState* into migration check functions
  migration: fix hardcoded function name in error report
  migration: split ufd_version_check onto receive/request features part
  migration: introduce postcopy-blocktime capability
  migration: add postcopy blocktime ctx into MigrationIncomingState
  migration: calculate vCPU blocktime on dst side
  migration: postcopy_blocktime documentation

 docs/devel/migration.txt          |  10 ++
 linux-headers/linux/userfaultfd.h |   4 +
 migration/migration.c             |  12 +-
 migration/migration.h             |   9 ++
 migration/postcopy-ram.c          | 300 ++++++++++++++++++++++++++++++++++++--
 migration/postcopy-ram.h          |   2 +-
 migration/savevm.c                |   2 +-
 migration/trace-events            |   5 +-
 qapi-schema.json                  |   5 +-
 9 files changed, 334 insertions(+), 15 deletions(-)

-- 
1.8.3.1
