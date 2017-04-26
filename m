Received: from eggs.gnu.org ([2001:4830:134:3::10]:38012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1d3ODe-0003OS-0l
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:47:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1d3ODZ-0002Nk-4d
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:47:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54609
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.vnet.ibm.com>)
	id 1d3ODY-0002Mo-Ub
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:46:57 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3QEhqEv062570
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 10:46:55 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a2q264n86-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 10:46:55 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.vnet.ibm.com>;
	Wed, 26 Apr 2017 15:46:53 +0100
From: Eric Farman <farman@linux.vnet.ibm.com>
Date: Wed, 26 Apr 2017 16:46:42 +0200
In-Reply-To: <20170426144645.12476-1-farman@linux.vnet.ibm.com>
References: <20170426144645.12476-1-farman@linux.vnet.ibm.com>
Message-Id: <20170426144645.12476-3-farman@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v1 2/5] pc-bios/s390-ccw: Remove duplicate
 blk_factor adjustment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Eric Farman <farman@linux.vnet.ibm.com>

When using virtio-scsi, we multiply the READ(10) data_size by
a block factor twice when building the I/O.  This is fine,
since it's only 1 for SCSI disks, but let's clean it up.

Signed-off-by: Eric Farman <farman@linux.vnet.ibm.com>
---
 pc-bios/s390-ccw/virtio-scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/virtio-scsi.c b/pc-bios/s390-ccw/virtio-scsi.c
index d850a8d..69b7a93 100644
--- a/pc-bios/s390-ccw/virtio-scsi.c
+++ b/pc-bios/s390-ccw/virtio-scsi.c
@@ -154,7 +154,7 @@ static bool scsi_read_10(VDev *vdev,
     VirtioCmd read_10[] = {
         { &req, sizeof(req), VRING_DESC_F_NEXT },
         { &resp, sizeof(resp), VRING_DESC_F_WRITE | VRING_DESC_F_NEXT },
-        { data, data_size * f, VRING_DESC_F_WRITE },
+        { data, data_size, VRING_DESC_F_WRITE },
     };
 
     debug_print_int("read_10  sector", sector);
-- 
2.10.2
