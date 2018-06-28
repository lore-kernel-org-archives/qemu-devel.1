Received: from eggs.gnu.org ([2001:4830:134:3::10]:36145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYVrH-0003QY-H3
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:17:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYVrG-0005ku-AG
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:17:07 -0400
References: <20180626135035.133432-1-vsementsov@virtuozzo.com>
	<20180626135035.133432-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e5373c81-a72f-57c2-794a-829b52865d10@redhat.com>
Date: Thu, 28 Jun 2018 07:16:58 -0500
MIME-Version: 1.0
In-Reply-To: <20180626135035.133432-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/6] block/qcow2: improve error message in
 qcow2_inactivate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, quintela@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, jsnow@redhat.com

On 06/26/2018 08:50 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/qcow2.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 945132f692..46194a33ca 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2114,9 +2114,9 @@ static int qcow2_inactivate(BlockDriverState *bs)
>       qcow2_store_persistent_dirty_bitmaps(bs, &local_err);
>       if (local_err != NULL) {
>           result = -EINVAL;
> -        error_report_err(local_err);
> -        error_report("Persistent bitmaps are lost for node '%s'",
> -                     bdrv_get_device_or_node_name(bs));
> +        error_reportf_err(local_err, "Persistent bitmaps are lost for node "
> +                          "'%s', because failed to store them on qcow2 "
> +                          "inactivation: ", bdrv_get_device_or_node_name(bs));

That's longer, and has awkward grammar.

Also, for a patch designed to improve an error message, it's nice if the 
commit message demonstrates a before-and-after comparison of the two 
different wordings, along with a formula for reproducing the error (not 
mandatory, but it can sure help in reviewing).

Shorter might be:

"Lost persistent bitmaps during inactivation of node '%s': "

since the local_err text appended after the colon will then make it 
obvious what the error was during inactivation.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
