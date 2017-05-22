Received: from eggs.gnu.org ([2001:4830:134:3::10]:59681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dCnpl-0006d1-6q
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:57:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dCnpk-0005Q4-Di
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:57:17 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 22 May 2017 14:57:00 +0100
Message-Id: <20170522135704.842-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/4] block: fix 'savevm' hang with -object
 iothread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

v3:
 * Add missing bdrv_drain_all_end() in error code paths [Kevin]
v2:
 * New patch to use bdrv_drain_all_begin/end() in savevm/loadvm [Kevin]
   (All other patches unchanged)

The 'savevm' command hangs when -object iothread is used.  See patches for
details, but basically the vmstate read/write code didn't conform to the latest
block layer locking rules.

Stefan Hajnoczi (4):
  block: count bdrv_co_rw_vmstate() requests
  block: use BDRV_POLL_WHILE() in bdrv_rw_vmstate()
  migration: avoid recursive AioContext locking in save_vmstate()
  migration: use bdrv_drain_all_begin/end() instead bdrv_drain_all()

 block/io.c         | 21 +++++++++++++--------
 migration/savevm.c | 30 ++++++++++++++++++++++++++----
 2 files changed, 39 insertions(+), 12 deletions(-)

-- 
2.9.3
