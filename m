Received: from eggs.gnu.org ([2001:4830:134:3::10]:36031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSE2Q-0008Vl-PM
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 23:35:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSE2O-00005a-MJ
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 23:34:54 -0500
References: <20180609151758.17343-1-vsementsov@virtuozzo.com>
	<20180609151758.17343-5-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7941495f-688d-66d3-6b3f-2575a79137b3@redhat.com>
Date: Wed, 28 Nov 2018 22:34:42 -0600
MIME-Version: 1.0
In-Reply-To: <20180609151758.17343-5-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 4/6] nbd/server: implement dirty bitmap
 export
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

On 6/9/18 10:17 AM, Vladimir Sementsov-Ogievskiy wrote:
> Handle new NBD meta namespace: "qemu", and corresponding queries:
> "qemu:dirty-bitmap:<export bitmap name>".
> 
> With new metadata context negotiated, BLOCK_STATUS query will reply
> with dirty-bitmap data, converted to extents. New public function
> nbd_export_bitmap selects bitmap to export. For now, only one bitmap
> may be exported.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   include/block/nbd.h |   6 ++
>   nbd/server.c        | 271 ++++++++++++++++++++++++++++++++++++++++++++++++----
>   2 files changed, 259 insertions(+), 18 deletions(-)
> 
> diff --git a/include/block/nbd.h b/include/block/nbd.h
> index fcdcd54502..a653d0fba7 100644
> --- a/include/block/nbd.h
> +++ b/include/block/nbd.h
> @@ -234,6 +234,10 @@ enum {
>   #define NBD_STATE_HOLE (1 << 0)
>   #define NBD_STATE_ZERO (1 << 1)
>   
> +/* Flags for extents (NBDExtent.flags) of NBD_REPLY_TYPE_BLOCK_STATUS,
> + * for qemu:dirty-bitmap:* meta contexts */
> +#define NBD_STATE_DIRTY (1 << 0)

Hindsight is 20:20, so there's nothing we can do about this definition 
now; commit 3d068aff is already released in 3.0.  However, if I had been 
more careful when this was first introduced, I would have negated the 
sense of this bit.  The NBD protocol recommends that a status of all 0 
represent the default state, and when it comes to dirty bitmaps, the 
safest fallback path is to declare the entire image as dirty (the way 
that we have a bit named NBD_STATE_HOLE that is 1 for a hole, but 0 for 
data, because the safest fallback path is to treat the entire image as 
data).

Why does this matter?  Because with the 3.0 hack of qemu-img map with 
x-dirty-bitmap=qemu:dirty-bitmap:FOO (commit 216ee365), if the client 
requests a particular bitmap name but the server does NOT have that name 
present, the client does NOT refuse to connect, but rather acts as 
though bdrv_block_status() treats the entire image as data.  Since the 
hack relies on treating "data":false sections of the disk as dirty, but 
the fallback causes qemu-img map to report "data":true for the entire 
image, relying on the hack will end up seeing NO clusters as dirty, and 
with NO indication that the x-dirty-bitmap= failed to work.

Had we used NBD_STATE_CLEAN (1 for clean, 0 for dirty), we would have at 
least had the safe fallback of treating the entire image as dirty, which 
would result in a full backup (a bit wasteful, but better than not 
backing up any data on the incorrect assumption that the image is clean).

I'm in the process of implementing 'qemu-nbd --list' which will show 
exactly which meta contexts an export supports, so that we can use that 
as a fallback mechanism for a client to check whether the NBD server is 
actually advertising the desired qemu:dirty-bitmap: context prior to 
blindly requesting that context via x-dirty-bitmap.  But even that hits 
a slight snag:

> @@ -924,6 +987,16 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
>           }
>       }
>   
> +    if (meta->dirty_bitmap) {
> +        ret = nbd_negotiate_send_meta_context(client,
> +                                              meta->exp->export_bitmap_context,
> +                                              NBD_META_ID_DIRTY_BITMAP,
> +                                              errp);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +    }
> +

The NBD spec says a client is allowed to issue NBD_OPT_LIST_META_CONTEXT 
with 0 queries in order to learn about all supported contexts, but this 
hunk forgot to advertise qemu:dirty-bitmap:FOO in that case.  My full 
patch series for 'qemu-nbd --list' is coming up soon, and includes a 
patch that works around the 3.0/3.1 flaw by following up with a second 
LIST_META_CONTEXT with 1 query of "qemu:' if the 0-query version didn't 
get any "qemu:..." responses.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
