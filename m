Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A95C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:03:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BD742192A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nj93jtWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD742192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyv3J-00083f-9D
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 05:03:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56310)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david.edmondson@oracle.com>) id 1iyut9-0005Q9-0w
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david.edmondson@oracle.com>) id 1iyut8-0008Mr-3z
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:58 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:52898)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david.edmondson@oracle.com>)
 id 1iyut5-0008BD-A5; Tue, 04 Feb 2020 04:52:55 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0149m93o134245;
 Tue, 4 Feb 2020 09:52:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=CJeQzwNpMBjrisYdU0dh6CtrQrVPPrXRdKH2x8owPK4=;
 b=nj93jtWE1ph3vwRwYoPm5+nuzk4+Ehfo09hwc79Sf1bvOYmlr5Pw0SMhVnL11pjJEktn
 a2bx2kjgHwdNqiHMyIsHFJPCDnzCghLajGVbnBPl8CPdrY13jlAvZ9M5s9IsDOpm8PdL
 +wizzt+iOxmuvgeBEII4Q0ZVvtn28JZtJlMli0NDJiKeYqEmua963TuwyLyXEH6zyDOx
 HmNQVrPf/Q9xdk4zMdAPP8SHT+KU/b9feKc8LFuOEXcn42H70akR6z01ppFb/QDpGTBM
 T54R1rg+tHRp+fkWXE3vf4YigaQKRsTdyco3lXdEOErgnMGk535yo5HR+znZlaiOu3N6 3w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2xwyg9hqvs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Feb 2020 09:52:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0149nKud044825;
 Tue, 4 Feb 2020 09:52:51 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 2xxvurb9n7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Feb 2020 09:52:51 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0149qoLs000306;
 Tue, 4 Feb 2020 09:52:50 GMT
Received: from disaster-area.hh.sledj.net (/81.149.164.25)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 04 Feb 2020 01:52:50 -0800
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id a857fdf2;
 Tue, 4 Feb 2020 09:52:48 +0000 (UTC)
From: David Edmondson <david.edmondson@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/1] qemu-img: Add --target-is-zero to indicate that a
 target is blank
Date: Tue,  4 Feb 2020 09:52:45 +0000
Message-Id: <20200204095246.1974117-1-david.edmondson@oracle.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9520
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=593
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002040073
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9520
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=649 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002040073
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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
Cc: David Edmondson <david.edmondson@oracle.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


qemu-img: Add --target-is-zero to indicate that a target is blank

v3:
- Merge with the rST docs.
- No more need to fix @var -> @code.

v2:
- Remove target_is_zero, preferring to set has_zero_init
  directly (Mark Kanda).
- Disallow --target-is-zero in the presence of a backing file (Max
  Reitz).
- Add relevant documentation (Max Reitz).
- @var -> @code for options in qemu-img.texi.


David Edmondson (1):
  qemu-img: Add --target-is-zero to convert

 docs/interop/qemu-img.rst |  8 +++++++-
 qemu-img-cmds.hx          |  4 ++--
 qemu-img.c                | 25 ++++++++++++++++++++++---
 3 files changed, 31 insertions(+), 6 deletions(-)

-- 
2.24.1


