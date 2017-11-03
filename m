Received: from eggs.gnu.org ([2001:4830:134:3::10]:57223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAgzw-0007jo-OM
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 14:47:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAgzv-0005bx-RT
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 14:47:20 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:45815)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eAgzv-0005Zi-Jk
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 14:47:19 -0400
Received: by mail-wr0-x242.google.com with SMTP id y9so3313350wrb.2
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 11:47:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170808203900.7661-3-jfreimann@redhat.com>
References: <20170808203900.7661-1-jfreimann@redhat.com>
	<20170808203900.7661-3-jfreimann@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Nov 2017 18:46:57 +0000
Message-ID: <CAFEAcA96q_ebN06WE5mgOqiPprufR3aVOgkFBhgKKyjFr=aiCA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 2/5] net: fix -netdev socket,
 fd= for UDP sockets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jens Freimann <jfreimann@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Victor Kaplansky <victork@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On 8 August 2017 at 21:38, Jens Freimann <jfreimann@redhat.com> wrote:
> This patch fixes -netdev socket,fd= for UDP sockets
> Currently -netdev socket,fd=<...> results in
>
>   qemu: error: specified mcastaddr "127.0.0.1" (0x7f000001) does not
>     contain a multicast address
>   qemu-system-x86_64: -netdev
>     socket,id=n1,fd=3: Device 'socket' could not be initialized
>
> To fix these we need to allow specifying multicast and fd arguments
> for the same netdev. With this the user can specify "-netdev
> fd=3,mcast=<IP:port>"
>
> Cc: Jason Wang <jasowang@redhat.com>
> Fixes: 3d830459b1eccdb61b75e2712fd364012ce5a115
> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Hi. It looks like this patch (commit 0f8c289ad539 in master)
introduced a coverity issue (CID1005339):

> @@ -333,8 +333,13 @@ static NetSocketState *net_socket_fd_init_dgram(NetClientState *peer,
>       * by ONLY ONE process: we must "clone" this dgram socket --jjo
>       */
>
> -    if (is_connected) {
> -        if (getsockname(fd, (struct sockaddr *) &saddr, &saddr_len) == 0) {
> +    if (is_connected && mcast != NULL) {

This changes the condition() under which we fill in the struct sockaddr_in saddr
from "if (is_connected)" to "if (is_connected && mcast != NULL)"...

> +            if (parse_host_port(&saddr, mcast) < 0) {
> +                fprintf(stderr,
> +                        "qemu: error: init_dgram: fd=%d failed parse_host_port()\n",
> +                        fd);
> +                goto err;
> +            }
>              /* must be bound */
>              if (saddr.sin_addr.s_addr == 0) {
>                  fprintf(stderr, "qemu: error: init_dgram: fd=%d unbound, "

...but later in the function we do:

    /* mcast: save bound address as dst */
    if (is_connected) {
        s->dgram_dst = saddr;
        snprintf(nc->info_str, sizeof(nc->info_str),
                 "socket: fd=%d (cloned mcast=%s:%d)",
                 fd, inet_ntoa(saddr.sin_addr), ntohs(saddr.sin_port));
    } else {
        snprintf(nc->info_str, sizeof(nc->info_str),
                 "socket: fd=%d", fd);
    }

and coverity correctly points out that if is_connected is true
but mcast is NULL then we use 'saddr' without having initialized
it properly.

Any suggestions for the correct fix for this?

thanks
-- PMM
