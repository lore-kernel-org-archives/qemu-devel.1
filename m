Received: from eggs.gnu.org ([2001:4830:134:3::10]:41480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gVHCd-0003xF-Cs
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 09:34:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gVHCa-0000nh-02
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 09:34:03 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181203101429.88735-4-anton.nefedov@virtuozzo.com>
References: <20181203101429.88735-1-anton.nefedov@virtuozzo.com>
	<20181203101429.88735-4-anton.nefedov@virtuozzo.com>
Date: Fri, 07 Dec 2018 15:33:58 +0100
Message-ID: <w51pnudv221.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v10 3/9] quorum: set supported write flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

On Mon 03 Dec 2018 11:14:55 AM CET, Anton Nefedov wrote:
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>  block/quorum.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/block/quorum.c b/block/quorum.c
> index 16b3c8067c..d21a6a3b8e 100644
> --- a/block/quorum.c
> +++ b/block/quorum.c
> @@ -857,6 +857,19 @@ static QemuOptsList quorum_runtime_opts = {
>      },
>  };
>  
> +static void quorum_set_supported_flags(BlockDriverState *bs)
> +{
> +    BDRVQuorumState *s = bs->opaque;
> +    int i;
> +
> +    bs->supported_write_flags = BDRV_REQ_FUA;
> +    for (i = 0; i < s->num_children; i++) {
> +        bs->supported_write_flags &= s->children[i]->bs->supported_write_flags;
> +    }
> +
> +    bs->supported_write_flags |= BDRV_REQ_WRITE_UNCHANGED;
> +}

You don't set supported_zero_flags here anymore ?

Berto
