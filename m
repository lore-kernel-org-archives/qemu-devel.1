Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800FBCA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 13:40:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65C7B204EF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 13:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rnyQSZtN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C7B204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYrcT-0002kp-GP
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 09:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eyal.moscovici@oracle.com>)
 id 1jYrb1-0000l2-Q3; Wed, 13 May 2020 09:38:51 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38744)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eyal.moscovici@oracle.com>)
 id 1jYrb0-0005CL-TL; Wed, 13 May 2020 09:38:51 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04DDWVp3163828;
 Wed, 13 May 2020 13:38:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=7uYVCNJ3IcRaqaueO/mQf4X8aaj6MOJoym/nvcg420A=;
 b=rnyQSZtNTdIuoWoFpyNQ9gLfAckEWix+QazyRz2u02uhbnZcZ9E10N+x/4D5Ieg4+/SD
 AI3eawt0C4kkH7s/LAPi3Fo7gEeuuzH1eQNwgt1K6FryCfmLd6EdCYEsZF0hTxFmJWjg
 3CjDRvDtv+Idye1bjALEpFvuvJ5fFd5S54Xtr6Dp2ONya/PUvQwWkz3De8eK3pPh7/W/
 qLmYBCPkWdh6P89oDjQI6yJ6likwznhP4E4Z+VEJfR7Hpk7DQacD0gK7TB0TwuHJ6eMS
 3YIgarAFnoEZpLZtDQSP5lky2dT2gzbkbm5a8vHtXtN2HF4seelvNwyGKTA6cQEIScTO Iw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 3100yfv7fe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 13 May 2020 13:38:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04DDXuWb102343;
 Wed, 13 May 2020 13:36:48 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 3100yajc0w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 May 2020 13:36:48 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04DDalVk015393;
 Wed, 13 May 2020 13:36:47 GMT
Received: from localhost.localdomain (/10.74.123.68)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 13 May 2020 06:36:46 -0700
From: Eyal Moscovici <eyal.moscovici@oracle.com>
To: 
Subject: [PATCH v3 2/4] qemu-img: validate image length in img_map
Date: Wed, 13 May 2020 16:36:27 +0300
Message-Id: <20200513133629.18508-3-eyal.moscovici@oracle.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20200513133629.18508-1-eyal.moscovici@oracle.com>
References: <20200513133629.18508-1-eyal.moscovici@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9619
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005130121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9619
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 adultscore=0
 cotscore=-2147483648 mlxscore=0 suspectscore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005130121
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=eyal.moscovici@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 09:36:43
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
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

The code handles this case correctly we merely skip the loop. However it
is probably best to return an explicit error.

Reviewed-by: Eric Blake <eblake@redhat.com>
Acked-by: Mark Kanda <mark.kanda@oracle.com>
Signed-off-by: Eyal Moscovici <eyal.moscovici@oracle.com>
---
 qemu-img.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/qemu-img.c b/qemu-img.c
index cc2e4a3799..23e90a99e1 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3091,6 +3091,11 @@ static int img_map(int argc, char **argv)
     }
 
     length = blk_getlength(blk);
+    if (length < 0) {
+        error_report("Failed to get size for '%s'", filename);
+        return 1;
+    }
+
     while (curr.start + curr.length < length) {
         int64_t offset = curr.start + curr.length;
         int64_t n;
-- 
2.17.2 (Apple Git-113)


