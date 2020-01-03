Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE87C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 16:30:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE2DC22314
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 16:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TX1IhXaG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE2DC22314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inPqQ-0007d4-Hh
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 11:30:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36323)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1inPpJ-00075U-0j
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 11:29:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1inPpF-00005v-Qk
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 11:29:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36712
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1inPpF-0008RI-Ap
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 11:29:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578068964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MzgAdmVIAQMO3bFr6OwSSau80q0n4VX4/RF7jUWdbo8=;
 b=TX1IhXaG0utSIMEyn2ySx4Cg6RCzvAYrdo3ijsb0L0kl71IamXwLvgbW03ugU1oUodl1Qx
 Skn+SncXVQzjjkfN4W8NNN7t8w8crIxAG1CFEL2lj1FDHzdvNQlqcY2SUN4p2NSRgOlkho
 FA3J+dWzmhBRJDqVixv8yPJer9ilGa0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-4pk6GWb7MdaVPjtX73qcUA-1; Fri, 03 Jan 2020 11:29:21 -0500
Received: by mail-wm1-f72.google.com with SMTP id b131so1559724wmd.9
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2020 08:29:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MzgAdmVIAQMO3bFr6OwSSau80q0n4VX4/RF7jUWdbo8=;
 b=BKXsYR94TOk/A2Xw1QoZBLkuj2d7V0+Jy4fFsNg95KY2EchLzCGLXmXuaJ9t+s6tqw
 p4QnSxGbCCw+CkpumeW4CKCeAJu45167+funB+1/D4iaL0SyPADAl2xItuRDtem9Ys1V
 oL78EP92Umnyoa39gqjRThVrYTH+hbMYhQbMDZNqb+DP0cDSEpVUFEJbLus21JZSxDLj
 NxuiYWmHz33msgseq80WjftBFLpLCs4odoSDKyeeOwZFMxf6q/aobS1eyVDfZ9DBJ1On
 zD2GWs2EI+U7l1+s5np7VYjSLhVSOvZKZ6kB8FFQZ/vy2KUDv1XqncJXS0FiKKbI+bqp
 ixAQ==
X-Gm-Message-State: APjAAAWKSGayFiXqVR6CL4bD64IV+RKd4ForD5gMDMi82OCwPvpmWCaG
 dVwcafQbbExsNJatO2VqQezlYV9jxX4qrVg08Owoz+KZDZQJSbfgpaniBOL+H056gEOBOoRIwKh
 FSpIt1EFRqYfWItM=
X-Received: by 2002:a1c:20d3:: with SMTP id
 g202mr20891723wmg.169.1578068960185; 
 Fri, 03 Jan 2020 08:29:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqx3qnWmFDxh+W76sX9Q0ZQQnxr8HWrdg4ImCoelyFpNkV3uvdjdsDCa51RmwkI+pshS4uoEKw==
X-Received: by 2002:a1c:20d3:: with SMTP id
 g202mr20891701wmg.169.1578068959923; 
 Fri, 03 Jan 2020 08:29:19 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id h17sm63867001wrs.18.2020.01.03.08.29.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2020 08:29:19 -0800 (PST)
Subject: Re: [PATCH v6 05/21] libqtest: Add a layer of abstraciton to send/recv
To: "Oleinik, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20191129213424.6290-1-alxndr@bu.edu>
 <20191129213424.6290-6-alxndr@bu.edu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f82b43de-bead-a1d6-8ae7-83ab14ac1ef6@redhat.com>
Date: Fri, 3 Jan 2020 17:29:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191129213424.6290-6-alxndr@bu.edu>
Content-Language: en-US
X-MC-Unique: 4pk6GWb7MdaVPjtX73qcUA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

Hi Aleksander,

Typo in patch subject: "abstraction"

