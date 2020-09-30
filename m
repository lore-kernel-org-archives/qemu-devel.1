Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE66C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:02:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51FCB206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AFd9HzqV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51FCB206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNeZ4-0000nT-CI
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 12:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@de.ibm.com>)
 id 1kNeVs-0007Mh-CT; Wed, 30 Sep 2020 11:59:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37912
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@de.ibm.com>)
 id 1kNeVk-0001zq-7K; Wed, 30 Sep 2020 11:59:27 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08UFWZgY039564; Wed, 30 Sep 2020 11:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=XGHxuduTFCcRM6VE9K2tUBnf9hLxcHF7PyCsiQzm6yE=;
 b=AFd9HzqVgsm6WY91OY8/FVwxSehHTRb56F9YFQ92RunmOaqpp5X3ZwMSq7cNK1aC99rl
 +/PESWyrRXkx/hYfysmx2/gx8LYZrurTWR+WyS5cprEOxOVLA2lefOIu7pRPa55eMErx
 jqoDCxuyOd8y7Xt9oa9Z02IdZsLJi9vHDTXtwAk3yifBGz9jFOhB3Z865aehT3byaBK3
 6xOlMIeaD/vxT0bUWpamdfL2Smn3NH68D1unPAw33xw4oc6fwGF1UPbbFQ267JigWfMK
 QyPb8+uoX6hHH3Gq0SqZF24MTzSzKrDRixigHwAVH9DJhkop4GLW/Qe2FyUdWkDqACM5 FA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 33vvqq0sch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2020 11:59:07 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08UFWluP040690;
 Wed, 30 Sep 2020 11:59:06 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 33vvqq0sb8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2020 11:59:06 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08UFvJ4X032376;
 Wed, 30 Sep 2020 15:59:05 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma03ams.nl.ibm.com with ESMTP id 33sw984k7a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2020 15:59:04 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08UFx2Dk20578686
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2020 15:59:02 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B312B11C052;
 Wed, 30 Sep 2020 15:59:02 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D57B11C04A;
 Wed, 30 Sep 2020 15:59:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Wed, 30 Sep 2020 15:59:02 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 25651)
 id 45729E1FB0; Wed, 30 Sep 2020 17:59:02 +0200 (CEST)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] qemu-io-cmds: avoid gcc 10 warning
Date: Wed, 30 Sep 2020 17:58:58 +0200
Message-Id: <20200930155859.303148-4-borntraeger@de.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200930155859.303148-1-borntraeger@de.ibm.com>
References: <20200930155859.303148-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-30_08:2020-09-30,
 2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=1
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=858 adultscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300121
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@de.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 11:59:16
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.373, SPF_HELO_NONE=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With gcc 10 on Fedora32 I do get:

Compiling C object libblock.fa.p/qemu-io-cmds.c.o
In file included from /usr/include/stdio.h:867,
                 from /home/cborntra/REPOS/qemu/include/qemu/osdep.h:85,
                 from ../qemu-io-cmds.c:11:
In function ‘printf’,
    inlined from ‘help_oneline’ at ../qemu-io-cmds.c:2389:9,
    inlined from ‘help_all’ at ../qemu-io-cmds.c:2414:9,
    inlined from ‘help_f’ at ../qemu-io-cmds.c:2424:9:
/usr/include/bits/stdio2.h:107:10: error: ‘%s’ directive argument is null [-Werror=format-overflow=]
  107 |   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Let us check for null.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 qemu-io-cmds.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index baeae86d8c85..c2080aa398a9 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -2386,7 +2386,9 @@ static void help_oneline(const char *cmd, const cmdinfo_t *ct)
     if (cmd) {
         printf("%s ", cmd);
     } else {
-        printf("%s ", ct->name);
+        if (ct->name) {
+            printf("%s ", ct->name);
+        }
         if (ct->altname) {
             printf("(or %s) ", ct->altname);
         }
-- 
2.26.2


