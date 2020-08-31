Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFCAC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 15:13:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3EF2207EA
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 15:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YvpRJDXl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3EF2207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kClUy-0006yk-UW
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 11:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1kClR1-00082e-DT
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 11:09:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12738)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1kClQz-0005mD-2F
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 11:09:27 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07VF1t3D044264
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 11:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ewISRNzAsQs3texf9cSX1KatK1L6SRb6IyOVU2F1Vew=;
 b=YvpRJDXlilA/duiEVWI+nWgKmiRTZXGuOueTg6pvgLackeaS+BxheWudn0bWTxtpe3Q7
 FzY/vlSVmJmUN9vn5NyBZm9671vg8TYNjX4nPoU7k95uxyg1XX1Q6wSjwMXAqzGWT9x6
 QHNN0Gt09fYGREaI90oXwHegXfTx3w2ePIWdfaf01+0ht0S+PqIuke0GUaUhnsVd+/1R
 eTY2fSlIAXZoqcALZ5Lbj+9adwq9+ULvl5/D5nSvfwpJm4w0woUyGcKWkM5FVPzUSzDn
 /J+bPBN+yHrn65ewxvMNYfoahd81YUXSecn1eQuqFErgnq8WKJDcMNLHBz32PzHIyiF0 hA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3390qc5c90-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 11:09:23 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07VF25Zs045108
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 11:09:23 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3390qc5c7w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2020 11:09:23 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07VF70hJ014191;
 Mon, 31 Aug 2020 15:09:21 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma06ams.nl.ibm.com with ESMTP id 337e9gta70-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2020 15:09:21 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 07VF9IhB30474734
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2020 15:09:19 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC107A404D;
 Mon, 31 Aug 2020 15:09:18 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F175A4051;
 Mon, 31 Aug 2020 15:09:18 +0000 (GMT)
Received: from linux01.pok.stglabs.ibm.com (unknown [9.114.17.81])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 31 Aug 2020 15:09:18 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 5/5] pc-bios: s390x: Go into disabled wait when
 encountering a PGM exception
Date: Mon, 31 Aug 2020 11:09:10 -0400
Message-Id: <20200831150910.317171-6-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831150910.317171-1-frankja@linux.ibm.com>
References: <20200831150910.317171-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-31_06:2020-08-31,
 2020-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 mlxscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=1 priorityscore=1501 malwarescore=0 mlxlogscore=834
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008310086
Received-SPF: pass client-ip=148.163.156.1; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 11:09:22
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
Cc: borntraeger@de.ibm.com, thuth@redhat.com, cohuck@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's setup a PGM PSW, so we won't load 0s when a program exception
happens. Instead we'll load a disabled wait PSW.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 pc-bios/s390-ccw/start.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
index 939aac3a7c..775b45baeb 100644
--- a/pc-bios/s390-ccw/start.S
+++ b/pc-bios/s390-ccw/start.S
@@ -44,6 +44,9 @@ done:
         larl  %r2, external_new_psw
         stg   %r1, 8(%r2)
         mvc   0x1b0(16),0(%r2)
+        /* set up a pgm exception disabled wait psw */
+        larl  %r2, disabled_wait_psw
+        mvc   0x01d0(16), 0(%r2)
         j      main		/* And call C */
 
 memsetxc:
-- 
2.25.1


