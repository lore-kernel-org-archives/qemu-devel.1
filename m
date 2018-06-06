Received: from eggs.gnu.org ([2001:4830:134:3::10]:53766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQcnI-0002lz-Ov
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:04:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQcnF-0001CP-Jp
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:04:24 -0400
Received: from 7.mo68.mail-out.ovh.net ([46.105.63.230]:60893)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fQcnF-0001B9-DG
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:04:21 -0400
Received: from player730.ha.ovh.net (unknown [10.109.105.112])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id B3E86E5C09
	for <qemu-devel@nongnu.org>; Wed,  6 Jun 2018 20:04:19 +0200 (CEST)
References: <20180605162545.80778-1-dgilbert@redhat.com>
	<20180605162545.80778-2-dgilbert@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <b12ed444-9abc-6ab9-3003-a7aff041f536@kaod.org>
Date: Wed, 6 Jun 2018 20:04:16 +0200
MIME-Version: 1.0
In-Reply-To: <20180605162545.80778-2-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] migration: Fixes for non-migratable
 RAMBlocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, peterx@redhat.com

On 06/05/2018 06:25 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> There are still a few cases where migration code is using the macros
> and functions that do all RAMBlocks rather than just the migratable
> blocks; fix those up.
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>=20

Thanks,

C.

> ---
>  migration/ram.c  | 4 ++--
>  migration/rdma.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/migration/ram.c b/migration/ram.c
> index a500015a2f..a7807cea84 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2516,7 +2516,7 @@ static void ram_state_resume_prepare(RAMState *rs=
, QEMUFile *out)
>       * about dirty page logging as well.
>       */
> =20
> -    RAMBLOCK_FOREACH(block) {
> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
>          pages +=3D bitmap_count_one(block->bmap,
>                                    block->used_length >> TARGET_PAGE_BI=
TS);
>      }
> @@ -3431,7 +3431,7 @@ static int ram_dirty_bitmap_sync_all(MigrationSta=
te *s, RAMState *rs)
> =20
>      trace_ram_dirty_bitmap_sync_start();
> =20
> -    RAMBLOCK_FOREACH(block) {
> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
>          qemu_savevm_send_recv_bitmap(file, block->idstr);
>          trace_ram_dirty_bitmap_request(block->idstr);
>          ramblock_count++;
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 05aee3d591..8bd7159059 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -635,7 +635,7 @@ static int qemu_rdma_init_ram_blocks(RDMAContext *r=
dma)
> =20
>      assert(rdma->blockmap =3D=3D NULL);
>      memset(local, 0, sizeof *local);
> -    qemu_ram_foreach_block(qemu_rdma_init_one_block, rdma);
> +    qemu_ram_foreach_migratable_block(qemu_rdma_init_one_block, rdma);
>      trace_qemu_rdma_init_ram_blocks(local->nb_blocks);
>      rdma->dest_blocks =3D g_new0(RDMADestBlock,
>                                 rdma->local_ram_blocks.nb_blocks);
>=20
