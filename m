Received: from eggs.gnu.org ([2001:4830:134:3::10]:34924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dpAak-0004PF-0C
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:56:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dpAaf-0003LQ-A9
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:56:22 -0400
Date: Tue, 5 Sep 2017 10:56:10 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170905095610.GF17449@stefanha-x1.localdomain>
References: <20170901201054.11738-1-briansteffens@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170901201054.11738-1-briansteffens@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] block: add block device shared field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brian Steffens <briansteffens@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

On Fri, Sep 01, 2017 at 08:10:54PM +0000, Brian Steffens wrote:
> This adds a boolean option called 'shared' to block devices. It defaults
> to off/false. When enabled for a particular block device, the 'shared' option
> causes the block migration code to skip over syncing of that device. This
> allows controlling exactly which block devices get synced during a migration.
> 
> Signed-off-by: Brian Steffens <briansteffens@gmail.com>
> ---
>  block.c                   | 7 +++++++
>  block/qapi.c              | 2 ++
>  include/block/block.h     | 1 +
>  include/block/block_int.h | 3 +++
>  migration/block.c         | 4 ++++
>  qapi/block-core.json      | 2 +-
>  6 files changed, 18 insertions(+), 1 deletion(-)

Thanks for the patch!  Please email the relevant maintainers:

  $ scripts/get_maintainer.pl -f block.c
  Kevin Wolf <kwolf@redhat.com> (supporter:Block layer core)
  Max Reitz <mreitz@redhat.com> (supporter:Block layer core)
  qemu-block@nongnu.org (open list:Block layer core)
  qemu-devel@nongnu.org (open list:All patches CC here)

I have CCed them so they see this email.

> diff --git a/migration/block.c b/migration/block.c
> index 9171f60028..b347c3dc61 100644
> --- a/migration/block.c
> +++ b/migration/block.c
> @@ -402,6 +402,10 @@ static int init_blk_migration(QEMUFile *f)
>      bmds_bs = g_malloc0(num_bs * sizeof(*bmds_bs));
>  
>      for (i = 0, bs = bdrv_first(&it); bs; bs = bdrv_next(&it), i++) {
> +        if (bs->shared) {
> +            continue;
> +        }
> +

Have you considered extending the 'migrate' command with a list of
drives instead?

  { 'command': 'migrate',
    'data': {'*blk': 'bool',
	     '*drives': ['str'], <--- new!
	     ...}}

That way the set of drives doesn't need to be decided until migration
time.  It avoids adding new state to BlockDriverState that is used only
by the legacy block/migration.c code.

In case you haven't seen it, the preferred approach for non-shared
storage migration is drive-mirror + NBD.  The block/migration.c code is
an older feature that is less flexible.  More info on drive-mirror +
NBD:
http://wiki.libvirt.org/page/NBD_storage_migration
Slide 29 in http://events.linuxfoundation.org/sites/events/files/slides/A-Practical-Look-at-QEMU-Block-Layer-Primitives.pdf

Stefan
