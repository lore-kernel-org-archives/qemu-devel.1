Received: from eggs.gnu.org ([2001:4830:134:3::10]:54974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dQZk9-0003GS-0I
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:44:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dQZk4-0002td-20
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:44:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35754
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dQZk3-0002tT-Rz
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:44:19 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5TDctZh143238
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 09:44:19 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bcx8h3srh-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 09:44:19 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 29 Jun 2017 14:44:17 +0100
From: Greg Kurz <groug@kaod.org>
Date: Thu, 29 Jun 2017 15:43:47 +0200
In-Reply-To: <1498743831-28676-1-git-send-email-groug@kaod.org>
References: <1498743831-28676-1-git-send-email-groug@kaod.org>
Message-Id: <1498743831-28676-5-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 4/8] virtio-9p: record element after sanity
 checks
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

If the guest sends a malformed request, we end up with a dangling pointer
in V9fsVirtioState. This doesn't seem to cause any bug, but let's remove
this side effect anyway.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/9pfs/virtio-9p-device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 245abd8aaef1..3380bfc0c551 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -61,7 +61,6 @@ static void handle_9p_output(VirtIODevice *vdev, VirtQueue *vq)
         }
         QEMU_BUILD_BUG_ON(sizeof(out) != 7);
 
-        v->elems[pdu->idx] = elem;
         len = iov_to_buf(elem->out_sg, elem->out_num, 0,
                          &out, sizeof(out));
         if (len != sizeof(out)) {
@@ -70,6 +69,8 @@ static void handle_9p_output(VirtIODevice *vdev, VirtQueue *vq)
             goto out_free_req;
         }
 
+        v->elems[pdu->idx] = elem;
+
         pdu_submit(pdu, &out);
     }
 
-- 
2.7.5
