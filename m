Received: from eggs.gnu.org ([2001:4830:134:3::10]:44125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fnOBf-0003ZQ-FP
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 09:07:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fnOBZ-00067B-HA
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 09:07:39 -0400
References: <20180808071051.30628-1-lbloch@janustech.com>
	<20180808071051.30628-3-lbloch@janustech.com>
	<w51d0utt4kk.fsf@maestria.local.igalia.com>
From: Leonid Bloch <lbloch@janustech.com>
Message-ID: <f1197908-f00f-1c2b-b63c-3339e39488c5@janustech.com>
Date: Wed, 8 Aug 2018 16:07:10 +0300
MIME-Version: 1.0
In-Reply-To: <w51d0utt4kk.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/5] qcow2: Make the default L2 cache
 sufficient to cover the entire image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

On 08/08/2018 03:39 PM, Alberto Garcia wrote:
> On Wed 08 Aug 2018 09:10:48 AM CEST, Leonid Bloch wrote:
>> Sufficient L2 cache can noticeably improve the performance when using
>> large images with frequent I/O. The memory overhead is not significant
>> in most cases, as the cache size is only 1 MB for each 8 GB of virtual
>> image size (with the default cluster size of 64 KB). For cases with very
>> large images and/or small cluster sizes, there is an upper limit on the
>> default L2 cache: 32 MB.
> 
> I find this description a bit confusing.
> 
> First of all, because it's not true that the default will cover the
> whole image: we're just increasing it, but any image > 256GB is going to
> need more than 32MB (with 64KB clusters, that is).

How about the following:

qcow2: Make the default L2 cache try to cover the entire image

> 
> Second, because it's not clear what happens if you increase that
> maximum. Do you have to calculate the new value? Can you make it larger
> than what you actually need?

What if I add after the full text of the comment (which already says 
about the 'l2-cache-size' option) something like: "In any case, the L2 
cache will be set to fit the virtual image size, unless it will require 
more space than the allowed maximum, in which case it will occupy the 
allowed maximum only."

> 
> The way I see it: there are two simple changes from the user's point of
> view (they can even be two separate patches).
> 
> 1) The default l2-cache-size is now 32MB. DEFAULT_L2_CACHE_CLUSTERS is
>     useless now and disappears.
I don't think that it can be a separate patch, because unless the other 
logic is changed, the cache will occupy 32 MB *always*, regardless of 
the image size, and that's quite a big and unneeded overhead.

> 2) QEMU will only use as much memory from l2-cache-size as it can use to
>     cover the whole image. Increasing the value of l2-cache-size will not
>     use any additional memory, so it's safe to do.

I'll add the clarification that it's safe to increase the l2-cache-size 
value to the commit message. It is reasonably safe, except of some 
corner cases with very large image sizes.

> 
> Berto
> 
