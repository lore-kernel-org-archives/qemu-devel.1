Received: from eggs.gnu.org ([2001:4830:134:3::10]:33171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cvmhb-00032s-6v
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 11:18:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cvmhY-0001gE-30
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 11:18:31 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:38114 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@openvz.org>) id 1cvmhX-0001eW-OB
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 11:18:28 -0400
From: "Denis V. Lunev" <den@openvz.org>
Date: Wed,  5 Apr 2017 18:18:25 +0300
Message-Id: <1491405505-31620-3-git-send-email-den@openvz.org>
In-Reply-To: <1491405505-31620-1-git-send-email-den@openvz.org>
References: <1491405505-31620-1-git-send-email-den@openvz.org>
Subject: [Qemu-devel] [PATCH 2/2] block: assert no image modification under
 BDRV_O_INACTIVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

As long as BDRV_O_INACTIVE is set, the image file is only opened so we
have a file descriptor for it. We're definitely not supposed to modify
the image, it's still owned by the migration source.

This commit is an addition to 09e0c771 but the assert() is added to
bdrv_truncate().

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
---
 block.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block.c b/block.c
index 927ba89..9273741 100644
--- a/block.c
+++ b/block.c
@@ -3279,6 +3279,8 @@ int bdrv_truncate(BdrvChild *child, int64_t offset)
     if (bs->read_only)
         return -EACCES;
 
+    assert(!(bs->open_flags & BDRV_O_INACTIVE));
+
     ret = drv->bdrv_truncate(bs, offset);
     if (ret == 0) {
         ret = refresh_total_sectors(bs, offset >> BDRV_SECTOR_BITS);
-- 
2.7.4
