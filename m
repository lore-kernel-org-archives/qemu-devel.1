Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C5FC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:20:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84176206FA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="artp2n9z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84176206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOK3H-0003Ew-NN
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 08:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kOJuz-0003zI-OI
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:12:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51176)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kOJud-0003Pk-8g
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601640698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tbj1u8uW6H73Lq4XOm8md4dGxbv6a164Fz6/bA8zMrY=;
 b=artp2n9zmLd5xl6xLO65d3Z8BR43dJ1w1veIIFABdcWTm7dFJAXVeHoak1/zDfplFoDLBP
 ibld06vhIc60u1ke+dtwr/jz5StmetGV/5b/DaU6RuIWqbsiKcuJfg2SOHwCHMTDunEf2c
 QSWIeokhEAr3WYNDXfOAREPOy7xPkH8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-c80II4jGNkG7cZPo_SUH-w-1; Fri, 02 Oct 2020 08:11:34 -0400
X-MC-Unique: c80II4jGNkG7cZPo_SUH-w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DCE5802B75;
 Fri,  2 Oct 2020 12:11:33 +0000 (UTC)
Received: from localhost (ovpn-112-216.ams2.redhat.com [10.36.112.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3EB3219C66;
 Fri,  2 Oct 2020 12:11:33 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 04/19] s390/sclp: read sccb from mem based on provided length
Date: Fri,  2 Oct 2020 14:11:03 +0200
Message-Id: <20201002121118.180315-5-cohuck@redhat.com>
In-Reply-To: <20201002121118.180315-1-cohuck@redhat.com>
References: <20201002121118.180315-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Collin Walling <walling@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Collin Walling <walling@linux.ibm.com>

The header contained within the SCCB passed to the SCLP service call
contains the actual length of the SCCB. Instead of allocating a static
4K size for the work sccb, let's allow for a variable size determined
by the value in the header. The proper checks are already in place to
ensure the SCCB length is sufficent to store a full response and that
the length does not cross any explicitly-set boundaries.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-Id: <20200915194416.107460-4-walling@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/event-facility.c |  2 +-
 hw/s390x/sclp.c           | 55 ++++++++++++++++++++++-----------------
 include/hw/s390x/sclp.h   |  2 +-
 3 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index 645b4080c5b9..ed92ce510d9e 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -213,7 +213,7 @@ static uint16_t handle_sccb_read_events(SCLPEventFacility *ef, SCCB *sccb,
 
     event_buf = &red->ebh;
     event_buf->length = 0;
-    slen = sizeof(sccb->data);
+    slen = sccb_data_len(sccb);
 
     rc = SCLP_RC_NO_EVENT_BUFFERS_STORED;
 
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index a37cfbf534cd..4ae6fb400b40 100644
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
index cd730772f94b..374ea83e7811 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -178,7 +178,7 @@ typedef struct IoaCfgSccb {
 
 typedef struct SCCB {
     SCCBHeader h;
-    char data[SCCB_DATA_LEN];
+    char data[];
  } QEMU_PACKED SCCB;
 
 #define TYPE_SCLP "sclp"
-- 
2.25.4


