Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1BBC35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:34:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87A972072B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nKHa32WF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A972072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izIwr-0002xb-PN
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 06:34:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58534)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1izIvO-0001le-Rp
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:32:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <darren.kenny@oracle.com>) id 1izIvN-0005Ht-1Z
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:32:54 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:43296)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
 id 1izIvL-0005AO-8t
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:32:51 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015BRqHm013118;
 Wed, 5 Feb 2020 11:32:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=hJZSQDWj0VzWQB8Dgl74xr5TWWHJ4xwzHBBgUarn+ow=;
 b=nKHa32WFon6TWK6WkQyVwMeoZ2/i49/yK5JtO3BzWPMnRpSlhyhNbSt5W/zf9OOwQz/t
 uANWsCUENVfi9PvJS31bodbRNV9XaBOTde55kMVkceHZFzfQvw/x3REa9qon+Ey0MmkR
 RaqNZ+91pd2ZIrz4hSz8FYi0vFXKPjA3sLClimGPEhlekle9mAUUzRNB//q9oCnlAeQS
 M6M856lq9l/wDdO2wp1kS8pkkysLFnyv6xL6bHL9Uhd5UJl0jCsOwFogMMpQWjLWswEP
 ARtqUC5KCCSaDVcNTqh1GfUag6XIOy29O+TA14h1xXGjEPTiIdMOg75DYfhYlT2d6SjX bQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 2xykbp2dpf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 11:32:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015BSIbs014249;
 Wed, 5 Feb 2020 11:30:47 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 2xykbrmm65-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 11:30:46 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 015BUkpW016697;
 Wed, 5 Feb 2020 11:30:46 GMT
Received: from starbug-mbp.localdomain (/10.169.111.17)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 05 Feb 2020 03:30:46 -0800
Received: from starbug-mbp (localhost [127.0.0.1])
 by starbug-mbp.localdomain (Postfix) with SMTP id 06BA657D71EC;
 Wed,  5 Feb 2020 11:30:43 +0000 (GMT)
Date: Wed, 5 Feb 2020 11:30:43 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: "Bulekov, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v8 04/21] qtest: add qtest_server_send abstraction
Message-ID: <20200205113043.4equxgqk5xreug57@starbug-mbp>
Mail-Followup-To: "Bulekov, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
References: <20200129053357.27454-1-alxndr@bu.edu>
 <20200129053357.27454-5-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200129053357.27454-5-alxndr@bu.edu>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002050093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002050093
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 29, 2020 at 05:34:14AM +0000, Bulekov, Alexander wrote:
>qtest_server_send is a function pointer specifying the handler used to
>transmit data to the qtest client. In the standard configuration, this
>calls the CharBackend handler, but now it is possible for other types of
>handlers, e.g direct-function calls if the qtest client and server
>exist within the same process (inproc)
>
>Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
>Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

>Acked-by: Thomas Huth <thuth@redhat.com>
>---
> include/sysemu/qtest.h |  3 +++
> qtest.c                | 18 ++++++++++++++++--
> 2 files changed, 19 insertions(+), 2 deletions(-)
>
>diff --git a/include/sysemu/qtest.h b/include/sysemu/qtest.h
>index 5ed09c80b1..e2f1047fd7 100644
>--- a/include/sysemu/qtest.h
>+++ b/include/sysemu/qtest.h
>@@ -26,4 +26,7 @@ bool qtest_driver(void);
>
> void qtest_server_init(const char *qtest_chrdev, const char *qtest_log, Error **errp);
>
>+void qtest_server_set_send_handler(void (*send)(void *, const char *),
>+                                 void *opaque);
>+
> #endif
>diff --git a/qtest.c b/qtest.c
>index 12432f99cf..938c3746d6 100644
>--- a/qtest.c
>+++ b/qtest.c
>@@ -42,6 +42,8 @@ static GString *inbuf;
> static int irq_levels[MAX_IRQ];
> static qemu_timeval start_time;
> static bool qtest_opened;
>+static void (*qtest_server_send)(void*, const char*);
>+static void *qtest_server_send_opaque;
>
> #define FMT_timeval "%ld.%06ld"
>
>@@ -228,8 +230,10 @@ static void GCC_FMT_ATTR(1, 2) qtest_log_send(const char *fmt, ...)
>     va_end(ap);
> }
>
>-static void do_qtest_send(CharBackend *chr, const char *str, size_t len)
>+static void qtest_server_char_be_send(void *opaque, const char *str)
> {
>+    size_t len = strlen(str);
>+    CharBackend* chr = (CharBackend *)opaque;
>     qemu_chr_fe_write_all(chr, (uint8_t *)str, len);
>     if (qtest_log_fp && qtest_opened) {
>         fprintf(qtest_log_fp, "%s", str);
>@@ -238,7 +242,7 @@ static void do_qtest_send(CharBackend *chr, const char *str, size_t len)
>
> static void qtest_send(CharBackend *chr, const char *str)
> {
>-    do_qtest_send(chr, str, strlen(str));
>+    qtest_server_send(qtest_server_send_opaque, str);
> }
>
> static void GCC_FMT_ATTR(2, 3) qtest_sendf(CharBackend *chr,
>@@ -783,6 +787,16 @@ void qtest_server_init(const char *qtest_chrdev, const char *qtest_log, Error **
>     qemu_chr_fe_set_echo(&qtest_chr, true);
>
>     inbuf = g_string_new("");
>+
>+    if (!qtest_server_send) {
>+        qtest_server_set_send_handler(qtest_server_char_be_send, &qtest_chr);
>+    }
>+}
>+
>+void qtest_server_set_send_handler(void (*send)(void*, const char*), void *opaque)
>+{
>+    qtest_server_send = send;
>+    qtest_server_send_opaque = opaque;
> }
>
> bool qtest_driver(void)
>-- 
>2.23.0
>
>

