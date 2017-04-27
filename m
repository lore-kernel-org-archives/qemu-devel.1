Received: from eggs.gnu.org ([2001:4830:134:3::10]:48879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d3nyd-0006ki-Hv
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 14:17:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d3nyY-0006BR-M8
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 14:17:15 -0400
Received: from mail.kernel.org ([198.145.29.136]:42804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1d3nyY-0006BB-G4
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 14:17:10 -0400
Date: Thu, 27 Apr 2017 11:17:06 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <149328635105.30266.13681288439634920908.stgit@bahia>
Message-ID: <alpine.DEB.2.10.1704271116190.11141@sstabellini-ThinkPad-X260>
References: <149328633283.30266.4224847428546759127.stgit@bahia>
	<149328635105.30266.13681288439634920908.stgit@bahia>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v2 2/4] 9pfs: drop pdu_push_and_notify()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>

On Thu, 27 Apr 2017, Greg Kurz wrote:
> Only pdu_complete() needs to notify the client that a request has completed.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p.c |    7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index c80ba67389ce..01deffa0c3b5 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -65,11 +65,6 @@ ssize_t pdu_unmarshal(V9fsPDU *pdu, size_t offset, const char *fmt, ...)
>      return ret;
>  }
>  
> -static void pdu_push_and_notify(V9fsPDU *pdu)

I would probably turn this into a static inline and keep it around as
syntactic sugar. Regardless:

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> -{
> -    pdu->s->transport->push_and_notify(pdu);
> -}
> -
>  static int omode_to_uflags(int8_t mode)
>  {
>      int ret = 0;
> @@ -668,7 +663,7 @@ static void coroutine_fn pdu_complete(V9fsPDU *pdu, ssize_t len)
>      pdu->size = len;
>      pdu->id = id;
>  
> -    pdu_push_and_notify(pdu);
> +    pdu->s->transport->push_and_notify(pdu);
>  
>      /* Now wakeup anybody waiting in flush for this request */
>      if (!qemu_co_queue_next(&pdu->complete)) {
> 
> 
