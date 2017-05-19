Received: from eggs.gnu.org ([2001:4830:134:3::10]:33829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dBfDQ-00013P-1z
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:33:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dBfDP-00080C-AX
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:33:00 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 19 May 2017 11:32:43 +0100
Message-Id: <20170519103247.4405-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/4] block: fix 'savevm' hang with -object
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
 migration/savevm.c | 21 +++++++++++++++++++--
 2 files changed, 32 insertions(+), 10 deletions(-)

-- 
2.9.3
