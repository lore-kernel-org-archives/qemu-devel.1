Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD04C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 09:39:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCE3520882
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 09:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DmAX8Ci3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE3520882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGJ3H-0006ij-Oy
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 05:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1kGJ16-00024U-IL; Thu, 10 Sep 2020 05:37:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61976)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1kGJ11-0003Qt-71; Thu, 10 Sep 2020 05:37:20 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08A9XaWE098940; Thu, 10 Sep 2020 05:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=uebDz0qw0RBpt8SJgjy03PUZZR3hKTMdMn+QgrdEyoE=;
 b=DmAX8Ci3VhCqOZXl68vTFYBFwdB+YmY83MehN8iNvfn//0Af56eq3n7OIsfi+NzA9oih
 rR4eCkze/enDptagvCgjwVU1k8Bc86FFLfTPa8dnrkx1zhMNs3Mkx9h+pw+rAKoQk77q
 Zutm1XfaXWhUG9OciHdXKrohvOzFSlOzSxs9uoRA+SPOT4P43zp/VJpXhKu049UP93JP
 eeNXmT2+pzEq5XrJou/BDca5XMoKxs0wmpCrtwHg6PB0VRdEu983UMOki8Z75pj5YHIx
 iA+1qrkLH0JBh7wetMowZWpE1cRkMINA+hJEWcwurIE5i4Sc5sfidgmldHvwwWOUJgKe Eg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33fh2hh6dd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2020 05:37:13 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08A9XobE100196;
 Thu, 10 Sep 2020 05:37:13 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33fh2hh6cp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2020 05:37:12 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08A9WKfQ020288;
 Thu, 10 Sep 2020 09:37:12 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23]) by ppma03dal.us.ibm.com with ESMTP id 33c2a9fww4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2020 09:37:12 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08A9bBe437552422
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Sep 2020 09:37:11 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4108C112062;
 Thu, 10 Sep 2020 09:37:11 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF15F112064;
 Thu, 10 Sep 2020 09:37:10 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.156.134])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 10 Sep 2020 09:37:10 +0000 (GMT)
From: Collin Walling <walling@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v5 3/8] s390/sclp: read sccb from mem based on provided length
Date: Thu, 10 Sep 2020 05:36:50 -0400
Message-Id: <20200910093655.255774-4-walling@linux.ibm.com>
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
 suspectscore=2 bulkscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 malwarescore=0
 spamscore=0 mlxlogscore=754 mlxscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009100088
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

The header contained within the SCCB passed to the SCLP service call
contains the actual length of the SCCB. Instead of allocating a static
4K size for the work sccb, let's allow for a variable size determined
by the value in the header. The proper checks are already in place to
ensure the SCCB length is sufficent to store a full response and that
the length does not cross any explicitly-set boundaries.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
---
 hw/s390x/event-facility.c |  2 +-
 hw/s390x/sclp.c           | 58 ++++++++++++++++++++++-----------------
 include/hw/s390x/sclp.h   |  2 +-
 3 files changed, 35 insertions(+), 27 deletions(-)

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
index 69a8724dc7..cb8e2e8ec3 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -231,25 +231,30 @@ int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
 {
     SCLPDevice *sclp = get_sclp_device();
     SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
-    SCCB work_sccb;
-    hwaddr sccb_len = sizeof(SCCB);
+    SCCBHeader header;
+    SCCB *work_sccb;
 
-    s390_cpu_pv_mem_read(env_archcpu(env), 0, &work_sccb, sccb_len);
+    s390_cpu_pv_mem_read(env_archcpu(env), 0, &header, sizeof(SCCBHeader));
+
+    work_sccb = g_malloc0(header.length);
+    s390_cpu_pv_mem_read(env_archcpu(env), 0, work_sccb,
+                         be16_to_cpu(header.length));
 
     if (!sclp_command_code_valid(code)) {
-        work_sccb.h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
+        work_sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
         goto out_write;
     }
 
-    if (!sccb_verify_boundary(sccb, work_sccb.h.length)) {
-        work_sccb.h.response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
+    if (!sccb_verify_boundary(sccb, work_sccb->h.length)) {
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
+    g_free(work_sccb);
     sclp_c->service_interrupt(sclp, SCLP_PV_DUMMY_ADDR);
     return 0;
 }
@@ -258,9 +263,8 @@ int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
 {
     SCLPDevice *sclp = get_sclp_device();
     SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
-    SCCB work_sccb;
-
-    hwaddr sccb_len = sizeof(SCCB);
+    SCCBHeader header;
+    SCCB *work_sccb;
 
     /* first some basic checks on program checks */
     if (env->psw.mask & PSW_MASK_PSTATE) {
@@ -274,33 +278,37 @@ int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
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
+    work_sccb = g_malloc0(header.length);
+    cpu_physical_memory_read(sccb, work_sccb, be16_to_cpu(header.length));
 
     if (!sclp_command_code_valid(code)) {
-        work_sccb.h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
+        work_sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
         goto out_write;
     }
 
-    if (!sccb_verify_boundary(sccb, work_sccb.h.length)) {
-        work_sccb.h.response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
+    if (!sccb_verify_boundary(sccb, work_sccb->h.length)) {
+        work_sccb->h.response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
         goto out_write;
     }
 
-    sclp_c->execute(sclp, &work_sccb, code);
+    sclp_c->execute(sclp, work_sccb, code);
 out_write:
-    cpu_physical_memory_write(sccb, &work_sccb,
-                              be16_to_cpu(work_sccb.h.length));
-
+    cpu_physical_memory_write(sccb, work_sccb,
+                              be16_to_cpu(work_sccb->h.length));
+    g_free(work_sccb);
     sclp_c->service_interrupt(sclp, sccb);
 
     return 0;
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


