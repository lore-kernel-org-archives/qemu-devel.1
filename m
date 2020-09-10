Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA71C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 09:38:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 232C1207EA
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 09:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jUDYdGAL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 232C1207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGJ21-0003hr-42
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 05:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1kGJ13-00022W-CW; Thu, 10 Sep 2020 05:37:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15570)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1kGJ11-0003Qq-3S; Thu, 10 Sep 2020 05:37:17 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08A9Zu7K106608; Thu, 10 Sep 2020 05:37:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=s3UdhajvrPAmsDLb+7RgLwyerWtlM1eOhwUZzh7OpUI=;
 b=jUDYdGALvrRpR4TBjIZiTrKUTciRtR6GNu8uIiCHNxbZEF4OsoucXLnIkqZ/Qu82NRAk
 az/C2Y13LRMbXUARI0Oje2dKjNToFL8If/+qq6WTLhTRUISTnAWU6/KGgC13LF8XZxSw
 4N+/mmEItoJqroUpGRs5bYKIqYLixvOZqpqak/qoEWvHMCyaymqT/Nd6mZvJdz6IA/zq
 4uiShyLOvh8VkyqEkmrZbKbshkKdYa59l0vbBvW/P2YzzyhPwQ7Uq5C+MknnELpRkQVz
 mlYsi5a96ymDwaNs69On04JVEUvicJtbTDTHmnXGoufqRQ3Mgxo2FJC6yPYtEo38ox0/ Xg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33fhgx84au-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2020 05:37:12 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08A9bCtM109606;
 Thu, 10 Sep 2020 05:37:12 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33fhgx84af-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2020 05:37:12 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08A9bAWX004235;
 Thu, 10 Sep 2020 09:37:11 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25]) by ppma03wdc.us.ibm.com with ESMTP id 33cebv2m86-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2020 09:37:11 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08A9bAMY31260946
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Sep 2020 09:37:10 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 920DE112066;
 Thu, 10 Sep 2020 09:37:10 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5EE5A112065;
 Thu, 10 Sep 2020 09:37:10 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.156.134])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 10 Sep 2020 09:37:10 +0000 (GMT)
From: Collin Walling <walling@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v5 1/8] s390/sclp: get machine once during read scp/cpu info
Date: Thu, 10 Sep 2020 05:36:48 -0400
Message-Id: <20200910093655.255774-2-walling@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910093655.255774-1-walling@linux.ibm.com>
References: <20200910093655.255774-1-walling@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-10_01:2020-09-10,
 2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 mlxscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 malwarescore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009100085
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 05:37:13
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: thuth@redhat.com, frankja@linux.ibm.com, david@redhat.com,
 cohuck@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, mst@redhat.com,
 pbonzini@redhat.com, sumanthk@linux.ibm.com, mihajlov@linux.ibm.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Functions within read scp/cpu info will need access to the machine
state. Let's make a call to retrieve the machine state once and
pass the appropriate data to the respective functions.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/sclp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index a0ce444b4b..28b973de8f 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -49,9 +49,8 @@ static inline bool sclp_command_code_valid(uint32_t code)
     return false;
 }
 
-static void prepare_cpu_entries(SCLPDevice *sclp, CPUEntry *entry, int *count)
+static void prepare_cpu_entries(MachineState *ms, CPUEntry *entry, int *count)
 {
-    MachineState *ms = MACHINE(qdev_get_machine());
     uint8_t features[SCCB_CPU_FEATURE_LEN] = { 0 };
     int i;
 
@@ -77,7 +76,7 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
     IplParameterBlock *ipib = s390_ipl_get_iplb();
 
     /* CPU information */
-    prepare_cpu_entries(sclp, read_info->entries, &cpu_count);
+    prepare_cpu_entries(machine, read_info->entries, &cpu_count);
     read_info->entries_cpu = cpu_to_be16(cpu_count);
     read_info->offset_cpu = cpu_to_be16(offsetof(ReadInfo, entries));
     read_info->highest_cpu = cpu_to_be16(machine->smp.max_cpus - 1);
@@ -132,10 +131,11 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
 /* Provide information about the CPU */
 static void sclp_read_cpu_info(SCLPDevice *sclp, SCCB *sccb)
 {
+    MachineState *machine = MACHINE(qdev_get_machine());
     ReadCpuInfo *cpu_info = (ReadCpuInfo *) sccb;
     int cpu_count;
 
-    prepare_cpu_entries(sclp, cpu_info->entries, &cpu_count);
+    prepare_cpu_entries(machine, cpu_info->entries, &cpu_count);
     cpu_info->nr_configured = cpu_to_be16(cpu_count);
     cpu_info->offset_configured = cpu_to_be16(offsetof(ReadCpuInfo, entries));
     cpu_info->nr_standby = cpu_to_be16(0);
-- 
2.26.2


