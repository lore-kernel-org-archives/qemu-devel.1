Received: from eggs.gnu.org ([2001:4830:134:3::10]:49795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=878dab2db=Paul.Durrant@citrix.com>)
	id 1gXQMN-0007GF-Uf
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:45:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=878dab2db=Paul.Durrant@citrix.com>)
	id 1gXQMJ-0004cd-Hf
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:44:59 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Thu, 13 Dec 2018 12:44:53 +0000
Message-ID: <b323cd922b6d4a5798a2f3cfae2bd573@AMSPEX02CL03.citrite.net>
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
> From: Kevin Wolf [mailto:kwolf@redhat.com]
> Sent: 13 December 2018 11:52
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: qemu-devel@nongnu.org; qemu-block@nongnu.org; xen-
> devel@lists.xenproject.org; Max Reitz <mreitz@redhat.com>; Stefano
> Stabellini <sstabellini@kernel.org>
> Subject: Re: [PATCH v4 16/18] xen: automatically create XenBlockDevice-s
>=20
> Am 11.12.2018 um 16:57 hat Paul Durrant geschrieben:
> > This patch adds a creator function for XenBlockDevice-s so that they ca=
n
> > be created automatically when the Xen toolstack instantiates a new
> > PV backend. When the XenBlockDevice is created this way it is also
> > necessary to create a drive which matches the configuration that the Xe=
n
> > toolstack has written into xenstore. This drive is marked 'auto_del' so
> > that it will be removed when the XenBlockDevice is destroyed. Also, for
> > compatibility with the legacy 'xen_disk' implementation, an iothread
> > is automatically created for the new XenBlockDevice. This will also be
> > removed when the XenBlockDevice is destroyed.
> >
> > Correspondingly the legacy backend scan for 'qdisk' is removed.
> >
> > After this patch is applied the legacy 'xen_disk' code is redundant. It
> > will be removed by a subsequent patch.
> >
> > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> > Reviewed-by: Anthony Perard <anthony.perard@citrix.com>
>=20
> So I have two points for this patch.
>=20
> The first is that devices creating their own backends feels so wrong.

Indeed it does feel wrong, but this is the only way to deal with existing X=
en toolstacks. Once toolstacks have been ported to using QMP to instantiate=
 backends then this code can go away.

> I
> know that the old xen_disk did the same, and fixing it might neither be
> easy nor directly related to the qdevification, so requiring that from
> you would probably be unfair. But I still have to make the note, and
> hopefully we can get to it eventually (or maybe it is even easy enough
> that we can indeed address it in this series).
>=20

No, it's not easy but once this series is committed the work can be started=
.

> My problem here is that I don't really understand the Xen mechanisms.
> Could you give me a very high-level overview of how adding a disk works
> and which component communicates with which other component to get the
> information down to QEMU and eventually the newly added
> xen_block_device_create()?

Xen toolstacks instantiate PV backends by just writing values into xenstore=
. It is up to the entity implementing the backend to set 'watches' so that =
it gets notified when these values appear. Currently that entity may be QEM=
U, or it may be a kernel driver such as Linux xen-blkback.ko.

>=20
> Essentially, what I'm wondering is whether we have anything that could
> be treated more or less like another monitor besides QMP and HMP, which
> would internally work similar to HMP, i.e. map (almost) everything to
> QMP commands.

Yes, it would be possible to have a separate 'compatibility' daemon to watc=
h xenstore and then formulate the correct sequence of QMP commands to insta=
ntiate the backend, but that is more complicated and the right answer of co=
urse is to have the toolstack send the QMP commands in the first place.

