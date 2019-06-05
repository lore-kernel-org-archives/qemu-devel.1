Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A10EC282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 06:25:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43F422083E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 06:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E65sv6PJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F422083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36254 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYPMT-0002wu-K1
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 02:25:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lidong.chen@oracle.com>) id 1hYPKX-00023A-1s
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 02:23:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lidong.chen@oracle.com>) id 1hYPKV-0001ek-Vp
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 02:23:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43820)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lidong.chen@oracle.com>)
	id 1hYPKV-0001cw-Mv
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 02:23:23 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x556J8I9194306; Wed, 5 Jun 2019 06:23:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=from : to : cc :
	subject : date : message-id : in-reply-to : references : in-reply-to :
	references; s=corp-2018-07-02;
	bh=DvBcQvrw2mXQCsz+/0O3D1uiaSo9CY48agW3IQWWiss=;
	b=E65sv6PJHMvbh3AgN1Kt7qKWWLN5RH53C03xY1wbrD0SstkLi8rG3KdjoloB8xYwNptM
	g797Neg24Z3u1pur/nAu5o5ytJPhUrIFaGIlpnseJU0gkK3I0Ap6NeesKYZiSd8NjdgF
	JuP3n/8Ba3RK6ABS67b45P6m5fBtVk7QiOxRYIXGAfI4ZvUX6BNhS37J1U3W51gcVI2b
	ESTJcVVS3df9i0BBDti6gh6VcdrmjDcMj491JcNdXi8KdBjrAsGqRbM2PNTHY+e8QlXx
	tNZDE79PyFz0QZtwdh+uHI5DrKJpKnOnh/ytivvosyYcUyGQemKer/3j8kH1f0+v2fnP
	kw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by userp2120.oracle.com with ESMTP id 2suj0qgtwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Jun 2019 06:23:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x556L01X118603; Wed, 5 Jun 2019 06:21:21 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by userp3030.oracle.com with ESMTP id 2swngkrb36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Jun 2019 06:21:20 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x556LKb7004002;
	Wed, 5 Jun 2019 06:21:20 GMT
Received: from ca-virt2-2.us.oracle.com (/10.211.11.112)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 04 Jun 2019 23:21:19 -0700
From: Lidong Chen <lidong.chen@oracle.com>
To: qemu-devel@nongnu.org
Date: Wed,  5 Jun 2019 02:21:06 -0400
Message-Id: <2410fe0d6dc7d5afdec8e3b8901b32e71ed303a5.1559710447.git.lidong.chen@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1559710447.git.lidong.chen@oracle.com>
References: <cover.1559710447.git.lidong.chen@oracle.com>
In-Reply-To: <cover.1559710447.git.lidong.chen@oracle.com>
References: <cover.1559710447.git.lidong.chen@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1906050040
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1906050040
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
Reviewed-by: Liran Alon <liran.alon@oracle.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
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


