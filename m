Received: from eggs.gnu.org ([209.51.188.92]:33194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDvoq-0004nN-B7
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 14:50:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDvoo-0005h3-DU
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 14:50:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32771)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hDvoh-0005eD-Fl
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 14:49:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id q1so22290147wrp.0
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 11:49:51 -0700 (PDT)
References: <20190409151830.6024-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <585e8815-9c3c-d532-c32b-02bab712c315@redhat.com>
Date: Tue, 9 Apr 2019 20:49:48 +0200
MIME-Version: 1.0
In-Reply-To: <20190409151830.6024-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.0] migration/ram.c: Fix
 use-after-free in multifd_recv_unfill_packet()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On 4/9/19 5:18 PM, Peter Maydell wrote:
> Coverity points out (CID 1400442) that in this code:
> 
>     if (packet->pages_alloc > p->pages->allocated) {
>         multifd_pages_clear(p->pages);
>         multifd_pages_init(packet->pages_alloc);
>     }
> 
> we free p->pages in multifd_pages_clear() but continue to
> use it in the following code. We also leak memory, because
> multifd_pages_init() returns the pointer to a new MultiFDPages_t
> struct but we are ignoring its return value.
> 
> Fix both of these bugs by adding the missing assignment of
> the newly created struct to p->pages.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> I don't know anything about the multifd code, but this seems like
> the obvious fix based on looking at what the clear and init
> functions are doing. I have only run 'make check' on this,
> so review and testing definitely in order. I think we should
> really put this into 4.0, which means ideally I'd like to
> commit it to master today or tomorrow, though...
> ---
>  migration/ram.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index f68beeeeffc..1ca9ba77b6a 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -851,7 +851,7 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
>       */
>      if (packet->pages_alloc > p->pages->allocated) {
>          multifd_pages_clear(p->pages);
> -        multifd_pages_init(packet->pages_alloc);
> +        p->pages = multifd_pages_init(packet->pages_alloc);
>      }
>  
>      p->pages->used = be32_to_cpu(packet->pages_used);
> 
