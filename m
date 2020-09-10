Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7C7C2D0A7
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 09:38:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F715207EA
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 09:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eP3tl01r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F715207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGJ23-0003oq-5t
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 05:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1kGJ16-000246-DP; Thu, 10 Sep 2020 05:37:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49156)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1kGJ11-0003RH-Pq; Thu, 10 Sep 2020 05:37:20 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08A9Xd0V114686; Thu, 10 Sep 2020 05:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=0mV/AZK/BmNAaOHlJLrTxbCKSR4rbSoMfQGazJoTM00=;
 b=eP3tl01rvVujbwZbX2/Dcb4vrWGR98MqWo/8yH0VfOyc5BWvV0asIg47uoCWLv0QuS+4
 fC6qZJrXbKySPpq/eBmrooisDLk7BIqP+DyQ+djudJY4B2wCWFLtQSs8ahfJfJg/rlZ0
 pW8u/cbD3CnejkyVlgNaYNbZW/9Jwqi9FM/qPwLZXWNhzEaa4jcSdz0kdfaQ0d8E2/3w
 qKF5HniJ1nIfZxsz2MyWPnThFdTpB2U5jOrsaoDbU79/lUBmX7qQKspe5dLiu4ncrWvb
 B8nDC6XxKChS3oK6sEglpBw4XHYIh0GrtI81aTnuUtZP7qpZh6EklOnRFyEp+DFTyPBY jw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33fhgkr8b5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2020 05:37:14 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08A9Y2KY115180;
 Thu, 10 Sep 2020 05:37:13 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33fhgkr895-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2020 05:37:13 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08A9VXoL020663;
 Thu, 10 Sep 2020 09:37:11 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23]) by ppma02wdc.us.ibm.com with ESMTP id 33c2a9e84q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2020 09:37:11 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08A9bBNt48824812
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Sep 2020 09:37:11 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E9433112062;
 Thu, 10 Sep 2020 09:37:10 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9C8EF112069;
 Thu, 10 Sep 2020 09:37:10 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.156.134])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 10 Sep 2020 09:37:10 +0000 (GMT)
From: Collin Walling <walling@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v5 2/8] s390/sclp: rework sclp boundary checks
Date: Thu, 10 Sep 2020 05:36:49 -0400
Message-Id: <20200910093655.255774-3-walling@linux.ibm.com>
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
 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 mlxscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009100088
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 05:37:14
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
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

Rework the SCLP boundary check to account for different SCLP commands
(eventually) allowing different boundary sizes.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
Acked-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/sclp.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 28b973de8f..69a8724dc7 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -49,6 +49,18 @@ static inline bool sclp_command_code_valid(uint32_t code)
     return false;
 }
 
+static bool sccb_verify_boundary(uint64_t sccb_addr, uint16_t len)
+{
+    uint64_t sccb_max_addr = sccb_addr + be16_to_cpu(len) - 1;
+    uint64_t sccb_boundary = (sccb_addr & PAGE_MASK) + PAGE_SIZE;
+
+    if (sccb_max_addr < sccb_boundary) {
+        return true;
+    }
+
+    return false;
+}
+
 static void prepare_cpu_entries(MachineState *ms, CPUEntry *entry, int *count)
 {
     uint8_t features[SCCB_CPU_FEATURE_LEN] = { 0 };
@@ -229,6 +241,11 @@ int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
         goto out_write;
     }
 
+    if (!sccb_verify_boundary(sccb, work_sccb.h.length)) {
+        work_sccb.h.response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
+        goto out_write;
+    }
+
     sclp_c->execute(sclp, &work_sccb, code);
 out_write:
     s390_cpu_pv_mem_write(env_archcpu(env), 0, &work_sccb,
@@ -274,7 +291,7 @@ int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
         goto out_write;
     }
 
-    if ((sccb + be16_to_cpu(work_sccb.h.length)) > ((sccb & PAGE_MASK) + PAGE_SIZE)) {
+    if (!sccb_verify_boundary(sccb, work_sccb.h.length)) {
         work_sccb.h.response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
         goto out_write;
     }
-- 
2.26.2


