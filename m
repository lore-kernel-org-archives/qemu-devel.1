Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6D9C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:39:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D37D3207DE
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZWgB0zUI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D37D3207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFvdy-00028J-MO
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 04:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovmurik@linux.vnet.ibm.com>)
 id 1kFvb6-0006PJ-1s
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 04:36:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62214)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovmurik@linux.vnet.ibm.com>)
 id 1kFvb4-0006oo-1S
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 04:36:55 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0898WAcB127410
 for <qemu-devel@nongnu.org>; Wed, 9 Sep 2020 04:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=3Ynz+pnyvYzTN+xw2lWfQw6lWn1cSFqzPVUU0qUqbHk=;
 b=ZWgB0zUIfi8qZIMUywwDZG8vdwM0BhJ4SH6aw0mV10Wzt2o2x/AJ0mL+x5hBXxeA6aQT
 imTt8wGmJX5VeLNEouvVEXuNHN7AaBujcoBjWGXK39n3vkVJLljMwhctbtvJTLpwU3QE
 SlD+zke996FXIik+Rvx0kMUWdebsRkFZphfDcZmwzlGu4EBrT6bRciDDKBeXsd9875Sh
 zolQ4E5PXXOYdDcFUIyy+elY4NrmSErxljyh1CvD0DwvYkwgo93z9refj247ikkS0AXy
 NesUd85OjpmDuiO7mVc4G/sloEZqN2qYOZFU9ytou4WZ0qYUqPWgX/mzBFFuWMsbZN6A fQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33eu11s9xr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 04:36:53 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0898WgIO128616
 for <qemu-devel@nongnu.org>; Wed, 9 Sep 2020 04:36:52 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33eu11s9xd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Sep 2020 04:36:52 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0898SPpK016498;
 Wed, 9 Sep 2020 08:36:52 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25]) by ppma02dal.us.ibm.com with ESMTP id 33c2a9d9gf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Sep 2020 08:36:52 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0898ap3E53608860
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 9 Sep 2020 08:36:51 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 61E57AE05C;
 Wed,  9 Sep 2020 08:36:51 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 47B2AAE060;
 Wed,  9 Sep 2020 08:36:51 +0000 (GMT)
Received: from amdrome1.watson.ibm.com (unknown [9.2.130.16])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed,  9 Sep 2020 08:36:51 +0000 (GMT)
From: Dov Murik <dovmurik@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] hw/timer/hpet: Fix debug format strings
Date: Wed,  9 Sep 2020 08:36:50 +0000
Message-Id: <20200909083650.46771-3-dovmurik@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200909083650.46771-1-dovmurik@linux.vnet.ibm.com>
References: <20200909083650.46771-1-dovmurik@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-09_03:2020-09-08,
 2020-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 suspectscore=1 mlxlogscore=999 mlxscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009090073
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=dovmurik@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 02:27:07
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Dov Murik <dovmurik@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix compiler errors when compiling with -DHPET_DEBUG due to mismatch
between format string token "%x" and the argument type uint64_t.

Also "%#x" is replaced by "0x%" PRIx64 according to the coding style.

Signed-off-by: Dov Murik <dovmurik@linux.vnet.ibm.com>
---
 hw/timer/hpet.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index b683f64f1d..73d2168c32 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -495,7 +495,8 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
     HPETState *s = opaque;
     uint64_t old_val, new_val, val, index;
 
-    DPRINTF("qemu: Enter hpet_ram_writel at %" PRIx64 " = %#x\n", addr, value);
+    DPRINTF("qemu: Enter hpet_ram_writel at %" PRIx64 " = 0x%" PRIx64 "\n",
+            addr, value);
     index = addr;
     old_val = hpet_ram_read(opaque, addr, 4);
     new_val = value;
@@ -505,7 +506,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
         uint8_t timer_id = (addr - 0x100) / 0x20;
         HPETTimer *timer = &s->timer[timer_id];
 
-        DPRINTF("qemu: hpet_ram_writel timer_id = %#x\n", timer_id);
+        DPRINTF("qemu: hpet_ram_writel timer_id = 0x%x\n", timer_id);
         if (timer_id > s->num_timers) {
             DPRINTF("qemu: timer id out of range\n");
             return;
@@ -637,8 +638,8 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
             }
             s->hpet_counter =
                 (s->hpet_counter & 0xffffffff00000000ULL) | value;
-            DPRINTF("qemu: HPET counter written. ctr = %#x -> %" PRIx64 "\n",
-                    value, s->hpet_counter);
+            DPRINTF("qemu: HPET counter written. ctr = 0x%" PRIx64 " -> "
+                    "%" PRIx64 "\n", value, s->hpet_counter);
             break;
         case HPET_COUNTER + 4:
             if (hpet_enabled(s)) {
@@ -646,8 +647,8 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
             }
             s->hpet_counter =
                 (s->hpet_counter & 0xffffffffULL) | (((uint64_t)value) << 32);
-            DPRINTF("qemu: HPET counter + 4 written. ctr = %#x -> %" PRIx64 "\n",
-                    value, s->hpet_counter);
+            DPRINTF("qemu: HPET counter + 4 written. ctr = 0x%" PRIx64 " -> "
+                    "%" PRIx64 "\n", value, s->hpet_counter);
             break;
         default:
             DPRINTF("qemu: invalid hpet_ram_writel\n");
-- 
2.20.1


