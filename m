Received: from eggs.gnu.org ([2001:4830:134:3::10]:42449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eBhTZ-0006Sm-7H
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 08:30:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eBhTY-0005WE-6v
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 08:30:05 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:54947)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eBhTX-0005Vz-VV
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 08:30:04 -0500
Received: by mail-wm0-x244.google.com with SMTP id r68so14236153wmr.3
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 05:30:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171106132805.19986-1-jfreimann@redhat.com>
References: <20171106132805.19986-1-jfreimann@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Nov 2017 13:29:42 +0000
Message-ID: <CAFEAcA_nYzSr5BodQAeHr_knc4XKMwQKNT_rAmJ25RDx3ba01Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] net/socket: fix coverity issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jens Freimann <jfreimann@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>

On 6 November 2017 at 13:28, Jens Freimann <jfreimann@redhat.com> wrote:
> This fixes coverity issue CID1005339.
>
> Make sure that saddr is not used uninitialized if the
> mcast parameter is NULL.
>
> Cc: qemu-stable@nongnu.org
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
> ---
>  net/socket.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/socket.c b/net/socket.c
> index e6b471c63d..51eaea67a0 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -332,7 +332,7 @@ static NetSocketState *net_socket_fd_init_dgram(NetClientState *peer,
>                                                  const char *mcast,
>                                                  Error **errp)
>  {
> -    struct sockaddr_in saddr;
> +    struct sockaddr_in saddr = { 0 };

Do we really need the initialization here? With the two if()
conditions aligned we should be properly initializing it
in all the cases we use it, or have I missed one?

thanks
-- PMM
