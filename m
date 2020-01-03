Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CC3C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 16:46:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD4052072C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 16:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSnasFY4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD4052072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inQ64-0001Gp-6r
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 11:46:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1inQ4W-0000T7-4Z
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 11:45:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1inQ4T-0000Fp-0v
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 11:45:10 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35123
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1inQ4S-00007G-Cg
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 11:45:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578069907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GACDei65r7g0qCAfrtjPPyCiW3Ljoiaoqq4YLvOcNrA=;
 b=QSnasFY4ggvR61mb65TDnU6twgXNiTgyIkGpnGN6hhqgNNWAB9l2bWqbzUTyfxwJCh0YjT
 Y0wPywh83O6hZ2juxRkTM+cbsltKoqpphkr103nkIDBIGjXia6X2riTgOsdwQPD4nLqUdX
 KS47m4cdruHq6HX2LETJ96OJi3JSLBY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-IEtPupRyNBeHXlsLolfRww-1; Fri, 03 Jan 2020 11:45:06 -0500
Received: by mail-wm1-f72.google.com with SMTP id t4so1577189wmf.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2020 08:45:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GACDei65r7g0qCAfrtjPPyCiW3Ljoiaoqq4YLvOcNrA=;
 b=BMvTFMds6wKBAaUsrUrUDeSRQqnzaNMqv62hsZFkLNdfwZdT8Ip3DSjQ43YY5RLEFw
 sdZ0PYmn+WxYBgyhTesHwctbLZeYuEvjgC+yEcVb8iNDWwtZ0ex7fu0jJiPf6RBFusFn
 9wrEIWSwQiMXiuy0DHZyWgOy3qnSFgXVbS/pc7t/dHZ0IhR7OOOr6tEfYq7f1rjCaPGV
 /1S2Pa12qm0EXQKN19Dl1imKprd+P4MYGpPUcYOQaPH6niQHqC/kbZqeDWhagTd0C0yW
 FatDfrkYh6QM1EmAgSDGhDjhIZg+kfvr1/yEV8EgBik9J98Foq4/H7rG2XTOcQqP9g9u
 AsVg==
X-Gm-Message-State: APjAAAURpbhQz3JF9/JXwPyaLjMhwSk8P/UboBDi4bjuJWvPManCWsn3
 MTTwEjVcGczL2tnabSWvnM39AMTGwhWO7cZhMh+3GWOn4fYa1EM9v6TtFzvJ3qB2IrT4LcsZE4w
 SqVOAhkyrJqko19M=
X-Received: by 2002:adf:e6c6:: with SMTP id y6mr89319081wrm.284.1578069904986; 
 Fri, 03 Jan 2020 08:45:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqwWkfhLsyEI65C8XhlP7JOt8kEs4xlP366iyAbGua//omxiKsxRJ4aMmJ2v1MSL+X84IYNfhw==
X-Received: by 2002:adf:e6c6:: with SMTP id y6mr89319061wrm.284.1578069904798; 
 Fri, 03 Jan 2020 08:45:04 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id q6sm64989394wrx.72.2020.01.03.08.45.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2020 08:45:04 -0800 (PST)
Subject: Re: [PATCH v6 11/21] libqtest: make bufwrite rely on the TransportOps
To: "Oleinik, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20191129213424.6290-1-alxndr@bu.edu>
 <20191129213424.6290-12-alxndr@bu.edu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3745422f-0b12-d1ba-4c7c-b51ddf734012@redhat.com>
Date: Fri, 3 Jan 2020 17:45:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191129213424.6290-12-alxndr@bu.edu>
Content-Language: en-US
X-MC-Unique: IEtPupRyNBeHXlsLolfRww-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/29/19 10:34 PM, Oleinik, Alexander wrote:
> When using qtest "in-process" communication, qtest_sendf directly calls
> a function in the server (qtest.c). Previously, bufwrite used
> socket_send, which bypasses the TransportOps enabling the call into
> qtest.c. This change replaces the socket_send calls with ops->send,
> maintaining the benefits of the direct socket_send call, while adding
> support for in-process qtest calls.
> 
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>   tests/libqtest.c | 4 ++--
>   tests/libqtest.h | 3 +++
>   2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index ac4b6ab5f0..a7df92319a 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -1080,8 +1080,8 @@ void qtest_bufwrite(QTestState *s, uint64_t addr, const void *data, size_t size)
>   
>       bdata = g_base64_encode(data, size);
>       qtest_sendf(s, "b64write 0x%" PRIx64 " 0x%zx ", addr, size);
> -    socket_send(s->fd, bdata, strlen(bdata));
> -    socket_send(s->fd, "\n", 1);
> +    s->ops.send(s, bdata);
> +    s->ops.send(s, "\n");

Ah, is this the send_line() from patch #5?

Now it makes sense to move the send("\n") there and call it send_line().

Moving the send(\n) we get this in patch #5:

  static void qtest_client_socket_send_line(QTestState *s,
                                            const char *bufline)
  {
      socket_send(s->fd, bufline, strlen(bufline));
      socket_send(s->fd, "\n", 1);
  }

>       qtest_rsp(s, 0);
>       g_free(bdata);
>   }
> diff --git a/tests/libqtest.h b/tests/libqtest.h
> index c9e21e05b3..0e9b8908ef 100644
> --- a/tests/libqtest.h
> +++ b/tests/libqtest.h
> @@ -729,4 +729,7 @@ bool qtest_probe_child(QTestState *s);
>    */
>   void qtest_set_expected_status(QTestState *s, int status);
>   
> +QTestState *qtest_inproc_init(bool log, const char* arch,
> +                    void (*send)(void*, const char*));
> +void qtest_client_inproc_recv(void *opaque, const char *str);
>   #endif
> 


