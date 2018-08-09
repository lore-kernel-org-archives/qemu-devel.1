Received: from eggs.gnu.org ([2001:4830:134:3::10]:51302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fnt2G-00051y-QK
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 18:04:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fnt2F-0004jw-Vs
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 18:04:00 -0400
References: <20180809215307.18241-1-lbloch@janustech.com>
	<20180809215307.18241-6-lbloch@janustech.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e47135a1-2827-d969-1c33-da00846c9e61@redhat.com>
Date: Thu, 9 Aug 2018 17:03:53 -0500
MIME-Version: 1.0
In-Reply-To: <20180809215307.18241-6-lbloch@janustech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 5/8] qcow2: Increase the default upper
 limit on the L2 cache size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>

On 08/09/2018 04:53 PM, Leonid Bloch wrote:
> The upper limit on the L2 cache size is increased from 1 MB to 32 MB.
> This is done in order to allow default full coverage of an image with
> the L2 cache for images of up to 256 GB in size (was 8 GB). Note, that
> only the needed amount to cover the full image is allocated. The value
> which is changed here is just the upper limit on the L2 cache size,
> beyond which it will not grow, even if the size of the image requires
> it to.
> 
> Signed-off-by: Leonid Bloch <lbloch@janustech.com>
> ---
>   block/qcow2.h        | 2 +-
>   docs/qcow2-cache.txt | 6 +++---
>   qemu-options.hx      | 2 +-
>   3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 0bab3d8b94..d77a31d932 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -73,7 +73,7 @@
>   /* Must be at least 4 to cover all cases of refcount table growth */
>   #define MIN_REFCOUNT_CACHE_SIZE 4 /* clusters */
>   
> -#define DEFAULT_L2_CACHE_MAX_SIZE 1048576  /* bytes */
> +#define DEFAULT_L2_CACHE_MAX_SIZE 0x2000000U /* bytes */

I'd spell this as '(64 * MiB)' with the help of "qemu/units.h".

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
