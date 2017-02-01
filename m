Received: from eggs.gnu.org ([2001:4830:134:3::10]:36453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cYqqY-0001ja-2K
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 04:04:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cYqqV-0004JJ-KZ
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 04:04:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1cYqqV-0004Iv-BS
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 04:04:55 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1193vmQ095646
	for <qemu-devel@nongnu.org>; Wed, 1 Feb 2017 04:04:54 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28ba36w826-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 01 Feb 2017 04:04:53 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 1 Feb 2017 09:04:50 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed,  1 Feb 2017 10:04:43 +0100
In-Reply-To: <1485939884-39956-1-git-send-email-borntraeger@de.ibm.com>
References: <1485939884-39956-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1485939884-39956-3-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PULL 2/3] s390x/kvm: fix small race reboot vs. cmma
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-stable@nongnu.org

Right now we reset all devices before we reset the cmma states.  This
can result in the host kernel discarding guest pages that were
previously in the unused state but already contain a bios or a -kernel
file before the cmma reset has finished.  This race results in random
guest crashes or hangs during very early reboot.

Fixes: 1cd4e0f6f0a6 ("s390x/cmma: clean up cmma reset")
Cc: qemu-stable@nongnu.org
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/s390x/s390-virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/s390-virtio.c b/hw/s390x/s390-virtio.c
index 0a96347..7a3a7fe 100644
--- a/hw/s390x/s390-virtio.c
+++ b/hw/s390x/s390-virtio.c
@@ -204,8 +204,8 @@ void s390_machine_reset(void)
 {
     S390CPU *ipl_cpu = S390_CPU(qemu_get_cpu(0));
 
-    qemu_devices_reset();
     s390_cmma_reset();
+    qemu_devices_reset();
     s390_crypto_reset();
 
     /* all cpus are stopped - configure and start the ipl cpu only */
-- 
2.7.4
