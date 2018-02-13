Received: from eggs.gnu.org ([2001:4830:134:3::10]:37293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elg6d-0000kA-Ll
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 14:19:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elg6c-0001Ej-Q8
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 14:19:07 -0500
References: <20180116060901.17413-1-famz@redhat.com>
	<20180116060901.17413-4-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <897efee5-9ec5-5f99-ce56-3f7bf54f4d5d@redhat.com>
Date: Tue, 13 Feb 2018 13:18:48 -0600
MIME-Version: 1.0
In-Reply-To: <20180116060901.17413-4-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 3/9] block: Add VFIO based NVMe driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, alex.williamson@redhat.com, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Karl Rister <krister@redhat.com>

On 01/16/2018 12:08 AM, Fam Zheng wrote:
> This is a new protocol driver that exclusively opens a host NVMe
> controller through VFIO. It achieves better latency than linux-aio by
> completely bypassing host kernel vfs/block layer.
> 
>      $rw-$bs-$iodepth  linux-aio     nvme://
>      ----------------------------------------
>      randread-4k-1     10.5k         21.6k
>      randread-512k-1   745           1591
>      randwrite-4k-1    30.7k         37.0k
>      randwrite-512k-1  1945          1980
> 
>      (unit: IOPS)
> 
> The driver also integrates with the polling mechanism of iothread.
> 
> This patch is co-authored by Paolo and me.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> Message-Id: <20180110091846.10699-4-famz@redhat.com>
> ---

Sorry for not noticing sooner, but

> +static int64_t coroutine_fn nvme_co_get_block_status(BlockDriverState *bs,
> +                                                     int64_t sector_num,
> +                                                     int nb_sectors, int *pnum,
> +                                                     BlockDriverState **file)
> +{
> +    *pnum = nb_sectors;
> +    *file = bs;
> +
> +    return BDRV_BLOCK_ALLOCATED | BDRV_BLOCK_OFFSET_VALID |
> +           (sector_num << BDRV_SECTOR_BITS);

This is wrong.  Drivers should only ever return BDRV_BLOCK_DATA (which 
io.c then _adds_ BDRV_BLOCK_ALLOCATED to, as needed).  I'll fix it up as 
part of my byte-based block status series (v8 coming up soon).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
