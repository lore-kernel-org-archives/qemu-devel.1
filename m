Received: from eggs.gnu.org ([2001:4830:134:3::10]:47449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJgKP-00011X-NJ
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:25:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJgKL-00031M-Ht
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:25:53 -0400
References: <20180518132114.4070-1-kwolf@redhat.com>
	<20180518132114.4070-3-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c0590f28-6394-36ba-2c32-9fdefafca875@redhat.com>
Date: Fri, 18 May 2018 09:25:43 -0500
MIME-Version: 1.0
In-Reply-To: <20180518132114.4070-3-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 02/40] blockjob: Improve
 BlockJobInfo.offset/len documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, jsnow@redhat.com, jcody@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

On 05/18/2018 08:20 AM, Kevin Wolf wrote:
> Clarify that len is just an estimation of the end value of offset, and
> that offset increases monotonically while len can change arbitrarily.

That's tighter than what libvirt promises (and in fact, there are cases 
where libvirt synthesizes an offset/len of 1/1 to indicate completion 
when the information is no longer available from qemu, which means the 
offset has gone backwards to libvirt clients).

But it matches the qemu implementation, and I'm okay if we want to stick 
to those semantics of monotonically increasing offset (the more 
important semantics of being an estimate of time remaining is possible 
whether or not you have a guarantee of a monotonic increase on one of 
the two numbers).

> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   qapi/block-core.json | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index d32ec95666..0e29abf099 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1148,7 +1148,12 @@
>   # @device: The job identifier. Originally the device name but other
>   #          values are allowed since QEMU 2.7
>   #
> -# @len: the maximum progress value
> +# @len: Estimated @offset value at the completion of the job. This value can
> +#       arbitrarily change while the job is running, in both directions.
> +#
> +# @offset: Progress made until now. The unit is arbitrary and the value can
> +#          only meaningfully be used for the ratio of @offset to @len. The
> +#          value is monotonically increasing.

So I'm okay whether or not you drop that last sentence.

You're also rearranging the docs to occur in the order that the struct 
declares things (good change, and trivial; not sure if you want to call 
it out in the commit message).

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
