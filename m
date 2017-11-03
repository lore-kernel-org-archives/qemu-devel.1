Received: from eggs.gnu.org ([2001:4830:134:3::10]:59602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAh7T-0003Dj-Vl
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 14:55:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAh7T-0004iQ-0L
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 14:55:08 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:46327)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eAh7S-0004hP-Or
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 14:55:06 -0400
Received: by mail-wm0-x229.google.com with SMTP id r68so3377433wmr.1
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 11:55:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171016201650.18399-4-berrange@redhat.com>
References: <20171016201650.18399-1-berrange@redhat.com>
	<20171016201650.18399-4-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Nov 2017 18:54:44 +0000
Message-ID: <CAFEAcA-0as0ACWy-KHv9+DoS+6aaiHShR4xAMj9bXAMQGr3_Lw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v1 03/11] sockets: Handle race condition
 between binds to the same port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Knut Omang <knut.omang@oracle.com>

On 16 October 2017 at 21:16, Daniel P. Berrange <berrange@redhat.com> wrote:
> From: Knut Omang <knut.omang@oracle.com>
>
> If an offset of ports is specified to the inet_listen_saddr function(),
> and two or more processes tries to bind from these ports at the same time,
> occasionally more than one process may be able to bind to the same
> port. The condition is detected by listen() but too late to avoid a failure.
>
> This function is called by socket_listen() and used
> by all socket listening code in QEMU, so all cases where any form of dynamic
> port selection is used should be subject to this issue.
>
> Add code to close and re-establish the socket when this
> condition is observed, hiding the race condition from the user.
>
> Also clean up some issues with error handling to allow more
> accurate reporting of the cause of an error.
>
> This has been developed and tested by means of the
> test-listen unit test in the previous commit.
> Enable the test for make check now that it passes.
>
> Reviewed-by: Bhavesh Davda <bhavesh.davda@oracle.com>
> Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
> Reviewed-by: Girish Moodalbail <girish.moodalbail@oracle.com>
> Signed-off-by: Knut Omang <knut.omang@oracle.com>
> Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Hi. Coverity points out that this code could leak a socket fd
(CID 1381805):


> -    /* create socket + bind */
> +    /* create socket + bind/listen */
>      for (e = res; e != NULL; e = e->ai_next) {
>          getnameinfo((struct sockaddr*)e->ai_addr,e->ai_addrlen,
>                         uaddr,INET6_ADDRSTRLEN,uport,32,
> @@ -266,37 +269,58 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
>
>          slisten = create_fast_reuse_socket(e);

Every time around this outer for() loop we create an fd by calling
create_fast_reuse_socket(), which means that the previous fd
we had in that variable is leaked.

>          if (slisten < 0) {
> -            if (!e->ai_next) {
> -                error_setg_errno(errp, errno, "Failed to create socket");
> -            }
>              continue;
>          }
>
> +        socket_created = true;
>          port_min = inet_getport(e);
>          port_max = saddr->has_to ? saddr->to + port_offset : port_min;
>          for (p = port_min; p <= port_max; p++) {
>              inet_setport(e, p);
> -            if (try_bind(slisten, saddr, e) >= 0) {
> -                goto listen;
> -            }
> -            if (p == port_max) {
> -                if (!e->ai_next) {
> +            rc = try_bind(slisten, saddr, e);
> +            if (rc) {
> +                if (errno == EADDRINUSE) {
> +                    continue;
> +                } else {
>                      error_setg_errno(errp, errno, "Failed to bind socket");
> +                    goto listen_failed;
>                  }
>              }
> +            if (!listen(slisten, 1)) {
> +                goto listen_ok;
> +            }
> +            if (errno != EADDRINUSE) {
> +                error_setg_errno(errp, errno, "Failed to listen on socket");
> +                goto listen_failed;
> +            }
> +            /* Someone else managed to bind to the same port and beat us
> +             * to listen on it! Socket semantics does not allow us to
> +             * recover from this situation, so we need to recreate the
> +             * socket to allow bind attempts for subsequent ports:
> +             */
> +            closesocket(slisten);
> +            slisten = create_fast_reuse_socket(e);

(Here we do close the old fd before opening a new one, so the
inner loop doesn't leak, only the outer one.)

> +            if (slisten < 0) {
> +                error_setg_errno(errp, errno,
> +                                 "Failed to recreate failed listening socket");
> +                goto listen_failed;
> +            }
>          }
> +    }

thanks
-- PMM
