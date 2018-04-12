Received: from eggs.gnu.org ([2001:4830:134:3::10]:59404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f6XlL-0000Su-NG
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:39:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f6Xl6-0004SC-CX
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:39:23 -0400
References: <20180411163940.2523-1-kwolf@redhat.com>
	<20180411163940.2523-8-kwolf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <33c2ce2d-18d6-5479-19d4-3a1923cea3cb@redhat.com>
Date: Thu, 12 Apr 2018 10:37:51 +0200
MIME-Version: 1.0
In-Reply-To: <20180411163940.2523-8-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/19] block: Really pause block jobs on
 drain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, famz@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

On 11/04/2018 18:39, Kevin Wolf wrote:
> +bool bdrv_drain_poll(BlockDriverState *bs, bool top_level)
>  {
>      /* Execute pending BHs first and check everything else only after the BHs
>       * have executed. */
> -    while (aio_poll(bs->aio_context, false));
> +    if (top_level) {
> +        while (aio_poll(bs->aio_context, false));
> +    }
> +
> +    if (bdrv_parent_drained_poll(bs)) {
> +        return true;
> +    }
> +
>      return atomic_read(&bs->in_flight);
>  }
>  

Up until now I liked very much this series, but I like this patch a bit
less for two reasons.

1) I think I would prefer to have the !top_level case in a separate
function---making the API easier to use in the BdrvChildRole callback
because there is no need to pass false.  In addition, the callback is
not really polling anything, but rather returning whether the children
are quiescent.  So a better name would be bdrv_children_drained and
c->role->drained.

2) Worse, the main idea behind the first drain restructuring was that
draining could proceed in topological order: first drain the roots' I/O,
then call bdrv_drain to send the last requests to their children, then
recurse.  It is not clear to me why you need to introduce this recursive
step, which is also O(n^2) in the worst case.

Paolo
