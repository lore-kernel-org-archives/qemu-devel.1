Received: from eggs.gnu.org ([2001:4830:134:3::10]:37734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dxuE9-0008Mp-83
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 08:17:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dxuE5-0008VJ-8J
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 08:17:09 -0400
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Fri, 29 Sep 2017 15:16:11 +0300
Message-Id: <20170929121613.25997-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 0/2] Truncate the tail of the image file in
 qcow2 shrinking
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbutsykin@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, jsnow@redhat.com, den@openvz.org
List-ID: <qemu-devel.nongnu.org>

Now after shrinking the qcow2 image, at the end of the image file, there might
be a tail that probably will never be used. Although it will not bring any
tangible benefit, we can cut the tail if it is. Yes, it will not free up disk
space, but if the blocks were be allocated sequentially and the image is not
heavily fragmented then the virtual size of the image file will be commensurate
with the real size. It also doesn't look like a great plus.. Well, at least we
can discuss it.

Changes from v1:
- rewrite qcow2_get_last_cluster() function according to Max's comments. (2)

Changes from v2:
- report a warning if truncation of the tail of the image file failed. (2)

Pavel Butsykin (2):
  qcow2: fix return error code in qcow2_truncate()
  qcow2: truncate the tail of the image file after shrinking the image

 block/qcow2-refcount.c | 22 ++++++++++++++++++++++
 block/qcow2.c          | 27 +++++++++++++++++++++++++--
 block/qcow2.h          |  1 +
 3 files changed, 48 insertions(+), 2 deletions(-)

-- 
2.14.1
