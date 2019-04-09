Received: from eggs.gnu.org ([209.51.188.92]:50009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1hDsz1-0006sI-Ef
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:48:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1hDsz0-0006VT-Es
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:48:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54837)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hDsz0-0006RZ-4X
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:48:22 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20190409151830.6024-1-peter.maydell@linaro.org> (Peter Maydell's
	message of "Tue, 9 Apr 2019 16:18:30 +0100")
References: <20190409151830.6024-1-peter.maydell@linaro.org>
Reply-To: quintela@redhat.com
Date: Tue, 09 Apr 2019 17:46:42 +0200
Message-ID: <87ef6byye5.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Peter Maydell <peter.maydell@linaro.org> wrote:
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
> ---

ouch,

good catch.

Reviewed-by: Juan Quintela <quintela@redhat.com>



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
