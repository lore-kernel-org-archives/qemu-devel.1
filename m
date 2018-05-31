Received: from eggs.gnu.org ([2001:4830:134:3::10]:42758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fOWaQ-0004kC-9w
	for qemu-devel@nongnu.org; Thu, 31 May 2018 19:02:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fOWaN-0003NE-8K
	for qemu-devel@nongnu.org; Thu, 31 May 2018 19:02:26 -0400
Received: from mail-qt0-x22f.google.com ([2607:f8b0:400d:c0d::22f]:34169)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fOWaN-0003N6-4p
	for qemu-devel@nongnu.org; Thu, 31 May 2018 19:02:23 -0400
Received: by mail-qt0-x22f.google.com with SMTP id m5-v6so29973694qti.1
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 16:02:23 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180531203110.17203-1-samuel.thibault@ens-lyon.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6f257ea2-1cea-002e-8b8a-ac1d785778cd@amsat.org>
Date: Thu, 31 May 2018 20:02:18 -0300
MIME-Version: 1.0
In-Reply-To: <20180531203110.17203-1-samuel.thibault@ens-lyon.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv2] slirp: Fix spurious error report when
 sending directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, jan.kiszka@siemens.com

On 05/31/2018 05:31 PM, Samuel Thibault wrote:
> Move check to where it actually is useful, and reduce scope of 'len'
> variable along the way.
> 
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Thanks!

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> 
> Difference from v1:
> - move check instead of initializing len.
> 
>  slirp/socket.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/slirp/socket.c b/slirp/socket.c
> index e2a71c9b04..08fe98907d 100644
> --- a/slirp/socket.c
> +++ b/slirp/socket.c
> @@ -340,7 +340,7 @@ sosendoob(struct socket *so)
>  	struct sbuf *sb = &so->so_rcv;
>  	char buff[2048]; /* XXX Shouldn't be sending more oob data than this */
>  
> -	int n, len;
> +	int n;
>  
>  	DEBUG_CALL("sosendoob");
>  	DEBUG_ARG("so = %p", so);
> @@ -359,7 +359,7 @@ sosendoob(struct socket *so)
>  		 * send it all
>  		 */
>  		uint32_t urgc = so->so_urgc;
> -		len = (sb->sb_data + sb->sb_datalen) - sb->sb_rptr;
> +		int len = (sb->sb_data + sb->sb_datalen) - sb->sb_rptr;
>  		if (len > urgc) {
>  			len = urgc;
>  		}
> @@ -374,13 +374,13 @@ sosendoob(struct socket *so)
>  			len += n;
>  		}
>  		n = slirp_send(so, buff, len, (MSG_OOB)); /* |MSG_DONTWAIT)); */
> -	}
> -
>  #ifdef DEBUG
> -	if (n != len) {
> -		DEBUG_ERROR((dfd, "Didn't send all data urgently XXXXX\n"));
> -	}
> +		if (n != len) {
> +			DEBUG_ERROR((dfd, "Didn't send all data urgently XXXXX\n"));
> +		}
>  #endif
> +	}
> +
>  	if (n < 0) {
>  		return n;
>  	}
> 
