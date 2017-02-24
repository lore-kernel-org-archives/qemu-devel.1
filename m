Received: from eggs.gnu.org ([2001:4830:134:3::10]:42553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1chBRj-0000h1-U6
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 03:41:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1chBRj-0002rK-56
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 03:41:47 -0500
Date: Fri, 24 Feb 2017 16:41:39 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170224084139.GB32354@lemon.lan>
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-34-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487689130-30373-34-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 33/54] block: Include details on permission
 errors in message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

On Tue, 02/21 15:58, Kevin Wolf wrote:
> Instead of just telling that there was some conflict, we can be specific
> and tell which permissions were in conflict and which way the conflict
> is.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 56 insertions(+), 11 deletions(-)
> 
> diff --git a/block.c b/block.c
> index 19cf3b0..a8a2fa7 100644
> --- a/block.c
> +++ b/block.c
> @@ -1461,6 +1461,43 @@ static void bdrv_update_perm(BlockDriverState *bs)
>      bdrv_set_perm(bs, cumulative_perms, cumulative_shared_perms);
>  }
>  
> +static char *bdrv_child_user(BdrvChild *c)

Poor function name IMHO, maybe bdrv_child_user_desc() or
bdrv_child_owner_desc()?

> +{
> +    if (c->role->get_parent_desc) {
> +        return c->role->get_parent_desc(c);
> +    }
> +
> +    return g_strdup("another user");
> +}
