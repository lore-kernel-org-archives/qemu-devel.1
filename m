Received: from eggs.gnu.org ([2001:4830:134:3::10]:43856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eBnf9-0006cN-OS
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 15:06:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eBnf5-0001vb-P7
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 15:06:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eBnf5-0001vK-Fu
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 15:06:23 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA6K5P23091731
	for <qemu-devel@nongnu.org>; Mon, 6 Nov 2017 15:06:15 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e2wmjjm52-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 15:06:14 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 6 Nov 2017 20:06:11 -0000
From: Greg Kurz <groug@kaod.org>
Date: Mon,  6 Nov 2017 21:05:54 +0100
In-Reply-To: <20171106200554.5894-1-groug@kaod.org>
References: <20171106200554.5894-1-groug@kaod.org>
Message-Id: <20171106200554.5894-3-groug@kaod.org>
Subject: [Qemu-devel] [PULL 2/2] 9pfs: fix v9fs_mark_fids_unreclaim() return
 value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

The return value of v9fs_mark_fids_unreclaim() is then propagated to
pdu_complete(). It should be a negative errno, not -1.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 hw/9pfs/9p.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index f8bbac251dc9..52d46632fe15 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -512,7 +512,7 @@ static int coroutine_fn v9fs_mark_fids_unreclaim(V9fsPDU *pdu, V9fsPath *path)
             /* reopen the file/dir if already closed */
             err = v9fs_reopen_fid(pdu, fidp);
             if (err < 0) {
-                return -1;
+                return err;
             }
             /*
              * Go back to head of fid list because
-- 
2.13.6
