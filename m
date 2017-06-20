Received: from eggs.gnu.org ([2001:4830:134:3::10]:46736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dNRUu-0006Vg-4v
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 18:19:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dNRUt-0003eW-4y
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 18:19:44 -0400
Date: Tue, 20 Jun 2017 15:19:33 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <20170620134756.9632-2-paul.durrant@citrix.com>
Message-ID: <alpine.DEB.2.10.1706201510490.12819@sstabellini-ThinkPad-X260>
References: <20170620134756.9632-1-paul.durrant@citrix.com>
	<20170620134756.9632-2-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 1/3] xen-disk: only advertize
 feature-persistent if grant copy is not available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, qemu-block@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, roger.pau@citrix.com

On Tue, 20 Jun 2017, Paul Durrant wrote:
> If grant copy is available then it will always be used in preference to
> persistent maps. In this case feature-persistent should not be advertized
> to the frontend, otherwise it may needlessly copy data into persistently
> granted buffers.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

CC'ing Roger.

It is true that using feature-persistent together with grant copies is a
a very bad idea.

But this change enstablishes an explicit preference of
feature_grant_copy over feature-persistent in the xen_disk backend. It
is not obvious to me that it should be the case.

Why is feature_grant_copy (without feature-persistent) better than
feature-persistent (without feature_grant_copy)? Shouldn't we simply
avoid grant copies to copy data to persistent grants?


> ---
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> ---
>  hw/block/xen_disk.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
> index 3a22805fbc..9b06e3aa81 100644
> --- a/hw/block/xen_disk.c
> +++ b/hw/block/xen_disk.c
> @@ -1023,11 +1023,18 @@ static int blk_init(struct XenDevice *xendev)
>  
>      blkdev->file_blk  = BLOCK_SIZE;
>  
> +    blkdev->feature_grant_copy =
> +                (xengnttab_grant_copy(blkdev->xendev.gnttabdev, 0, NULL) == 0);
> +
> +    xen_pv_printf(&blkdev->xendev, 3, "grant copy operation %s\n",
> +                  blkdev->feature_grant_copy ? "enabled" : "disabled");
> +
>      /* fill info
>       * blk_connect supplies sector-size and sectors
>       */
>      xenstore_write_be_int(&blkdev->xendev, "feature-flush-cache", 1);
> -    xenstore_write_be_int(&blkdev->xendev, "feature-persistent", 1);
> +    xenstore_write_be_int(&blkdev->xendev, "feature-persistent",
> +                          !blkdev->feature_grant_copy);
>      xenstore_write_be_int(&blkdev->xendev, "info", info);
>  
>      blk_parse_discard(blkdev);
> @@ -1202,12 +1209,6 @@ static int blk_connect(struct XenDevice *xendev)
>  
>      xen_be_bind_evtchn(&blkdev->xendev);
>  
> -    blkdev->feature_grant_copy =
> -                (xengnttab_grant_copy(blkdev->xendev.gnttabdev, 0, NULL) == 0);
> -
> -    xen_pv_printf(&blkdev->xendev, 3, "grant copy operation %s\n",
> -                  blkdev->feature_grant_copy ? "enabled" : "disabled");
> -
>      xen_pv_printf(&blkdev->xendev, 1, "ok: proto %s, ring-ref %d, "
>                    "remote port %d, local port %d\n",
>                    blkdev->xendev.protocol, blkdev->ring_ref,
> -- 
> 2.11.0
> 
