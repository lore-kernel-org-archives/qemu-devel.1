Received: from eggs.gnu.org ([2001:4830:134:3::10]:48707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dD82F-0006gJ-JY
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:31:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dD82B-0003cc-L3
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:31:31 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:24882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dD82B-0003bt-Ea
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:31:27 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OQE0016NLCA5K70@mailout1.w1.samsung.com> for
	qemu-devel@nongnu.org; Tue, 23 May 2017 12:31:22 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Tue, 23 May 2017 14:31:01 +0300
Message-id: <1495539071-12995-1-git-send-email-a.perevalov@samsung.com>
References: <CGME20170523113120eucas1p2032ace2121aa8627067b6d7f03fbf482@eucas1p2.samsung.com>
Subject: [Qemu-devel] [PATCH V6 00/10] calculate blocktime for postcopy live
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
Cc: i.maximets@samsung.com, peterx@redhat.com, eblake@redhat.com, dgilbert@redhat.com, Alexey Perevalov <a.perevalov@samsung.com>

Hello, this is 6th version of the series.

Previous version of that series at
https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg03117.html 

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

patch set is based on commit 56821559f0ba682fe6b367815572e6f974d329ab
"Merge remote-tracking branch 'dgilbert/tags/pull-hmp-20170517' into staging"

Alexey Perevalov (10):
  userfault: add pid into uffd_msg & update UFFD_FEATURE_*
  migration: pass MigrationIncomingState* into migration check functions
  migration: fix hardcoded function name in error report
  migration: split ufd_version_check onto receive/request features part
  migration: introduce postcopy-blocktime capability
  migration: add postcopy blocktime ctx into MigrationIncomingState
  migration: add bitmap for copied page
  migration: calculate vCPU blocktime on dst side
  migration: add postcopy total blocktime into query-migrate
  migration: postcopy_blocktime documentation

 docs/migration.txt                |  10 +
 hmp.c                             |  15 ++
 include/migration/migration.h     |  29 +++
 linux-headers/linux/userfaultfd.h |   5 +
 migration/migration.c             |  51 +++++-
 migration/postcopy-ram.c          | 375 ++++++++++++++++++++++++++++++++++++--
 migration/postcopy-ram.h          |   2 +-
 migration/ram.c                   |  63 +++++++
 migration/savevm.c                |   2 +-
 migration/trace-events            |   6 +-
 qapi-schema.json                  |  14 +-
 11 files changed, 551 insertions(+), 21 deletions(-)

-- 
1.8.3.1
