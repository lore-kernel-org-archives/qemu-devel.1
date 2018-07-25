Received: from eggs.gnu.org ([2001:4830:134:3::10]:44800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fiF7o-0006xB-Ld
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 04:26:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fiF7l-0001sS-Lo
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 04:26:24 -0400
Date: Wed, 25 Jul 2018 10:26:11 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180725082611.GA4879@localhost.localdomain>
References: <20180724200343.13733-1-lbloch@janustech.com>
	<20180724200343.13733-4-lbloch@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724200343.13733-4-lbloch@janustech.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/5] qcow2: Introduce an option for
 sufficient L2 cache for the entire image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

Am 24.07.2018 um 22:03 hat Leonid Bloch geschrieben:
> An option "l2-cache-full" is introduced to automatically set the qcow2
> L2 cache to a sufficient value for covering the entire image. The memory
> overhead when using this option is not big (1 MB for each 8 GB of
> virtual image size with the default cluster size) and it can noticeably
> improve performance when using large images with frequent I/O.
> Previously, for this functionality the correct L2 cache size needed to
> be calculated manually or with a script, and then this size needed to be
> passed to the "l2-cache-size" option. Now it is sufficient to just pass
> the boolean "l2-cache-full" option.
> 
> Signed-off-by: Leonid Bloch <lbloch@janustech.com>

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index d40d5ecc3b..c584059e23 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2812,7 +2812,12 @@
>  #                         refcount block caches in bytes (since 2.2)
>  #
>  # @l2-cache-size:         the maximum size of the L2 table cache in
> -#                         bytes (since 2.2)
> +#                         bytes (mutually exclusive with l2-cache-full)
> +#                         (since 2.2)
> +#
> +# @l2-cache-full:         make the L2 table cache large enough to cover the
> +#                         entire image (mutually exclusive with l2-cache-size)
> +#                         (since 3.1)
>  #
>  # @l2-cache-entry-size:   the size of each entry in the L2 cache in
>  #                         bytes. It must be a power of two between 512
> @@ -2840,6 +2845,7 @@
>              '*overlap-check': 'Qcow2OverlapChecks',
>              '*cache-size': 'int',
>              '*l2-cache-size': 'int',
> +            '*l2-cache-full': 'bool',
>              '*l2-cache-entry-size': 'int',
>              '*refcount-cache-size': 'int',
>              '*cache-clean-interval': 'int',

Only looking at the external interface for now, I wonder whether it
would be nicer not to have two mutually exclusive options, but to make
l2-cache-size an alternate that can take either an int like before
(meaning the number of bytes) or a string/enum (with the only accepted
value "full" for now).

Another interesting question is whether 'full' shouldn't keep meaning
full throughout the lifetime of the BlockDriverState, i.e. should it
keep adapting to the new size when the image size changes?

Kevin
