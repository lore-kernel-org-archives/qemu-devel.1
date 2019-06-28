Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E58FC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 13:40:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38D1A20645
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 13:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pB+Lewpu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D1A20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgr6r-0005Jd-ES
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 09:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49166)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liam.merwick@oracle.com>) id 1hgqce-0008Uj-RO
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 09:09:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liam.merwick@oracle.com>) id 1hgqcd-00081b-Sw
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 09:09:00 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49842)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
 id 1hgqcb-0007yA-Lo; Fri, 28 Jun 2019 09:08:57 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5SD3rv4156645;
 Fri, 28 Jun 2019 13:08:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=0C8PA+eTTuhq384WLM/bZtQrEJRTuSkPTMxjc8gHyQ4=;
 b=pB+Lewpujjup7igrBL8lUwjCIMqIDs/MJaaW/IYMP9bPe58CIs51KnXRe/Qe6ujYF1Ma
 VnXlFKJCTKmjynZiZmZMR2hPUq0dd2CFc7iS5+JQkVKyA267xAGnkeaQXmOVoqFoJLxy
 wi4mojLvBv2A57Cze/qGkJNE5XLZgpzeBF27d131UF3mlCt8WXG/hZJSlCoNgUPi085d
 uxvHIIZ7QeJzXUVGm6iGBe6KgWz8qCF2f4kNzUX3/iX29ukp/aYgo/tJfi+zKX/abMaE
 XbcUJJw+ZFXW98Au+9B1MvyS2EzU46D5tnCh8C52KzS0HkJ8g0WjhmPzztqD8IBH+Lsx sg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 2t9c9q5kfa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Jun 2019 13:08:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5SD8185106726;
 Fri, 28 Jun 2019 13:08:52 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 2t99f5jxch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Jun 2019 13:08:52 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5SD8pHq009018;
 Fri, 28 Jun 2019 13:08:51 GMT
Received: from ol7.uk.oracle.com (/10.175.202.14)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 28 Jun 2019 06:08:50 -0700
From: Liam Merwick <liam.merwick@oracle.com>
To: qemu-trivial@nongnu.org
Date: Fri, 28 Jun 2019 14:08:37 +0100
Message-Id: <1561727317-30655-1-git-send-email-liam.merwick@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301
 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=993
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906280157
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301
 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906280156
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: [Qemu-devel] [PATCH] docs/devel/testing: Fix typo in dockerfile path
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
---
 docs/devel/testing.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index da2d0fc9646f..3ef50a61db4d 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -327,7 +327,7 @@ Images
 ------
 
 Along with many other images, the ``min-glib`` image is defined in a Dockerfile
-in ``tests/docker/dockefiles/``, called ``min-glib.docker``. ``make docker``
+in ``tests/docker/dockerfiles/``, called ``min-glib.docker``. ``make docker``
 command will list all the available images.
 
 To add a new image, simply create a new ``.docker`` file under the
-- 
1.8.3.1


