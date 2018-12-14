Received: from eggs.gnu.org ([2001:4830:134:3::10]:41455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8792ba347=Paul.Durrant@citrix.com>)
	id 1gXonT-0008DI-Nx
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:50:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8792ba347=Paul.Durrant@citrix.com>)
	id 1gXonP-0002pX-0d
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:50:35 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Fri, 14 Dec 2018 14:50:24 +0000
Message-ID: <6291f3bff540494a9f1b2e7ce72570ac@AMSPEX02CL02.citrite.net>
References: <1544543862-9997-1-git-send-email-paul.durrant@citrix.com>
	<1544543862-9997-17-git-send-email-paul.durrant@citrix.com>
	<20181213115152.GA5427@linux.fritz.box>
In-Reply-To: <20181213115152.GA5427@linux.fritz.box>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 16/18] xen: automatically create
 XenBlockDevice-s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Kevin Wolf' <kwolf@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Max Reitz <mreitz@redhat.com>, Stefano
	Stabellini <sstabellini@kernel.org>

> -----Original Message-----
[snip]
> > +
> > +    blockdev->auto_iothread =3D iothread;
> > +
> > +    object_property_set_bool(OBJECT(dev), true, "realized",
> &local_err);
> > +    if (local_err) {
> > +        error_propagate_prepend(errp, local_err,
> > +                                "initialization of device %s failed: "=
,
> > +                                type);
> > +        goto unref;
> > +    }
> > +
> > +    blockdev_mark_auto_del(blk);
>=20
> You don't need this one any more then (if you look into the details,
> it's one of the more confusing parts of the drive_*() magic, so it's
> good to get rid of it). When you use the anonymous BlockBackend created
> by the qdev drive property (because you passed it a node-name rather
> than a BlockBackend name) means that the BlockBackend disappears
> together with the drive.
>=20
> Note that explicitly created block nodes must also be unreferenced
> explicitly (bdrv_open() should be paired with bdrv_unref() and
> qmp_blockdev_add() with qmp_blockdev_del()). Maybe XenBackendInfo needs
> a .destroy callback so we can do destruction symmetrically to device
> creation?
>=20

I have something implemented using qmp_blockdev_add() now and it seems to w=
ork, but when I call into qmp_blockdev_del() (passing in the node-name I us=
ed to the set the "drive" parameter) during unrealize then it tells me that=
 the device is in use. Do I need a callback that runs after unrealize of th=
e device?

  Paul=20

> > +    return;
> > +
> > +unref:
> > +    if (dev) {
> > +        object_unparent(OBJECT(dev));
> > +    }
> > +
> > +    if (iothread) {
> > +        iothread_destroy(iothread);
> > +    }
> > +
> > +    if (blk) {
> > +        monitor_remove_blk(blk);
> > +        blk_unref(blk);
> > +    }
> > +}
>=20
> Kevin
