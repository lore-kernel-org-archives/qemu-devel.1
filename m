Received: from eggs.gnu.org ([2001:4830:134:3::10]:53475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cQxTp-0000TL-C5
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:32:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cQxTj-0002TF-Gn
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:32:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cQxTj-0002Si-6U
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:32:47 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0AESlQh019982
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 09:32:45 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27w0h82xhc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 09:32:45 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 10 Jan 2017 07:32:44 -0700
From: Greg Kurz <groug@kaod.org>
Date: Tue, 10 Jan 2017 15:32:40 +0100
In-Reply-To: <148405872846.9522.17126828396099315346.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <148405872846.9522.17126828396099315346.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148405876032.9522.5550235155877781534.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: [Qemu-devel] [PATCH 5/7] 9pfs: don't create files if pathname
 already exists
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>

As specified in the http://man.cat-v.org/plan_9/5/open :

"An attempt to create a file in a directory where the given
name already exists will be rejected"

Malicious code in a guest could for example create a named pipe and
then pass its name to the server in a RLCREATE message. This would
cause QEMU to hang in open(), waiting for someone to open the other
end of the pipe.

Let's fix this by simply using O_EXCL.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index edd7b97270e3..d9686601deda 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1545,7 +1545,7 @@ static void coroutine_fn v9fs_lcreate(void *opaque)
 
     flags = get_dotl_openflags(pdu->s, flags);
     err = v9fs_co_open2(pdu, fidp, &name, gid,
-                        flags | O_CREAT, mode, &stbuf);
+                        flags | O_CREAT | O_EXCL, mode, &stbuf);
     if (err < 0) {
         goto out;
     }
@@ -2252,7 +2252,8 @@ static void coroutine_fn v9fs_create(void *opaque)
         v9fs_path_copy(&fidp->path, &path);
     } else {
         err = v9fs_co_open2(pdu, fidp, &name, -1,
-                            omode_to_uflags(mode)|O_CREAT, perm, &stbuf);
+                            omode_to_uflags(mode) | O_CREAT | O_EXCL, perm,
+                            &stbuf);
         if (err < 0) {
             goto out;
         }
