Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D32C3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 17:41:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C03DC22B48
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 17:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rOFMVr7G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C03DC22B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Y1U-00010S-1A
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 12:41:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1j9Y0m-0000FI-E5
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 12:40:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1j9Y0l-0003lx-9Y
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 12:40:48 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:45192)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1j9Y0l-0003jb-0D
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 12:40:47 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 024HOKE3132248;
 Wed, 4 Mar 2020 17:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=o5M69noFxkyvpJ14JVB5JPXJcFk8kRfKPovdExpo4dA=;
 b=rOFMVr7GNeVP7IFjxMAK/K2wKIqY4wpnxGTzpyctFHSQqnVJ5X+McW5MNKr9KLiBusIh
 6obrmxLYW46peWJFkLXt7mpYGA0LTJkFkFBSmZitM53WNG0WsFcvzZrp2BVMbo+LCMGk
 FGx9nFJBimpIX0JMomAmaWiRyxh2ulo8JVwna16Sm0BuuxfuUWyTedURsAOMx+AALnoG
 Z132wPNoMA660lu5u6Iy/tMoAWbydHu1JeR5fcJn4pX4GmFV79B8m+e6+FU20ulB4bdj
 bKF1ecIxKMavJdHjW9WPzp3twWMbkKy1JigLuOVFen9E2cPJNxYEnLGxNclTH+Q5PkyQ nA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2yffcuqy6f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Mar 2020 17:40:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 024HNC5T063076;
 Wed, 4 Mar 2020 17:40:43 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 2yg1eqcy9s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Mar 2020 17:40:43 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 024HeZZg004954;
 Wed, 4 Mar 2020 17:40:35 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 04 Mar 2020 09:40:15 -0800
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] configure: Fix pkg_config --exists parameter
Date: Wed,  4 Mar 2020 19:41:20 +0200
Message-Id: <20200304174120.11970-1-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9550
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=1 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003040122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9550
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 bulkscore=0
 adultscore=0 suspectscore=1 spamscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003040122
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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
Cc: pbonzini@redhat.com, Bhavesh Davda <bhavesh.davda@oracle.com>,
 Liran Alon <liran.alon@oracle.com>, dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

pkg_config parameter should be "--exists", not "--exist".
This is probably a typo.

Fixes: 3a67848134d0 ("configure: Enable test and libs for zstd")
Reviewed-by: Bhavesh Davda <bhavesh.davda@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 50c4d96e2a8c..280f3654f786 100755
--- a/configure
+++ b/configure
@@ -2464,7 +2464,7 @@ fi
 # zstd check
 
 if test "$zstd" != "no" ; then
-    if $pkg_config --exist libzstd ; then
+    if $pkg_config --exists libzstd ; then
         zstd_cflags="$($pkg_config --cflags libzstd)"
         zstd_libs="$($pkg_config --libs libzstd)"
         LIBS="$zstd_libs $LIBS"
-- 
2.20.1


