Received: from eggs.gnu.org ([209.51.188.92]:41819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB45b-0002Ll-TZ
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB45a-00044i-N4
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55734)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB45a-0003yF-Cf
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:30 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L1p2c061963
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:03:19 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rksw4s3pc-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:03:18 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:03:17 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 16:00:09 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-96-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 95/97] 9p: fix QEMU crash when renaming files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, P J P <ppandit@redhat.com>

From: Greg Kurz <groug@kaod.org>

When using the 9P2000.u version of the protocol, the following shell
command line in the guest can cause QEMU to crash:

    while true; do rm -rf aa; mkdir -p a/b & touch a/b/c & mv a aa; done

With 9P2000.u, file renaming is handled by the WSTAT command. The
v9fs_wstat() function calls v9fs_complete_rename(), which calls
v9fs_fix_path() for every fid whose path is affected by the change.
The involved calls to v9fs_path_copy() may race with any other access
to the fid path performed by some worker thread, causing a crash like
shown below:

Thread 12 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
0x0000555555a25da2 in local_open_nofollow (fs_ctx=0x555557d958b8, path=0x0,
 flags=65536, mode=0) at hw/9pfs/9p-local.c:59
59          while (*path && fd != -1) {
(gdb) bt
#0  0x0000555555a25da2 in local_open_nofollow (fs_ctx=0x555557d958b8,
 path=0x0, flags=65536, mode=0) at hw/9pfs/9p-local.c:59
#1  0x0000555555a25e0c in local_opendir_nofollow (fs_ctx=0x555557d958b8,
 path=0x0) at hw/9pfs/9p-local.c:92
#2  0x0000555555a261b8 in local_lstat (fs_ctx=0x555557d958b8,
 fs_path=0x555556b56858, stbuf=0x7fff84830ef0) at hw/9pfs/9p-local.c:185
#3  0x0000555555a2b367 in v9fs_co_lstat (pdu=0x555557d97498,
 path=0x555556b56858, stbuf=0x7fff84830ef0) at hw/9pfs/cofile.c:53
#4  0x0000555555a1e9e2 in v9fs_stat (opaque=0x555557d97498)
 at hw/9pfs/9p.c:1083
#5  0x0000555555e060a2 in coroutine_trampoline (i0=-669165424, i1=32767)
 at util/coroutine-ucontext.c:116
#6  0x00007fffef4f5600 in __start_context () at /lib64/libc.so.6
#7  0x0000000000000000 in  ()
(gdb)

The fix is to take the path write lock when calling v9fs_complete_rename(),
like in v9fs_rename().

Impact:  DoS triggered by unprivileged guest users.

Fixes: CVE-2018-19489
Cc: P J P <ppandit@redhat.com>
Reported-by: zhibin hu <noirfate@gmail.com>
Reviewed-by: Prasad J Pandit <pjp@fedoraproject.org>
Signed-off-by: Greg Kurz <groug@kaod.org>
(cherry picked from commit 1d20398694a3b67a388d955b7a945ba4aa90a8a8)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/9pfs/9p.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index eef289e394..88e523f8dd 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2840,6 +2840,7 @@ static void coroutine_fn v9fs_wstat(void *opaque)
     struct stat stbuf;
     V9fsFidState *fidp;
     V9fsPDU *pdu = opaque;
+    V9fsState *s = pdu->s;
 
     v9fs_stat_init(&v9stat);
     err = pdu_unmarshal(pdu, offset, "dwS", &fid, &unused, &v9stat);
@@ -2905,7 +2906,9 @@ static void coroutine_fn v9fs_wstat(void *opaque)
         }
     }
     if (v9stat.name.size != 0) {
+        v9fs_path_write_lock(s);
         err = v9fs_complete_rename(pdu, fidp, -1, &v9stat.name);
+        v9fs_path_unlock(s);
         if (err < 0) {
             goto out;
         }
-- 
2.17.1
