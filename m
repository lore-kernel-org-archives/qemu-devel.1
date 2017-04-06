Received: from eggs.gnu.org ([2001:4830:134:3::10]:38184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cw3Hl-0003Kr-AR
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 05:00:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cw3Hk-00043R-Nh
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 05:00:57 -0400
Date: Thu, 6 Apr 2017 11:00:45 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170406090045.GC4341@noname.redhat.com>
References: <20170405194741.18956-1-eblake@redhat.com>
	<20170405194741.18956-11-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170405194741.18956-11-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 10/13] block: Simplify
 bdrv_append_temp_snapshot() logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

Am 05.04.2017 um 21:47 hat Eric Blake geschrieben:
> Noticed while checking Coccinelle results. Naming a label 'out:'
> when it is only used on error paths is weird; meanwhile we know
> that snapshot_options is NULL on success and that QDECREF(NULL)
> is safe.  So merge the two exit paths into one.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/block.c b/block.c
> index 9b87bf6..a13625f 100644
> --- a/block.c
> +++ b/block.c
> @@ -2209,13 +2209,10 @@ static BlockDriverState *bdrv_append_temp_snapshot(BlockDriverState *bs,
>          goto out;
>      }
> 
> +out:
> +    QDECREF(snapshot_options);
>      g_free(tmp_filename);
>      return bs_snapshot;

bs_snapshot is uninitialised or at least the wrong return value in error
cases. (Hm... Shouldn't the compiler catch the uninitialised part?)

> -
> -out:
> -    QDECREF(snapshot_options);
> -    g_free(tmp_filename);
> -    return NULL;
>  }

Kevin
