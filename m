Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DE5C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 21:38:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF4C82072D
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 21:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oBLRgzy+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF4C82072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeQEb-0007x3-Sv
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 17:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tobin@linux.vnet.ibm.com>)
 id 1jePVk-0006zg-0L
 for qemu-devel@nongnu.org; Thu, 28 May 2020 16:52:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1862
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tobin@linux.vnet.ibm.com>)
 id 1jePVj-000294-8F
 for qemu-devel@nongnu.org; Thu, 28 May 2020 16:52:19 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04SKVwfK079638
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 16:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-type : mime-version :
 content-transfer-encoding; s=pp1;
 bh=yoCAJ7wnWaETgxRGxNpq0aGJAAiEd0SpoVfbBkYcK48=;
 b=oBLRgzy+nxz1isyQWz7c1Zyz3U8uvgDQBws5cK0ybEwaNk3dccmqj72V9nqidZeI7iuv
 78hmjV6WUuY3M2iK2KbKsY8YWs3vL+ppE94GJqocbdb9xoBO2wNFCo3REW4j9ljycN/Y
 JOAnclwFWFZTkBCCr3m7W/CpinefYpapNC5b/NHXQB0Tgv+18yOW1bEamQGWucCcO5Zu
 384cKjfqWjpRMWrvwnQAQGR555gFFjJDNXokO3oY4rrkyFsG1iLtsZ7JIuMiAliNfoxU
 dy6/0/b2ksRBVJj9yxiYRn4xpXlRfsk8yCbeR2Ve8s0LEgLlVhir/TAbiRXAQ9gtdJpi vQ== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31agujygcs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 16:52:18 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04SKdjgh011953
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 20:52:17 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma03dal.us.ibm.com with ESMTP id 316ufb95dk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 20:52:17 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04SKpE3R31654282
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 May 2020 20:51:14 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 895C278064;
 Thu, 28 May 2020 20:51:15 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A8F17805E;
 Thu, 28 May 2020 20:51:15 +0000 (GMT)
Received: from Tobins-MBP-2.fios-router.home (unknown [9.80.221.203])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 28 May 2020 20:51:14 +0000 (GMT)
From: Tobin Feldman-Fitzthum <tobin@linux.vnet.ibm.com>
To: jejb@linux.ibm.com, qemu-devel@nongnu.org
Subject: [PATCH 0/2] Add support for SEV Launch Secret Injection
Date: Thu, 28 May 2020 16:51:12 -0400
Message-Id: <20200528205114.42078-1-tobin@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-05-28_07:2020-05-28,
 2020-05-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 lowpriorityscore=0 cotscore=-2147483648
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005280131
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=tobin@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 16:51:19
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 28 May 2020 17:35:50 -0400
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
Cc: Tobin Feldman-Fitzthum <tobin@linux.vnet.ibm.com>, tobin@ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchset contains two patches. The first enables QEMU
to facilitate the injection of a secret blob into the guest
memory.

The second enables QEMU to parse the guest ROM to determine
the address at which the secret should be injected.

Tobin Feldman-Fitzthum (2):
  sev: add sev-inject-launch-secret
  sev: scan guest ROM for launch secret address

 include/sysemu/sev.h       |   2 +
 qapi/misc-target.json      |  20 +++++++
 target/i386/monitor.c      |   8 +++
 target/i386/sev-stub.c     |   5 ++
 target/i386/sev.c          | 113 +++++++++++++++++++++++++++++++++++++
 target/i386/sev_i386.h     |  16 ++++++
 target/i386/trace-events   |   1 +
 tests/qtest/qmp-cmd-test.c |   6 +-
 8 files changed, 168 insertions(+), 3 deletions(-)

-- 
2.20.1 (Apple Git-117)


