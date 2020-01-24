Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FC8C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:37:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F8B22070A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kYMcvnwx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8B22070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuwKg-0003uu-GR
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 05:36:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46967)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david.edmondson@oracle.com>) id 1iuwJt-00039j-T5
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:36:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david.edmondson@oracle.com>) id 1iuwJs-0005zT-VL
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:36:09 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55106)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david.edmondson@oracle.com>)
 id 1iuwJq-0005qM-EO; Fri, 24 Jan 2020 05:36:06 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00OAN8uN062733;
 Fri, 24 Jan 2020 10:36:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=2i5HnxJjWNN/4VAMdRb22UA/NbzBxmwhnxlv5ZPpX68=;
 b=kYMcvnwxF7tT/3/vQ4yJQ9tnPEC5iI8PBG4uMHIhowD65mx+90Q8OhRz3fq2IQ/a6TkP
 Byy0CNjmDSluYZtsc4K3hjJXJ/6TIw8eO6u17d0rsZ1c+as90n0bzvhr1PgBzdQr8haS
 qK0HPJF14daCFlmopNNr4NrDs5F+ifJEPYqW0hsbqs0pI75N3+IWzucN/5AELRbP29uX
 GKV12yfHGaQbp8M/b3a9joa0OgBdcGlmcrOqflNW3m/eeTLWfTUyRWBrCs4iElIdGNFi
 LSKtOM9o+g35lID3Cu6QxmfIQMxwXm6FGoFjM91hMLPA/t7tRYO228c/8Ng/8adOVq7X lg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2xktnrr2bd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jan 2020 10:36:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00OAVJ2x183541;
 Fri, 24 Jan 2020 10:36:03 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2xqnrt2p89-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jan 2020 10:36:03 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00OAa2It019262;
 Fri, 24 Jan 2020 10:36:02 GMT
Received: from disaster-area.hh.sledj.net (/81.149.164.25)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 24 Jan 2020 02:36:02 -0800
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 402c1b9b;
 Fri, 24 Jan 2020 10:36:00 +0000 (UTC)
From: David Edmondson <david.edmondson@oracle.com>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: [PATCH v2 0/2] qemu-img: Add --target-is-zero to indicate that a
 target is blank
Date: Fri, 24 Jan 2020 10:34:56 +0000
Message-Id: <20200124103458.1525982-1-david.edmondson@oracle.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9509
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=486
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001240086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9509
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=549 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001240086
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: David Edmondson <david.edmondson@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


qemu-img: Add --target-is-zero to indicate that a target is blank

v2:
- Remove target_is_zero, preferring to set has_zero_init
  directly (Mark Kanda).
- Disallow --target-is-zero in the presence of a backing file (Max
  Reitz).
- Add relevant documentation (Max Reitz).
- @var -> @code for options in qemu-img.texi.


David Edmondson (2):
  qemu-img: Add --target-is-zero to convert
  doc: Use @code rather than @var for options

 qemu-img-cmds.hx |  4 ++--
 qemu-img.c       | 25 ++++++++++++++++++++++---
 qemu-img.texi    | 20 ++++++++++++--------
 3 files changed, 36 insertions(+), 13 deletions(-)

-- 
2.24.1


