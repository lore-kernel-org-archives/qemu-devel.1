Received: from eggs.gnu.org ([2001:4830:134:3::10]:50254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqMBp-0007eT-GI
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:36:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqMBl-0001Id-Cw
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:36:05 -0400
References: <1534440027-10528-1-git-send-email-vsementsov@virtuozzo.com>
	<1534440027-10528-2-git-send-email-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <dcf1e629-272c-0727-7472-d4aee92fb8a0@virtuozzo.com>
Date: Thu, 16 Aug 2018 20:35:40 +0300
MIME-Version: 1.0
In-Reply-To: <1534440027-10528-2-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 1/4] block: improve blk_root_get_parent_desc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: crosa@redhat.com, ehabkost@redhat.com, eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, famz@redhat.com, jsnow@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

Hmm, now I think, that instead of this, it is better to use pointer as 
parent id for
nod-bds parents, to be sure they will not intersect. And add special 
field to
qapi block relation info "parent-description" for such parents.

Also I'm afraid that this patch may break iotests..

16.08.2018 20:20, Vladimir Sementsov-Ogievskiy wrote:
> Make blk_root_get_parent_desc return different descriptions for
> different blk's in worst case.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/block-backend.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/block-backend.c b/block/block-backend.c
> index fa120630be..e5707a0f8c 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -141,7 +141,7 @@ static char *blk_root_get_parent_desc(BdrvChild *child)
>       } else {
>           /* TODO Callback into the BB owner for something more detailed */
>           g_free(dev_id);
> -        return g_strdup("a block device");
> +        return g_strdup_printf("a block device %p", blk);
>       }
>   }
>   


-- 
Best regards,
Vladimir
