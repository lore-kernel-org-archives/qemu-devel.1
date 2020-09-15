Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FD9C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 19:46:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43E4E2078D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 19:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V7ubfznN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E4E2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIGuZ-0003A0-7H
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 15:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1kIGsm-0001Hb-VH; Tue, 15 Sep 2020 15:44:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6362)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1kIGsk-0005p6-Lf; Tue, 15 Sep 2020 15:44:52 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08FJWEY7027897; Tue, 15 Sep 2020 15:44:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9NHCM+J+9upYvWZQhUODbaJU21RMfT99EnQfGpWgy7c=;
 b=V7ubfznN4JGqtOye8IHsqzTiGdKVdBbLLjy8p9WSNcZVN+zGodyt9vJbnZAwO6frMHBV
 aVRrHkuNVfxRyF4WRXYBT8AQ04nVEya1/+DSbP2T/S+vQEcBhYgSgFuc2RQ5jts1NIfS
 Rd3rHPGIT1kR+DvD2p+vmAOWwz17+W7/l17H/YqlTsV1DjI+HUsoilXJkkFFCwnbluE1
 yp3oOOsd1y/z8/kVl1RaRRlkFkSZ2m/ygcpLoPXuySBHb/3jqRaHw8j7gf5EhpjvkcIh
 m9NZKvkpL/3fZsj5IGVBjUqKPP+QdOKYHEcc+dN4IWjzu3bV54FQwzQRMoXLMivq+xM7 tA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33k3uxrab0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2020 15:44:49 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08FJWRuW028935;
 Tue, 15 Sep 2020 15:44:48 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33k3uxraag-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2020 15:44:48 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08FJVhFm015362;
 Tue, 15 Sep 2020 19:44:47 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma05wdc.us.ibm.com with ESMTP id 33gny91tck-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2020 19:44:47 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08FJikAo52756844
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Sep 2020 19:44:46 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0634E6A04F;
 Tue, 15 Sep 2020 19:44:46 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F05EF6A047;
 Tue, 15 Sep 2020 19:44:44 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.140.9])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 15 Sep 2020 19:44:44 +0000 (GMT)
From: Collin Walling <walling@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v6 3/8] s390/sclp: read sccb from mem based on provided length
Date: Tue, 15 Sep 2020 15:44:11 -0400
Message-Id: <20200915194416.107460-4-walling@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200915194416.107460-1-walling@linux.ibm.com>
References: <20200915194416.107460-1-walling@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-15_13:2020-09-15,
 2020-09-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0
 clxscore=1015 suspectscore=0 spamscore=0 mlxlogscore=733 malwarescore=0
 bulkscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009150149
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 15:14:56
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

