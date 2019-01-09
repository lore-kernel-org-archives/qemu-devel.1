Received: from eggs.gnu.org ([209.51.188.92]:60753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=905b6060a=anthony.perard@citrix.com>)
	id 1ghCfv-0001az-87
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 07:09:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=905b6060a=anthony.perard@citrix.com>)
	id 1ghCfs-0000Hh-GZ
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 07:09:35 -0500
Date: Wed, 9 Jan 2019 12:09:16 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20190109120916.GI1508@perard.uk.xensource.com>
References: <20190108144903.8249-1-paul.durrant@citrix.com>
	<20190108144903.8249-17-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190108144903.8249-17-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v9 16/18] xen: automatically create
 XenBlockDevice-s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>

On Tue, Jan 08, 2019 at 02:49:01PM +0000, Paul Durrant wrote:
> This patch adds create and destroy function for XenBlockDevice-s so that
> they can be created automatically when the Xen toolstack instantiates a new
> PV backend via xenstore. When the XenBlockDevice is created this way it is
> also necessary to create a 'drive' which matches the configuration that the
> Xen toolstack has written into xenstore. This is done by formulating the
> parameters necessary for each 'blockdev' layer of the drive and then using
> qmp_blockdev_add() to create the layers. Also, for compatibility with the
> legacy 'xen_disk' implementation, an iothread is automatically created for
> the new XenBlockDevice. This, like the driver layers, will be destroyed
> after the XenBlockDevice is unrealized.
> 
> The legacy backend scan for 'qdisk' is removed by this patch, which makes
> the 'xen_disk' code is redundant. The code will be removed by a subsequent
> patch.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> Signed-off-by: Anthony Perard <anthony.perard@citrix.com>
> ---

> diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
> index a7c37c185a..c6ec1d9543 100644
> --- a/hw/block/xen-block.c
> +++ b/hw/block/xen-block.c
> @@ -7,12 +7,20 @@
...

> +static XenBlockDrive *xen_block_drive_create(const char *id,
> +                                             const char *device_type,
> +                                             QDict *opts, Error **errp)
> +{
...
> +    Error *local_err = NULL;
...
> +    if (!filename) {
> +        error_setg(errp, "no filename");
> +        goto done;
> +    }
...
> +    drive->node_name = xen_block_blockdev_add(drive->id, driver_layer,
> +                                              &local_err);
> +
> +done:
> +    g_free(driver);
> +    g_free(filename);
> +
> +    if (local_err) {

When xen_block_blockdev_add failed, it sets local_err, but nothing after
sets errp. I'm going to add this while preparing the pull request:

    error_propagate(errp, local_err);

Is this fine with you?

With that fix, I think the series is ready, so:
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

> +        xen_block_drive_destroy(drive, NULL);
> +        return NULL;
> +    }
> +
> +    return drive;
> +}

There is still the warning about using the 'file' driver when
'host_device' should be use, but I think we can try to fix that later.

Thanks,

-- 
Anthony PERARD
