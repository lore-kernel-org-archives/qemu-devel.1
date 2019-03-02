Received: from eggs.gnu.org ([209.51.188.92]:43374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h08es-0005SJ-Rj
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 12:42:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h08es-00061L-10
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 12:42:46 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38875)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h08er-0005yr-PI
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 12:42:45 -0500
Received: by mail-wm1-f67.google.com with SMTP id a188so987382wmf.3
	for <qemu-devel@nongnu.org>; Sat, 02 Mar 2019 09:42:44 -0800 (PST)
References: <1551476756-25749-1-git-send-email-will@wbowling.info>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <77613668-7b49-0c45-70ed-0684831a5b03@redhat.com>
Date: Sat, 2 Mar 2019 18:42:42 +0100
MIME-Version: 1.0
In-Reply-To: <1551476756-25749-1-git-send-email-will@wbowling.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] slirp: check sscanf result when emulating
 ident
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: William Bowling <will@wbowling.info>, qemu-devel@nongnu.org
Cc: secalert@redhat.com, qemu-stable@nongnu.org

Hi William, Samuel,

On 3/1/19 10:45 PM, William Bowling wrote:
> When emulating ident in tcp_emu, if the strchr checks passed but the
> sscanf check failed, two uninitialized variables would be copied and
> sent in the reply.

William: How did you notice that? Using a static analyzer?

Samuel: since this diff is not obvious without looking at the context
(also due to the code re-indent), can you improve the commit
description, such (or better):

"Move this code inside the if(sscanf()) clause".

We have a data leak, Cc'ing qemu-stable.
(Adding the address I noticed you Cc'ed secalert@redhat.com, so that
confirms my guess).

> 
> Signed-off-by: William Bowling <will@wbowling.info>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Thanks,

Phil.

> ---
>  slirp/tcp_subr.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
> index 262a42d6c8..73a160ba16 100644
> --- a/slirp/tcp_subr.c
> +++ b/slirp/tcp_subr.c
> @@ -664,12 +664,12 @@ tcp_emu(struct socket *so, struct mbuf *m)
>  							break;
>  						}
>  					}
> -				}
> -                                so_rcv->sb_cc = snprintf(so_rcv->sb_data,
> -                                                         so_rcv->sb_datalen,
> -                                                         "%d,%d\r\n", n1, n2);
> -				so_rcv->sb_rptr = so_rcv->sb_data;
> -				so_rcv->sb_wptr = so_rcv->sb_data + so_rcv->sb_cc;
> +                    so_rcv->sb_cc = snprintf(so_rcv->sb_data,
> +                                             so_rcv->sb_datalen,
> +                                             "%d,%d\r\n", n1, n2);
> +                    so_rcv->sb_rptr = so_rcv->sb_data;
> +                    so_rcv->sb_wptr = so_rcv->sb_data + so_rcv->sb_cc;
> +                }
>  			}
>  			m_free(m);
>  			return 0;
> 
