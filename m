Received: from eggs.gnu.org ([2001:4830:134:3::10]:49372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiangyiwen@huawei.com>) id 1eFbxX-0002PB-5s
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 03:25:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiangyiwen@huawei.com>) id 1eFbxU-0000NB-1l
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 03:25:11 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2792)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <jiangyiwen@huawei.com>) id 1eFbxT-0000Io-Ej
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 03:25:07 -0500
From: jiangyiwen <jiangyiwen@huawei.com>
Message-ID: <5A0E9C91.4050108@huawei.com>
Date: Fri, 17 Nov 2017 16:23:45 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] Don't ignore O_DIRECT flag in the 9pfs server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: aneesh.kumar@linux.vnet.ibm.com, groug@kaod.org, qemu-devel@nongnu.org
Cc: sochin.jiang@huawei.com, Eduard.Shishkin@huawei.com

Now v9fs in linux has already supported O_DIRECT(v9fs_direct_IO),
when guest user open file with O_DIRECT flag and return success,
so user hopes data doesn't pass through page cache, but 9pfs in
qemu ignore direct disk access and use host page cache, it is not
match to DIRECT_IO semantic, so we should not ignore O_DIRECT in
9pfs unless v9fs in linux don't support DIRECT_IO.

And if server fs don't support O_DIRECT, user will receive -EINVAL
and know the filesystem don't support O_DIRECT.

So in order to ensure semantic consistency, don't ignore direct
disk access in 9pfs.

Signed-off-by: Yiwen Jiang <jiangyiwen@huawei.com>
---
 hw/9pfs/9p.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 52d4663..5ea01c4 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -155,10 +155,6 @@ static int get_dotl_openflags(V9fsState *s, int oflags)
      */
     flags = dotl_to_open_flags(oflags);
     flags &= ~(O_NOCTTY | O_ASYNC | O_CREAT);
-    /*
-     * Ignore direct disk access hint until the server supports it.
-     */
-    flags &= ~O_DIRECT;
     return flags;
 }

-- 
1.8.3.1
