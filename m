Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADC0C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:32:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AA4F2077C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kTE3BmhM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AA4F2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSLQN-0001Fg-J6
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 08:32:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45589)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1iSLPF-0000Tt-Cw
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:31:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <darren.kenny@oracle.com>) id 1iSLPD-0003lH-PE
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:31:28 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:35614)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
 id 1iSLPC-0003iB-Lu
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:31:26 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA6DTImV132936;
 Wed, 6 Nov 2019 13:31:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=26B6T8CzNJSnTD105UslaAB+aOR+jeKerIl/VYMEbEo=;
 b=kTE3BmhMMupV+2VrD/xEo1V39aeJPxXB6K6Fo7kP7t9HGsR3e/lZQNS8XQznhQ6RGwu3
 4Uv6TSdfeSrGUS8fN6hgeGPwa2pHLflN/dTeP4r1IFAJ07k0Z+UJXP8uKok4wDgcOqXn
 HFhtVkYx1OLiDnv9HkegcJdx6QWVNYT5Qr2vJxSL1jvDdFHHosuyTJs7LEnHkJnzsf84
 FX9xr0BDdJruksKgCuDiSLxwEv+PLtV4Wl5BvXlk+ZXN0j2yI6dC/sE/dcGE7L/xFHVr
 lsRvQOOaNe3egpXUSCprMB9/3zeRAJTK4OC3+pmAhXdUwnBknSY+p0EEQZ5XpIj0wR0m Sw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2w11rq67jk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Nov 2019 13:31:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA6DVBbX104634;
 Wed, 6 Nov 2019 13:31:22 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2w3163gtjq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Nov 2019 13:31:14 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA6DTL3e018111;
 Wed, 6 Nov 2019 13:29:21 GMT
Received: from starbug-mbp.localdomain (/10.175.184.49)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 06 Nov 2019 05:29:21 -0800
Received: from starbug-mbp (localhost [127.0.0.1])
 by starbug-mbp.localdomain (Postfix) with SMTP id 686764AC8130;
 Wed,  6 Nov 2019 13:29:18 +0000 (GMT)
Date: Wed, 6 Nov 2019 13:29:18 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v4 04/20] qtest: add qtest_server_send abstraction
Message-ID: <20191106132918.y2qm36rzyehn4via@starbug-mbp>
Mail-Followup-To: "Oleinik, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20191030144926.11873-1-alxndr@bu.edu>
 <20191030144926.11873-5-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20191030144926.11873-5-alxndr@bu.edu>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9432
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911060133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9432
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911060133
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 30, 2019 at 02:49:51PM +0000, Oleinik, Alexander wrote:
>From: Alexander Oleinik <alxndr@bu.edu>
>
>qtest_server_send is a function pointer specifying the handler used to
>transmit data to the qtest client. In the standard configuration, this
>calls the CharBackend handler, but now it is possible for other types of
>handlers, e.g direct-function calls if the qtest client and server
>exist within the same process (inproc)
>
>Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
>---
> include/sysemu/qtest.h |  3 +++
> qtest.c                | 17 +++++++++++++++--
> 2 files changed, 18 insertions(+), 2 deletions(-)
>
>diff --git a/include/sysemu/qtest.h b/include/sysemu/qtest.h
>index 5ed09c80b1..fda7000d2c 100644
>--- a/include/sysemu/qtest.h
>+++ b/include/sysemu/qtest.h
>@@ -26,4 +26,7 @@ bool qtest_driver(void);
>
> void qtest_server_init(const char *qtest_chrdev, const char *qtest_log, Error **errp);
>
>+void qtest_server_set_tx_handler(void (*send)(void *, const char *, size_t),
>+                                 void *opaque);
>+
> #endif
>diff --git a/qtest.c b/qtest.c
>index 8b50e2783e..ae7e6d779d 100644
>--- a/qtest.c
>+++ b/qtest.c
>@@ -42,6 +42,8 @@ static GString *inbuf;
> static int irq_levels[MAX_IRQ];
> static qemu_timeval start_time;
> static bool qtest_opened;
>+static void (*qtest_server_send)(void*, const char*, size_t);
>+static void *qtest_server_send_opaque;
>
> #define FMT_timeval "%ld.%06ld"
>
>@@ -228,8 +230,9 @@ static void GCC_FMT_ATTR(1, 2) qtest_log_send(const char *fmt, ...)
>     va_end(ap);
> }
>
>-static void do_qtest_send(CharBackend *chr, const char *str, size_t len)
>+static void qtest_server_char_be_send(void *opaque, const char *str, size_t len)
> {
>+    CharBackend* chr = (CharBackend *)opaque;
>     qemu_chr_fe_write_all(chr, (uint8_t *)str, len);
>     if (qtest_log_fp && qtest_opened) {
>         fprintf(qtest_log_fp, "%s", str);
>@@ -238,7 +241,7 @@ static void do_qtest_send(CharBackend *chr, const char *str, size_t len)
>
> static void qtest_send(CharBackend *chr, const char *str)
> {
>-    do_qtest_send(chr, str, strlen(str));

Given that this is a function pointer, it may be worth asserting
that it is not NULL.

>+    qtest_server_send(qtest_server_send_opaque, str, strlen(str));
> }
>
> static void GCC_FMT_ATTR(2, 3) qtest_sendf(CharBackend *chr,
>@@ -783,6 +786,16 @@ void qtest_server_init(const char *qtest_chrdev, const char *qtest_log, Error **
>     qemu_chr_fe_set_echo(&qtest_chr, true);
>
>     inbuf = g_string_new("");
>+
>+    if (!qtest_server_send) {
>+        qtest_server_set_tx_handler(qtest_server_char_be_send, &qtest_chr);
>+    }
>+}
>+
>+void qtest_server_set_tx_handler(void (*send)(void*, const char*, size_t), void *opaque)

It's a nit, but it might be better to rename this to match the
variables actually being set, i.e. s/_tx_/_send_/.

Thanks,

Darren.

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

