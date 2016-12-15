Received: from eggs.gnu.org ([2001:4830:134:3::10]:42076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBc-0001uo-Hq
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBZ-00014c-F1
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55484
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKBZ-00013r-8R
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:13 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0hcBO007215
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:12 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bdm3h0k1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:12 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 19:46:12 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:06 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-13-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 12/67] scsi-disk: change disk serial length
 from 20 to 36
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Rony Weng <ronyweng@synology.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Rony Weng <ronyweng@synology.com>

Openstack Cinder assigns volume a 36 characters uuid as serial.
QEMU will shrinks the uuid to 20 characters, which does not match
the original uuid.

Note that there is no limit to the length of the serial number in
the SCSI spec.  20 was copy-pasted from virtio-blk which in turn was
copy-pasted from ATA; 36 is even more arbitrary.  However, bumping it
up too much might cause issues (e.g. 252 seems to make sense because
then the maximum amount of returned data is 256; but who knows there's
no off-by-one somewhere for such a nicely rounded number).

Signed-off-by: Rony Weng <ronyweng@synology.com>
Message-Id: <1472457138-23386-1-git-send-email-ronyweng@synology.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 48b6206305b8d56524ac2ee347b68e6e0a528559)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/scsi/scsi-disk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 836a155..0e1bb68 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -599,8 +599,8 @@ static int scsi_disk_emulate_inquiry(SCSIRequest *req, uint8_t *outbuf)
             }
 
             l = strlen(s->serial);
-            if (l > 20) {
-                l = 20;
+            if (l > 36) {
+                l = 36;
             }
 
             DPRINTF("Inquiry EVPD[Serial number] "
-- 
1.9.1
