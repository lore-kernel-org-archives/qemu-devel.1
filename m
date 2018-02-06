Received: from eggs.gnu.org ([2001:4830:134:3::10]:43341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ej5Vz-0002Yl-7r
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:50:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ej5Vt-0003z1-54
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:50:35 -0500
References: <20180206140722.10110-1-vsementsov@virtuozzo.com>
	<20180206140722.10110-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c501a095-43e6-95f3-b7bb-96ab80f99689@redhat.com>
Date: Tue, 6 Feb 2018 09:50:09 -0600
MIME-Version: 1.0
In-Reply-To: <20180206140722.10110-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] qapi: add block latency histogram
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

On 02/06/2018 08:07 AM, Vladimir Sementsov-Ogievskiy wrote:
> Set (and clear) histogram through new command
> block-latency-histogram-set and show new statistics in
> query-blockstats results.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   qapi/block-core.json | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>   block/qapi.c         | 31 ++++++++++++++++++++++++++
>   blockdev.c           | 15 +++++++++++++
>   3 files changed, 107 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 8225308904..4706a934d9 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -451,6 +451,63 @@
>              'status': 'DirtyBitmapStatus'} }
>   
>   ##
> +# @BlockLatencyHistogramInfo:
> +#
> +# Block latency histogram.
> +#
> +# @latency: list of latency points in microseconds. Equals to @latency parameter
> +#           of last called block-latency-histogram-set.

Second sentence might read better as:

Matches the @latency parameter from the last call to 
block-latency-histogram-set for the given device.

> +#
> +# @read: list of read-request counts corresponding to latency region.
> +#        len(@read) = len(@latency) + 1
> +#        @read[0] corresponds to latency region [0, @latency[0])
> +#        for 0 < i < len(@latency): @read[i] corresponds to latency region
> +#            [@latency[i-1], @latency[i])
> +#        @read.last_element corresponds to latency region
> +#            [@latency.last_element, +inf)
> +#
> +# @write: list of write-request counts (see @read semantics)
> +#
> +# @flush: list of flush-request counts (see @read semantics)
> +#
> +# Since: 2.12
> +##
> +{ 'struct': 'BlockLatencyHistogramInfo',
> +  'data': {'latency': ['uint64'],
> +           'read': ['uint64'],
> +           'write': ['uint64'],
> +           'flush': ['uint64'] } }

Okay, I can see how this interface works.

> +
> +##
> +# @block-latency-histogram-set:
> +#
> +# Add latency histogram to block device. If latency histogram alredy exists for

s/latency/a latency/ (twice)
s/alredy/already/

> +# the device it will be removed and a new one created. Latency histogram may be

s/Latency/The latency/

> +# quered through query-blockstats.

s/quered/queried/

> +#
> +# @device: device name to set latency histogram for.
> +#
> +# @latency: list of latency points in microseconds. The sequcence must be

s/sequcence/sequence/

> +#           ascending, elements must be greater than zero. Histogram latency
> +#           regions would be
> +#           [0, @latency[0]), ..., [@latency[i], @latency[i+1]), ...,
> +#           [@latency.last_element, +inf)
> +#
> +# Returns: error if device is not found.
> +#
> +# Since: 2.12
> +#
> +# Example:
> +#
> +# -> { "execute": "block-latency-histogram-set",
> +#      "arguments": { "device": "drive0",
> +#                     "latency": [500000, 1000000, 2000000] } }
> +# <- { "return": {} }
> +##
> +{ 'command': 'block-latency-histogram-set',
> +  'data': {'device': 'str', 'latency': ['uint64'] } }

The commit message mentioned that you can set and clear histogram 
tracking; how does this interface let you clear things?  By passing a 
0-length latency array?  If you violate the constraint (pass 
non-ascending points, for example), does the previous latency map get 
wiped out or is it still preserved unchanged?

> +
> +##
>   # @BlockInfo:
>   #
>   # Block device information.  This structure describes a virtual device and
> @@ -730,6 +787,8 @@
>   # @timed_stats: Statistics specific to the set of previously defined
>   #               intervals of time (Since 2.5)
>   #
> +# @latency-histogram: @BlockLatencyHistogramInfo. (Since 2.12)

I'd mention that this only appears if block-latency-histogram-set has 
been called.

> +#
>   # Since: 0.14.0
>   ##
>   { 'struct': 'BlockDeviceStats',
> @@ -742,7 +801,8 @@
>              'failed_flush_operations': 'int', 'invalid_rd_operations': 'int',
>              'invalid_wr_operations': 'int', 'invalid_flush_operations': 'int',
>              'account_invalid': 'bool', 'account_failed': 'bool',
> -           'timed_stats': ['BlockDeviceTimedStats'] } }
> +           'timed_stats': ['BlockDeviceTimedStats'],
> +           '*latency-histogram': 'BlockLatencyHistogramInfo' } }
>   


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
