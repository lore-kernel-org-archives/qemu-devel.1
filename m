Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE4CC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 06:01:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAD62206C9
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 06:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aa3NXd+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD62206C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHhYr-0001FB-R4
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 02:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovmurik@linux.vnet.ibm.com>)
 id 1kHhYE-0000oz-LT
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 02:01:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45558)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovmurik@linux.vnet.ibm.com>)
 id 1kHhYC-0001hF-I6
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 02:01:18 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08E5VrA8016541
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 02:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=nP3Eugv5dluo/FXEPi0IxHvQJaTGM74RNS4Iyd5n0q4=;
 b=aa3NXd+WdEnetyPfs0bZu7K48cvIn6bCRZGuqWlOQKXkFuvhflu4wlklGBIOQnTXUwpU
 UbfvnV/1mDB8PBIxWUjg0HDvseoyZrHuH1UIk4VAhp2O/h3Y3wO6pwNvnWcIjTiWJM+F
 mDMUtpoBK+U9uhinsuYW7hDj//XipoQqtqUcdeuEWgh6i4MzEv3OVhvOgKAUGUejkevL
 nABGHiw5IzuJLpXV/fkQGG3zcNQLg1GSgRKcaNT2hLCaTeK4kfwlK7aPdaW/No/OQDYU
 qbzK8wETHivsukNp5vRZXReNOh0tBw/ZIGG0p1KUxZYlavweu5ZIkhK2v9b7dlqiOTjd kQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33j2830tks-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 02:01:12 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08E5rCTX128205
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 02:01:12 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33j2830tkb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2020 02:01:12 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08E5wCC7030225;
 Mon, 14 Sep 2020 06:01:11 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma01dal.us.ibm.com with ESMTP id 33gny8rx49-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2020 06:01:11 +0000
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08E61AfQ65143054
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Sep 2020 06:01:10 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E3C7F136055;
 Mon, 14 Sep 2020 06:01:09 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC74B13605D;
 Mon, 14 Sep 2020 06:01:09 +0000 (GMT)
Received: from amdrome1.watson.ibm.com (unknown [9.2.130.16])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon, 14 Sep 2020 06:01:09 +0000 (GMT)
From: Dov Murik <dovmurik@linux.vnet.ibm.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH] checkpatch: Detect '%#' or '%0#' in printf-style format
 strings
Date: Mon, 14 Sep 2020 06:01:09 +0000
Message-Id: <20200914060109.69583-1-dovmurik@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-13_09:2020-09-10,
 2020-09-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009140045
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dovmurik@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:01:13
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
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
Cc: Dov Murik <dovmurik@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

According to the coding style document, we should use literal '0x' prefix
instead of printf's '#' flag (which appears as '%#' or '%0#' in the format
string).  Add a checkpatch rule to enforce that.

Note that checkpatch already had a similar rule for trace-events files.

Example usage:

  $ scripts/checkpatch.pl --file chardev/baum.c
  ...
  ERROR: Don't use '#' flag of printf format ('%#') in format strings, use '0x' prefix instead
  #366: FILE: chardev/baum.c:366:
  +            DPRINTF("Broken packet %#2x, tossing\n", req); \
  ...
  ERROR: Don't use '#' flag of printf format ('%#') in format strings, use '0x' prefix instead
  #472: FILE: chardev/baum.c:472:
  +        DPRINTF("unrecognized request %0#2x\n", req);
  ...

Signed-off-by: Dov Murik <dovmurik@linux.vnet.ibm.com>
---
 scripts/checkpatch.pl | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index bd3faa154c..6ec2a9f6a1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2891,6 +2891,18 @@ sub process {
 			}
 		}
 
+# check for %# or %0# in printf-style format strings
+		while ($line =~ /(?:^|")([X\t]*)(?:"|$)/g) {
+			my $string = substr($rawline, $-[1], $+[1] - $-[1]);
+			$string =~ s/%%/__/g;
+			if ($string =~ /(?<!%)%0?#/) {
+				ERROR("Don't use '#' flag of printf format " .
+				      "('%#') in format strings, use '0x' " .
+				      "prefix instead\n" . $herecurr);
+				last;
+			}
+		}
+
 # QEMU specific tests
 		if ($rawline =~ /\b(?:Qemu|QEmu)\b/) {
 			ERROR("use QEMU instead of Qemu or QEmu\n" . $herecurr);
-- 
2.20.1