The header contained within the SCCB passed to the SCLP service call
contains the actual length of the SCCB. Instead of allocating a static
4K size for the work sccb, let's allow for a variable size determined
by the value in the header. The proper checks are already in place to
ensure the SCCB length is sufficent to store a full response and that
the length does not cross any explicitly-set boundaries.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
---
 hw/s390x/event-facility.c |  2 +-
 hw/s390x/sclp.c           | 55 ++++++++++++++++++++++-----------------
 include/hw/s390x/sclp.h   |  2 +-
 3 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index 645b4080c5..ed92ce510d 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -213,7 +213,7 @@ static uint16_t handle_sccb_read_events(SCLPEventFacility *ef, SCCB *sccb,
 
     event_buf = &red->ebh;
     event_buf->length = 0;
-    slen = sizeof(sccb->data);
+    slen = sccb_data_len(sccb);
 
     rc = SCLP_RC_NO_EVENT_BUFFERS_STORED;
 
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index a37cfbf534..4ae6fb400b 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -231,25 +231,29 @@ int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
 {
     SCLPDevice *sclp = get_sclp_device();
     SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
-    SCCB work_sccb;
-    hwaddr sccb_len = sizeof(SCCB);
+    SCCBHeader header;
+    g_autofree SCCB *work_sccb = NULL;
 
-    s390_cpu_pv_mem_read(env_archcpu(env), 0, &work_sccb, sccb_len);
+    s390_cpu_pv_mem_read(env_archcpu(env), 0, &header, sizeof(SCCBHeader));
+
+    work_sccb = g_malloc0(be16_to_cpu(header.length));
+    s390_cpu_pv_mem_read(env_archcpu(env), 0, work_sccb,
+                         be16_to_cpu(header.length));
 
     if (!sclp_command_code_valid(code)) {
-        work_sccb.h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
+        work_sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
         goto out_write;
     }
 
-    if (!sccb_verify_boundary(sccb, be16_to_cpu(work_sccb.h.length))) {
-        work_sccb.h.response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
+    if (!sccb_verify_boundary(sccb, be16_to_cpu(work_sccb->h.length))) {
+        work_sccb->h.response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
         goto out_write;
     }
 
-    sclp_c->execute(sclp, &work_sccb, code);
+    sclp_c->execute(sclp, work_sccb, code);
 out_write:
-    s390_cpu_pv_mem_write(env_archcpu(env), 0, &work_sccb,
-                          be16_to_cpu(work_sccb.h.length));
+    s390_cpu_pv_mem_write(env_archcpu(env), 0, work_sccb,
+                          be16_to_cpu(work_sccb->h.length));
     sclp_c->service_interrupt(sclp, SCLP_PV_DUMMY_ADDR);
     return 0;
 }
@@ -258,9 +262,8 @@ int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
 {
     SCLPDevice *sclp = get_sclp_device();
     SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
-    SCCB work_sccb;
-
-    hwaddr sccb_len = sizeof(SCCB);
+    SCCBHeader header;
+    g_autofree SCCB *work_sccb = NULL;
 
     /* first some basic checks on program checks */
     if (env->psw.mask & PSW_MASK_PSTATE) {
@@ -274,32 +277,36 @@ int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
         return -PGM_SPECIFICATION;
     }
 
+    /* the header contains the actual length of the sccb */
+    cpu_physical_memory_read(sccb, &header, sizeof(SCCBHeader));
+
+    /* Valid sccb sizes */
+    if (be16_to_cpu(header.length) < sizeof(SCCBHeader)) {
+        return -PGM_SPECIFICATION;
+    }
+
     /*
      * we want to work on a private copy of the sccb, to prevent guests
      * from playing dirty tricks by modifying the memory content after
      * the host has checked the values
      */
-    cpu_physical_memory_read(sccb, &work_sccb, sccb_len);
-
-    /* Valid sccb sizes */
-    if (be16_to_cpu(work_sccb.h.length) < sizeof(SCCBHeader)) {
-        return -PGM_SPECIFICATION;
-    }
+    work_sccb = g_malloc0(be16_to_cpu(header.length));
+    cpu_physical_memory_read(sccb, work_sccb, be16_to_cpu(header.length));
 
     if (!sclp_command_code_valid(code)) {
-        work_sccb.h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
+        work_sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
         goto out_write;
     }
 
-    if (!sccb_verify_boundary(sccb, be16_to_cpu(work_sccb.h.length))) {
-        work_sccb.h.response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
+    if (!sccb_verify_boundary(sccb, be16_to_cpu(work_sccb->h.length))) {
+        work_sccb->h.response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
         goto out_write;
     }
 
-    sclp_c->execute(sclp, &work_sccb, code);
+    sclp_c->execute(sclp, work_sccb, code);
 out_write:
-    cpu_physical_memory_write(sccb, &work_sccb,
-                              be16_to_cpu(work_sccb.h.length));
+    cpu_physical_memory_write(sccb, work_sccb,
+                              be16_to_cpu(work_sccb->h.length));
 
     sclp_c->service_interrupt(sclp, sccb);
 
diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index a87ed2a0ab..98c4727984 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -177,7 +177,7 @@ typedef struct IoaCfgSccb {
 
 typedef struct SCCB {
     SCCBHeader h;
-    char data[SCCB_DATA_LEN];
+    char data[];
  } QEMU_PACKED SCCB;
 
 #define TYPE_SCLP "sclp"
-- 
2.26.2


