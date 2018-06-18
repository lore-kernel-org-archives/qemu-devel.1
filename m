Received: from eggs.gnu.org ([2001:4830:134:3::10]:39222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUuwE-0006FD-2r
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:15:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUuwC-0004Iy-Q1
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:15:22 -0400
Date: Mon, 18 Jun 2018 16:15:07 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180618141507.GB4667@localhost.localdomain>
References: <cover.1528991017.git.berto@igalia.com>
	<4a1c8fb9816de2115d08284c36d7a718b5e48de6.1528991017.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a1c8fb9816de2115d08284c36d7a718b5e48de6.1528991017.git.berto@igalia.com>
Subject: Re: [Qemu-devel] [RFC PATCH 05/10] block: Add 'keep_old_opts'
 parameter to bdrv_reopen_queue()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

Am 14.06.2018 um 17:49 hat Alberto Garcia geschrieben:
> The bdrv_reopen_queue() function is used to create a queue with the
> BDSs that are going to be reopened and their new options. Once the
> queue is ready bdrv_reopen_multiple() is called to perform the
> operation.
> 
> The original options from each one of the BDSs are kept, with the new
> options passed to bdrv_reopen_queue() applied on top of them.
> 
> For "x-blockdev-reopen" we want a function that behaves much like
> "blockdev-add". We want to ignore the previous set of options so that
> only the ones actually specified by the user are applied, with the
> rest having their default values.
> 
> We can achieve this by adding a new parameter to bdrv_reopen_queue()
> that specifies whether the old set of options is kept or discarded
> when building the reopen queue. All current callers will set that
> parameter to true, but x-blockdev-reopen will set it to false.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block.c               | 34 +++++++++++++++++++---------------
>  block/replication.c   |  4 ++--
>  include/block/block.h |  3 ++-
>  qemu-io-cmds.c        |  2 +-
>  4 files changed, 24 insertions(+), 19 deletions(-)
> 
> diff --git a/block.c b/block.c
> index a741300fae..0b9268a48d 100644
> --- a/block.c
> +++ b/block.c
> @@ -2850,7 +2850,8 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
>                                                   int flags,
>                                                   const BdrvChildRole *role,
>                                                   QDict *parent_options,
> -                                                 int parent_flags)
> +                                                 int parent_flags,
> +                                                 bool keep_old_opts)

Can we change the semantics of keep_old_opts so that flags is completely
ignored for keep_old_opts=false?

Flags are one of the reasons why the behaviour of bdrv_reopen() is
rather complex and I'd prefer not having that complexity in a public
interface. To be honest, I wouldn't be sure that I could write a correct
documentation with it.

Kevin
