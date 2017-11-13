Received: from eggs.gnu.org ([2001:4830:134:3::10]:60691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eEHU6-0007Zw-Nt
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:21:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eEHU2-00039J-LT
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:21:18 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:10222 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1eEHU2-000378-9m
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:21:14 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 13 Nov 2017 19:20:49 +0300
Message-Id: <20171113162053.58795-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH for-2.12 0/4] qmp dirty bitmap API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, stefanha@redhat.com, armbru@redhat.com, pbonzini@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, nshirokovskiy@virtuozzo.com, mnestratov@virtuozzo.com

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

Question: it may be better to make one command instead of two:
block-dirty-bitmap-set-enabled(bool enabled)

Vladimir Sementsov-Ogievskiy (4):
  block/dirty-bitmap: add lock to bdrv_enable/disable_dirty_bitmap
  qapi: add block-dirty-bitmap-enable/disable
  qmp: transaction support for block-dirty-bitmap-enable/disable
  qapi: add block-dirty-bitmap-merge

 qapi/block-core.json         |  80 +++++++++++++++++++++++
 qapi/transaction.json        |   4 ++
 include/block/dirty-bitmap.h |   2 +
 block/dirty-bitmap.c         |  21 ++++++
 blockdev.c                   | 151 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 258 insertions(+)

-- 
2.11.1
