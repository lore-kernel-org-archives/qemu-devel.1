Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BBDC2BC11
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 17:27:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64E82217BA
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 17:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ArzSBDle"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E82217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHsGU-00026B-Cs
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 13:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovmurik@linux.vnet.ibm.com>)
 id 1kHsFK-00018s-0U
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 13:26:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49964)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovmurik@linux.vnet.ibm.com>)
 id 1kHsFH-0006e7-S7
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 13:26:29 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08EHDkZY055545
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 13:26:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=XgTGAy0ji38HzA6abhtQOvMzWawsMMSTBvHzgHF55rA=;
 b=ArzSBDleA8SMfJrqF1HMcFaazqdrUb7VTXcWNoekfQuFsuF8Yh/3ChpG8IqJfMEaN5YB
 fLqUZ6LhAgEhr2/fYlJJ0hfVDlBaKbBDc30jJhl2sSyuIE+dTWpSqy6BWp0J7C8mDp7q
 ugz9RSvzG3Ayb2nXGfoaQRvfZfxp99ZXwrfRreLmvRvF7QTfE1Xu6FZNmQTkadiQRTGh
 HNWVFLK5ERfDtzrlU4xjAKgWeDfhFs0QtPbkJrD9tmsKA0kId9kc6v6gaxUl+nBENdAg
 vd3hA2d6dnvtqDkyodqm9qRu6MFsJ6zt0YU+AecR54ch2BO+2HKLy2nD6lR6p2I1gLHv iw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33jcqsr8my-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 13:26:25 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08EHDw7O056208
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 13:26:25 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33jcqsr8mj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2020 13:26:25 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08EHMM97001268;
 Mon, 14 Sep 2020 17:26:24 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma04dal.us.ibm.com with ESMTP id 33gny8wthf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2020 17:26:24 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08EHQNam26673608
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Sep 2020 17:26:23 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BDC53124052;
 Mon, 14 Sep 2020 17:26:23 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9DE96124053;
 Mon, 14 Sep 2020 17:26:23 +0000 (GMT)
Received: from amdrome1.watson.ibm.com (unknown [9.2.130.16])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon, 14 Sep 2020 17:26:23 +0000 (GMT)
From: Dov Murik <dovmurik@linux.vnet.ibm.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2] checkpatch: Detect '%#' or '%0#' in printf-style format
 strings
Date: Mon, 14 Sep 2020 17:26:23 +0000
Message-Id: <20200914172623.72955-1-dovmurik@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-14_06:2020-09-14,
 2020-09-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxlogscore=976
 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009140138
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dovmurik@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 13:26:26
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
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
 Dov Murik <dovmurik@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>
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

Since v1:
- consolidate format string checks to avoid code duplication

---
 scripts/checkpatch.pl | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index bd3faa154c..f8dac953b2 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2880,14 +2880,20 @@ sub process {
 				$herecurr);
 		}
 
-# check for %L{u,d,i} in strings
+# format strings checks
 		my $string;
 		while ($line =~ /(?:^|")([X\t]*)(?:"|$)/g) {
 			$string = substr($rawline, $-[1], $+[1] - $-[1]);
 			$string =~ s/%%/__/g;
+			# check for %L{u,d,i} in strings
 			if ($string =~ /(?<!%)%L[udi]/) {
 				ERROR("\%Ld/%Lu are not-standard C, use %lld/%llu\n" . $herecurr);
-				last;
+			}
+			# check for %# or %0# in printf-style format strings
+			if ($string =~ /(?<!%)%0?#/) {
+				ERROR("Don't use '#' flag of printf format " .
+				      "('%#') in format strings, use '0x' " .
+				      "prefix instead\n" . $herecurr);
 			}
 		}
 
-- 
2.20.1


