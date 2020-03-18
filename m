Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2639C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 14:34:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAA1F20773
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 14:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA1F20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEZmV-0006jF-UY
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 10:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58409)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jEZj9-0002gH-65
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jEZj7-0001Uq-Pj
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:31:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30892)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jEZj7-0001SG-H4
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:31:21 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02IETcuj142775
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 10:31:20 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yu8ad9thv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 10:31:19 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Wed, 18 Mar 2020 14:31:13 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 18 Mar 2020 14:31:12 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 02IEUASR5308838
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Mar 2020 14:30:11 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C331442041;
 Wed, 18 Mar 2020 14:31:11 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A7CC742042;
 Wed, 18 Mar 2020 14:31:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.78.199])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 18 Mar 2020 14:31:10 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 04/16] s390x: protvirt: Add migration blocker
Date: Wed, 18 Mar 2020 10:30:35 -0400
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200318143047.2335-1-frankja@linux.ibm.com>
References: <20200318143047.2335-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20031814-0008-0000-0000-0000035F6376
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031814-0009-0000-0000-00004A80BE1F
Message-Id: <20200318143047.2335-5-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-18_06:2020-03-18,
 2020-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 malwarescore=0 impostorscore=0 suspectscore=3 bulkscore=0 mlxlogscore=628
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003180067
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

Migration is not yet supported.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index afd499c59fffc848..8013c82236a36724 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -44,6 +44,9 @@
 #include "sysemu/sysemu.h"
 #include "hw/s390x/pv.h"
 #include <linux/kvm.h>
+#include "migration/blocker.h"
+
+static Error *pv_mig_blocker;
 
 S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
 {
@@ -323,15 +326,30 @@ static void s390_machine_unprotect(S390CcwMachineState *ms)
 {
     s390_pv_vm_disable();
     ms->pv = false;
+    migrate_del_blocker(pv_mig_blocker);
+    error_free_or_abort(&pv_mig_blocker);
 }
 
 static int s390_machine_protect(S390CcwMachineState *ms)
 {
+    Error *local_err = NULL;
     int rc;
 
+    error_setg(&pv_mig_blocker,
+               "protected VMs are currently not migrateable.");
+    rc = migrate_add_blocker(pv_mig_blocker, &local_err);
+    if (rc) {
+        error_report_err(local_err);
+        error_free_or_abort(&pv_mig_blocker);
+        return rc;
+    }
+
     /* Create SE VM */
     rc = s390_pv_vm_enable();
     if (rc) {
+        error_report_err(local_err);
+        migrate_del_blocker(pv_mig_blocker);
+        error_free_or_abort(&pv_mig_blocker);
         return rc;
     }
 
-- 
2.25.1


