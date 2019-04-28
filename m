Received: from eggs.gnu.org ([209.51.188.92]:50385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liliangleo@didiglobal.com>) id 1hKgcv-00087s-3H
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 06:01:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liliangleo@didiglobal.com>) id 1hKgct-0004pd-Us
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 06:01:41 -0400
Received: from mx2.didichuxing.com ([36.110.17.22]:27867
	helo=bsf02.didichuxing.com) by eggs.gnu.org with smtp (Exim 4.71)
	(envelope-from <liliangleo@didiglobal.com>) id 1hKgcs-0004ml-6L
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 06:01:39 -0400
Date: Sun, 28 Apr 2019 18:01:17 +0800
From: Liang Li <liliangleo@didiglobal.com>
Message-ID: <20190428100052.GA63525@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH 0/2] buffer and delay backup COW write operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Wen Congyang <wencongyang2@huawei.com>, Xie Changlong <xiechanglong.d@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Fam Zheng <fam@euphon.net>

If the backup target is a slow device like ceph rbd, the backup
process will affect guest BLK write IO performance seriously,
it's cause by the drawback of COW mechanism, if guest overwrite the
backup BLK area, the IO can only be processed after the data has
been written to backup target.
The impact can be relieved by buffering data read from backup
source and writing to backup target later, so the guest BLK write
IO can be processed in time.
Data area with no overwrite will be process like before without
buffering, in most case, we don't need a very large buffer.

An fio test was done when the backup was going on, the test resut
show a obvious performance improvement by buffering.

Test result(1GB buffer):
========================
fio setting:
[random-writers]
ioengine=libaio
iodepth=8
rw=randwrite
bs=32k
direct=1
size=1G
numjobs=1

result:
                      IOPS        AVG latency
       no backup:     19389         410 us
          backup:      1402        5702 us
backup w/ buffer:      8684         918 us
==============================================

Cc: John Snow <jsnow@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: Wen Congyang <wencongyang2@huawei.com>
Cc: Xie Changlong <xiechanglong.d@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Fam Zheng <fam@euphon.net>

Liang Li (2):
  backup: buffer COW request and delay the write operation
  qapi: add interface for setting backup cow buffer size

 block/backup.c            | 118 +++++++++++++++++++++++++++++++++++++++++-----
 block/replication.c       |   2 +-
 blockdev.c                |   5 ++
 include/block/block_int.h |   2 +
 qapi/block-core.json      |   5 ++
 5 files changed, 118 insertions(+), 14 deletions(-)

-- 
2.14.1
