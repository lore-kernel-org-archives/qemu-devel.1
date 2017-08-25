Received: from eggs.gnu.org ([2001:4830:134:3::10]:43181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dlNM2-0003IR-Hv
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 18:45:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dlNLz-0000VG-G0
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 18:45:30 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34863)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dlNLz-0000VB-BG
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 18:45:27 -0400
Received: by mail-qt0-x243.google.com with SMTP id u11so1036012qtu.2
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 15:45:27 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170825223721.2052-1-samuel.thibault@ens-lyon.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <08ed8fdc-8765-b18f-d021-31e4f05d4f9a@amsat.org>
Date: Fri, 25 Aug 2017 19:45:17 -0300
MIME-Version: 1.0
In-Reply-To: <20170825223721.2052-1-samuel.thibault@ens-lyon.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] slirp: fix clearing ifq_so from pending
 packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, jan.kiszka@siemens.com, ppandit@redhat.com, wjjzhang@tencent.com

Hi Sam, thanks for this patch :)

On 08/25/2017 07:37 PM, Samuel Thibault wrote:
> The if_fastq and if_batchq contain not only packets, but queues of packets
> for the same socket. When sofree frees a socket, it thus has to clear ifq_so
> from all the packets from the queues, not only the first.
> 
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> Acked-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

so let's raise this to:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   slirp/socket.c | 39 +++++++++++++++++++++++----------------
>   1 file changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/slirp/socket.c b/slirp/socket.c
> index ecec0295a9..cb7b5b608d 100644
> --- a/slirp/socket.c
> +++ b/slirp/socket.c
> @@ -59,6 +59,27 @@ socreate(Slirp *slirp)
>     return(so);
>   }
>   
> +/*
> + * Remove references to so from the given message queue.
> + */
> +static void
> +soqfree(struct socket *so, struct quehead *qh)
> +{
> +    struct mbuf *ifq;
> +
> +    for (ifq = (struct mbuf *) qh->qh_link;
> +             (struct quehead *) ifq != qh;
> +             ifq = ifq->ifq_next) {
> +        if (ifq->ifq_so == so) {
> +            struct mbuf *ifm;
> +            ifq->ifq_so = NULL;
> +            for (ifm = ifq->ifs_next; ifm != ifq; ifm = ifm->ifs_next) {
> +                ifm->ifq_so = NULL;
> +            }
> +        }
> +    }
> +}
> +
>   /*
>    * remque and free a socket, clobber cache
>    */
> @@ -66,23 +87,9 @@ void
>   sofree(struct socket *so)
>   {
>     Slirp *slirp = so->slirp;
> -  struct mbuf *ifm;
>   
> -  for (ifm = (struct mbuf *) slirp->if_fastq.qh_link;
> -       (struct quehead *) ifm != &slirp->if_fastq;
> -       ifm = ifm->ifq_next) {
> -    if (ifm->ifq_so == so) {
> -      ifm->ifq_so = NULL;
> -    }
> -  }
> -
> -  for (ifm = (struct mbuf *) slirp->if_batchq.qh_link;
> -       (struct quehead *) ifm != &slirp->if_batchq;
> -       ifm = ifm->ifq_next) {
> -    if (ifm->ifq_so == so) {
> -      ifm->ifq_so = NULL;
> -    }
> -  }
> +  soqfree(so, &slirp->if_fastq);
> +  soqfree(so, &slirp->if_batchq);
>   
>     if (so->so_emu==EMU_RSH && so->extra) {
>   	sofree(so->extra);
> 
