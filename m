Received: from eggs.gnu.org ([2001:4830:134:3::10]:43331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evllT-0006Ax-41
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:23:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evllS-000867-7m
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:22:59 -0400
Date: Tue, 13 Mar 2018 16:22:51 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180313152251.GF4642@localhost.localdomain>
References: <20180313142003.12124-1-famz@redhat.com>
	<20180313142003.12124-2-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313142003.12124-2-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] block: Fix flags in reopen queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 13.03.2018 um 15:20 hat Fam Zheng geschrieben:
> Reopen flags are not synchronized according to the
> bdrv_reopen_queue_child precedence until bdrv_reopen_prepare. It is a
> bit too late: we already check the consistency in bdrv_check_perm before
> that.
> 
> This fixes the bug that when bdrv_reopen a RO node as RW, the flags for
> backing child are wrong. Before, we could recurse with flags.rw=1; now,
> role->inherit_options + update_flags_from_options will make sure to
> clear the bit when necessary.  Note that this will not clear an
> explicitly set bit, as in the case of parallel block jobs (e.g.
> test_stream_parallel in 030), because the explicit options include
> 'read-only=false' (for an intermediate node used by a different job).
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/block.c b/block.c
> index 75a9fd49de..a121d2ebcc 100644
> --- a/block.c
> +++ b/block.c
> @@ -2883,8 +2883,15 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
>  
>      /* Inherit from parent node */
>      if (parent_options) {
> +        QemuOpts *opts;
> +        QDict *options_copy;
>          assert(!flags);
>          role->inherit_options(&flags, options, parent_flags, parent_options);
> +        options_copy = qdict_clone_shallow(options);
> +        opts = qemu_opts_create(&bdrv_runtime_opts, NULL, 0, &error_abort);
> +        qemu_opts_absorb_qdict(opts, options_copy, NULL);
> +        update_flags_from_options(&flags, opts);
> +        qemu_opts_del(opts);

Squashed in a line here after Fam and Max agreed on IRC:

+        QDECREF(options_copy);

>      }
>  
>      /* Old values are used for options that aren't set yet */

Kevin
