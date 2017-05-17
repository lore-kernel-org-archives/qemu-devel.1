Received: from eggs.gnu.org ([2001:4830:134:3::10]:38715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dB2SS-0005za-MQ
	for qemu-devel@nongnu.org; Wed, 17 May 2017 13:09:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dB2SR-00051d-Rb
	for qemu-devel@nongnu.org; Wed, 17 May 2017 13:09:56 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 17 May 2017 18:09:38 +0100
Message-Id: <20170517170941.25850-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] block: fix 'savevm' hang with -object
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

The 'savevm' command hangs when -object iothread is used.  See patches for
details, but basically the vmstate read/write code didn't conform to the latest
block layer locking rules.

Stefan Hajnoczi (3):
  block: count bdrv_co_rw_vmstate() requests
  block: use BDRV_POLL_WHILE() in bdrv_rw_vmstate()
  migration: avoid recursive AioContext locking in save_vmstate()

 block/io.c         | 21 +++++++++++++--------
 migration/savevm.c | 12 +++++++++++-
 2 files changed, 24 insertions(+), 9 deletions(-)

-- 
2.9.3
