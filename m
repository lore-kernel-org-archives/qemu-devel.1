Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298F5C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:39:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6DD9217BA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EdqVYfG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6DD9217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izJ1s-0006bh-6R
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 06:39:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1izJ17-000672-DZ
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:38:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <darren.kenny@oracle.com>) id 1izJ15-0003G7-S6
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:38:49 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39970)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
 id 1izJ15-0003BY-Kx
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:38:47 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015Bc9Yv001545;
 Wed, 5 Feb 2020 11:38:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=TEsYqZ7LpRwFIGtiNDcHAvvpUIDxulIjaQ08ZeiRJBA=;
 b=EdqVYfG+zUF9S0dRF4AfoopNiRyUf6aHsbgMDPL/3zYpw7hx67vlOLERhhqdycQkdbuB
 n82UToc4PVJ0X+mkJAAmmLV8DOQN25Te7dWSQqLiE0wEkQk1D3ws1mdkJA2S08dn4gBb
 f+lWCQZ20UoQcGZgqOOg+GdhGONhmKAAoEIcrZ0XnLkV3IAUg6lkLGANlRyYw+Q4vPVG
 Qr3PidYm7epvXft+EO1CD2KNiqc4qSchgrasxnfqAnzojyXIjKacon1VHeP2q6Z/QJJE
 avWGrh8RmqmigsHew1tPI0EPGSLJw6eaoLTIk63vEroWh9yoY5plcwna2pCCXaKdyA4K pA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2xykbp2ex6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 11:38:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015BYD7e175981;
 Wed, 5 Feb 2020 11:36:44 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 2xykc5swp5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 11:36:44 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 015Bahxe027133;
 Wed, 5 Feb 2020 11:36:43 GMT
Received: from starbug-mbp.localdomain (/10.169.111.17)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 05 Feb 2020 03:36:43 -0800
Received: from starbug-mbp (localhost [127.0.0.1])
 by starbug-mbp.localdomain (Postfix) with SMTP id 9B70D57D738E;
 Wed,  5 Feb 2020 11:36:40 +0000 (GMT)
Date: Wed, 5 Feb 2020 11:36:40 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: "Bulekov, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v8 06/21] libqtest: make bufwrite rely on the TransportOps
Message-ID: <20200205113640.gpdgks2gzd3imymf@starbug-mbp>
Mail-Followup-To: "Bulekov, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
References: <20200129053357.27454-1-alxndr@bu.edu>
 <20200129053357.27454-7-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200129053357.27454-7-alxndr@bu.edu>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002050094
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
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

On Wed, Jan 29, 2020 at 05:34:16AM +0000, Bulekov, Alexander wrote:
>When using qtest "in-process" communication, qtest_sendf directly calls
>a function in the server (qtest.c). Previously, bufwrite used
>socket_send, which bypasses the TransportOps enabling the call into
>qtest.c. This change replaces the socket_send calls with ops->send,
>maintaining the benefits of the direct socket_send call, while adding
>support for in-process qtest calls.
>
>Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
>Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

>---
> tests/qtest/libqtest.c | 71 ++++++++++++++++++++++++++++++++++++++++--
> tests/qtest/libqtest.h |  4 +++
> 2 files changed, 73 insertions(+), 2 deletions(-)
>
>diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
>index e5056a1d0f..49075b55a1 100644
>--- a/tests/qtest/libqtest.c
>+++ b/tests/qtest/libqtest.c
>@@ -37,10 +37,18 @@
>
>
> typedef void (*QTestSendFn)(QTestState *s, const char *buf);
>+typedef void (*ExternalSendFn)(void *s, const char *buf);
> typedef GString* (*QTestRecvFn)(QTestState *);
>
> typedef struct QTestClientTransportOps {
>     QTestSendFn     send;      /* for sending qtest commands */
>+
>+    /*
>+     * use external_send to send qtest command strings through functions which
>+     * do not accept a QTestState as the first parameter.
>+     */
>+    ExternalSendFn  external_send;
>+
>     QTestRecvFn     recv_line; /* for receiving qtest command responses */
> } QTestTransportOps;
>
>@@ -1078,8 +1086,8 @@ void qtest_bufwrite(QTestState *s, uint64_t addr, const void *data, size_t size)
>
>     bdata = g_base64_encode(data, size);
>     qtest_sendf(s, "b64write 0x%" PRIx64 " 0x%zx ", addr, size);
>-    socket_send(s->fd, bdata, strlen(bdata));
>-    socket_send(s->fd, "\n", 1);
>+    s->ops.send(s, bdata);
>+    s->ops.send(s, "\n");
>     qtest_rsp(s, 0);
>     g_free(bdata);
> }
>@@ -1367,3 +1375,62 @@ static void qtest_client_set_rx_handler(QTestState *s, QTestRecvFn recv)
> {
>     s->ops.recv_line = recv;
> }
>+/* A type-safe wrapper for s->send() */
>+static void send_wrapper(QTestState *s, const char *buf)
>+{
>+    s->ops.external_send(s, buf);
>+}
>+
>+static GString *qtest_client_inproc_recv_line(QTestState *s)
>+{
>+    GString *line;
>+    size_t offset;
>+    char *eol;
>+
>+    eol = strchr(s->rx->str, '\n');
>+    offset = eol - s->rx->str;
>+    line = g_string_new_len(s->rx->str, offset);
>+    g_string_erase(s->rx, 0, offset + 1);
>+    return line;
>+}
>+
>+QTestState *qtest_inproc_init(QTestState **s, bool log, const char* arch,
>+                    void (*send)(void*, const char*))
>+{
>+    QTestState *qts;
>+    qts = g_new0(QTestState, 1);
>+    *s = qts; /* Expose qts early on, since the query endianness relies on it */
>+    qts->wstatus = 0;
>+    for (int i = 0; i < MAX_IRQ; i++) {
>+        qts->irq_level[i] = false;
>+    }
>+
>+    qtest_client_set_rx_handler(qts, qtest_client_inproc_recv_line);
>+
>+    /* send() may not have a matching protoype, so use a type-safe wrapper */
>+    qts->ops.external_send = send;
>+    qtest_client_set_tx_handler(qts, send_wrapper);
>+
>+    qts->big_endian = qtest_query_target_endianness(qts);
>+
>+    /*
>+     * Set a dummy path for QTEST_QEMU_BINARY. Doesn't need to exist, but this
>+     * way, qtest_get_arch works for inproc qtest.
>+     */
>+    gchar *bin_path = g_strconcat("/qemu-system-", arch, NULL);
>+    setenv("QTEST_QEMU_BINARY", bin_path, 0);
>+    g_free(bin_path);
>+
>+    return qts;
>+}
>+
>+void qtest_client_inproc_recv(void *opaque, const char *str)
>+{
>+    QTestState *qts = *(QTestState **)opaque;
>+
>+    if (!qts->rx) {
>+        qts->rx = g_string_new(NULL);
>+    }
>+    g_string_append(qts->rx, str);
>+    return;
>+}
>diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
>index c9e21e05b3..f5cf93c386 100644
>--- a/tests/qtest/libqtest.h
>+++ b/tests/qtest/libqtest.h
>@@ -729,4 +729,8 @@ bool qtest_probe_child(QTestState *s);
>  */
> void qtest_set_expected_status(QTestState *s, int status);
>
>+QTestState *qtest_inproc_init(QTestState **s, bool log, const char* arch,
>+                    void (*send)(void*, const char*));
>+
>+void qtest_client_inproc_recv(void *opaque, const char *str);
> #endif
>-- 
>2.23.0
>
>

