Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D6FC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:48:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A709324670
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A709324670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idIe0-00044q-6x
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 13:48:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51241)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1idIaN-00020w-5L
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 13:44:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1idIaL-0003DO-B4
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 13:44:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52782)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1idIaJ-00039g-9r
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 13:44:13 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xB6Ihlho073149
 for <qemu-devel@nongnu.org>; Fri, 6 Dec 2019 13:44:10 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wq55twfdf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 13:44:09 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Fri, 6 Dec 2019 18:44:07 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 6 Dec 2019 18:44:01 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xB6IhKxj49152398
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Dec 2019 18:43:20 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01E2B4203F;
 Fri,  6 Dec 2019 18:44:01 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9C60142041;
 Fri,  6 Dec 2019 18:44:00 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.42.200])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri,  6 Dec 2019 18:44:00 +0000 (GMT)
Subject: [for-5.0 PATCH 2/3] cpu: Introduce cpu_class_set_parent_reset()
From: Greg Kurz <groug@kaod.org>
To: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 06 Dec 2019 19:44:00 +0100
In-Reply-To: <157565782864.3897844.627720481210693346.stgit@bahia.lan>
References: <157565782864.3897844.627720481210693346.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19120618-4275-0000-0000-0000038C7C40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120618-4276-0000-0000-000038A025FE
Message-Id: <157565784026.3897844.6515055734977835356.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-06_06:2019-12-05,2019-12-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 clxscore=1034 mlxlogscore=777 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912060152
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Similarly to what we already do with qdev, use a helper to overload the
reset QOM methods of the parent in children classes, for clarity.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/core/cpu.c         |    8 ++++++++
 include/hw/core/cpu.h |    4 ++++
 2 files changed, 12 insertions(+)

diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index db1a03c6bbb3..6dad2c8488a9 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -239,6 +239,14 @@ void cpu_dump_statistics(CPUState *cpu, int flags)
     }
 }
 
+void cpu_class_set_parent_reset(CPUClass *cc,
+                                CPUReset child_reset,
+                                CPUReset *parent_reset)
+{
+    *parent_reset = cc->reset;
+    cc->reset = child_reset;
+}
+
 void cpu_reset(CPUState *cpu)
 {
     CPUClass *klass = CPU_GET_CLASS(cpu);
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 047e3972ecaf..6680f4b047f4 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1137,6 +1137,10 @@ void cpu_exec_unrealizefn(CPUState *cpu);
  */
 bool target_words_bigendian(void);
 
+void cpu_class_set_parent_reset(CPUClass *cc,
+                                CPUReset child_reset,
+                                CPUReset *parent_reset);
+
 #ifdef NEED_CPU_H
 
 #ifdef CONFIG_SOFTMMU


