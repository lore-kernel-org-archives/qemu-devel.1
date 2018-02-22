Received: from eggs.gnu.org ([2001:4830:134:3::10]:57262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ep0R3-0005xl-QP
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 18:39:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ep0QW-0004eN-VO
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 18:37:57 -0500
References: <20180221135404.27598-1-kwolf@redhat.com>
	<20180221135404.27598-35-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e1794b29-919c-d090-8892-11fae64c7723@redhat.com>
Date: Thu, 22 Feb 2018 17:35:57 -0600
MIME-Version: 1.0
In-Reply-To: <20180221135404.27598-35-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 34/36] block: Fail bdrv_truncate() with
 negative size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

On 02/21/2018 07:54 AM, Kevin Wolf wrote:
> Most callers have their own checks, but something like this should also
> be checked centrally. As it happens, x-blockdev-create can pass negative
> image sizes to format drivers (because there is no QAPI type that would
> reject negative numbers) and triggers the check added by this patch.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>   block.c | 5 +++++
>   1 file changed, 5 insertions(+)

Are there any callers that can be simplified (such as now assert()ing 
rather than checking and returning an error) due to better guarantees 
about a non-negative argument?

> 
> diff --git a/block.c b/block.c
> index 4a7e448226..5c874aefa1 100644
> --- a/block.c
> +++ b/block.c
> @@ -3684,6 +3684,11 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, PreallocMode prealloc,
>           error_setg(errp, "No medium inserted");
>           return -ENOMEDIUM;
>       }
> +    if (offset < 0) {
> +        error_setg(errp, "Image size cannot be negative");
> +        return -EINVAL;
> +    }
> +
>       if (!drv->bdrv_truncate) {
>           if (bs->file && drv->is_filter) {
>               return bdrv_truncate(bs->file, offset, prealloc, errp);
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
