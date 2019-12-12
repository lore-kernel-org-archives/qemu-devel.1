Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFF6C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:44:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A85B206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A85B206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifTSA-0002zt-HV
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 13:44:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33595)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1ifStG-00081R-22
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 13:08:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1ifStE-0006IL-N1
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 13:08:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51468)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1ifStE-0006GP-EL; Thu, 12 Dec 2019 13:08:40 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBCHrEJu027787; Thu, 12 Dec 2019 13:08:28 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wuspg21cp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Dec 2019 13:08:28 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xBCHtihC001138;
 Thu, 12 Dec 2019 13:08:28 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wuspg21c4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Dec 2019 13:08:28 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBCI5uG7015700;
 Thu, 12 Dec 2019 18:08:32 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma01wdc.us.ibm.com with ESMTP id 2wr3q705t4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Dec 2019 18:08:32 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBCI8Q034457088
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Dec 2019 18:08:26 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD4E9B2065;
 Thu, 12 Dec 2019 18:08:26 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A9A43B2066;
 Thu, 12 Dec 2019 18:08:26 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 12 Dec 2019 18:08:26 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH v4 2/8] tpm_backend: Implement check whether tpm backend is
 suspended
Date: Thu, 12 Dec 2019 13:07:38 -0500
Message-Id: <20191212180744.1070446-3-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191212180744.1070446-1-stefanb@linux.vnet.ibm.com>
References: <20191212180744.1070446-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_05:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=1 adultscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=999 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912120140
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
Cc: marcandre.lureau@redhat.com, Stefan Berger <stefanb@linux.ibm.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some frontends need to know whether the backend is suspended.
Implement tpm_backend_is_suspended().

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

diff --git a/backends/tpm.c b/backends/tpm.c
index 375587e743..424c9fd485 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -163,6 +163,13 @@ size_t tpm_backend_get_buffer_size(TPMBackend *s)
     return k->get_buffer_size(s);
 }
 
+bool tpm_backend_is_suspended(TPMBackend *s)
+{
+    TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
+
+    return k->is_suspended(s);
+}
+
 TPMInfo *tpm_backend_query_tpm(TPMBackend *s)
 {
     TPMInfo *info = g_new0(TPMInfo, 1);
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index 9e7451fb52..f5d8051b45 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -84,6 +84,8 @@ struct TPMBackendClass {
     TpmTypeOptions *(*get_tpm_options)(TPMBackend *t);
 
     void (*handle_request)(TPMBackend *s, TPMBackendCmd *cmd, Error **errp);
+
+    bool (*is_suspended)(TPMBackend *t);
 };
 
 /**
@@ -213,6 +215,16 @@ void tpm_backend_finish_sync(TPMBackend *s);
  */
 TPMInfo *tpm_backend_query_tpm(TPMBackend *s);
 
+/**
+ * tpm_backend_is_suspended:
+ * @s: the backend to call into
+ *
+ * Whether the backend is suspended
+ *
+ * Returns true in case the backend is suspended
+ */
+bool tpm_backend_is_suspended(TPMBackend *s);
+
 TPMBackend *qemu_find_tpm_be(const char *id);
 
 #endif
-- 
2.21.0


