Received: from eggs.gnu.org ([2001:4830:134:3::10]:40101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1etDzE-0005S1-6W
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:54:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1etDzA-0003jK-5n
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:54:40 -0500
Date: Tue, 6 Mar 2018 15:54:26 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180306145426.GG7139@localhost.localdomain>
References: <cover.1519921268.git.berto@igalia.com>
	<d58bbc353563bb9c83ffe90faaa36fadf683e332.1519921268.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d58bbc353563bb9c83ffe90faaa36fadf683e332.1519921268.git.berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH 3/7] qcow2: Check L1 table parameters in
 qcow2_expand_zero_clusters()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>

Am 01.03.2018 um 17:27 hat Alberto Garcia geschrieben:
> This function iterates over all snapshots of a qcow2 file in order to
> expand all zero clusters, but it does not validate the snapshots' L1
> tables first.
> 
> We now have a function to take care of this, so let's use it.
> 
> We can also take the opportunity to replace the sector-based
> bdrv_read() with bdrv_pread().
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c      | 20 +++++++++++++-------
>  tests/qemu-iotests/080     |  2 ++
>  tests/qemu-iotests/080.out |  2 ++
>  3 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index e406b0f3b9..40167ac09c 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -2092,11 +2092,18 @@ int qcow2_expand_zero_clusters(BlockDriverState *bs,
>      }
>  
>      for (i = 0; i < s->nb_snapshots; i++) {
> -        int l1_sectors = DIV_ROUND_UP(s->snapshots[i].l1_size *
> -                                      sizeof(uint64_t), BDRV_SECTOR_SIZE);
> +        int l1_size2;
> +        uint64_t *new_l1_table;
>  
> -        uint64_t *new_l1_table =
> -            g_try_realloc(l1_table, l1_sectors * BDRV_SECTOR_SIZE);
> +        ret = qcow2_validate_table(bs, s->snapshots[i].l1_table_offset,
> +                                   s->snapshots[i].l1_size, sizeof(uint64_t),
> +                                   QCOW_MAX_L1_SIZE, "", NULL);
> +        if (ret < 0) {
> +            return ret;

Shouldn't this be goto fail?

Kevin