On 11/29/19 10:34 PM, Oleinik, Alexander wrote:
> This makes it simple to swap the transport functions for qtest commands
> to and from the qtest client. For example, now it is possible to
> directly pass qtest commands to a server handler that exists within the
> same process, without the standard way of writing to a file descriptor.
> 
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>   tests/libqtest.c | 50 +++++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 41 insertions(+), 9 deletions(-)
> 
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 91e9cb220c..ac4b6ab5f0 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -35,6 +35,17 @@
>   #define SOCKET_TIMEOUT 50
>   #define SOCKET_MAX_FDS 16
>   
> +
> +typedef void (*QTestSendFn)(QTestState *s, const char *buf);
> +typedef void (*ExternalSendFn)(void *s, const char *buf);
> +typedef GString* (*QTestRecvFn)(QTestState *);
> +
> +typedef struct QTestClientTransportOps {
> +    QTestSendFn     send;

We use strlen() so we also send a send a string. Maybe rename it send_line?

Please add a comment here about what does each function handler in this 
structure.

> +    ExternalSendFn  external_send;

Is external_send used? Apparently in patch #12. Can you add it there, 
where it is used? I don't understand why we a "type-safe wrapper" is 
called 'external'.

> +    QTestRecvFn     recv_line;
> +} QTestTransportOps;
> +
>   struct QTestState
>   {
>       int fd;
> @@ -45,6 +56,7 @@ struct QTestState
>       bool big_endian;
>       bool irq_level[MAX_IRQ];
>       GString *rx;
> +    QTestTransportOps ops;
>   };
>   
>   static GHookList abrt_hooks;
> @@ -52,6 +64,14 @@ static struct sigaction sigact_old;
>   
>   static int qtest_query_target_endianness(QTestState *s);
>   
> +static void qtest_client_socket_send(QTestState*, const char *buf);
> +static void socket_send(int fd, const char *buf, size_t size);
> +
> +static GString *qtest_client_socket_recv_line(QTestState *);
> +
> +static void qtest_client_set_tx_handler(QTestState *s, QTestSendFn send);
> +static void qtest_client_set_rx_handler(QTestState *s, QTestRecvFn recv);
> +
>   static int init_socket(const char *socket_path)
>   {
>       struct sockaddr_un addr;
> @@ -234,6 +254,9 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
>       sock = init_socket(socket_path);
>       qmpsock = init_socket(qmp_socket_path);
>   
> +    qtest_client_set_rx_handler(s, qtest_client_socket_recv_line);
> +    qtest_client_set_tx_handler(s, qtest_client_socket_send);
> +
>       qtest_add_abrt_handler(kill_qemu_hook_func, s);
>   
>       command = g_strdup_printf("exec %s "
> @@ -379,13 +402,9 @@ static void socket_send(int fd, const char *buf, size_t size)
>       }
>   }
>   
> -static void socket_sendf(int fd, const char *fmt, va_list ap)
> +static void qtest_client_socket_send(QTestState *s, const char *buf)
>   {
> -    gchar *str = g_strdup_vprintf(fmt, ap);
> -    size_t size = strlen(str);
> -
> -    socket_send(fd, str, size);
> -    g_free(str);
> +    socket_send(s->fd, buf, strlen(buf));
>   }
>   
>   static void GCC_FMT_ATTR(2, 3) qtest_sendf(QTestState *s, const char *fmt, ...)
> @@ -393,8 +412,11 @@ static void GCC_FMT_ATTR(2, 3) qtest_sendf(QTestState *s, const char *fmt, ...)
>       va_list ap;
>   
>       va_start(ap, fmt);
> -    socket_sendf(s->fd, fmt, ap);
> +    gchar *str = g_strdup_vprintf(fmt, ap);
>       va_end(ap);
> +
> +    s->ops.send(s, str);
> +    g_free(str);
>   }
>   
>   /* Sends a message and file descriptors to the socket.
> @@ -431,7 +453,7 @@ static void socket_send_fds(int socket_fd, int *fds, size_t fds_num,
>       g_assert_cmpint(ret, >, 0);
>   }
>   
> -static GString *qtest_recv_line(QTestState *s)
> +static GString *qtest_client_socket_recv_line(QTestState *s)
>   {
>       GString *line;
>       size_t offset;
> @@ -468,7 +490,7 @@ static gchar **qtest_rsp(QTestState *s, int expected_args)
>       int i;
>   
>   redo:
> -    line = qtest_recv_line(s);
> +    line = s->ops.recv_line(s);
>       words = g_strsplit(line->str, " ", 0);
>       g_string_free(line, TRUE);
>   
> @@ -1337,3 +1359,13 @@ void qmp_assert_error_class(QDict *rsp, const char *class)
>   
>       qobject_unref(rsp);
>   }
> +
> +static void qtest_client_set_tx_handler(QTestState *s,
> +                    QTestSendFn send)
> +{
> +    s->ops.send = send;
> +}
> +static void qtest_client_set_rx_handler(QTestState *s, QTestRecvFn recv)
> +{
> +    s->ops.recv_line = recv;
> +}
> 


