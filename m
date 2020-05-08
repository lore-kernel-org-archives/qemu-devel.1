Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF6BC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 20:06:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2291F20A8B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 20:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2291F20A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX9Gp-0006T0-C0
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 16:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1jX9G2-0005LJ-7D
 for qemu-devel@nongnu.org; Fri, 08 May 2020 16:06:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1640
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1jX9G1-0002Zm-EF
 for qemu-devel@nongnu.org; Fri, 08 May 2020 16:06:05 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 048K5xKT178430; Fri, 8 May 2020 16:06:04 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 30vtwcy6fe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2020 16:06:04 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 048K63kT178832;
 Fri, 8 May 2020 16:06:03 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0b-001b2d01.pphosted.com with ESMTP id 30vtwcy60w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2020 16:06:02 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 048Jthv3026823;
 Fri, 8 May 2020 20:04:50 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma02dal.us.ibm.com with ESMTP id 30s0g7hr21-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2020 20:04:50 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 048K4mHl11796982
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 May 2020 20:04:48 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0CC97C6059;
 Fri,  8 May 2020 20:04:49 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F180C6062;
 Fri,  8 May 2020 20:04:48 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri,  8 May 2020 20:04:48 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 1/1] hw/tpm: fix usage of bool in tpm-tis.c
Date: Fri,  8 May 2020 16:04:46 -0400
Message-Id: <20200508200446.1277398-2-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200508200446.1277398-1-stefanb@linux.vnet.ibm.com>
References: <20200508200446.1277398-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-08_18:2020-05-08,
 2020-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 mlxscore=0 impostorscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 suspectscore=1 phishscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2005080165
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=stefanb@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 15:43:05
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, Thomas Huth <thuth@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>, Jafar Abdi <cafer.abdi@gmail.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Clean up wrong usage of FALSE and TRUE in places that use "bool" from stdbool.h.

FALSE and TRUE (with capital letters) are the constants defined by glib for
being used with the "gboolean" type of glib. But some parts of the code also use
TRUE and FALSE for variables that are declared as "bool" (the type from <stdbool.h>).

Signed-off-by: Jafar Abdi <cafer.abdi@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/tpm_tis_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/tpm/tpm_tis_common.c b/hw/tpm/tpm_tis_common.c
index 9ce64d4836..5cd4006d2f 100644
--- a/hw/tpm/tpm_tis_common.c
+++ b/hw/tpm/tpm_tis_common.c
@@ -536,7 +536,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr addr,
             while ((TPM_TIS_IS_VALID_LOCTY(s->active_locty) &&
                     locty > s->active_locty) ||
                     !TPM_TIS_IS_VALID_LOCTY(s->active_locty)) {
-                bool higher_seize = FALSE;
+                bool higher_seize = false;
 
                 /* already a pending SEIZE ? */
                 if ((s->loc[locty].access & TPM_TIS_ACCESS_SEIZE)) {
@@ -546,7 +546,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr addr,
                 /* check for ongoing seize by a higher locality */
                 for (l = locty + 1; l < TPM_TIS_NUM_LOCALITIES; l++) {
                     if ((s->loc[l].access & TPM_TIS_ACCESS_SEIZE)) {
-                        higher_seize = TRUE;
+                        higher_seize = false;
                         break;
                     }
                 }
-- 
2.24.1


