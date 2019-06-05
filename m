Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AED8C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 19:18:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 383C02075C
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 19:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5M0zlJXR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 383C02075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48645 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYbQy-00039Q-FP
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 15:18:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lidong.chen@oracle.com>) id 1hYbQ3-0002oy-Uw
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 15:17:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lidong.chen@oracle.com>) id 1hYbQ0-0008E1-10
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 15:17:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lidong.chen@oracle.com>)
	id 1hYbPx-0007ky-RV
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 15:17:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x55JEPMw038858; Wed, 5 Jun 2019 19:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=from : to : cc :
	subject : date : message-id : in-reply-to : references : in-reply-to :
	references; s=corp-2018-07-02;
	bh=pMM3g/lXlfzIAdICK/bAJKcbHnAJyHws6Dubb/vNs+s=;
	b=5M0zlJXRltPdHG3x4j55/4CD4PcW6wm9Dovqw0XxNBtCGdmB/lvxwYdqVCNM3FcstU8i
	G9NrP9LYN433Lj2PQ9jD/kHdGlFRes5UjeqNHxDHU3j2r7r6910UD6V5mHsMBmupE1Fm
	wfRTKIVBb+RiCXK+p0vLRR28fftiYg9XfFtyj7MSEw4u8m2oN25yhu0DAooI0m9fV6WW
	ltSn9X81Q2NED6PAqs5Y5pSTGIXVimmarKJmvs6S5hnGaSgqAxQDPcuQDYsG2qAXCYKx
	vTwvdwVuOvcfERa7SainbhiD09xLWC7o8gggfiZ+FtTwK0P/MAfhyJzamx3Pr4s+EeUL
	+g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2120.oracle.com with ESMTP id 2suj0qmgnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Jun 2019 19:17:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x55JDsdF125400; Wed, 5 Jun 2019 19:15:34 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by aserp3020.oracle.com with ESMTP id 2swngj27qn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Jun 2019 19:15:34 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x55JFXlJ017424;
	Wed, 5 Jun 2019 19:15:33 GMT
Received: from ca-virt2-2.us.oracle.com (/10.211.11.112)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 05 Jun 2019 12:15:32 -0700
From: Lidong Chen <lidong.chen@oracle.com>
To: qemu-devel@nongnu.org
Date: Wed,  5 Jun 2019 15:15:21 -0400
Message-Id: <00742cd052c0b66e8da0b6b684cd460d6a051175.1559761541.git.lidong.chen@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1559761541.git.lidong.chen@oracle.com>
References: <cover.1559761541.git.lidong.chen@oracle.com>
In-Reply-To: <cover.1559761541.git.lidong.chen@oracle.com>
References: <cover.1559761541.git.lidong.chen@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9279
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1906050120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9279
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1906050120
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [Qemu-devel PATCH v2 2/2] util/main-loop: Fix
 incorrect assertion
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, berrange@redhat.com, liran.alon@oracle.com,
	liq3ea@gmail.com, armbru@redhat.com, lidong.chen@oracle.com,
	darren.kenny@oracle.com, marcandre.lureau@gmail.com,
	amarkovic@wavecomp.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The check for poll_fds in g_assert() was incorrect. The correct assertion
should check "n_poll_fds + w->num <= ARRAY_SIZE(poll_fds)" because the
subsequent for-loop is doing access to poll_fds[n_poll_fds + i] where i
is in [0, w->num).

Signed-off-by: Lidong Chen <lidong.chen@oracle.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Suggested-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Liran Alon <liran.alon@oracle.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
---
 util/main-loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/main-loop.c b/util/main-loop.c
index e1e349c..a9f4e8d 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -422,7 +422,7 @@ static int os_host_main_loop_wait(int64_t timeout)
     g_main_context_prepare(context, &max_priority);
     n_poll_fds = g_main_context_query(context, max_priority, &poll_timeout,
                                       poll_fds, ARRAY_SIZE(poll_fds));
-    g_assert(n_poll_fds <= ARRAY_SIZE(poll_fds));
+    g_assert(n_poll_fds + w->num <= ARRAY_SIZE(poll_fds));
 
     for (i = 0; i < w->num; i++) {
         poll_fds[n_poll_fds + i].fd = (DWORD_PTR)w->events[i];
-- 
1.8.3.1


