Received: from eggs.gnu.org ([2001:4830:134:3::10]:33066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dDufA-0004qK-KI
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:26:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dDuf5-0002fi-Is
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:26:56 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:38885 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dDuf5-0002fH-7C
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:26:51 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 25 May 2017 18:26:21 +0300
Message-Id: <20170525152628.37628-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 0/7] qemu-img check: unallocated size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Hi all!

These small series is about "Format unallocated size" section for
qemu-img check. It is needed to know, how many holes we have in qcow2,
when underlying raw file is on non-sparse file-system. In this case
actual-size from qemu-img info will not take holes into account.
Also, qemu-img check 'allocated' stat is not appropriate too, as it
is about guest clusters, so metadata and snapshots are not accounted.

Qemu-img check is chosen instead of qemu-img info, to not slow down
qemu-img info by loading all L2 tables (Kevin)

Vladimir Sementsov-Ogievskiy (7):
  block: fix comment for bdrv_get_allocated_file_size()
  block: add bdrv_get_format_allocated_size format interface
  qcow2: add .bdrv_get_format_allocated_size
  common: make get_human_readable_size public
  qemu-img check: add format unallocated size
  qemu-img check: add file-size
  block: rename _get_allocated_file_size() to _get_fs_allocated_size()

 block.c                   | 27 ++++++++++++++++-----
 block/file-posix.c        | 14 ++++-------
 block/file-win32.c        |  8 +++----
 block/gluster.c           |  8 +++----
 block/nfs.c               |  8 +++----
 block/qapi.c              |  4 ++--
 block/qcow2-refcount.c    | 61 +++++++++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c             |  2 ++
 block/qcow2.h             |  2 ++
 block/sheepdog.c          |  8 +++----
 block/vmdk.c              |  8 +++----
 include/block/block.h     |  3 ++-
 include/block/block_int.h |  3 ++-
 include/qemu-common.h     |  2 ++
 qapi/block-core.json      |  3 ++-
 qemu-img.c                | 24 +++++++++++++++++++
 16 files changed, 144 insertions(+), 41 deletions(-)

-- 
2.11.1
