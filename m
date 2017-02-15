Received: from eggs.gnu.org ([2001:4830:134:3::10]:36152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ce2JW-0002zE-4c
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 11:20:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ce2JU-0003pH-O9
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 11:20:18 -0500
Date: Wed, 15 Feb 2017 17:20:07 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170215162007.GF4935@noname.redhat.com>
References: <20170214192525.18624-1-eblake@redhat.com>
	<20170214192525.18624-7-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170214192525.18624-7-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 6/7] blkdebug: Add ability to override
 unmap geometries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, Markus Armbruster <armbru@redhat.com>

Am 14.02.2017 um 20:25 hat Eric Blake geschrieben:
> Make it easier to simulate various unusual hardware setups (for
> example, recent commits 3482b9b and b8d0a98 affect the Dell
> Equallogic iSCSI with its 15M preferred and maximum unmap and
> write zero sizing, or b2f95fe deals with the Linux loopback
> block device having a max_transfer of 64k), by allowing blkdebug
> to wrap any other device with further restrictions on various
> alignments.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v5: tweak docs regarding max-transfer minimum
> v4: relax 512 byte minimum now that blkdebug is byte-based, fix doc typo
> v3: improve legibility of bounds checking, improve docs
> v2: new patch
> ---
>  qapi/block-core.json | 25 ++++++++++++++-
>  block/blkdebug.c     | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 114 insertions(+), 2 deletions(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 932f5bb..8556c2b 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2463,6 +2463,27 @@
>  # @align:           #optional required alignment for requests in bytes,
>  #                   must be power of 2, or 0 for default
>  #
> +# @max-transfer:    #optional maximum size for I/O transfers in bytes,
> +#                   must be multiple of @align and of the underlying file's
> +#                   request alignment (but need not be a power of 2), or
> +#                   0 for default (since 2.9)
> +#
> +# @opt-write-zero:  #optional preferred alignment for write zero requests
> +#                   in bytes, must be multiple of @align (but need not be
> +#                   a power of 2), or 0 for default (since 2.9)

The code doesn't only check against @align, but also against the
"underlying file's request alignment" like you specified for
@max-transfer.

The same is true for all of the following options.

> +# @max-write-zero:  #optional maximum size for write zero requests in bytes,
> +#                   must be multiple of @align (but need not be a power of
> +#                   2), or 0 for default (since 2.9)

Must be a multiple of @opt-write-zero, too.

> +#
> +# @opt-discard:     #optional preferred alignment for discard requests
> +#                   in bytes, must be multiple of @align (but need not be
> +#                   a power of 2), or 0 for default (since 2.9)
> +#
> +# @max-discard:     #optional maximum size for discard requests in bytes,
> +#                   must be multiple of @align (but need not be a power of
> +#                   2), or 0 for default (since 2.9)

And here of @opt-discard.

>  # @inject-error:    #optional array of error injection descriptions
>  #
>  # @set-state:       #optional array of state-change descriptions
> @@ -2472,7 +2493,9 @@
>  { 'struct': 'BlockdevOptionsBlkdebug',
>    'data': { 'image': 'BlockdevRef',
>              '*config': 'str',
> -            '*align': 'int',
> +            '*align': 'int', '*max-transfer': 'int32',
> +            '*opt-write-zero': 'int32', '*max-write-zero': 'int32',
> +            '*opt-discard': 'int32', '*max-discard': 'int32',

Hm, strictly speaking, this schema allows for negative values. Should we
document that they aren't allowed?

>              '*inject-error': ['BlkdebugInjectErrorOptions'],
>              '*set-state': ['BlkdebugSetStateOptions'] } }
> 
> diff --git a/block/blkdebug.c b/block/blkdebug.c
> index 2996152..c2e4604 100644
> --- a/block/blkdebug.c
> +++ b/block/blkdebug.c
> @@ -39,6 +39,11 @@ typedef struct BDRVBlkdebugState {
>      int state;
>      int new_state;
>      uint64_t align;
> +    uint64_t max_transfer;
> +    uint64_t opt_write_zero;
> +    uint64_t max_write_zero;
> +    uint64_t opt_discard;
> +    uint64_t max_discard;
> 
>      /* For blkdebug_refresh_filename() */
>      char *config_file;
> @@ -343,6 +348,31 @@ static QemuOptsList runtime_opts = {
>              .type = QEMU_OPT_SIZE,
>              .help = "Required alignment in bytes",
>          },
> +        {
> +            .name = "max-transfer",
> +            .type = QEMU_OPT_SIZE,
> +            .help = "Maximum transfer size in bytes",
> +        },
> +        {
> +            .name = "opt-write-zero",
> +            .type = QEMU_OPT_SIZE,
> +            .help = "Optimum write zero alignment in bytes",
> +        },
> +        {
> +            .name = "max-write-zero",
> +            .type = QEMU_OPT_SIZE,
> +            .help = "Maximum write zero size in bytes",
> +        },
> +        {
> +            .name = "opt-discard",
> +            .type = QEMU_OPT_SIZE,
> +            .help = "Optimum discard alignment in bytes",
> +        },
> +        {
> +            .name = "max-discard",
> +            .type = QEMU_OPT_SIZE,
> +            .help = "Maximum discard size in bytes",
> +        },
>          { /* end of list */ }
>      },
>  };
> @@ -354,6 +384,7 @@ static int blkdebug_open(BlockDriverState *bs, QDict *options, int flags,
>      QemuOpts *opts;
>      Error *local_err = NULL;
>      int ret;
> +    uint64_t align;
> 
>      opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
>      qemu_opts_absorb_qdict(opts, options, &local_err);
> @@ -387,12 +418,55 @@ static int blkdebug_open(BlockDriverState *bs, QDict *options, int flags,
>      bs->supported_zero_flags = (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
>          bs->file->bs->supported_zero_flags;
> 
> -    /* Set request alignment */
> +    /* Set alignment overrides */
>      s->align = qemu_opt_get_size(opts, "align", 0);
>      if (s->align && (s->align >= INT_MAX || !is_power_of_2(s->align))) {
>          error_setg(errp, "Invalid alignment, align must be integer power of 2");
>          goto fail_unref;
>      }
> +    align = MAX(s->align, bs->file->bs->bl.request_alignment);
> +
> +    s->max_transfer = qemu_opt_get_size(opts, "max-transfer", 0);
> +    if (s->max_transfer &&
> +        (s->max_transfer >= INT_MAX ||
> +         !QEMU_IS_ALIGNED(s->max_transfer, align))) {
> +        error_setg(errp, "Invalid max-transfer, must be multiple of align");

It's not that I'm generally a friend of unspecific messages, but in this
case I think I would prefer being unspecific to the potentially wrong
error message that is returned here. We're checking multiple conditions
and the error message mentions only one of them as the reason, which may
or may not be the right one.

This is the same for all new options.

> +        goto fail_unref;
> +    }
> +
> +    s->opt_write_zero = qemu_opt_get_size(opts, "opt-write-zero", 0);
> +    if (s->opt_write_zero &&
> +        (s->opt_write_zero >= INT_MAX ||
> +         !QEMU_IS_ALIGNED(s->opt_write_zero, align))) {
> +        error_setg(errp, "Invalid opt-write-zero, not consistent with align");
> +        goto fail_unref;
> +    }
> +
> +    s->max_write_zero = qemu_opt_get_size(opts, "max-write-zero", 0);
> +    if (s->max_write_zero &&
> +        (s->max_write_zero >= INT_MAX ||
> +         !QEMU_IS_ALIGNED(s->max_write_zero,
> +                          MAX(s->opt_write_zero, align)))) {
> +        error_setg(errp, "Invalid max-write-zero, not consistent with align");
> +        goto fail_unref;
> +    }
> +
> +    s->opt_discard = qemu_opt_get_size(opts, "opt-discard", 0);
> +    if (s->opt_discard &&
> +        (s->opt_discard >= INT_MAX ||
> +         !QEMU_IS_ALIGNED(s->opt_discard, align))) {
> +        error_setg(errp, "Invalid opt-discard, not consistent with align");
> +        goto fail_unref;
> +    }
> +
> +    s->max_discard = qemu_opt_get_size(opts, "max-discard", 0);
> +    if (s->max_discard &&
> +        (s->max_discard >= INT_MAX ||
> +         !QEMU_IS_ALIGNED(s->max_discard,
> +                          MAX(s->opt_discard, align)))) {
> +        error_setg(errp, "Invalid max-discard, not consistent with align");
> +        goto fail_unref;
> +    }

Kevin
