Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255E2C352A2
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:40:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E838721741
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mSR04w3d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E838721741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izJ2u-0007bs-6b
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 06:40:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34081)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1izJ2D-000765-Rf
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:39:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <darren.kenny@oracle.com>) id 1izJ2C-0007AA-Nx
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:39:57 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:41180)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
 id 1izJ2C-00077d-EB
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:39:56 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015Bc8wn001514;
 Wed, 5 Feb 2020 11:39:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=fVEmtZsUkEBaHYRUwUDIpm7RubVzvMkE2a6XmKWfnvU=;
 b=mSR04w3dMo0AvjJ2evw4Xcl7nTaWI7Dd2bN6+YcY9Tkn0/iWlyBd4TgZ++MgKnrO9YwM
 m8UTA5mgSUxtE157XRMr//Y3i8tqVoXbxHYPJ6kvnQb8C22KmFpZzxEK7B4HRVhUpBaJ
 nE48g+uFdWrNo2Oc04Cp6ZmdUAFpGySMMJ43LFfhgaaLLtsf0A1xxaERJ3Romd/DCbGr
 8KJJb/9BQmF7KQCD7TuYfDr4SqVqvoY2LrkdyFVosqci/1u4SVtjdFMrSm94w5gMepM+
 NPbnka9dALIP0Xqrv3GP6ZnR7tUAahyjCErWGQACkOI9vNJ1PSX3DSJ/yok2KHwICTOb Hg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2xykbp2f7y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 11:39:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015Bc84S032219;
 Wed, 5 Feb 2020 11:39:53 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 2xykc2nfc5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 11:39:53 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 015BdqZA002529;
 Wed, 5 Feb 2020 11:39:52 GMT
Received: from starbug-mbp.localdomain (/10.169.111.17)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 05 Feb 2020 03:39:52 -0800
Received: from starbug-mbp (localhost [127.0.0.1])
 by starbug-mbp.localdomain (Postfix) with SMTP id B30FF57D74CE;
 Wed,  5 Feb 2020 11:39:49 +0000 (GMT)
Date: Wed, 5 Feb 2020 11:39:49 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: "Bulekov, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v8 07/21] qtest: add in-process incoming command handler
Message-ID: <20200205113949.afspajk2iyysnb3t@starbug-mbp>
Mail-Followup-To: "Bulekov, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
References: <20200129053357.27454-1-alxndr@bu.edu>
 <20200129053357.27454-8-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200129053357.27454-8-alxndr@bu.edu>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002050095
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002050095
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 29, 2020 at 05:34:17AM +0000, Bulekov, Alexander wrote:
>The handler allows a qtest client to send commands to the server by
>directly calling a function, rather than using a file/CharBackend
>
>Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
>Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

>---
> include/sysemu/qtest.h |  1 +
> qtest.c                | 13 +++++++++++++
> 2 files changed, 14 insertions(+)
>
>diff --git a/include/sysemu/qtest.h b/include/sysemu/qtest.h
>index e2f1047fd7..eedd3664f0 100644
>--- a/include/sysemu/qtest.h
>+++ b/include/sysemu/qtest.h
>@@ -28,5 +28,6 @@ void qtest_server_init(const char *qtest_chrdev, const char *qtest_log, Error **
>
> void qtest_server_set_send_handler(void (*send)(void *, const char *),
>                                  void *opaque);
>+void qtest_server_inproc_recv(void *opaque, const char *buf);
>
> #endif
>diff --git a/qtest.c b/qtest.c
>index 938c3746d6..ad6eb6a526 100644
>--- a/qtest.c
>+++ b/qtest.c
>@@ -803,3 +803,16 @@ bool qtest_driver(void)
> {
>     return qtest_chr.chr != NULL;
> }
>+
>+void qtest_server_inproc_recv(void *dummy, const char *buf)
>+{
>+    static GString *gstr;
>+    if (!gstr) {
>+        gstr = g_string_new(NULL);
>+    }
>+    g_string_append(gstr, buf);
>+    if (gstr->str[gstr->len - 1] == '\n') {
>+        qtest_process_inbuf(NULL, gstr);
>+        g_string_truncate(gstr, 0);
>+    }
>+}
>-- 
>2.23.0
>
>

