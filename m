Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB304C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:06:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 980832082E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bTn6XC7k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 980832082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izIWI-0000St-Q6
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 06:06:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45220)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david.edmondson@oracle.com>) id 1izISr-0003vx-Nf
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:03:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david.edmondson@oracle.com>) id 1izISq-0002DP-NO
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:03:25 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43258)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david.edmondson@oracle.com>)
 id 1izISo-0001Gs-AM; Wed, 05 Feb 2020 06:03:22 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015AxDiq175458;
 Wed, 5 Feb 2020 11:03:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=Z+hWbfF+/UsjcwZYyuGBeJA8vYQ2qZ///5B+nqeLlXk=;
 b=bTn6XC7k7Wk0kkRKJLOLTvYw40jb3EYgnsrseoCwoao0nYJXwwIIIXhT4DqfEpkn+Bbq
 vdKbfM94p6w6H9atF4Pt8p3jCo8SuItYdzqJBbRY6m8QvrGIi2RSCq/CNnTNxSxI8A1p
 aNnl41WK3u2XHrBsvUl67NNZIwSX8Fabq8UE21XrZ3Rt5LTBiN5hTi2bpmL3hBueTUyv
 lEUC7zojfGXh3RA+MwZijCOT58K2rgqVpWEp5BSgHwNu8B70q6FRZ+hCVTB/Xl7u1u6Z
 1Rn67SoUKVQeEntUbGXArWXcqCV4tTKZeaG7cnekX+enIotHzwbNN3E9MXoXEKTnJnGs cg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2xykbpa9a6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 11:03:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015AwdMh124065;
 Wed, 5 Feb 2020 11:03:16 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 2xykbrk3a7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 11:03:15 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 015B3Fj7008091;
 Wed, 5 Feb 2020 11:03:15 GMT
Received: from disaster-area.hh.sledj.net (/81.149.164.25)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 05 Feb 2020 03:03:15 -0800
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id ae2de090;
 Wed, 5 Feb 2020 11:03:13 +0000 (UTC)
From: David Edmondson <david.edmondson@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/1] qemu-img: Add --target-is-zero to indicate that a
 target is blank
Date: Wed,  5 Feb 2020 11:02:47 +0000
Message-Id: <20200205110248.2009589-1-david.edmondson@oracle.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=543
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002050089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=600 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002050089
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

v4:
- Wording in the doc and error message.

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

 docs/interop/qemu-img.rst |  9 ++++++++-
 qemu-img-cmds.hx          |  4 ++--
 qemu-img.c                | 26 +++++++++++++++++++++++---
 3 files changed, 33 insertions(+), 6 deletions(-)

-- 
2.24.1


