Received: from eggs.gnu.org ([209.51.188.92]:40761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h08UV-0001Yu-1H
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 12:32:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h08UU-0003IL-6H
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 12:32:03 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34957)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h08UT-0003Ds-VU
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 12:32:02 -0500
Received: by mail-wm1-f66.google.com with SMTP id y15so983125wma.0
	for <qemu-devel@nongnu.org>; Sat, 02 Mar 2019 09:31:59 -0800 (PST)
References: <20190302022518.18719-1-samuel.thibault@ens-lyon.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5b0be3f1-85c1-bb1a-2692-e0f2650bcb4f@redhat.com>
Date: Sat, 2 Mar 2019 18:31:56 +0100
MIME-Version: 1.0
In-Reply-To: <20190302022518.18719-1-samuel.thibault@ens-lyon.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] slirp: fix big/little endian conversion in
 ident protocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-devel@nongnu.org
Cc: will@wbowling.info, stefanha@redhat.com, jan.kiszka@siemens.com

Hi Samuel,

On 3/2/19 3:25 AM, Samuel Thibault wrote:
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> ---

I got:

Applying: slirp: fix big/little endian conversion in ident protocol
error: patch failed: slirp/tcp_subr.c:660
error: slirp/tcp_subr.c: patch does not apply

Then noticed another slirp patch, applied first then this one succeed,
so you missed:

Based-on: <1551476756-25749-1-git-send-email-will@wbowling.info>

>  slirp/tcp_subr.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
> index ef9d99c154..1d7e72dca7 100644
> --- a/slirp/tcp_subr.c
> +++ b/slirp/tcp_subr.c
> @@ -660,10 +660,12 @@ tcp_emu(struct socket *so, struct mbuf *m)
>  						    tmpso->so_fport == n1) {
>  							if (getsockname(tmpso->s,
>  								(struct sockaddr *)&addr, &addrlen) == 0)
> -							   n2 = ntohs(addr.sin_port);
> +							   n2 = addr.sin_port;
>  							break;
>  						}
>  					}
> +					NTOHS(n1);
> +					NTOHS(n2);
>  					so_rcv->sb_cc = snprintf(so_rcv->sb_data,
>  								 so_rcv->sb_datalen,
>  								 "%d,%d\r\n", n1, n2);
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
