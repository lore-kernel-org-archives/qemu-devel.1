Received: from eggs.gnu.org ([209.51.188.92]:45730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAxcc-0001r1-Nj
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:09:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAxcb-0004hh-Qo
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:09:10 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  1 Apr 2019 09:08:50 -0500
Message-Id: <20190401140903.19186-2-eblake@redhat.com>
In-Reply-To: <20190401140903.19186-1-eblake@redhat.com>
References: <20190401140903.19186-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/14] qemu-img: Report bdrv_block_status
 failures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Richard W . M . Jones" <rjones@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

If bdrv_block_status_above() fails, we are aborting the convert
process but failing to print an error message.  Broken in commit
690c7301 (v2.4) when rewriting convert's logic.

Discovered when teaching nbdkit to support NBD_CMD_BLOCK_STATUS, and
accidentally violating the protocol by returning more than one extent
in spite of qemu asking for NBD_CMD_FLAG_REQ_ONE.  The qemu NBD code
should probably handle the server's non-compliance more gracefully
than failing with EINVAL, but qemu-img shouldn't be silently
squelching any block status failures. It doesn't help that qemu 3.1
masks the qemu-img bug with extra noise that the nbd code is dumping
to stderr (that noise was cleaned up in d8b4bad8).

Reported-by: Richard W.M. Jones <rjones@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190323212639.579-2-eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qemu-img.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/qemu-img.c b/qemu-img.c
index 8ee63daeaeb..03a9a10dec1 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1630,6 +1630,8 @@ static int convert_iteration_sectors(ImgConvertStat=
e *s, int64_t sector_num)
                                           count, &count, NULL, NULL);
         }
         if (ret < 0) {
+            error_report("error while reading block status of sector %" =
PRId64
+                         ": %s", sector_num, strerror(-ret));
             return ret;
         }
         n =3D DIV_ROUND_UP(count, BDRV_SECTOR_SIZE);
--=20
2.20.1
