Received: from eggs.gnu.org ([2001:4830:134:3::10]:60940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eurXt-00059G-FN
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 22:21:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eurXs-00083G-B4
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 22:21:13 -0500
References: <20180309165212.97144-1-vsementsov@virtuozzo.com>
	<20180309165212.97144-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <29747b20-9a56-dcef-a058-e12264ecdda3@redhat.com>
Date: Sat, 10 Mar 2018 21:20:49 -0600
MIME-Version: 1.0
In-Reply-To: <20180309165212.97144-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 2/2] qapi: add block latency histogram
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, nshirokovskiy@virtuozzo.com

On 03/09/2018 10:52 AM, Vladimir Sementsov-Ogievskiy wrote:
> Set (and clear) histogram through new command
> block-latency-histogram-set and show new statistics in
> query-blockstats results.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   qapi/block-core.json | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>   block/qapi.c         |  41 +++++++++++++++++++
>   blockdev.c           |  43 ++++++++++++++++++++
>   3 files changed, 194 insertions(+), 1 deletion(-)
> 

> +# @boundaries: list of interval boundary values in nanoseconds, all greater
> +#              than zero and in ascending order.
> +#              For example, the list [10, 50, 100] produces the following
> +#              histogram intervals: [0, 10), [10, 50), [50, 100), [100, +inf).

10 vs. 50 nanoseconds is a bit unrealistic; the example makes sense but 
you may want to scale the boundaries into values that are more likely to 
make sense during use.  Can be a followup.

> +#
> +# @bins: list of io request counts corresponding to histogram intervals.
> +#        len(@bins) = len(@boundaries) + 1
> +#        For the example above, @bins may be something like [3, 1, 5, 2],
> +#        and corresponding histogram looks like:
> +#
> +#        5|           *
> +#        4|           *
> +#        3| *         *
> +#        2| *         *    *
> +#        1| *    *    *    *
> +#         +------------------
> +#             10   50   100
> +#
> +# Since: 2.12
> +##
> +{ 'struct': 'XBlockLatencyHistogramInfo',

Struct names have no impact to introspection; I see no reason to use a 
leading X here.

> +  'data': {'boundaries': ['uint64'], 'bins': ['uint64'] } }
> +
> +##
> +# @x-block-latency-histogram-set:

I guess you've decided that this should be experimental in 2.12?  If you 
want to change the name and promote it to a released interface, you 
don't have much time left.


> +#
> +# @boundaries-read: list of interval boundary values for read latency
> +#                   histogram. If specified, old read latency histogram is
> +#                   removed, and empty one created with interavals

s/interavals/intervals/

> +#                   corresponding to @boundaries-read. The parameter has higher
> +#                   priority then @boundaries.
> +#
> +# @boundaries-write: list of interaval boundary values for write latency

and again

> +#                    histogram.
> +#
> +# @boundaries-flush: list of interaval boundary values for flush latency

copy-paste strikes again :)

> +#                    histogram.
> +#
> +# Returns: error if device is not found or @boundaries* arrays are invalid.

s/@boundaries*/any boundary arrays/

> +#
> +# Since: 2.12
> +#
> +# Example: set new histograms for all io types with intervals
> +# [0, 10), [10, 50), [50, 100), [100, +inf):

Again, are these reasonable numbers in nanoseconds?  And spelling out 
the time unit in the example documentation may be helpful.

> @@ -730,6 +830,12 @@
>   # @timed_stats: Statistics specific to the set of previously defined
>   #               intervals of time (Since 2.5)
>   #
> +# @x_rd_latency_histogram: @BlockLatencyHistogramInfo. (Since 2.12)

Here, the naming makes sense (the _ is consistent with this being an 
older interface and already using it elsewhere, and the leading x 
matches with your command being marked experimental).

> +++ b/blockdev.c
> @@ -4180,6 +4180,49 @@ void qmp_x_blockdev_set_iothread(const char *node_name, StrOrNull *iothread,
>       aio_context_release(old_context);
>   }
>   
> +void qmp_x_block_latency_histogram_set(
> +    const char *device,
I'll fix up the trivial typos, but you may want a followup patch.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
