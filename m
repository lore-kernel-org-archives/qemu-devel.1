Received: from eggs.gnu.org ([209.51.188.92]:55685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gvqtW-0003xN-V2
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:56:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gvqtW-0003NL-13
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:56:10 -0500
References: <20190218214251.8969-1-jsnow@redhat.com>
	<20190218214251.8969-2-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <53e19065-6a53-39e5-1915-a262e3be711b@redhat.com>
Date: Mon, 18 Feb 2019 15:55:51 -0600
MIME-Version: 1.0
In-Reply-To: <20190218214251.8969-2-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/1] blockdev: acquire aio_context for
 bitmap add/remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, Max Reitz <mreitz@redhat.com>, vsementsov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 2/18/19 3:42 PM, John Snow wrote:
> When bitmaps are persistent, they may incur a disk read or write when bitmaps
> are added or removed. For configurations like virtio-dataplane, failing to
> acquire this lock will abort QEMU when disk IO occurs.
> 
> We used to acquire aio_context as part of the bitmap lookup, so re-introduce
> the lock for just the cases that have an IO penalty. Commit 2119882c removed
> these locks, and I failed to notice this when we committed fd5ae4cc, so this
> has been broken since persistent bitmaps were introduced.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1672010
> Reported-By: Aihua Liang <aliang@redhat.com>
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  blockdev.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 

>      bitmap = bdrv_create_dirty_bitmap(bs, granularity, name, errp);
>      if (bitmap == NULL) {
> -        return;
> +        goto out
>      }
>  

Your scripts are still going haywire. :(

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
