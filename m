Received: from eggs.gnu.org ([2001:4830:134:3::10]:59688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKpbO-0006Oy-8p
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:59:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKpbN-0006V7-AY
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:59:54 -0500
References: <20171130164750.47320-1-vsementsov@virtuozzo.com>
	<20171130164750.47320-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2f4391f0-bbe1-07d9-83eb-82672c5583a9@redhat.com>
Date: Fri, 1 Dec 2017 11:59:46 -0600
MIME-Version: 1.0
In-Reply-To: <20171130164750.47320-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] qcow2: add overlap check for bitmap
 directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>

[adding Dan in cc]

On 11/30/2017 10:47 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/qcow2.h          |  7 +++++--
>   block/qcow2-refcount.c | 12 ++++++++++++
>   block/qcow2.c          |  6 ++++++
>   3 files changed, 23 insertions(+), 2 deletions(-)
> 

Does the LUKS encryption header need similar overlap protection checks?

> diff --git a/block/qcow2.h b/block/qcow2.h
> index 6f0ff15dd0..8f226a3609 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h

> +++ b/block/qcow2-refcount.c
> @@ -2585,6 +2585,18 @@ int qcow2_check_metadata_overlap(BlockDriverState *bs, int ign, int64_t offset,
>           }
>       }
>   
> +    if ((chk & QCOW2_OL_BITMAP_DIRECTORY) &&
> +        (s->autoclear_features & QCOW2_AUTOCLEAR_BITMAPS))
> +    {
> +        /* update_ext_header_and_dir_in_place firstly drop autoclear flag,
> +         * so it will not fail */

Wording is awkward, how about:

The autoclear flag was previously dropped by 
update_ext_header_and_dir_in_place, so this will not fail

but I'm not sure if that is the intended meaning.

> +        if (overlaps_with(s->bitmap_directory_offset,
> +                          s->bitmap_directory_size))
> +        {
> +            return QCOW2_OL_BITMAP_DIRECTORY;
> +        }
> +    }
> +
>       return 0;
>   }

Do we need to add/update any iotests to cover this?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
