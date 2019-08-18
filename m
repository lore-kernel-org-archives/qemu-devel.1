Return-Path: <SRS0=DeAR=WO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B339CC3A589
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 13:24:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C80C2087E
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 13:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F87nq17z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C80C2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzLAO-0000AH-Jx
	for qemu-devel@archiver.kernel.org; Sun, 18 Aug 2019 09:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuval.shaia@oracle.com>) id 1hzL7c-0006L5-0e
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 09:21:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuval.shaia@oracle.com>) id 1hzL7a-00009u-Kp
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 09:21:23 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36364)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
 id 1hzL7a-00008x-DN
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 09:21:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7IDKZbF028261;
 Sun, 18 Aug 2019 13:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=agKDKB9XoDJ/onXjH/R69wBWoq9VofDS9IhKS2V7ph8=;
 b=F87nq17zc/lpcu0eVcFP6kzZoZm2B7uKRmMQtmW4prQRR4ug0lD81DZj3FMlC5Jw+mtf
 yq1TUJDEkqhiMcCqH7CGE9ttEHwSyGYBVZOo0bB8ropPyBexWCt56u16EVQ9K7qGWlOd
 gfZF1cEN2Hfq2in1X4/XWjjk4oQHAM9eXygYy8s6wp1Km3RSXTF807f3cPIAimwX2pnk
 sgl9Se9iR6PzfNjbXsAdtILrX7rVb2+9BNdpmj9UV8r/AfmVrRy8srdRbqPBWNtVpYZJ
 wUJ9VyThcyLRRtgCZpB43b2fV39cILaI5plBGOv7LOI3dikvyJtQM0tN+M3R+j/0d8Fh /Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2ue90t3mn4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 18 Aug 2019 13:21:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7IDIAdD087326;
 Sun, 18 Aug 2019 13:21:19 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 2ue8wx80n5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 18 Aug 2019 13:21:19 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7IDLFpZ020074;
 Sun, 18 Aug 2019 13:21:16 GMT
Received: from host4.lan (/77.138.183.59)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sun, 18 Aug 2019 06:21:15 -0700
From: Yuval Shaia <yuval.shaia@oracle.com>
To: berrange@redhat.com, thuth@redhat.com, philmd@redhat.com,
 pbonzini@redhat.com, laurent@vivier.eu, qemu-devel@nongnu.org,
 yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com
Date: Sun, 18 Aug 2019 16:21:06 +0300
Message-Id: <20190818132107.18181-2-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190818132107.18181-1-yuval.shaia@oracle.com>
References: <20190818132107.18181-1-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9352
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908180148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9352
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908180148
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: [Qemu-devel] [PATCH 1/2] configure: Check if we can use
 ibv_reg_mr_iova
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The function reg_mr_iova is an enhanced version of ibv_reg_mr function
that can help to easly register and use guest's MRs.

Add check in 'configure' phase to detect if we have libibverbs with this
support.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 configure | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/configure b/configure
index 714e7fb6a1..e8e4a57b6f 100755
--- a/configure
+++ b/configure
@@ -3205,6 +3205,34 @@ else
     pvrdma="no"
 fi
 
+# Let's see if enhanced reg_mr is supported
+if test "$pvrdma" = "yes" ; then
+
+cat > $TMPC <<EOF &&
+#include <infiniband/verbs.h>
+
+int
+main(void)
+{
+    struct ibv_mr *mr;
+    struct ibv_pd *pd = NULL;
+    size_t length = 10;
+    uint64_t iova = 0;
+    int access = 0;
+    void *addr = NULL;
+
+    mr = ibv_reg_mr_iova(pd, addr, length, iova, access);
+
+    ibv_dereg_mr(mr);
+
+    return 0;
+}
+EOF
+    if ! compile_prog "" "-libverbs"; then
+        QEMU_CFLAGS="$QEMU_CFLAGS -DLEGACY_RDMA_REG_MR"
+    fi
+fi
+
 ##########################################
 # VNC SASL detection
 if test "$vnc" = "yes" && test "$vnc_sasl" != "no" ; then
-- 
2.20.1


