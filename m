Received: from eggs.gnu.org ([2001:4830:134:3::10]:54254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fo7Ff-0002GL-JZ
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 09:14:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fo7Fc-0006tP-9j
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 09:14:47 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180810062647.23211-5-lbloch@janustech.com>
References: <20180810062647.23211-1-lbloch@janustech.com>
	<20180810062647.23211-5-lbloch@janustech.com>
Date: Fri, 10 Aug 2018 15:14:40 +0200
Message-ID: <w51wosy748v.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 4/9] qcow2: Avoid duplication in setting
 the refcount cache size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

On Fri 10 Aug 2018 08:26:42 AM CEST, Leonid Bloch wrote:
> The refcount cache size does not need to be set to its minimum value in
> read_cache_sizes(), as it is set to at least its minimum value in
> qcow2_update_options_prepare().
>
> Signed-off-by: Leonid Bloch <lbloch@janustech.com>

> -    } else {
> -        if (!l2_cache_size_set) {
> -            *l2_cache_size = MAX(DEFAULT_L2_CACHE_SIZE,
> -                                 (uint64_t)DEFAULT_L2_CACHE_CLUSTERS
> -                                 * s->cluster_size);
> -        }
> -        if (!refcount_cache_size_set) {
> -            *refcount_cache_size = min_refcount_cache;
> -        }

Since you're getting rid of the rest of the code later anyway, I think
it's cleaner to only remove these last three lines here and leave the
rest untouched. It makes the patch shorter and easier to read.

> +    /* If refcount-cache-size is not specified, it will be set to minimum
> +     * in qcow2_update_options_prepare(). No need to set it here. */

This is not quite correct, because apart from the "not specified" case,
refcount_cache_size is also overridden in other circumstances: (a) the
value is specified but is too low, or (b) the value is set indirectly
via "cache-size" but the end result is too low[*].

Also, the same thing happens to l2-cache-size: if you set it manually
but it's too low then it will be overridden.

I'd personally remove the comment altogether, I think the explanation in
the commit message is enough.

Berto

[*] Now that I think of it: if you set e.g. cache-size = 16M and
    l2-cache-size = 16MB then you'll end up with refcount-cache-size =
    16M - 16M = 0, which will be overridden and set to the minimum.

    But then refcount-cache-size + l2-cache-size > cache-size

    So perhaps this should produce an error, and it may make sense to
    take the opportunity to move all the logic that ensures that
    MIN_SIZE <= size <= INT_MAX to read_cache_sizes(). But that's a
    possible task for the future and I wouldn't worry about it in this
    series.
