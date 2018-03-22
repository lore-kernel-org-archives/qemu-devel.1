Received: from eggs.gnu.org ([2001:4830:134:3::10]:43928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eyrPc-0004Uq-Gt
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 00:01:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eyrPZ-0005K8-7n
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 00:01:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50948 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eyrPZ-0005Jj-32
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 00:01:09 -0400
Date: Thu, 22 Mar 2018 12:00:48 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180322040048.GE26618@lemon.usersys.redhat.com>
References: <20180322024056.29599-1-yuchenlin@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322024056.29599-1-yuchenlin@synology.com>
Subject: Re: [Qemu-devel] [PATCH] vmdk: return ENOTSUP before offset overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuchenlin@synology.com
Cc: qemu-devel@nongnu.org

On Thu, 03/22 10:40, yuchenlin@synology.com wrote:
> From: yuchenlin <yuchenlin@synology.com>
> 
> VMDK has a hard limitation of extent size, which is due to the size of grain
> table entry is 32 bits. It means it can only point to a grain located at
> offset = 2^32. To prevent offset overflow and record a useless offset
> in grain table. We should return un-support here.
> 
> Signed-off-by: yuchenlin <yuchenlin@synology.com>
> ---
>  block/vmdk.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/block/vmdk.c b/block/vmdk.c
> index f94c49a9c0..d8fc961940 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c
> @@ -47,6 +47,9 @@
>  #define VMDK4_FLAG_MARKER (1 << 17)
>  #define VMDK4_GD_AT_END 0xffffffffffffffffULL
>  
> +/* 2TB */
> +#define VMDK_EXTENT_SIZE_LIMIT (2199023255552)
> +
>  #define VMDK_GTE_ZEROED 0x1
>  
>  /* VMDK internal error codes */
> @@ -1645,6 +1648,9 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
>                  return ret;
>              }
>              if (m_data.valid) {
> +                if (cluster_offset > VMDK_EXTENT_SIZE_LIMIT) {

I think this should be >=?

Also the check should be done earlier, in get_cluster_offset even before
m_data.valid is set. We can peek at extent->next_cluster_sector to tell if the
allocation will succeed or not, and avoid writing the user data.

Fam

> +                    return -ENOTSUP;
> +                }
>                  /* update L2 tables */
>                  if (vmdk_L2update(extent, &m_data,
>                                    cluster_offset >> BDRV_SECTOR_BITS)
> -- 
> 2.16.2
> 
