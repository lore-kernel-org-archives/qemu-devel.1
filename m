Received: from eggs.gnu.org ([2001:4830:134:3::10]:42266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cqyTr-0000PL-Gz
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 04:52:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cqyTo-0003j9-Fz
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 04:52:27 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:34745)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1cqyTo-0003il-A7
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 04:52:24 -0400
Received: by mail-pg0-x243.google.com with SMTP id w20so9968885pgc.1
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 01:52:23 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 23 Mar 2017 01:52:13 -0700
Message-Id: <1490259133-44411-1-git-send-email-liqiang6-s@360.cn>
Subject: [Qemu-devel] [PATCH] 9pfs: fix file descriptor leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org, qemu-devel@nongnu.org
Cc: ppandit@redhat.com, Li Qiang <liqiang6-s@360.cn>

In v9fs_create/lcreate dispatch handler, the fidp's fid_type is not checked
before used. As these function will set the fid_type, if the guest call
more than once them, it will leak the fidp. This can cause some other
issue, such as memory leak. Check the fid_type before using them.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
---
 hw/9pfs/9p.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index b8c0b99..48babce 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1550,6 +1550,10 @@ static void coroutine_fn v9fs_lcreate(void *opaque)
         err = -ENOENT;
         goto out_nofid;
     }
+    if (fidp->fid_type != P9_FID_NONE) {
+        err = -EINVAL;
+        goto out;
+    }
 
     flags = get_dotl_openflags(pdu->s, flags);
     err = v9fs_co_open2(pdu, fidp, &name, gid,
@@ -2153,6 +2157,10 @@ static void coroutine_fn v9fs_create(void *opaque)
         err = -EINVAL;
         goto out_nofid;
     }
+    if (fidp->fid_type != P9_FID_NONE) {
+        err = -EINVAL;
+        goto out;
+    }
     if (perm & P9_STAT_MODE_DIR) {
         err = v9fs_co_mkdir(pdu, fidp, &name, perm & 0777,
                             fidp->uid, -1, &stbuf);
-- 
1.8.3.1
