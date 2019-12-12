Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8A7C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 20:28:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51AC32077B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 20:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51AC32077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifV4B-0003CJ-Cp
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 15:28:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44018)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1ifV1b-0008W5-4u
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 15:25:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1ifV1a-0002FU-3C
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 15:25:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63396
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1ifV1Z-0002Dp-TG; Thu, 12 Dec 2019 15:25:26 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBCKOQSe030207; Thu, 12 Dec 2019 15:25:13 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wujxrngtg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Dec 2019 15:25:13 -0500
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xBCKOYFA030821;
 Thu, 12 Dec 2019 15:25:12 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wujxrngt6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Dec 2019 15:25:12 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBCKOgw8028780;
 Thu, 12 Dec 2019 20:25:12 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma04wdc.us.ibm.com with ESMTP id 2wuqrbjbf0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Dec 2019 20:25:12 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBCKPBeL49873358
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Dec 2019 20:25:11 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A2CCAAC059;
 Thu, 12 Dec 2019 20:25:11 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C12DAC064;
 Thu, 12 Dec 2019 20:25:11 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 12 Dec 2019 20:25:11 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH v5 2/5] tpm: Return bool from tpm_backend_finish_sync
Date: Thu, 12 Dec 2019 15:24:27 -0500
Message-Id: <20191212202430.1079725-3-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191212202430.1079725-1-stefanb@linux.vnet.ibm.com>
References: <20191212202430.1079725-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_06:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 clxscore=1015 suspectscore=1 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912120157
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
Cc: marcandre.lureau@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Return true in case we had to wait for an outstanding response
to come back, false otherwise.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

diff --git a/backends/tpm.c b/backends/tpm.c
index 375587e743..1f75883d8a 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -49,11 +49,15 @@ static int tpm_backend_worker_thread(gpointer data)
     return 0;
 }
 
-void tpm_backend_finish_sync(TPMBackend *s)
+bool tpm_backend_finish_sync(TPMBackend *s)
 {
+    bool ret = s->cmd != NULL;
+
     while (s->cmd) {
         aio_poll(qemu_get_aio_context(), true);
     }
+
+    return ret;
 }
 
 enum TpmType tpm_backend_get_type(TPMBackend *s)
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index 9e7451fb52..c35fe85c62 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -200,8 +200,10 @@ size_t tpm_backend_get_buffer_size(TPMBackend *s);
  *
  * Finish the pending command synchronously (this will call aio_poll()
  * on qemu main AIOContext until it ends)
+ *
+ * Returns true in case there was a pending command, false otherwise.
  */
-void tpm_backend_finish_sync(TPMBackend *s);
+bool tpm_backend_finish_sync(TPMBackend *s);
 
 /**
  * tpm_backend_query_tpm:
-- 
2.21.0


