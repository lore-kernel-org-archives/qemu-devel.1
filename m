Received: from eggs.gnu.org ([2001:4830:134:3::10]:37697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dbUo7-00060P-0y
	for qemu-devel@nongnu.org; Sat, 29 Jul 2017 12:41:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dbUo4-00018u-Sq
	for qemu-devel@nongnu.org; Sat, 29 Jul 2017 12:41:39 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:42940 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dbUo4-00017r-Gj
	for qemu-devel@nongnu.org; Sat, 29 Jul 2017 12:41:36 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Sat, 29 Jul 2017 19:41:01 +0300
Message-Id: <20170729164104.29537-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 0/3] qemu-img check: format allocation info
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

See 01 patch for the doc.

Question to discuss.
If I understand correctly get_block_status flags allocated, zero, and data
actually provide 5 possible combinations, which I combine into three.

allocated data zero
1         1    1    \__ data
1         1    0    /
1         0    1    \__ zero
0         0    1    /
0         0    0    ___ discarded

This division looks not bad, but it is not the only one possible.
Separating data is really useful - it shows leaked clusters..
So the question is, don't we want to adjust the division?
I'm ok with the current one.

v4: - reword docs in 01
    - s/2.10/2.11/ for qapi

v3: - improve docs
    - rename fields
    - add 'zero' type of underlying file portions status. It as these
      areas cannot be presented as 'discarded', but they are not
      occupying real space, so we don't want to present them as
      'allocated data' too.
    - remove last patch. It is not needed after introducing new naming
      for the fields

v2: fix build error, gcc things that some variables may be used
    uninitialized (actually they didn't).

v1: 

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

Vladimir Sementsov-Ogievskiy (3):
  block: add bdrv_get_format_alloc_stat format interface
  qcow2: add .bdrv_get_format_alloc_stat
  qemu-img check: add format allocation info

 block.c                   |  16 +++++
 block/qcow2-refcount.c    | 152 ++++++++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c             |   2 +
 block/qcow2.h             |   2 +
 include/block/block.h     |   3 +
 include/block/block_int.h |   2 +
 qapi/block-core.json      |  78 +++++++++++++++++++++++-
 qemu-img.c                |  42 +++++++++++++
 8 files changed, 296 insertions(+), 1 deletion(-)

-- 
2.11.1
