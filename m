Received: from eggs.gnu.org ([2001:4830:134:3::10]:39145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dPRAj-00017V-Ba
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 06:23:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dPRAg-0006mF-5T
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 06:23:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dPRAf-0006lg-SR
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 06:23:06 -0400
Date: Mon, 26 Jun 2017 11:22:54 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170626102254.GG495@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <cover.050aaed1de4cecd4ba9a4dc6576d1d148a8a9004.1498213152.git-series.knut.omang@oracle.com>
	<51d7f54d100e9dedecf6dc65691ca65adfc8394f.1498213152.git-series.knut.omang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <51d7f54d100e9dedecf6dc65691ca65adfc8394f.1498213152.git-series.knut.omang@oracle.com>
Subject: Re: [Qemu-devel] [PATCH v4 4/4] sockets: Handle race condition
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

On Fri, Jun 23, 2017 at 12:31:08PM +0200, Knut Omang wrote:
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
> This has been developed and tested by means of the
> test-listen unit test in the previous commit.
> Enable the test for make check now that it passes.
> 
> Signed-off-by: Knut Omang <knut.omang@oracle.com>
> Reviewed-by: Bhavesh Davda <bhavesh.davda@oracle.com>
> Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
> Reviewed-by: Girish Moodalbail <girish.moodalbail@oracle.com>
> ---
>  tests/Makefile.include |  2 +-
>  util/qemu-sockets.c    | 68 ++++++++++++++++++++++++++++++++-----------
>  2 files changed, 53 insertions(+), 17 deletions(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 22bb97e..c38f94e 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -127,7 +127,7 @@ check-unit-y += tests/test-bufferiszero$(EXESUF)
>  gcov-files-check-bufferiszero-y = util/bufferiszero.c
>  check-unit-y += tests/test-uuid$(EXESUF)
>  check-unit-y += tests/ptimer-test$(EXESUF)
> -#check-unit-y += tests/test-listen$(EXESUF)
> +check-unit-y += tests/test-listen$(EXESUF)
>  gcov-files-ptimer-test-y = hw/core/ptimer.c
>  check-unit-y += tests/test-qapi-util$(EXESUF)
>  gcov-files-test-qapi-util-y = qapi/qapi-util.c
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index 48b9319..7b118b4 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -201,6 +201,42 @@ static int try_bind(int socket, InetSocketAddress *saddr, struct addrinfo *e)
>  #endif
>  }
>  
> +static int try_bind_listen(int *socket, InetSocketAddress *saddr,
> +                           struct addrinfo *e, int port, Error **errp)
> +{
> +    int s = *socket;
> +    int ret;
> +
> +    inet_setport(e, port);
> +    ret = try_bind(s, saddr, e);
> +    if (ret) {
> +        if (errno != EADDRINUSE) {
> +            error_setg_errno(errp, errno, "Failed to bind socket");
> +        }
> +        return errno;
> +    }
> +    if (listen(s, 1) == 0) {
> +            return 0;
> +    }
> +    if (errno == EADDRINUSE) {
> +        /* We got to bind the socket to a port but someone else managed
> +         * to bind to the same port and beat us to listen on it!
> +         * Recreate the socket and return EADDRINUSE to preserve the
> +         * expected state by the caller:
> +         */
> +        closesocket(s);
> +        s = create_fast_reuse_socket(e, errp);
> +        if (s < 0) {
> +            return errno;
> +        }
> +        *socket = s;

I don't really like this at all - if we need to close + recreate the
socket, IMHO that should remain the job of the caller, since it owns
the socket FD ultimately.

> +        errno = EADDRINUSE;
> +        return errno;
> +    }
> +    error_setg_errno(errp, errno, "Failed to listen on socket");
> +    return errno;
> +}
> +
>  static int inet_listen_saddr(InetSocketAddress *saddr,
>                               int port_offset,
>                               bool update_addr,
> @@ -210,7 +246,9 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
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
> @@ -276,28 +314,26 @@ static int inet_listen_saddr(InetSocketAddress *saddr,

Just above this line is the original 'create_fast_reuse_socket' call.

I'd suggest that we push that call down into the body of the loop
below:

>          port_min = inet_getport(e);
>          port_max = saddr->has_to ? saddr->to + port_offset : port_min;
>          for (p = port_min; p <= port_max; p++) {
> -            inet_setport(e, p);
> -            if (try_bind(slisten, saddr, e) >= 0) {
> -                goto listen;
> -            }
> -            if (p == port_max) {
> -                if (!e->ai_next) {
> -                    error_setg_errno(errp, errno, "Failed to bind socket");
> -                }
> +            int eno = try_bind_listen(&slisten, saddr, e, p, &err);

Which would mean try_bind_listen no longer needs the magic to close +
recreate the socket.

The only cost of doing this is that you end up closing + recreating the
socket after bind hits EADDRINUSE, as well as after listen() hits it.

I think that's acceptable tradeoff for simpler code, since this is not
a performance critical operation.

> +            if (!eno) {
> +                goto listen_ok;
> +            } else if (eno != EADDRINUSE) {
> +                goto listen_failed;
>              }
>          }
> +    }
> +    error_setg_errno(errp, errno, "Failed to find available port");

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
