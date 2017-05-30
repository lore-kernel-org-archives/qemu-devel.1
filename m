Received: from eggs.gnu.org ([2001:4830:134:3::10]:33826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dFei7-0004hO-0X
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:49:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dFei6-0005BZ-8t
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:49:11 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:10951 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dFei5-0005Ac-U5
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:49:10 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 30 May 2017 13:48:53 +0300
Message-Id: <20170530104857.70083-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 0/4] qemu-img check: format allocation info
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

Hi all.

v2: fix build error, gcc things that some variables may be used
    uninitialized (actually they didn't).

These series is a replacement for "qemu-img check: unallocated size"
series.

There was a question, should we account allocated clusters in qcow2 but
actually holes in underalying file as allocated or not. Instead of
hiding this information in one-number statistic I've decided to print
the whole information, 5 numbers:

For allocated by top-level format driver (qcow2 for ex.) clusters, 3
numbers: number of bytes, which are:
 - allocated in underlying file
 - holes in underlying file
 - after end of underlying file

To account other areas of underlying file, 2 more numbers of bytes:
 - unallocated by top-level driver but allocated in underlying file
 - unallocated by top-level driver and holes in underlying file

Vladimir Sementsov-Ogievskiy (4):
  block: add bdrv_get_format_alloc_stat format interface
  qcow2: add .bdrv_get_format_alloc_stat
  qemu-img check: add format allocation info
  qemu-img check: improve dump_human_format_alloc_info

 block.c                   |  16 ++++++
 block/qcow2-refcount.c    | 144 ++++++++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c             |   2 +
 block/qcow2.h             |   2 +
 include/block/block.h     |   3 +
 include/block/block_int.h |   2 +
 qapi/block-core.json      |  32 ++++++++++-
 qemu-img.c                |  57 +++++++++++++++++-
 8 files changed, 255 insertions(+), 3 deletions(-)

-- 
2.11.1
