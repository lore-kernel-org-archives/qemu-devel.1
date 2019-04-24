Received: from eggs.gnu.org ([209.51.188.92]:37183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1hJFE7-0002eh-JT
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:34:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1hJF0b-0005p1-Ho
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:20:10 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 24 Apr 2019 18:19:54 +0800
From: yuchenlin <yuchenlin@synology.com>
In-Reply-To: <20190424074901.31430-2-shmuel.eiderman@oracle.com>
References: <20190424074901.31430-1-shmuel.eiderman@oracle.com>
	<20190424074901.31430-2-shmuel.eiderman@oracle.com>
Message-ID: <4da5f516c2a2512e87709141f4c2b4e2@synology.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/2] vmdk: Fix comment
 regarding max l1_size coverage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Eiderman <shmuel.eiderman@oracle.com>
Cc: fam@euphon.net, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, eyal.moscovici@oracle.com, arbel.moshe@oracle.com, qemu-devel@nongnu.org, liran.alon@oracle.com, Qemu-block <qemu-block-bounces+yuchenlin=synology.com@nongnu.org>

On 2019-04-24 15:49, Sam Eiderman wrote:
> Commit b0651b8c246d ("vmdk: Move l1_size check into vmdk_add_extent")
> extended the l1_size check from VMDK4 to VMDK3 but did not update the
> default coverage in the moved comment.
> 
> The previous vmdk4 calculation:
> 
>     (512 * 1024 * 1024) * 512(l2 entries) * 65536(grain) = 16PB
> 
> The added vmdk3 calculation:
> 
>     (512 * 1024 * 1024) * 4096(l2 entries) * 512(grain) = 1PB
> 
> Adding the calculation of vmdk3 to the comment.
> 
> In any case, VMware does not offer virtual disks more than 2TB for
> vmdk4/vmdk3 or 64TB for the new undocumented seSparse format which is
> not implemented yet in qemu.
> 
> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
> Reviewed-by: Eyal Moscovici <eyal.moscovici@oracle.com>
> Reviewed-by: Liran Alon <liran.alon@oracle.com>
> Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
> Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
> ---
>  block/vmdk.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/block/vmdk.c b/block/vmdk.c
> index de8cb859f8..fc7378da78 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c
> @@ -426,10 +426,15 @@ static int vmdk_add_extent(BlockDriverState *bs,
>          return -EFBIG;
>      }
>      if (l1_size > 512 * 1024 * 1024) {
> -        /* Although with big capacity and small l1_entry_sectors, we 
> can get a
> +        /*
> +         * Although with big capacity and small l1_entry_sectors, we 
> can get a
>           * big l1_size, we don't want unbounded value to allocate the 
> table.
> -         * Limit it to 512M, which is 16PB for default cluster and L2 
> table
> -         * size */
> +         * Limit it to 512M, which is:
> +         *     16PB - for default "Hosted Sparse Extent" (VMDK4)
> +         *            cluster size: 64KB, L2 table size: 512 entries
> +         *     1PB  - for default "ESXi Host Sparse Extent" 
> (VMDK3/vmfsSparse)
> +         *            cluster size: 512B, L2 table size: 4096 entries
> +         */
>          error_setg(errp, "L1 size too big");
>          return -EFBIG;
>      }

The calculation of VMDK3 can be verified in end of page No.9 of the spec 
(https://www.vmware.com/support/developer/vddk/vmdk_50_technote.pdf).

Also the VMDK4 can be checked in the section Grain Table and Grain in 
page No.8 of the spec.

Reviewed-by: yuchenlin <yuchenlin@synology.com>
