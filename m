Received: from eggs.gnu.org ([2001:4830:134:3::10]:37417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1csmmV-00058P-E8
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:47:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1csmmS-0005AL-CR
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:47:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47645)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1csmmS-00059s-2v
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:47:08 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2S8kbdA069291
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 04:47:07 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29fm1jtc12-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 04:47:06 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 28 Mar 2017 09:47:04 +0100
From: Greg Kurz <groug@kaod.org>
Date: Tue, 28 Mar 2017 10:46:34 +0200
In-Reply-To: <1490690794-19023-1-git-send-email-groug@kaod.org>
References: <1490690794-19023-1-git-send-email-groug@kaod.org>
Message-Id: <1490690794-19023-3-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 2/2] tests/virtio-9p-test: Don't call
 le*_to_cpus on fields of packed struct
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

From: Peter Maydell <peter.maydell@linaro.org>

For a packed struct like 'P9Hdr' the fields within it may not be
aligned as much as the natural alignment for their types.  This means
it is not valid to pass the address of such a field to a function
like le32_to_cpus() which operate on uint32_t* and assume alignment.
Doing this results in a SIGBUS on hosts like SPARC which have strict
alignment requirements.

Use ldl_le_p() instead, which is specified to correctly handle
unaligned pointers.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 tests/virtio-9p-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
index 43a1ad813fda..ad33d963876f 100644
--- a/tests/virtio-9p-test.c
+++ b/tests/virtio-9p-test.c
@@ -256,8 +256,8 @@ static void v9fs_req_recv(P9Req *req, uint8_t id)
         qvirtio_wait_queue_isr(v9p->dev, v9p->vq, 1000 * 1000);
 
         v9fs_memread(req, &hdr, 7);
-        le32_to_cpus(&hdr.size);
-        le16_to_cpus(&hdr.tag);
+        hdr.size = ldl_le_p(&hdr.size);
+        hdr.tag = lduw_le_p(&hdr.tag);
         if (hdr.size >= 7) {
             break;
         }
-- 
2.7.4
