Received: from eggs.gnu.org ([2001:4830:134:3::10]:39360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=4297b1e9d=anthony.perard@citrix.com>)
	id 1dugUO-0006Jw-Fl
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:00:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=4297b1e9d=anthony.perard@citrix.com>)
	id 1dugUI-0006dr-Hw
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:00:36 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:36508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=4297b1e9d=anthony.perard@citrix.com>)
	id 1dugUI-0006cX-AX
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:00:30 -0400
Date: Wed, 20 Sep 2017 16:00:06 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170920150006.GB1859@perard.uk.xensource.com>
References: <20170919115055.19278-1-jgross@suse.com>
	<20170919115055.19278-3-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20170919115055.19278-3-jgross@suse.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] xen: dont try setting max grants
 multiple times
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juergen Gross <jgross@suse.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, kraxel@redhat.com, sstabellini@kernel.org

On Tue, Sep 19, 2017 at 01:50:55PM +0200, Juergen Gross wrote:
> Trying to call xengnttab_set_max_grants() with the same file handle
> might fail on some kernels, as this operation is allowed only once.
> 
> This is a problem for the qdisk backend as blk_connect() can be
> called multiple times for a domain, e.g. in case grub-xen is being
> used to boot it.
> 
> So instead of letting the generic backend code open the gnttab device
> do it in blk_connect() and close it again in blk_disconnect.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  hw/block/xen_disk.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
> index 6632746250..7cff8863cb 100644
> --- a/hw/block/xen_disk.c
> +++ b/hw/block/xen_disk.c
> @@ -1220,6 +1220,12 @@ static int blk_connect(struct XenDevice *xendev)
>      /* Add on the number needed for the ring pages */
>      max_grants += blkdev->nr_ring_ref;
>  
> +    blkdev->xendev.gnttabdev = xengnttab_open(NULL, 0);
> +    if (blkdev->xendev.gnttabdev == NULL) {
> +        xen_pv_printf(xendev, 0, "xengnttab_open failed: %s\n",
> +                      strerror(errno));
> +        return -1;
> +    }
>      if (xengnttab_set_max_grants(blkdev->xendev.gnttabdev, max_grants)) {
>          xen_pv_printf(xendev, 0, "xengnttab_set_max_grants failed: %s\n",
>                        strerror(errno));
> @@ -1327,6 +1333,11 @@ static void blk_disconnect(struct XenDevice *xendev)
>          }
>          blkdev->feature_persistent = false;
>      }
> +
> +    if (blkdev->xendev.gnttabdev) {
> +        xengnttab_close(blkdev->xendev.gnttabdev);
> +        blkdev->xendev.gnttabdev = NULL;
> +    }

I think blk_disconnect needs to be called from blk_free in case where
the gnttabdev is not closed (like it is done when blk or the sring are
not cleared, in blk_free).

>  }

>  static int blk_free(struct XenDevice *xendev)
> @@ -1363,7 +1374,6 @@ static void blk_event(struct XenDevice *xendev)
>  
>  struct XenDevOps xen_blkdev_ops = {
>      .size       = sizeof(struct XenBlkDev),
> -    .flags      = DEVOPS_FLAG_NEED_GNTDEV,
>      .alloc      = blk_alloc,
>      .init       = blk_init,
>      .initialise    = blk_connect,
> -- 
> 2.12.3
> 

-- 
Anthony PERARD
