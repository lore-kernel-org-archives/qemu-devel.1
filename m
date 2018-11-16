Received: from eggs.gnu.org ([2001:4830:134:3::10]:57751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gNgZz-0001mJ-T1
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:02:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gNgZy-0005Hj-UF
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:02:47 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181116155302.22472-2-mreitz@redhat.com>
References: <20181116155302.22472-1-mreitz@redhat.com>
	<20181116155302.22472-2-mreitz@redhat.com>
Date: Fri, 16 Nov 2018 17:02:22 +0100
Message-ID: <w51d0r5ui29.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-3.1? 1/3] block: Always abort reopen
 after prepare succeeded
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>

On Fri 16 Nov 2018 04:53:00 PM CET, Max Reitz wrote:
> bdrv_reopen_multiple() does not invoke bdrv_reopen_abort() for the
> element of the reopen queue for which bdrv_reopen_prepare() failed,
> because it assumes that the prepare function will have rolled back all
> changes already.
>
> However, bdrv_reopen_prepare() does not do this in every case: It may
> notice an error after BlockDriver.bdrv_reopen_prepare() succeeded, and
> it will not invoke BlockDriver.bdrv_reopen_abort() then; and neither
> will bdrv_reopen_multiple(), as explained above.
>
> This is wrong because we must always call .bdrv_reopen_commit() or
> .bdrv_reopen_abort() after .bdrv_reopen_prepare() has succeeded.
> Otherwise, the block driver has no chance to undo what it has done in
> its implementation of .bdrv_reopen_prepare().
>
> To fix this, bdrv_reopen_prepare() has to call .bdrv_reopen_abort() if
> it wants to return an error after .bdrv_reopen_prepare() has succeeded.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/block.c b/block.c
> index fd67e14dfa..7f5859aa74 100644
> --- a/block.c
> +++ b/block.c
> @@ -3332,7 +3332,7 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
>              if (!qobject_is_equal(new, old)) {
>                  error_setg(errp, "Cannot change the option '%s'", entry->key);
>                  ret = -EINVAL;
> -                goto error;
> +                goto late_error;
>              }
>          } while ((entry = qdict_next(reopen_state->options, entry)));
>      }
> @@ -3340,7 +3340,7 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
>      ret = bdrv_check_perm(reopen_state->bs, queue, reopen_state->perm,
>                            reopen_state->shared_perm, NULL, errp);
>      if (ret < 0) {
> -        goto error;
> +        goto late_error;
>      }
>  
>      ret = 0;
> @@ -3354,6 +3354,19 @@ error:
>      qobject_unref(orig_reopen_opts);
>      g_free(discard);
>      return ret;
> +
> +late_error:
> +    /* drv->bdrv_reopen_prepare() has succeeded, so we need to call
> +     * drv->bdrv_reopen_abort() before signaling an error
> +     * (bdrv_reopen_multiple() will not call bdrv_reopen_abort() when
> +     * the respective bdrv_reopen_prepare() failed) */
> +    if (drv->bdrv_reopen_abort) {
> +        drv->bdrv_reopen_abort(reopen_state);
> +    }
> +    qemu_opts_del(opts);
> +    qobject_unref(orig_reopen_opts);
> +    g_free(discard);
> +    return ret;
>  }

Instead of having two exit points you could also have something like
bool drv_prepared, set it to 'true' after drv->bdrv_reopen_prepare() has
succeeded and then simply add this at the end:

if (ret < 0 && drv_prepared) {
   drv->bdrv_reopen_abort(reopen_state);
} 

Berto
