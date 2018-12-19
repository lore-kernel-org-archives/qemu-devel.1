Received: from eggs.gnu.org ([2001:4830:134:3::10]:58951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=88499b8e4=Paul.Durrant@citrix.com>)
	id 1gZbCX-0001VD-50
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:43:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=88499b8e4=Paul.Durrant@citrix.com>)
	id 1gZbCU-0007md-EZ
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:43:49 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Wed, 19 Dec 2018 12:43:24 +0000
Message-ID: <40bdef2962864ca8bc364249196bf9b3@AMSPEX02CL03.citrite.net>
References: <20181217133011.31433-1-paul.durrant@citrix.com>
	<20181217133011.31433-17-paul.durrant@citrix.com>
	<20181219123926.GA1288@perard.uk.xensource.com>
In-Reply-To: <20181219123926.GA1288@perard.uk.xensource.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v6 16/18] xen: automatically create
 XenBlockDevice-s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony Perard <anthony.perard@citrix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>

> -----Original Message-----
> From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> Sent: 19 December 2018 12:39
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: qemu-devel@nongnu.org; qemu-block@nongnu.org; xen-
> devel@lists.xenproject.org; Kevin Wolf <kwolf@redhat.com>; Max Reitz
> <mreitz@redhat.com>; Stefano Stabellini <sstabellini@kernel.org>
> Subject: Re: [PATCH v6 16/18] xen: automatically create XenBlockDevice-s
>=20
> On Mon, Dec 17, 2018 at 01:30:09PM +0000, Paul Durrant wrote:
> > +static char *xen_block_blockdev_add(const char *id, QDict *qdict,
> > +                                    Error **errp)
> > +{
> > +    const char *driver =3D qdict_get_try_str(qdict, "driver");
> > +    BlockdevOptions *options =3D NULL;
> > +    Error *local_err =3D NULL;
> > +    char *str =3D NULL;
> > +    char *node_name;
> > +    Visitor *v;
> > +
> > +    if (!driver) {
> > +        error_setg(errp, "no 'driver' parameter");
> > +        return NULL;
> > +    }
> > +
> > +    node_name =3D g_strdup_printf("%s-%s", id, driver);
> > +    qdict_put_str(qdict, "node-name", node_name);
> > +
> > +    qdict_iter(qdict, add_item, &str);
> > +
> > +    trace_xen_block_blockdev_add(str);
> > +    g_free(str);
> > +
> > +    v =3D qobject_input_visitor_new_flat_confused(qdict, errp);
>=20
> Kevin seems to say that this could be done without the _flat_confused
> version. The flat_confused version seems to be useful just because
> the key "cache.direct" is used earlier, and because everything in qdict
> is a string.

It could be, but there's a good reason for wanting everything as a string, =
and that is so that I can do a qdict_iter to generate my trace message. Als=
o I really don't want to get too elaborate here... this is supposed to be m=
imicking what would normally come via a json blob, and that would start out=
 as strings.

  Paul

>=20
> I think instead, qobject_input_visitor_new could be used. You would just
> need to replace
>     qdict_put_str(qdict, "cache.direct", "on");
> by
>     QDict *cache =3D qdict_new();
>     qdict_put_str(cache, "direct", "on");
>     qdict_put_obj(qdict, "cache", QOBJECT(cache));
>=20
> And also the property "read-only" which seems to be a bool as well. I've
> check all property in the qdict, and I think that the only two that
> needs to be changes. And then, we can use:
>     v =3D qobject_input_visitor_new(qdict); which never fails.
>=20
> You'll just need "qapi/qobject-input-visitor.h" instead of "block/qdict.h=
"
>=20
> > +    if (!v) {
> > +        goto fail;
> > +    }
> > +
> > +    visit_type_BlockdevOptions(v, NULL, &options, &local_err);
> > +    visit_free(v);
> > +
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        goto fail;
> > +    }
> > +
> > +    qmp_blockdev_add(options, &local_err);
> > +
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        goto fail;
> > +    }
> > +
> > +    qapi_free_BlockdevOptions(options);
> > +
> > +    return node_name;
> > +
> > +fail:
> > +    if (options) {
> > +        qapi_free_BlockdevOptions(options);
> > +    }
> > +    g_free(node_name);
> > +
> > +    return NULL;
> > +}
> [...]
> > +static XenBlockDrive *xen_block_drive_create(const char *id,
> > +                                             const char *device_type,
> > +                                             QDict *opts, Error **errp=
)
> > +{
> > +    const char *params =3D qdict_get_try_str(opts, "params");
> > +    const char *mode =3D qdict_get_try_str(opts, "mode");
> > +    const char *direct_io_safe =3D qdict_get_try_str(opts, "direct-io-
> safe");
> > +    const char *discard_enable =3D qdict_get_try_str(opts, "discard-
> enable");
> > +    char *driver =3D NULL;
> > +    char *filename =3D NULL;
> > +    XenBlockDrive *drive =3D NULL;
> > +    Error *local_err =3D NULL;
> > +    QDict *qdict;
> > +
> > +    if (params) {
> > +        char **v =3D g_strsplit(params, ":", 2);
> > +
> > +        if (v[1] =3D=3D NULL) {
> > +            filename =3D g_strdup(v[0]);
> > +            driver =3D g_strdup("file");
> > +        } else {
> > +            if (strcmp(v[0], "aio") =3D=3D 0) {
> > +                driver =3D g_strdup("file");
> > +            } else if (strcmp(v[0], "vhd") =3D=3D 0) {
> > +                driver =3D g_strdup("vpc");
> > +            } else {
> > +                driver =3D g_strdup(v[0]);
> > +            }
> > +            filename =3D g_strdup(v[1]);
> > +        }
> > +
> > +        g_strfreev(v);
> > +    }
> > +
> > +    if (!filename) {
> > +        error_setg(errp, "no filename");
> > +        goto done;
> > +    }
> > +    assert(driver);
> > +
> > +    drive =3D g_new0(XenBlockDrive, 1);
> > +    drive->id =3D g_strdup(id);
> > +
> > +    qdict =3D qdict_new();
> > +
> > +    qdict_put_str(qdict, "driver", "file");
> > +    qdict_put_str(qdict, "filename", filename);
> > +
> > +    if (mode && *mode !=3D 'w') {
> > +        qdict_put_str(qdict, "read-only", "on");
> > +    }
> > +
> > +    if (direct_io_safe) {
> > +        unsigned long value;
> > +
> > +        if (!qemu_strtoul(direct_io_safe, NULL, 2, &value) && !!value)
> {
> > +            qdict_put_str(qdict, "cache.direct", "on");
> > +            qdict_put_str(qdict, "aio", "native");
> > +        }
> > +    }
> > +
> > +    if (discard_enable) {
> > +        unsigned long value;
> > +
> > +        if (!qemu_strtoul(discard_enable, NULL, 2, &value) && !!value)
> {
> > +            qdict_put_str(qdict, "discard", "unmap");
> > +        }
> > +    }
> > +
> > +    /*
> > +     * It is necessary to turn file locking off as an emulated device
> > +     * may have already opened the same image file.
> > +     */
> > +    qdict_put_str(qdict, "locking", "off");
> > +
> > +    xen_block_drive_layer_add(drive, qdict, &local_err);
> > +    qobject_unref(qdict);
> > +
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        goto done;
> > +    }
> > +
> > +    /* If the image is a raw file then we are done */
>=20
> I don't think that is true, as I have this warning in QEMU:
> qemu-system-i386: warning: Opening a block device as a file using the
> 'file' driver is deprecated
>=20
> We would need a "raw" driver.
>=20
> > +    if (!strcmp(driver, "file")) {
> > +        goto done;
> > +    }
> > +
> > +    qdict =3D qdict_new();
> > +
> > +    qdict_put_str(qdict, "driver", driver);
> > +
> > +    xen_block_drive_layer_add(drive, qdict, &local_err);
> > +    qobject_unref(qdict);
> > +
> > +done:
> > +    g_free(driver);
> > +    g_free(filename);
> > +
> > +    if (local_err) {
> > +        xen_block_drive_destroy(drive, NULL);
> > +        return NULL;
> > +    }
> > +
> > +    return drive;
> > +}
>=20
> --
> Anthony PERARD