> I see that there is this XenWatch infrastructure to get
> notified about changes (which would be treated like monitor commands),
> but I'm not sure if everything would be covered by this mechanism or
> whether some things must be fetched explicitly.
>=20
> Anyway, this is probably for later.
>=20
> > +static void xen_block_drive_create(const char *id, const char
> *device_type,
> > +                                   QDict *opts, Error **errp)
> > +{
> > +    const char *params =3D qdict_get_try_str(opts, "params");
> > +    const char *mode =3D qdict_get_try_str(opts, "mode");
> > +    const char *direct_io_safe =3D qdict_get_try_str(opts, "direct-io-
> safe");
> > +    const char *discard_enable =3D qdict_get_try_str(opts, "discard-
> enable");
> > +    char *format =3D NULL;
> > +    char *file =3D NULL;
> > +    char *drive_optstr =3D NULL;
> > +    QemuOpts *drive_opts;
> > +    Error *local_err =3D NULL;
> > +
> > +    if (params) {
> > +        char **v =3D g_strsplit(params, ":", 2);
> > +
> > +        if (v[1] =3D=3D NULL) {
> > +            file =3D g_strdup(v[0]);
> > +        } else {
> > +            if (strcmp(v[0], "aio") =3D=3D 0) {
> > +                format =3D g_strdup("raw");
> > +            } else if (strcmp(v[0], "vhd") =3D=3D 0) {
> > +                format =3D g_strdup("vpc");
> > +            } else {
> > +                format =3D g_strdup(v[0]);
> > +            }
> > +            file =3D g_strdup(v[1]);
> > +        }
> > +
> > +        g_strfreev(v);
> > +    }
> > +
> > +    if (!file) {
> > +        error_setg(errp, "no file parameter");
> > +        return;
> > +    }
> > +
> > +    drive_optstr =3D g_strdup_printf("id=3D%s", id);
> > +    drive_opts =3D drive_def(drive_optstr);
> > +    if (!drive_opts) {
> > +        error_setg(errp, "failed to create drive options");
> > +        goto done;
> > +    }
> > +
> > +    qemu_opt_set(drive_opts, "file", file, &local_err);
> > +    if (local_err) {
> > +        error_propagate_prepend(errp, local_err, "failed to set 'file'=
:
> ");
> > +        goto done;
> > +    }
> > +
> > +    qemu_opt_set(drive_opts, "media", device_type, &local_err);
> > +    if (local_err) {
> > +        error_propagate_prepend(errp, local_err,
> > +                                "failed to set 'media': ");
> > +        goto done;
> > +    }
> > +
> > +    if (format) {
> > +        qemu_opt_set(drive_opts, "format", format, &local_err);
> > +        if (local_err) {
> > +            error_propagate_prepend(errp, local_err,
> > +                                    "failed to set 'format': ");
> > +            goto done;
> > +        }
> > +    }
> > +
> > +    if (mode && *mode !=3D 'w') {
> > +        qemu_opt_set_bool(drive_opts, BDRV_OPT_READ_ONLY, true,
> &local_err);
> > +        if (local_err) {
> > +            error_propagate_prepend(errp, local_err, "failed to set
> '%s': ",
> > +                                    BDRV_OPT_READ_ONLY);
> > +            goto done;
> > +        }
> > +    }
> > +
> > +    /*
> > +     * It is necessary to turn file locking off as an emulated device
> > +     * my have already opened the same image file.
> > +     */
> > +    qemu_opt_set(drive_opts, "file.locking", "off", &local_err);
> > +    if (local_err) {
> > +        error_propagate_prepend(errp, local_err,
> > +                                "failed to set 'file.locking': ");
> > +        goto done;
> > +    }
> > +
> > +    qemu_opt_set_bool(drive_opts, BDRV_OPT_CACHE_WB, true, &local_err)=
;
> > +    if (local_err) {
> > +        error_propagate_prepend(errp, local_err, "failed to set '%s':
> ",
> > +                                BDRV_OPT_CACHE_WB);
> > +        goto done;
> > +    }
> > +
> > +    if (direct_io_safe) {
> > +        qemu_opt_set_bool(drive_opts, BDRV_OPT_CACHE_DIRECT, true,
> > +                          &local_err);
> > +        if (local_err) {
> > +            error_propagate_prepend(errp, local_err, "failed to set
> '%s': ",
> > +                                    BDRV_OPT_CACHE_DIRECT);
> > +            goto done;
> > +        }
> > +
> > +        qemu_opt_set(drive_opts, "aio", "native", &local_err);
> > +        if (local_err) {
> > +            error_propagate_prepend(errp, local_err,
> > +                                    "failed to set 'aio': ");
> > +            goto done;
> > +        }
> > +    }
> > +
> > +    if (discard_enable) {
> > +        unsigned long value;
> > +
> > +        if (!qemu_strtoul(discard_enable, NULL, 2, &value)) {
> > +            qemu_opt_set_bool(drive_opts, BDRV_OPT_DISCARD, !!value,
> > +                              &local_err);
> > +            if (local_err) {
> > +                error_propagate_prepend(errp, local_err,
> > +                                        "failed to set '%s': ",
> > +                                        BDRV_OPT_DISCARD);
> > +                goto done;
> > +            }
> > +        }
> > +    }
> > +
> > +    drive_new(drive_opts, IF_NONE, &local_err);
> > +    if (local_err) {
> > +        error_propagate_prepend(errp, local_err,
> > +                                "failed to create drive: ");
> > +        goto done;
> > +    }
>=20
> The other major point is that you're using the legacy drive_*()
> infrastructure, which should not only go away as soon as we can, but
> which is also full of magic and nasty surprises.
>=20
> I think the best way would be to create only a block node
> (BlockDriverState) here, and get an automatically created anonymous
> BlockBackend from the qdev drive property.
>=20
> There are two ways to achieve this: qmp_blockdev_add() would be optimal
> because that's a stable external interface. It would require you to
> specify a node-name (you already have the id parameter), and you'd use
> this node-name for the qdev drive property.
>=20
> qmp_blockdev_add() requires a BlockdevOptions object, which you can
> either construct manually in C or use a visitor to convert from an
> options QDict. Maybe in this case, converting from a QDict is better
> because otherwise you need special code for each block driver.
>=20

I was using the legacy interfaces because this code is, as I said above, su=
pposed to be a mechanism only required for compatibility with the way tools=
tacks currently operate (and so is essentially 'legacy') but using the top-=
level QMP entry point to construct the does sound do-able as long as the un=
derlying file locking can still be avoided with that mechanism. Since Block=
devOptions seems to be an auto-generated structure, figuring out how to fil=
l it in manually is somewhat tricky so the QDict approach is preferable but=
 I'll have to figure out how to use a visitor to do the translation.


> The other way would be calling bdrv_open() directly, which gives you a
> BlockDriverState, but it risks using legacy functionality that will be
> deprecated soon. Again, you'd take the node-name and pass it to the qdev
> drive option below.

Yes, xen_disk does things this way but then we end up with legacy block dev=
ice and still fall foul of the assertions buried in the code.

>=20
> > +
> > +done:
> > +    g_free(drive_optstr);
> > +    g_free(format);
> > +    g_free(file);
> > +}
> > +
> > +static void xen_block_device_create(BusState *bus, const char *name,
> > +                                    QDict *opts, Error **errp)
> > +{
> > +    unsigned long number;
> > +    const char *vdev, *device_type;
> > +    BlockBackend *blk =3D NULL;
> > +    IOThread *iothread =3D NULL;
> > +    DeviceState *dev =3D NULL;
> > +    Error *local_err =3D NULL;
> > +    const char *type;
> > +    XenBlockDevice *blockdev;
> > +
> > +    trace_xen_block_device_create(name);
> > +
> > +    if (qemu_strtoul(name, NULL, 10, &number)) {
> > +        error_setg(errp, "failed to parse name '%s'", name);
> > +        return;
> > +    }
> > +
> > +    vdev =3D qdict_get_try_str(opts, "dev");
> > +    if (!vdev) {
> > +        error_setg(errp, "no dev parameter");
> > +        return;
> > +    }
> > +
> > +    device_type =3D qdict_get_try_str(opts, "device-type");
> > +    if (!device_type) {
> > +        error_setg(errp, "no device-type parameter");
> > +        return;
> > +    }
> > +
> > +    if (!strcmp(device_type, "disk")) {
> > +        type =3D TYPE_XEN_DISK_DEVICE;
> > +    } else if (!strcmp(device_type, "cdrom")) {
> > +        type =3D TYPE_XEN_CDROM_DEVICE;
> > +    } else {
> > +        error_setg(errp, "invalid device-type parameter '%s'",
> device_type);
> > +        return;
> > +    }
> > +
> > +    xen_block_drive_create(vdev, device_type, opts, &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return;
> > +    }
> > +
> > +    blk =3D blk_by_name(vdev);
> > +    g_assert(blk);
> > +
> > +    iothread =3D iothread_create(vdev, &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        goto unref;
> > +    }
> > +
> > +    dev =3D qdev_create(bus, type);
> > +    blockdev =3D XEN_BLOCK_DEVICE(dev);
> > +
> > +    qdev_prop_set_string(dev, "vdev", vdev);
> > +    if (blockdev->vdev.number !=3D number) {
> > +        error_setg(errp, "invalid dev parameter '%s'", vdev);
> > +        goto unref;
> > +    }
> > +
> > +    qdev_prop_set_drive(dev, "drive", blk, &local_err);
> > +    if (local_err) {
> > +        error_propagate_prepend(errp, local_err, "failed to set
> 'drive': ");
> > +        goto unref;
> > +    }
>=20
> So here you would need to use something like this:
>=20
> object_property_set_str(OBJECT(dev), vdev, "driver", &local_err);
>=20
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

Ok.

> Note that explicitly created block nodes must also be unreferenced
> explicitly (bdrv_open() should be paired with bdrv_unref() and
> qmp_blockdev_add() with qmp_blockdev_del()). Maybe XenBackendInfo needs
> a .destroy callback so we can do destruction symmetrically to device
> creation?
>=20

Yes, I'd probably just add a callback function pointer into XenDevice which=
 only gets set for devices instantiated via this mechanism.

  Paul

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
