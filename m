Received: from eggs.gnu.org ([2001:4830:134:3::10]:39597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dvKRQ-0000Fa-9h
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 05:40:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dvKRL-0004a2-Dv
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 05:40:12 -0400
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Fri, 22 Sep 2017 12:39:24 +0300
Message-Id: <20170922093926.9723-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 0/2] Truncate the tail of the image file in
 qcow2 shrinking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbutsykin@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, jsnow@redhat.com, den@openvz.org

Now after shrinking the qcow2 image, at the end of the image file, there might
be a tail that probably will never be used. Although it will not bring any
tangible benefit, we can cut the tail if it is. Yes, it will not free up disk
space, but if the blocks were be allocated sequentially and the image is not
heavily fragmented then the virtual size of the image file will be commensurate
with the real size. It also doesn't look like a great plus.. Well, at least we
can discuss it.

Changes from v1:
- rewrite qcow2_get_last_cluster() function according to Max's comments. (2)

Pavel Butsykin (2):
  qcow2: fix return error code in qcow2_truncate()
  qcow2: truncate the tail of the image file after shrinking the image

 block/qcow2-refcount.c | 22 ++++++++++++++++++++++
 block/qcow2.c          | 27 +++++++++++++++++++++++++--
 block/qcow2.h          |  1 +
 3 files changed, 48 insertions(+), 2 deletions(-)

-- 
2.14.1
