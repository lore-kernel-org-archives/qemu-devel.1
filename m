Received: from eggs.gnu.org ([2001:4830:134:3::10]:43727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCY-0005Mo-3u
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCV-0001oD-26
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58691
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKCU-0001ni-Qx
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:10 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0hb4H007088
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:47:10 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27bdm612r4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:47:10 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:47:09 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:02 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1481762701-4587-9-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 08/67] 9pfs: fix potential segfault during walk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>

From: Greg Kurz <groug@kaod.org>

If the call to fid_to_qid() returns an error, we will call v9fs_path_free=
()
on uninitialized paths.

It is a regression introduced by the following commit:

56f101ecce0e 9pfs: handle walk of ".." in the root directory

Let's fix this by initializing dpath and path before calling fid_to_qid().

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
[groug: updated the changelog to indicate this is regression and to provi=
de
        the offending commit SHA1]
Signed-off-by: Greg Kurz <groug@kaod.org>

(cherry picked from commit 13fd08e631ec0c3ff5ad1bdcb6a4474c7d9a024f)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/9pfs/9p.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index dfe293d..91a4970 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1320,13 +1320,14 @@ static void v9fs_walk(void *opaque)
         goto out_nofid;
     }
=20
+    v9fs_path_init(&dpath);
+    v9fs_path_init(&path);
+
     err =3D fid_to_qid(pdu, fidp, &qid);
     if (err < 0) {
         goto out;
     }
=20
-    v9fs_path_init(&dpath);
-    v9fs_path_init(&path);
     /*
      * Both dpath and path initially poin to fidp.
      * Needed to handle request with nwnames =3D=3D 0
--=20
1.9.1
