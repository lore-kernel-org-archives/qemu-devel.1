Received: from eggs.gnu.org ([2001:4830:134:3::10]:53118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dSOUt-00088g-IP
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:08:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dSOUp-0003Wx-AS
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:08:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48993)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dSOUp-0003WI-0Q
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:08:07 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v64E4VDD000809
	for <qemu-devel@nongnu.org>; Tue, 4 Jul 2017 10:08:06 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bg6j6jt07-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 10:08:05 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 4 Jul 2017 15:08:03 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue,  4 Jul 2017 16:07:54 +0200
In-Reply-To: <1499177279-131407-1-git-send-email-borntraeger@de.ibm.com>
References: <1499177279-131407-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1499177279-131407-3-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 2/7] s390x/3270: fix instruction interception
 handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

Commit bab482d7405f ("s390x/css: ccw translation infrastructure")
introduced instruction interception handler for different types of
subchannels. For emulated 3270 devices, we should assign the virtual
subchannel handler to them during device realization process, or 3270
will not work.

Fixes: bab482d7405f ("s390x/css: ccw translation infrastructure")

Reviewed-by: Jing Liu <liujbjl@linux.vnet.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/s390x/3270-ccw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/s390x/3270-ccw.c b/hw/s390x/3270-ccw.c
index 6e6eee4..1554aa2 100644
--- a/hw/s390x/3270-ccw.c
+++ b/hw/s390x/3270-ccw.c
@@ -126,6 +126,7 @@ static void emulated_ccw_3270_realize(DeviceState *ds, Error **errp)
     sch->id.cu_type = EMULATED_CCW_3270_CU_TYPE;
     css_sch_build_virtual_schib(sch, (uint8_t)chpid,
                                 EMULATED_CCW_3270_CHPID_TYPE);
+    sch->do_subchannel_work = do_subchannel_work_virtual;
     sch->ccw_cb = emulated_ccw_3270_cb;
 
     ck->init(dev, &err);
-- 
2.7.4
