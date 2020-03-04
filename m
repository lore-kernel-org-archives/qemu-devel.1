Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4C5C3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 11:44:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D9092146E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 11:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D9092146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9SSA-0008Lq-MI
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 06:44:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45091)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1j9SQs-00063N-QL
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 06:43:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1j9SQr-0007c4-Pd
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 06:43:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40238)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1j9SQr-0007bF-I7
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 06:43:21 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 024BdaDs139651
 for <qemu-devel@nongnu.org>; Wed, 4 Mar 2020 06:43:20 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yj3es18fr-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 06:43:20 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Wed, 4 Mar 2020 11:43:18 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 4 Mar 2020 11:43:14 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 024BhEMb58917078
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Mar 2020 11:43:14 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 04F3242041;
 Wed,  4 Mar 2020 11:43:14 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3FA894203F;
 Wed,  4 Mar 2020 11:43:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.152.224.55])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  4 Mar 2020 11:43:13 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 06/18] s390x: protvirt: Inhibit balloon when switching to
 protected mode
Date: Wed,  4 Mar 2020 06:42:19 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304114231.23493-1-frankja@linux.ibm.com>
References: <20200304114231.23493-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20030411-0020-0000-0000-000003B06305
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030411-0021-0000-0000-000022089807
Message-Id: <20200304114231.23493-7-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-04_01:2020-03-04,
 2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 phishscore=0 spamscore=0
 clxscore=1015 suspectscore=1 bulkscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=846 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040090
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ballooning in protected VMs can only be done when the guest shares the
pages it gives to the host. If pages are not shared, the integrity
checks will fail once those pages have been altered and are given back
to the guest.

Hence, until we have a solution for this in the guest kernel, we
inhibit ballooning when switching into protected mode and reverse that
once we move out of it.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 038bad54cd..b039178004 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -41,6 +41,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/s390x/tod.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/balloon.h"
 #include "hw/s390x/pv.h"
 #include <linux/kvm.h>
 #include "migration/blocker.h"
@@ -335,6 +336,7 @@ static void s390_machine_unprotect(S390CcwMachineState *ms)
         ms->pv = false;
     }
     migrate_del_blocker(pv_mig_blocker);
+    qemu_balloon_inhibit(false);
 }
 
 static int s390_machine_protect(S390CcwMachineState *ms)
@@ -343,6 +345,7 @@ static int s390_machine_protect(S390CcwMachineState *ms)
     CPUState *t;
     int rc = -1;
 
+    qemu_balloon_inhibit(true);
     if (!pv_mig_blocker) {
         error_setg(&pv_mig_blocker,
                    "protected VMs are currently not migrateable.");
-- 
2.20.1


