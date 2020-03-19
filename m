Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CECFC4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 13:21:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E96E0208D6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 13:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E96E0208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEv71-00058m-2R
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 09:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jEv5V-0002BB-RJ
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 09:19:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jEv5T-0001b0-Nj
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 09:19:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57238)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jEv5T-0001aQ-FJ
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 09:19:51 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02JD6wKU072017
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 09:19:50 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yu8633k1r-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 09:19:50 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Thu, 19 Mar 2020 13:19:48 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 19 Mar 2020 13:19:45 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02JDJiJ550921522
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Mar 2020 13:19:45 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D17FBA405F;
 Thu, 19 Mar 2020 13:19:44 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7F233A4054;
 Thu, 19 Mar 2020 13:19:43 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.146.136])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 19 Mar 2020 13:19:43 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 10/16] s390x: protvirt: Set guest IPL PSW
Date: Thu, 19 Mar 2020 09:19:15 -0400
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200319131921.2367-1-frankja@linux.ibm.com>
References: <20200319131921.2367-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20031913-4275-0000-0000-000003AF199B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031913-4276-0000-0000-000038C44817
Message-Id: <20200319131921.2367-11-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-19_04:2020-03-19,
 2020-03-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 mlxscore=0 suspectscore=1 adultscore=0
 bulkscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003190058
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

Handling of CPU reset and setting of the IPL psw from guest storage at
offset 0 is done by a Ultravisor call. Let's only fetch it if
necessary.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 961e3ebdc530cfab..71a0c9b3e55d0cbf 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -77,16 +77,24 @@ static bool s390_cpu_has_work(CPUState *cs)
 static void s390_cpu_load_normal(CPUState *s)
 {
     S390CPU *cpu = S390_CPU(s);
-    uint64_t spsw = ldq_phys(s->as, 0);
-
-    cpu->env.psw.mask = spsw & PSW_MASK_SHORT_CTRL;
-    /*
-     * Invert short psw indication, so SIE will report a specification
-     * exception if it was not set.
-     */
-    cpu->env.psw.mask ^= PSW_MASK_SHORTPSW;
-    cpu->env.psw.addr = spsw & PSW_MASK_SHORT_ADDR;
+    uint64_t spsw;
 
+    if (!s390_is_pv()) {
+        spsw = ldq_phys(s->as, 0);
+        cpu->env.psw.mask = spsw & PSW_MASK_SHORT_CTRL;
+        /*
+         * Invert short psw indication, so SIE will report a specification
+         * exception if it was not set.
+         */
+        cpu->env.psw.mask ^= PSW_MASK_SHORTPSW;
+        cpu->env.psw.addr = spsw & PSW_MASK_SHORT_ADDR;
+    } else {
+        /*
+         * Firmware requires us to set the load state before we set
+         * the cpu to operating on protected guests.
+         */
+        s390_cpu_set_state(S390_CPU_STATE_LOAD, cpu);
+    }
     s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
 }
 #endif
-- 
2.25.1


