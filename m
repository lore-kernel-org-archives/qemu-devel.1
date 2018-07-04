Received: from eggs.gnu.org ([2001:4830:134:3::10]:48908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fab2t-0004aK-CN
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 02:13:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fab2s-0002nq-Gf
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 02:13:43 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed,  4 Jul 2018 14:13:18 +0800
Message-Id: <20180704061320.2041-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] block: Fix dst reading after tail copy
 offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Qcow2 allocates new clusters after the end of the file. If it is the destinaton
of copy offloading, we must adjust dst->bs->total_sectors. Otherwise, further
reads will drop to the "beyond EOF" code path and return zeroes, which problem
is caught by iotests 222.

Follow the logic in the normal write code and update bs->total_sectors after
I/O is done.

While at it, add a few convenient trace points to aid future debug experiences
in the topic.

Fam Zheng (2):
  block: Fix dst total_sectors after copy offloading
  block: Add copy offloading trace points

 block/file-posix.c | 2 ++
 block/io.c         | 6 ++++++
 block/iscsi.c      | 3 +++
 block/trace-events | 6 ++++++
 4 files changed, 17 insertions(+)

-- 
2.17.1
