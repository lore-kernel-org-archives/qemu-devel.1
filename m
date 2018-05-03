Received: from eggs.gnu.org ([2001:4830:134:3::10]:42830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fE9TW-0001UH-Eb
	for qemu-devel@nongnu.org; Thu, 03 May 2018 04:20:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fE9TV-00059X-Cc
	for qemu-devel@nongnu.org; Thu, 03 May 2018 04:20:26 -0400
References: <20180501211336.986372-1-eblake@redhat.com>
	<20180501211336.986372-2-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <0e8a0cd5-3ab8-fbe4-8c3a-35a1e94841dc@virtuozzo.com>
Date: Thu, 3 May 2018 11:20:11 +0300
MIME-Version: 1.0
In-Reply-To: <20180501211336.986372-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 1/4] nbd: Prepare for additional block
 sizing info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, edgar.kaziakhmedov@virtuozzo.com, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

02.05.2018 00:13, Eric Blake wrote:
> The NBD spec is clarifying [1] that a server may want to advertise
> different limits for READ/WRITE (in our case, 32M) than for
> TRIM/ZERO (in our case, nearly 4G).  Add the constants and name
> lookups for new NBD_INFO_ fields used during handshake to convey
> this additional information.  Note that the NBD spec already
> requires servers to ignore unknown requests from the client, and
> for clients to ignore unknown gratuitous responses sent from
> the server.
>
> [1] https://lists.debian.org/nbd/2018/03/msg00048.html
>
> Signed-off-by: Eric Blake <eblake@redhat.com>


Reviewed-by:=C2=A0 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

>
> ---
>
> The given URL for the NBD spec was v3; it will change to be a v4
> version of that patch in part to point back to this qemu commit
> as a proof of implementation.
> ---
>   include/block/nbd.h | 4 +++-
>   nbd/common.c        | 4 ++++
>   2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/include/block/nbd.h b/include/block/nbd.h
> index fcdcd545023..cbf51628f78 100644
> --- a/include/block/nbd.h
> +++ b/include/block/nbd.h
> @@ -1,5 +1,5 @@
>   /*
> - *  Copyright (C) 2016-2017 Red Hat, Inc.
> + *  Copyright (C) 2016-2018 Red Hat, Inc.
>    *  Copyright (C) 2005  Anthony Liguori <anthony@codemonkey.ws>
>    *
>    *  Network Block Device
> @@ -180,6 +180,8 @@ typedef struct NBDExtent {
>   #define NBD_INFO_NAME           1
>   #define NBD_INFO_DESCRIPTION    2
>   #define NBD_INFO_BLOCK_SIZE     3
> +#define NBD_INFO_TRIM_SIZE      4
> +#define NBD_INFO_ZERO_SIZE      5
>
>   /* Request flags, sent from client to server during transmission phase =
*/
>   #define NBD_CMD_FLAG_FUA        (1 << 0) /* 'force unit access' during =
write */
> diff --git a/nbd/common.c b/nbd/common.c
> index 8c95c1d606e..840c91d5ca4 100644
> --- a/nbd/common.c
> +++ b/nbd/common.c
> @@ -129,6 +129,10 @@ const char *nbd_info_lookup(uint16_t info)
>           return "description";
>       case NBD_INFO_BLOCK_SIZE:
>           return "block size";
> +    case NBD_INFO_TRIM_SIZE:
> +        return "trim size";
> +    case NBD_INFO_ZERO_SIZE:
> +        return "zero size";
>       default:
>           return "<unknown>";
>       }


--=20
Best regards,
Vladimir
