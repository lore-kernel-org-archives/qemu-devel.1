Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09269C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:33:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8C5F2072B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aa+wkHdS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8C5F2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izIvv-0001wp-1M
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 06:33:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1izIul-0001Kp-56
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:32:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <darren.kenny@oracle.com>) id 1izIuj-0002mT-On
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:32:15 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40250)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
 id 1izIuj-0002gB-F8
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:32:13 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015BRrh2001773;
 Wed, 5 Feb 2020 11:32:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=0pse9WGwtVAq25k/FwaWoLpeYxRs/QscNPPG0UQM0BI=;
 b=aa+wkHdSUxER+uXcTVcvjMGn7s6xx31AazGepiRwL3GOu164hZ0Z7HKZrYwBjR0jfiKh
 rFM+GMnrzqlBtL+D5D5kJdOh/pASvQnQ5r4UiHZM9AHR+kXo8oI2HhciuQr8p3L/BWfL
 AQl4ExYSylW8hyUmuXv0b0XxdOMUFhZ1jjca8X/FIHLgdpUFh6WGwNJrf69q1McBjL9r
 CTFR74GARX97p3v/TpiVcl4kY9zyu51nmqFOoi/pngUH4sImp2RjSaaPfZjVKjUZmEO/
 +oJaCxzDvqQXJVdbAAC7nvBU0d+w6aEB3QL6sWThqWDi7mwZaRHe7tvdPoYxyg34FPdF eQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2xykbpadeg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 11:32:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015BSqgI006217;
 Wed, 5 Feb 2020 11:32:11 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 2xykc2my7p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 11:32:11 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 015BWATQ024540;
 Wed, 5 Feb 2020 11:32:10 GMT
Received: from starbug-mbp.localdomain (/10.169.111.17)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 05 Feb 2020 03:32:09 -0800
Received: from starbug-mbp (localhost [127.0.0.1])
 by starbug-mbp.localdomain (Postfix) with SMTP id 843FF57D725D;
 Wed,  5 Feb 2020 11:32:07 +0000 (GMT)
Date: Wed, 5 Feb 2020 11:32:07 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: "Bulekov, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v8 05/21] libqtest: add a layer of abstraction to send/recv
Message-ID: <20200205113207.vx4u53ikurmhky2x@starbug-mbp>
Mail-Followup-To: "Bulekov, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
References: <20200129053357.27454-1-alxndr@bu.edu>
 <20200129053357.27454-6-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200129053357.27454-6-alxndr@bu.edu>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002050093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002050093
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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

On Wed, Jan 29, 2020 at 05:34:15AM +0000, Bulekov, Alexander wrote:
>This makes it simple to swap the transport functions for qtest commands
>to and from the qtest client. For example, now it is possible to
>directly pass qtest commands to a server handler that exists within the
>same process, without the standard way of writing to a file descriptor.
>
>Signed-off-by: Alexander Bulekov <alxndr@bu.edu>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

>Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>---
> tests/qtest/libqtest.c | 48 ++++++++++++++++++++++++++++++++++--------
> 1 file changed, 39 insertions(+), 9 deletions(-)
>
>diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
>index 76c9f8eade..e5056a1d0f 100644
>--- a/tests/qtest/libqtest.c
>+++ b/tests/qtest/libqtest.c
>@@ -35,6 +35,15 @@
> #define SOCKET_TIMEOUT 50
> #define SOCKET_MAX_FDS 16
>
>+
>+typedef void (*QTestSendFn)(QTestState *s, const char *buf);
>+typedef GString* (*QTestRecvFn)(QTestState *);
>+
>+typedef struct QTestClientTransportOps {
>+    QTestSendFn     send;      /* for sending qtest commands */
>+    QTestRecvFn     recv_line; /* for receiving qtest command responses */
>+} QTestTransportOps;
>+
> struct QTestState
> {
>     int fd;
>@@ -45,6 +54,7 @@ struct QTestState
>     bool big_endian;
>     bool irq_level[MAX_IRQ];
>     GString *rx;
>+    QTestTransportOps ops;
> };
>
> static GHookList abrt_hooks;
>@@ -52,6 +62,14 @@ static struct sigaction sigact_old;
>
> static int qtest_query_target_endianness(QTestState *s);
>
>+static void qtest_client_socket_send(QTestState*, const char *buf);
>+static void socket_send(int fd, const char *buf, size_t size);
>+
>+static GString *qtest_client_socket_recv_line(QTestState *);
>+
>+static void qtest_client_set_tx_handler(QTestState *s, QTestSendFn send);
>+static void qtest_client_set_rx_handler(QTestState *s, QTestRecvFn recv);
>+
> static int init_socket(const char *socket_path)
> {
>     struct sockaddr_un addr;
>@@ -234,6 +252,9 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
>     sock = init_socket(socket_path);
>     qmpsock = init_socket(qmp_socket_path);
>
>+    qtest_client_set_rx_handler(s, qtest_client_socket_recv_line);
>+    qtest_client_set_tx_handler(s, qtest_client_socket_send);
>+
>     qtest_add_abrt_handler(kill_qemu_hook_func, s);
>
>     command = g_strdup_printf("exec %s "
>@@ -379,13 +400,9 @@ static void socket_send(int fd, const char *buf, size_t size)
>     }
> }
>
>-static void socket_sendf(int fd, const char *fmt, va_list ap)
>+static void qtest_client_socket_send(QTestState *s, const char *buf)
> {
>-    gchar *str = g_strdup_vprintf(fmt, ap);
>-    size_t size = strlen(str);
>-
>-    socket_send(fd, str, size);
>-    g_free(str);
>+    socket_send(s->fd, buf, strlen(buf));
> }
>
> static void GCC_FMT_ATTR(2, 3) qtest_sendf(QTestState *s, const char *fmt, ...)
>@@ -393,8 +410,11 @@ static void GCC_FMT_ATTR(2, 3) qtest_sendf(QTestState *s, const char *fmt, ...)
>     va_list ap;
>
>     va_start(ap, fmt);
>-    socket_sendf(s->fd, fmt, ap);
>+    gchar *str = g_strdup_vprintf(fmt, ap);
>     va_end(ap);
>+
>+    s->ops.send(s, str);
>+    g_free(str);
> }
>
> /* Sends a message and file descriptors to the socket.
>@@ -431,7 +451,7 @@ static void socket_send_fds(int socket_fd, int *fds, size_t fds_num,
>     g_assert_cmpint(ret, >, 0);
> }
>
>-static GString *qtest_recv_line(QTestState *s)
>+static GString *qtest_client_socket_recv_line(QTestState *s)
> {
>     GString *line;
>     size_t offset;
>@@ -468,7 +488,7 @@ static gchar **qtest_rsp(QTestState *s, int expected_args)
>     int i;
>
> redo:
>-    line = qtest_recv_line(s);
>+    line = s->ops.recv_line(s);
>     words = g_strsplit(line->str, " ", 0);
>     g_string_free(line, TRUE);
>
>@@ -1337,3 +1357,13 @@ void qmp_assert_error_class(QDict *rsp, const char *class)
>
>     qobject_unref(rsp);
> }
>+
>+static void qtest_client_set_tx_handler(QTestState *s,
>+                    QTestSendFn send)
>+{
>+    s->ops.send = send;
>+}
>+static void qtest_client_set_rx_handler(QTestState *s, QTestRecvFn recv)
>+{
>+    s->ops.recv_line = recv;
>+}
>-- 
>2.23.0
>
>

