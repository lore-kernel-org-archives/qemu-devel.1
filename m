Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6471BC4BA10
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 12:21:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3289420838
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 12:21:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3289420838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6vhE-00041v-BY
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 07:21:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53184)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1j6vgL-0002Dd-QM
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 07:20:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1j6vgK-0007i4-Ro
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 07:20:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42964
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1j6vgK-0007hk-Nc
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 07:20:52 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01QCKj1G113369
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 07:20:52 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ydcp8d8pc-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 07:20:51 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Wed, 26 Feb 2020 12:20:49 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 26 Feb 2020 12:20:46 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01QCKj5r48562354
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Feb 2020 12:20:45 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 38E2F11C05C;
 Wed, 26 Feb 2020 12:20:45 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7560611C052;
 Wed, 26 Feb 2020 12:20:44 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.152.224.212])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 26 Feb 2020 12:20:44 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 01/18] s390x: Use constant for ESA PSW address
Date: Wed, 26 Feb 2020 07:20:21 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200226122038.61481-1-frankja@linux.ibm.com>
References: <20200226122038.61481-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022612-0012-0000-0000-0000038A6FEE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022612-0013-0000-0000-000021C715CF
Message-Id: <20200226122038.61481-2-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-26_04:2020-02-26,
 2020-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 mlxlogscore=919 suspectscore=1 priorityscore=1501
 mlxscore=0 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002260092
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
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

Lets make it a bit more clear that we're extracting the 31 bit address
from the short psw.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 hw/s390x/ipl.c     | 2 +-
 target/s390x/cpu.c | 4 ++--
 target/s390x/cpu.h | 1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 7773499d7f..42e21e7a6a 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -179,7 +179,7 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
                 /* if not Linux load the address of the (short) IPL PSW */
                 ipl_psw = rom_ptr(4, 4);
                 if (ipl_psw) {
-                    pentry = be32_to_cpu(*ipl_psw) & 0x7fffffffUL;
+                    pentry = be32_to_cpu(*ipl_psw) & PSW_MASK_ESA_ADDR;
                 } else {
                     error_setg(&err, "Could not get IPL PSW");
                     goto error;
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 8da1905485..43360912a0 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -78,13 +78,13 @@ static void s390_cpu_load_normal(CPUState *s)
     S390CPU *cpu = S390_CPU(s);
     uint64_t spsw = ldq_phys(s->as, 0);
 
-    cpu->env.psw.mask = spsw & 0xffffffff80000000ULL;
+    cpu->env.psw.mask = spsw & PSW_MASK_ESA_MASK;
     /*
      * Invert short psw indication, so SIE will report a specification
      * exception if it was not set.
      */
     cpu->env.psw.mask ^= PSW_MASK_SHORTPSW;
-    cpu->env.psw.addr = spsw & 0x7fffffffULL;
+    cpu->env.psw.addr = spsw & PSW_MASK_ESA_ADDR;
 
     s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
 }
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 8a557fd8d1..74e66fe0c2 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -277,6 +277,7 @@ extern const VMStateDescription vmstate_s390_cpu;
 #define PSW_MASK_64             0x0000000100000000ULL
 #define PSW_MASK_32             0x0000000080000000ULL
 #define PSW_MASK_ESA_ADDR       0x000000007fffffffULL
+#define PSW_MASK_ESA_MASK       0xffffffff80000000ULL
 
 #undef PSW_ASC_PRIMARY
 #undef PSW_ASC_ACCREG
-- 
2.20.1


