Received: from eggs.gnu.org ([2001:4830:134:3::10]:51918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ebQlR-0002oa-Nz
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 07:54:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ebQlM-00077H-07
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 07:54:53 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:26698 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1ebQlL-00076V-LF
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 07:54:47 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 16 Jan 2018 15:54:21 +0300
Message-Id: <20180116125427.18540-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 0/6] qmp dirty bitmap API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, nshirokovskiy@virtuozzo.com, mnestratov@virtuozzo.com

Hi all.

There are three qmp commands, needed to implement external backup API.

Using these three commands, client may do all needed bitmap management by
hand:

on backup start we need to do a transaction:
 {disable old bitmap, create new bitmap}

on backup success:
 drop old bitmap

on backup fail:
 enable old bitmap
 merge new bitmap to old bitmap
 drop new bitmap

v2: fix merge command deadlock
  add new patches: 1 and 6

Vladimir Sementsov-Ogievskiy (6):
  block: maintain persistent disabled bitmaps
  block/dirty-bitmap: add lock to bdrv_enable/disable_dirty_bitmap
  qapi: add block-dirty-bitmap-enable/disable
  qmp: transaction support for block-dirty-bitmap-enable/disable
  qapi: add block-dirty-bitmap-merge
  qapi: add disabled parameter to block-dirty-bitmap-add

 qapi/block-core.json         |  92 ++++++++++++++++++++++-
 qapi/transaction.json        |   4 +
 block/qcow2.h                |   2 +-
 include/block/dirty-bitmap.h |   3 +-
 block/dirty-bitmap.c         |  42 ++++++-----
 block/qcow2-bitmap.c         |  12 +--
 block/qcow2.c                |   2 +-
 blockdev.c                   | 169 +++++++++++++++++++++++++++++++++++++++++--
 8 files changed, 287 insertions(+), 39 deletions(-)

-- 
2.11.1
