Received: from eggs.gnu.org ([2001:4830:134:3::10]:47506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dZwYC-0004tu-4A
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:54:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dZwY8-0002ID-T3
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:54:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dZwY8-0002He-JC
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:54:44 -0400
Date: Tue, 25 Jul 2017 10:54:35 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170725095435.GL26394@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <cover.28627297ce9b47260986349ac22bf2de37bb9be6.1500709594.git-series.knut.omang@oracle.com>
	<ec9baca1bcdf385ea4b3e27fdbe2d35b6b0f687d.1500709594.git-series.knut.omang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ec9baca1bcdf385ea4b3e27fdbe2d35b6b0f687d.1500709594.git-series.knut.omang@oracle.com>
Subject: Re: [Qemu-devel] [PATCH v5 4/4] sockets: Handle race condition
 between binds to the same port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Knut Omang <knut.omang@oracle.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On Sat, Jul 22, 2017 at 09:49:33AM +0200, Knut Omang wrote:
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
> Signed-off-by: Knut Omang <knut.omang@oracle.com>
> Reviewed-by: Bhavesh Davda <bhavesh.davda@oracle.com>
> Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
> Reviewed-by: Girish Moodalbail <girish.moodalbail@oracle.com>
> Signed-off-by: Knut Omang <knut.omang@oracle.com>
> ---
>  tests/Makefile.include |  2 +-
>  util/qemu-sockets.c    | 51 ++++++++++++++++++++++++++++++++-----------
>  2 files changed, 39 insertions(+), 14 deletions(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index b37c0c8..9d2131d 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -128,7 +128,7 @@ check-unit-y += tests/test-bufferiszero$(EXESUF)
>  gcov-files-check-bufferiszero-y = util/bufferiszero.c
>  check-unit-y += tests/test-uuid$(EXESUF)
>  check-unit-y += tests/ptimer-test$(EXESUF)
> -#check-unit-y += tests/test-listen$(EXESUF)
> +check-unit-y += tests/test-listen$(EXESUF)
>  gcov-files-ptimer-test-y = hw/core/ptimer.c
>  check-unit-y += tests/test-qapi-util$(EXESUF)
>  gcov-files-test-qapi-util-y = qapi/qapi-util.c
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index 39f207c..8ca3ba6 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -210,7 +210,9 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
>      char port[33];
>      char uaddr[INET6_ADDRSTRLEN+1];
>      char uport[33];
> -    int slisten, rc, port_min, port_max, p;
> +    int rc, port_min, port_max, p;
> +    int slisten = 0;
> +    int saved_errno = 0;
>      Error *err = NULL;
>  
>      memset(&ai,0, sizeof(ai));
> @@ -277,27 +279,50 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
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

Add in  '&& e->ai_next' here, so we trigger the error handling
on the else branch if this was the last address we had.

> +                    continue;
> +                } else {
>                      error_setg_errno(errp, errno, "Failed to bind socket");
> +                    goto listen_failed;
> +                }
> +            }
> +            rc = listen(slisten, 1);
> +            if (!rc) {

Assigning to rc seems redundant here.

> +                goto listen_ok;
> +            } else if (errno == EADDRINUSE) {
> +                /* Someone else managed to bind to the same port and beat us
> +                 * to listen on it! Socket semantics does not allow us to
> +                 * recover from this situation, so we need to recreate the
> +                 * socket to allow bind attempts for subsequent ports:
> +                 */
> +                closesocket(slisten);
> +                slisten = create_fast_reuse_socket(e, errp);

create_fast_reuse_socket may report an error here

> +                if (slisten >= 0) {
> +                    continue;
>                  }
>              }
> +            error_setg_errno(errp, errno, "Failed to listen on socket");

at which point you report another error on top of it with a stale
errno value here. This bug would be more obvious if error reporting
was pulled out of create_fast_reuse_socket() as described in the
earlier patch.

I think it'd be clearer if we reduced the nesting here. eg

     if (listen() == 0) {
        goto listen_ok;
     }
     if (errno != EADDRINUSE) {
         error_setg_error(errp, errno, "....");
	 goto listen_failed;
     }
     closesocket(listen);
     slisten = create_fast_reuse_socket(e);
     if (slisten < 0 && !e->ai_next) {
         error_setg_error(errp, errno, "....");
	 goto listen_failed;
     }

> +            goto listen_failed;
>          }
> +    }
> +    if (err) {
> +        error_propagate(errp, err);
> +    } else {
> +        error_setg_errno(errp, errno, "Failed to find an available port");
> +    }

if we tidied up the first call to create_fast_reuse_socket() too, it would
remove the need for this.

> +
> +listen_failed:
> +    saved_errno = errno;
> +    if (slisten >= 0) {
>          closesocket(slisten);
>      }
>      freeaddrinfo(res);
> +    errno = saved_errno;
>      return -1;
>  
> -listen:
> -    if (listen(slisten,1) != 0) {
> -        error_setg_errno(errp, errno, "Failed to listen on socket");
> -        closesocket(slisten);
> -        freeaddrinfo(res);
> -        return -1;
> -    }
> +listen_ok:
>      if (update_addr) {
>          g_free(saddr->host);
>          saddr->host = g_strdup(uaddr);

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
