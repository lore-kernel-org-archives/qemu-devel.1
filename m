Received: from eggs.gnu.org ([2001:4830:134:3::10]:44838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1d3zqr-0001JV-DE
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 02:58:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1d3zqo-00035S-Cw
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 02:58:01 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:63296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1d3zqo-00033A-6o
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 02:57:58 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OP3009D8Y0HWR20@mailout1.w1.samsung.com> for
	qemu-devel@nongnu.org; Fri, 28 Apr 2017 07:57:53 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Fri, 28 Apr 2017 09:57:32 +0300
Message-id: <1493362658-8179-1-git-send-email-a.perevalov@samsung.com>
References: <CGME20170428065752eucas1p1b702ff53ba0bd96674e8cc35466f8046@eucas1p1.samsung.com>
Subject: [Qemu-devel] [PATCH RESEND V3 0/6] calculate downtime for postcopy
 live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, a.perevalov@samsung.com, i.maximets@samsung.com, f4bug@amsat.org, peterx@redhat.com

This is third version of patch set.
First version was tagged as RFC, second was without version tag.

Difference since previous version (V3 -> V2)
    - Downtime calculation approach was changed, thanks to Peter Xu
    - Due to previous point no more need to keep GTree as well as bitmap of cpus.
So glib changes aren't included in this patch set, it could be resent in
another patch set, if it will be a good reason for it.
    - No procfs traces in this patchset, if somebody wants it, you could get it
from patchwork site to track down page fault initiators.
    - UFFD_FEATURE_THREAD_ID is requesting only when kernel supports it
    - It doesn't send back the downtime, just trace it

This patch set is based on master branch of git://git.qemu-project.org/qemu.git
base commit is commit 81b2d5ceb0cfb4cdc2163492e3169ed714b0cda9
"Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20170426' into staging"

It contains patch for kernel header, just for convinience of applying current
patch set, for testing until kernel headers arn't synced.

Alexey Perevalov (6):
  userfault: add pid into uffd_msg & update UFFD_FEATURE_*
  migration: pass ptr to MigrationIncomingState into migration
    ufd_version_check & postcopy_ram_supported_by_host
  migration: split ufd_version_check onto receive/request features part
  migration: add postcopy downtime into MigrationIncommingState
  migration: calculate downtime on dst side
  migration: trace postcopy total downtime

 include/migration/migration.h     |  15 +++++
 include/migration/postcopy-ram.h  |   2 +-
 linux-headers/linux/userfaultfd.h |   5 ++
 migration/migration.c             | 138 +++++++++++++++++++++++++++++++++++++-
 migration/postcopy-ram.c          | 106 ++++++++++++++++++++++++++---
 migration/savevm.c                |   2 +-
 migration/trace-events            |   7 +-
 7 files changed, 261 insertions(+), 14 deletions(-)

-- 
1.9.1
