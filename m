Received: from eggs.gnu.org ([2001:4830:134:3::10]:40563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gKBmC-0005tx-Di
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 19:33:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gKBbP-0004cX-Ji
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 19:21:50 -0500
Received: from 17.mo1.mail-out.ovh.net ([87.98.179.142]:48014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gKBbN-0002fF-BT
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 19:21:47 -0500
Received: from player157.ha.ovh.net (unknown [10.109.159.73])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 985C7141772
	for <qemu-devel@nongnu.org>; Wed,  7 Nov 2018 01:21:22 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 07 Nov 2018 01:21:18 +0100
Message-ID: <154155007870.439125.16160474206652257208.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] 9p: write lock path in v9fs_co_open2()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Prasad J Pandit <prasad@redhat.com>, zhibin hu <noirfate@gmail.com>

The assumption that the fid cannot be used by any other operation is
wrong. At least, nothing prevents a misbehaving client to create a
file with a given fid, and to pass this fid to some other operation
at the same time (ie, without waiting for the response to the creation
request). The call to v9fs_path_copy() performed by the worker thread
after the file was created can race with any access to the fid path
performed by some other thread. This causes use-after-free issues that
can be detected by ASAN with a custom 9p client.

Unlike other operations that only read the fid path, v9fs_co_open2()
does modify it. It should hence take the write lock.

Cc: P J P <ppandit@redhat.com>
Reported-by: zhibin hu <noirfate@gmail.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/cofile.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/9pfs/cofile.c b/hw/9pfs/cofile.c
index 88791bc327ac..9c22837cda32 100644
--- a/hw/9pfs/cofile.c
+++ b/hw/9pfs/cofile.c
@@ -140,10 +140,10 @@ int coroutine_fn v9fs_co_open2(V9fsPDU *pdu, V9fsFidState *fidp,
     cred.fc_gid = gid;
     /*
      * Hold the directory fid lock so that directory path name
-     * don't change. Read lock is fine because this fid cannot
-     * be used by any other operation.
+     * don't change. Take the write lock to be sure this fid
+     * cannot be used by another operation.
      */
-    v9fs_path_read_lock(s);
+    v9fs_path_write_lock(s);
     v9fs_co_run_in_worker(
         {
             err = s->ops->open2(&s->ctx, &fidp->path,
