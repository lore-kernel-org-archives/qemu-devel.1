Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE60C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 21:37:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 360E62076D
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 21:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RfqsuDax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 360E62076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWRj3-0000VP-3q
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 17:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eyal.moscovici@oracle.com>)
 id 1jWRhN-0006o2-Jm; Wed, 06 May 2020 17:35:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52636)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eyal.moscovici@oracle.com>)
 id 1jWRhM-0006wV-Cg; Wed, 06 May 2020 17:35:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046LJ9Vn102767;
 Wed, 6 May 2020 21:35:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=sJ4m17NJK5cs8JtIQvb12r57i6kH9t2M3Mg55ZLfYHQ=;
 b=RfqsuDaxFcilvOURMCXES5fTegBX0/MHyYXbEOIG67b3I0k+OupWVpOGzq8u3cPlv45f
 c2mX1vGBr+D0ojla19GkbL+hKvLSdyCCQmWAqHgefW3Rl3E70H3NI7TUjZPDTlLtQ204
 JuTvWNxrB18eoQ++wsPSRQmovSVl5xsC3VpsT7bo1AqtNVmRtnrnwcwD4uK7JWk5LnPL
 0zWPUMb2sl2YqpVhBZoZVOo3coVaD6N/KBEjylr8tHOl7T8hmrdh9N3Ejy5WVkNlgCUP
 MOY/OSdrbSJ2lJh56z7X26Sm39266lCoPq/60OfchjAUtxPDfVMjvhSIH+ZoG+065ppB qA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 30s1gncq0r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 May 2020 21:35:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046LHn7H039657;
 Wed, 6 May 2020 21:35:22 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 30t1r8sryn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 May 2020 21:35:21 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 046LZLQe012347;
 Wed, 6 May 2020 21:35:21 GMT
Received: from localhost.localdomain (/10.74.121.228)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 06 May 2020 14:35:20 -0700
From: Eyal Moscovici <eyal.moscovici@oracle.com>
To: 
Subject: [PATCH v2 1/5] qemu-img: remove check that cvtnum value > MAX_INT
Date: Thu,  7 May 2020 00:34:55 +0300
Message-Id: <20200506213459.44743-2-eyal.moscovici@oracle.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20200506213459.44743-1-eyal.moscovici@oracle.com>
References: <59b0896d-85ad-08b5-fcc1-36adad7501a4@redhat.com>
 <20200506213459.44743-1-eyal.moscovici@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005060172
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 mlxscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005060172
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=eyal.moscovici@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 17:35:22
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eyal Moscovici <eyal.moscovici@oracle.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 liran.alon@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Following commit f46bfdbfc8f95cf65d7818ef68a801e063c40332 (util/cutils: Change
qemu_strtosz*() from int64_t to uint64_t) which added a similar check to
cvtnum. As a result there is no need to check it separately outside of cvtnum.

Acked-by: Mark Kanda <mark.kanda@oracle.com>
Signed-off-by: Eyal Moscovici <eyal.moscovici@oracle.com>
---
 qemu-img.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 6a4327aaba..116a9c6349 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4307,7 +4307,7 @@ static int img_bench(int argc, char **argv)
             int64_t sval;
 
             sval = cvtnum(optarg);
-            if (sval < 0 || sval > INT_MAX) {
+            if (sval < 0) {
                 error_report("Invalid buffer size specified");
                 return 1;
             }
@@ -4320,7 +4320,7 @@ static int img_bench(int argc, char **argv)
             int64_t sval;
 
             sval = cvtnum(optarg);
-            if (sval < 0 || sval > INT_MAX) {
+            if (sval < 0) {
                 error_report("Invalid step size specified");
                 return 1;
             }
@@ -4493,7 +4493,7 @@ static int img_dd_bs(const char *arg,
 
     res = cvtnum(arg);
 
-    if (res <= 0 || res > INT_MAX) {
+    if (res <= 0) {
         error_report("invalid number: '%s'", arg);
         return 1;
     }
-- 
2.17.2 (Apple Git-113)


