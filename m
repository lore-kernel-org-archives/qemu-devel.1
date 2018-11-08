Received: from eggs.gnu.org ([2001:4830:134:3::10]:53521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gKrDE-0001Bi-KE
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 15:47:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gKr7c-0001eV-1S
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 15:41:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41778
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gKr7b-0001UQ-IU
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 15:41:47 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wA8Kd0WI009171
	for <qemu-devel@nongnu.org>; Thu, 8 Nov 2018 15:41:36 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2nmv4ngmh7-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 15:41:36 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 8 Nov 2018 20:41:34 -0000
From: Greg Kurz <groug@kaod.org>
Date: Thu,  8 Nov 2018 21:41:10 +0100
In-Reply-To: <20181108204111.786455-1-groug@kaod.org>
References: <20181108204111.786455-1-groug@kaod.org>
Message-Id: <20181108204111.786455-2-groug@kaod.org>
Subject: [Qemu-devel] [PULL 1/1] 9p: write lock path in v9fs_co_open2()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>, P J P <ppandit@redhat.com>

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
 hw/9pfs/cofile.c | 6 +++---
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
-- 
2.17.2
