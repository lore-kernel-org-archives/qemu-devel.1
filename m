Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E34C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 19:19:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3C5821721
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 19:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uwm9ikb3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3C5821721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41258 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdg7e-0007Fj-TP
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 15:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47366)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lidong.chen@oracle.com>) id 1hdg4g-0005e2-8h
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:16:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lidong.chen@oracle.com>) id 1hdg4d-0007pl-B7
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:16:48 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56590)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lidong.chen@oracle.com>)
 id 1hdg4Y-0007Yb-Bq
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:16:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5JJ8Zgl065645;
 Wed, 19 Jun 2019 19:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references : mime-version : content-type : content-transfer-encoding;
 s=corp-2018-07-02; bh=+hIm15QIKJ+xsbaM2NNF5KWvBzjkV3dP0Rtjy3b/758=;
 b=uwm9ikb3U2o9TQQUajKxk8CoIOHlOCRYlHUDokJ7o6+mV1cMnn5+ah1KKd+ACcV2Sg4r
 4Xn0Jr/KBE8gMaEHspT8+XKOij7qdYry52nYAKYXMT1JFSOdyllCF3OPn7W4qPAyPJmj
 fDVUyCVTiF8auUlH62msZQbzjxYTVOm5HjdCTYtHwI/bvFwSgDZxQGCmB5LcoYfo6ZFl
 6rhm5LrzNgg85pz7g9QXM9Ua3RcxklwcWLIQasmdSmaSW3eIeWPkjI7VdkVs7RIJOxzh
 QSucyVCBaTmKQHt20iTvqUMKS3F4C2+i57rlArK3EEjc82o7eoKNWU068fdRa3bLYgVl oQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 2t7809d9f1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jun 2019 19:16:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5JJFEpf094589;
 Wed, 19 Jun 2019 19:16:29 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 2t7rdwtkvr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jun 2019 19:16:29 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5JJGTbT008847;
 Wed, 19 Jun 2019 19:16:29 GMT
Received: from ca-virt2-2.us.oracle.com (/10.211.11.112)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 19 Jun 2019 12:16:28 -0700
From: Lidong Chen <lidong.chen@oracle.com>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 15:14:47 -0400
Message-Id: <ded30967982811617ce7f0222d11228130c198b7.1560806687.git.lidong.chen@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1560806687.git.lidong.chen@oracle.com>
References: <cover.1560806687.git.lidong.chen@oracle.com>
In-Reply-To: <cover.1560806687.git.lidong.chen@oracle.com>
References: <cover.1560806687.git.lidong.chen@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190157
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190157
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2130.oracle.com id
 x5JJ8Zgl065645
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: [Qemu-devel] [Qemu-devel PATCH v3 2/2] util/main-loop: Fix
 incorrect assertion
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, liq3ea@gmail.com,
 f4bug@amsat.org, armbru@redhat.com, lidong.chen@oracle.com,
 darren.kenny@oracle.com, liran.alon@oracle.com, marcandre.lureau@gmail.com,
 amarkovic@wavecomp.com, pbonzini@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The check for poll_fds in g_assert() was incorrect. The correct assertion
should check "n_poll_fds + w->num <=3D ARRAY_SIZE(poll_fds)" because the
subsequent for-loop is doing access to poll_fds[n_poll_fds + i] where i
is in [0, w->num).

Signed-off-by: Lidong Chen <lidong.chen@oracle.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Suggested-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Liran Alon <liran.alon@oracle.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 util/main-loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/main-loop.c b/util/main-loop.c
index e1e349c..a9f4e8d 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -422,7 +422,7 @@ static int os_host_main_loop_wait(int64_t timeout)
     g_main_context_prepare(context, &max_priority);
     n_poll_fds =3D g_main_context_query(context, max_priority, &poll_tim=
eout,
                                       poll_fds, ARRAY_SIZE(poll_fds));
-    g_assert(n_poll_fds <=3D ARRAY_SIZE(poll_fds));
+    g_assert(n_poll_fds + w->num <=3D ARRAY_SIZE(poll_fds));
=20
     for (i =3D 0; i < w->num; i++) {
         poll_fds[n_poll_fds + i].fd =3D (DWORD_PTR)w->events[i];
--=20
1.8.3.1


