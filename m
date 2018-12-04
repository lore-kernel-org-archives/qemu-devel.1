Received: from eggs.gnu.org ([2001:4830:134:3::10]:37989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=869086d29=anthony.perard@citrix.com>)
	id 1gUDkx-00076L-Oe
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 11:41:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=869086d29=anthony.perard@citrix.com>)
	id 1gUDkw-0005xo-MA
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 11:41:07 -0500
Date: Tue, 4 Dec 2018 16:40:52 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181204164052.GY14786@perard.uk.xensource.com>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-17-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181121151211.15997-17-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH 16/18] xen: automatically create
 XenQdiskDevice-s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>

On Wed, Nov 21, 2018 at 03:12:09PM +0000, Paul Durrant wrote:
> This patch adds a creator function for XenQdiskDevice-s so that they can
> be created automatically when the Xen toolstack instantiates a new
> PV backend. When the XenQdiskDevice is created this way it is also
> necessary to create a drive which matches the configuration that the Xen
> toolstack has written into xenstore. This drive is marked 'auto_del' so
> that it will be removed when the XenQdiskDevice is destroyed. Also, for
> compatibilitye with the legacy 'xen_disk' implementation, an iothread
> is automatically created for the new XenQdiskDevice. This will also be
> removed when he XenQdiskDevice is destroyed.

"the XenQdiskDevice"

[...]
> +    qemu_opt_set(drive_opts, "file.locking", "off", &local_err);

That looks new, compared to the xen_disk.c implementation. Maybe that
should be mention in the commit message.


[..]

> +static void xen_qdisk_device_create(BusState *bus, const char *name,
> +                                    QDict *opts, Error **errp)
> +{
[...]
> +    iothread = iothread_create(vdev, &error_abort);

I would just propagate the error, since iothread could fail for external
reason. No need to crash qemu while a VM is running.

> +
> +    dev = qdev_create(bus, TYPE_XEN_QDISK_DEVICE);
> +
> +    qdev_prop_set_string(dev, "vdev", vdev);
> +
> +    if (XEN_QDISK_DEVICE(dev)->vdev.number != number) {
> +        error_setg(errp, "invalid dev parameter '%s'", vdev);
> +        goto unref;
> +    }
> +
> +    qdev_prop_set_drive(dev, "drive", blk, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        error_prepend(errp, "failed to set 'drive': ");
> +        goto unref;
> +    }
> +
> +    XEN_QDISK_DEVICE(dev)->auto_iothread = iothread;
> +
> +    qdev_init_nofail(dev);

That function shouldn't be use during hotplug. But I'm not sure what
should be done instead, probably object_property_set_bool(..., true
"realized") and check for error.


Thanks,

-- 
Anthony PERARD
