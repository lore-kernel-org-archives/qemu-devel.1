Received: from eggs.gnu.org ([209.51.188.92]:46988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpUjx-0005WB-Fo
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 04:04:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpUjr-0007uE-Ne
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 04:04:01 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190131143151.6146-1-kwolf@redhat.com>
Date: Fri, 01 Feb 2019 10:03:46 +0100
In-Reply-To: <20190131143151.6146-1-kwolf@redhat.com> (Kevin Wolf's message of
	"Thu, 31 Jan 2019 15:31:51 +0100")
Message-ID: <87r2crj2x9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] block: Fix invalidate_cache error path for
 parent activation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, armbru@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org, mreitz@redhat.com, dgilbert@redhat.com

Kevin Wolf <kwolf@redhat.com> writes:

> bdrv_co_invalidate_cache() clears the BDRV_O_INACTIVE flag before
> actually activating a node so that the correct permissions etc. are
> taken. In case of errors, the flag must be restored so that the next
> call to bdrv_co_invalidate_cache() retries activation.
>
> Restoring the flag was missing in the error path for a failed
> parent->role->activate() call. The consequence is that this attempt to
> activate all images correctly fails because we still set errp, however
> on the next attempt BDRV_O_INACTIVE is already clear, so we return
> success without actually retrying the failed action.
>
> An example where this is observable in practice is migration to a QEMU
> instance that has a raw format block node attached to a guest device
> with share-rw=off (the default) while another process holds
> BLK_PERM_WRITE for the same image. In this case, all activation steps
> before parent->role->activate() succeed because raw can tolerate other
> writers to the image. Only the parent callback (in particular
> blk_root_activate()) tries to implement the share-rw=on property and
> requests exclusive write permissions. This fails when the migration
> completes and correctly displays an error. However, a manual 'cont' will
> incorrectly resume the VM without calling blk_root_activate() again.
>
> This case is described in more detail in the following bug report:
> https://bugzilla.redhat.com/show_bug.cgi?id=1531888
>
> Fix this by correctly restoring the BDRV_O_INACTIVE flag in the error
> path.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/block.c b/block.c
> index 0eba8ebe5c..7f5c9bb02b 100644
> --- a/block.c
> +++ b/block.c
> @@ -4549,6 +4549,7 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
>          if (parent->role->activate) {
>              parent->role->activate(parent, &local_err);
>              if (local_err) {
> +                bs->open_flags |= BDRV_O_INACTIVE;
>                  error_propagate(errp, local_err);
>                  return;
>              }

Tested-by: Markus Armbruster <armbru@redhat.com>
