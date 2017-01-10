Received: from eggs.gnu.org ([2001:4830:134:3::10]:53317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cQxTM-00009U-3g
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:32:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cQxTI-0002H3-58
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:32:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51459
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cQxTH-0002Gv-U0
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:32:20 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0AET2bb034755
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 09:32:19 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27vwk9te95-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 09:32:19 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 10 Jan 2017 09:32:18 -0500
From: Greg Kurz <groug@kaod.org>
Date: Tue, 10 Jan 2017 15:32:15 +0100
In-Reply-To: <148405872846.9522.17126828396099315346.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <148405872846.9522.17126828396099315346.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148405873540.9522.2224634666374633695.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: [Qemu-devel] [PATCH 1/7] 9pfs: restrict open to regular files and
 directories
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

It really does not make sense for the 9P server to open anything else but
a regular file or a directory.

Malicious code in a guest could for example create a named pipe, associate
it to a valid fid and pass it to the server in a RLOPEN message. This would
cause QEMU to hang in open(), waiting for someone to open the other end of
the pipe.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index fa58877570f6..edd7b97270e3 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1462,7 +1462,7 @@ static void coroutine_fn v9fs_open(void *opaque)
             goto out;
         }
         err += offset;
-    } else {
+    } else if (S_ISREG(stbuf.st_mode)) {
         if (s->proto_version == V9FS_PROTO_2000L) {
             flags = get_dotl_openflags(s, mode);
         } else {
@@ -1494,6 +1494,9 @@ static void coroutine_fn v9fs_open(void *opaque)
             goto out;
         }
         err += offset;
+    } else {
+        err = -EINVAL;
+        goto out;
     }
     trace_v9fs_open_return(pdu->tag, pdu->id,
                            qid.type, qid.version, qid.path, iounit);
