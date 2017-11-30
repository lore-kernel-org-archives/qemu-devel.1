Received: from eggs.gnu.org ([2001:4830:134:3::10]:49520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKSKp-00006x-IT
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 12:09:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKSKo-0002BL-IS
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 12:09:15 -0500
References: <20171130164401.29221-1-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ce174622-1df0-bf86-452e-280dd3f7e068@redhat.com>
Date: Thu, 30 Nov 2017 11:09:07 -0600
MIME-Version: 1.0
In-Reply-To: <20171130164401.29221-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] block: Formats don't need CONSISTENT_READ
 with NO_IO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com

On 11/30/2017 10:44 AM, Kevin Wolf wrote:
> Commit 1f4ad7d fixed 'qemu-img info' for raw images that are currently
> in use as a mirror target. It is not enough for image formats, though,
> as these still unconditionally request BLK_PERM_CONSISTENT_READ.
> 
> As this permission is meaningless unless you do actual I/O on the image,
> drop the requirement and allow 'qemu-img info' even for image formats
> under conditions where BLK_PERM_CONSISTENT_READ can't be granted.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 

> @@ -1936,7 +1938,9 @@ void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
>   
>           /* bs->file always needs to be consistent because of the metadata. We
>            * can never allow other users to resize or write to it. */
> -        perm |= BLK_PERM_CONSISTENT_READ;
> +        if (!(flags & BDRV_O_NO_IO)) {
> +            perm |= BLK_PERM_CONSISTENT_READ;

I thought BDRV_O_NO_IO only means we aren't doing I/O on guest-visible 
data, but doesn't stop us from reading the metadata.  The comment is 
telling: if we can read metadata, then we depend on CONSISTENT_READ for 
the metadata to be stable (even if we don't care about guest data 
consistency).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
