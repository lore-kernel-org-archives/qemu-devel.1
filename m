Received: from eggs.gnu.org ([2001:4830:134:3::10]:40721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d1TBb-00014d-W1
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 03:41:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d1TBY-0000fH-MN
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 03:41:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44189
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d1TBY-0000ez-4V
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 03:40:56 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3L7cb3B008381
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 03:40:55 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29xucaxkmh-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 03:40:55 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Fri, 21 Apr 2017 08:40:53 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Fri, 21 Apr 2017 09:40:35 +0200
In-Reply-To: <20170421074038.774-1-cornelia.huck@de.ibm.com>
References: <20170421074038.774-1-cornelia.huck@de.ibm.com>
Message-Id: <20170421074038.774-9-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL 08/11] s390x: initialize flic before I/O
 subsystems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, Fei Li <sherrylf@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Fei Li <sherrylf@linux.vnet.ibm.com>

Let's have a flic before we move on to initialize more specific
subsystems that make use of it.

Signed-off-by: Fei Li <sherrylf@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/s390-virtio-ccw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 5ac315ac78..04bd0ebe40 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -113,12 +113,13 @@ static void ccw_init(MachineState *machine)
     s390_sclp_init();
     s390_memory_init(machine->ram_size);
 
+    s390_flic_init();
+
     /* get a BUS */
     css_bus = virtual_css_bus_init();
     s390_init_ipl_dev(machine->kernel_filename, machine->kernel_cmdline,
                       machine->initrd_filename, "s390-ccw.img",
                       "s390-netboot.img", true);
-    s390_flic_init();
 
     dev = qdev_create(NULL, TYPE_S390_PCI_HOST_BRIDGE);
     object_property_add_child(qdev_get_machine(), TYPE_S390_PCI_HOST_BRIDGE,
-- 
2.11.0
