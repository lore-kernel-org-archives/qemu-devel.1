Received: from eggs.gnu.org ([2001:4830:134:3::10]:59280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fvq2p-0002ZZ-N7
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 16:29:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fvq2l-0004bR-Mb
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 16:29:27 -0400
Date: Fri, 31 Aug 2018 16:29:19 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180831202919.GA13226@flamenco>
References: <20180819091335.22863-1-cota@braap.org>
	<374f82bc-1680-a59d-aa71-31e88e4936a2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <374f82bc-1680-a59d-aa71-31e88e4936a2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/11] convert CPU list to RCU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org

On Mon, Aug 20, 2018 at 11:30:07 +0200, Paolo Bonzini wrote:
> On 19/08/2018 11:13, Emilio G. Cota wrote:
> > - Add some fixes for test-rcu-list. I wanted to be able to get no
> >   races with ThreadSanitizer, but it still warns about two races.
> >   I'm appending the report just in case, but I think tsan is getting
> >   confused.
> 
> I cannot understand the first.  The second might be fixed by this untested
> patch (the second hunk; the first is an optimization and clarification):
> 
> diff --git a/util/rcu.c b/util/rcu.c
> index 5676c22bd1..314b7db1a6 100644
> --- a/util/rcu.c
> +++ b/util/rcu.c
> @@ -192,7 +192,9 @@ static void enqueue(struct rcu_head *node)
>  
>      node->next = NULL;
>      old_tail = atomic_xchg(&tail, &node->next);
> -    atomic_mb_set(old_tail, node);
> +
> +    /* Pairs with smb_mb_acquire() in try_dequeue.  */
> +    atomic_store_release(old_tail, node);
>  }
>  
>  static struct rcu_head *try_dequeue(void)
> @@ -213,7 +215,10 @@ retry:
>       * wrong and we need to wait until its enqueuer finishes the update.
>       */
>      node = head;
> -    next = atomic_mb_read(&head->next);
> +    smp_mb_acquire();
> +
> +    /* atomic_read is enough because the pointer is never dereferenced.  */
> +    next = atomic_read(&head->next);
>      if (!next) {
>          return NULL;
>      }
> 
> 
> The idea being that enqueue() writes so to speak node->prev->next in
> the atomic_store_release when it enqueues node; try_dequeue() instead reads
> node->next, so there is no synchronizes-with edge.  However, I'm not that
> convinced that it's necessary...

This doesn't seem to help :-( I'd try to avoid standalone barriers
as much as possible, otherwise TSan gets confused (BTW this is why
seqlocks cannot be "understood" by TSan).

The cause of the warnings seem to be the calls to g_usleep (both in rcu.c
and in the test file), which lead TSan to believe that we might be
coordinating threads via sleep calls.

Substituting the sleep calls with cpu_relax gets rid of the warnings,
so I would say these warnings can be safely ignored.

Thanks,

		Emilio
