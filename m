Received: from eggs.gnu.org ([209.51.188.92]:37326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9966e4c82=anthony.perard@citrix.com>)
	id 1hEFWW-0005ee-L8
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:52:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9966e4c82=anthony.perard@citrix.com>)
	id 1hEFWV-0002mI-Hw
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:52:28 -0400
Date: Wed, 10 Apr 2019 16:52:17 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20190410155217.GH1435@perard.uk.xensource.com>
References: <20190409164038.25484-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190409164038.25484-1-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH] xen-block: support
 feature-large-sector-size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, qemu-block@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Tue, Apr 09, 2019 at 05:40:38PM +0100, Paul Durrant wrote:
> A recent Xen commit [1] clarified the semantics of sector based quantities
> used in the blkif protocol such that it is now safe to create a xen-block
> device with a logical_block_size != 512, as long as the device only
> connects to a frontend advertizing 'feature-large-block-size'.
> 
> This patch modifies xen-block accordingly. It also uses a stack variable
> for the BlockBackend in xen_block_realize() to avoid repeated dereferencing
> of the BlockConf pointer, and changes the parameters of
> xen_block_dataplane_create() so that the BlockBackend pointer and sector
> size are passed expicitly rather than implicitly via the BlockConf.
> 
> These modifications have been tested against a recent Windows PV XENVBD
> driver [2] using a xen-disk device with a 4kB logical block size.
> 
> [1] http://xenbits.xen.org/gitweb/?p=xen.git;a=commit;h=67e1c050e36b2c9900cca83618e56189effbad98
> [2] https://winpvdrvbuild.xenproject.org:8080/job/XENVBD-master/126
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> ---
> diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
> index ef635be4c2..05e890ad78 100644
> --- a/hw/block/xen-block.c
> +++ b/hw/block/xen-block.c
> @@ -51,11 +51,25 @@ static void xen_block_connect(XenDevice *xendev, Error **errp)
[...]
> +    if (xen_device_frontend_scanf(xendev, "feature-large-sector-size", "%u",
> +                                  &feature_large_sector_size) != 1) {
> +        feature_large_sector_size = 0;
> +    }
> +
> +    if (feature_large_sector_size != 1 &&
> +        conf->logical_block_size != XEN_BLKIF_SECTOR_SIZE) {
> +        error_setg(errp, "logical_block_size != %u not supported",

Maybe add "by frontend" to the error message?

> +                   XEN_BLKIF_SECTOR_SIZE);
> +        return;
> +    }
> +

With the question answered:
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD
