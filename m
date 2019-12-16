Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AA0C2D0C3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 15:02:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B710206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 15:02:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B710206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igrtc-0003nx-SY
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 10:02:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49675)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1igrsH-0002h5-Kr
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:01:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1igrsG-0006GF-4P
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:01:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46120
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1igrsF-0006E8-VQ
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:01:28 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBGEunge098194
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 10:01:20 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wwdt9ev8s-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 10:01:20 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Mon, 16 Dec 2019 15:01:17 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 16 Dec 2019 15:01:14 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBGF1D0930146730
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2019 15:01:13 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 29FABA405F;
 Mon, 16 Dec 2019 15:01:13 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B8D77A405B;
 Mon, 16 Dec 2019 15:01:12 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.39.6])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 16 Dec 2019 15:01:12 +0000 (GMT)
Subject: [PATCH v3 1/2] cpu: Introduce cpu_class_set_parent_reset()
From: Greg Kurz <groug@kaod.org>
To: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 16 Dec 2019 16:01:12 +0100
In-Reply-To: <157650846660.354886.16810288202617432561.stgit@bahia.lan>
References: <157650846660.354886.16810288202617432561.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19121615-0020-0000-0000-00000398C334
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121615-0021-0000-0000-000021EFDA96
Message-Id: <157650847239.354886.2782881118916307978.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-16_05:2019-12-16,2019-12-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1034 mlxscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=992 malwarescore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912160132
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 hw/core/cpu.c         |    8 ++++++++
 include/hw/core/cpu.h |    4 ++++
 2 files changed, 12 insertions(+)

diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index db1a03c6bbb3..fde5fd395b10 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -239,6 +239,14 @@ void cpu_dump_statistics(CPUState *cpu, int flags)
     }
 }
 
+void cpu_class_set_parent_reset(CPUClass *cc,
+                                void (*child_reset)(CPUState *cpu),
+                                void (**parent_reset)(CPUState *cpu))
+{
+    *parent_reset = cc->reset;
+    cc->reset = child_reset;
+}
+
 void cpu_reset(CPUState *cpu)
 {
     CPUClass *klass = CPU_GET_CLASS(cpu);
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 77c6f0529903..73e9a869a41c 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1135,6 +1135,10 @@ void cpu_exec_unrealizefn(CPUState *cpu);
  */
 bool target_words_bigendian(void);
 
+void cpu_class_set_parent_reset(CPUClass *cc,
+                                void (*child_reset)(CPUState *cpu),
+                                void (**parent_reset)(CPUState *cpu));
+
 #ifdef NEED_CPU_H
 
 #ifdef CONFIG_SOFTMMU


