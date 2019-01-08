Received: from eggs.gnu.org ([209.51.188.92]:39449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=904727a53=Paul.Durrant@citrix.com>)
	id 1ggsWU-00080g-Hl
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 09:38:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=904727a53=Paul.Durrant@citrix.com>)
	id 1ggsWP-0002t4-Nz
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 09:38:28 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Tue, 8 Jan 2019 14:38:11 +0000
Message-ID: <4198c56b893a4539a4d27eea5dad71ec@AMSPEX02CL03.citrite.net>
References: <20181220171439.11159-1-paul.durrant@citrix.com>
	<20181220171439.11159-17-paul.durrant@citrix.com>
	<20190104163124.GE1508@perard.uk.xensource.com>
	<da727b0b8a9a4f9baa47a660298a9cba@AMSPEX02CL03.citrite.net>
	<20190108125321.GD11492@linux.fritz.box>
	<904d305f8c0f4aac8e60fb7ea14ebd41@AMSPEX02CL03.citrite.net>
	<20190108132823.GF1508@perard.uk.xensource.com>
In-Reply-To: <20190108132823.GF1508@perard.uk.xensource.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v7 16/18] xen: automatically create
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
Cc: 'Kevin Wolf' <kwolf@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>

> -----Original Message-----
> From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> Sent: 08 January 2019 13:28
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: 'Kevin Wolf' <kwolf@redhat.com>; qemu-devel@nongnu.org; qemu-
> block@nongnu.org; xen-devel@lists.xenproject.org; Max Reitz
> <mreitz@redhat.com>; Stefano Stabellini <sstabellini@kernel.org>
> Subject: Re: [PATCH v7 16/18] xen: automatically create XenBlockDevice-s
>=20
> On Tue, Jan 08, 2019 at 01:07:49PM +0000, Paul Durrant wrote:
> > > -----Original Message-----
> > > From: Kevin Wolf [mailto:kwolf@redhat.com]
> > > Sent: 08 January 2019 12:53
> > > To: Paul Durrant <Paul.Durrant@citrix.com>
> > > Cc: Anthony Perard <anthony.perard@citrix.com>; qemu-devel@nongnu.org=
;
> > > qemu-block@nongnu.org; xen-devel@lists.xenproject.org; Max Reitz
> > > <mreitz@redhat.com>; Stefano Stabellini <sstabellini@kernel.org>
> > > Subject: Re: [PATCH v7 16/18] xen: automatically create
> XenBlockDevice-s
> > >
> > > Am 04.01.2019 um 17:40 hat Paul Durrant geschrieben:
> > > > > -----Original Message-----
> > > > > From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> > > > > Sent: 04 January 2019 16:31
> > > > > To: Paul Durrant <Paul.Durrant@citrix.com>
> > > > > Cc: qemu-devel@nongnu.org; qemu-block@nongnu.org; xen-
> > > > > devel@lists.xenproject.org; Kevin Wolf <kwolf@redhat.com>; Max
> Reitz
> > > > > <mreitz@redhat.com>; Stefano Stabellini <sstabellini@kernel.org>
> > > > > Subject: Re: [PATCH v7 16/18] xen: automatically create
> > > XenBlockDevice-s
> > > > >
> > > > > Almost done, there is one thing left which I believe is an issue.
> > > > > Whenever I attach a raw file to QEMU, it print:
> > > > >     qemu-system-i386: warning: Opening a block device as a file
> using
> > > the
> > > > > 'file' driver is deprecated
> > > >
> > > > Oh, I'd not noticed that... but then I only use raw files
> occasionally.
> > >
> > > Strictly speaking, this is not about raw (regular) files, but raw
> block
> > > devices. 'file' is fine for actual regular files, but the protocol
> > > driver for block devices is 'host_device'.
> > >
> > > > > raw files should use the "raw" driver, so we aren't done yet.
> > > >
> > > > Ok. Having a strictly 2-layer stack actually makes things simpler
> anyway
> > > :-)
> > >
> > > Using 'raw' there will make the block layer auto-detect the right
> > > protocol layer, so this works. If you want to avoid the second layer,
> > > you'd have to figure out manually whether to use 'file' or
> > > 'host_device'.
> >
> > Thanks for the explanation. I'll give it a spin using a device... I've
> posted v8 but, given what you say, I'm still not sure I have it right.
>=20
> Indeed, in v8, even with the extra 'raw' layer, the warning is still
> there. I was trying to understand why, and I only found out today that
> we would need to use the 'host_device' driver as explain by Kevin.
>=20
>=20
> BTW Paul, we can simplify the code that manage layers, by not managing
> them.
> Instead of (in JSON / QMP term):
>     { 'driver': 'file', 'filename': '/file', 'node-name': 'node-file' }
>     { 'driver': 'qcow2', 'file': 'node-file', 'node-name': 'node-qcow2' }
> we can have:
>     { 'driver': 'qcow2', 'node-name': 'node-qcow2',
>       'file': { 'driver': 'file', 'filename': '/file' } }
>=20
>=20
> Here is the patch I have, fill free to review and squash it, or not:

I've tested your patch and it does seem like the best way forward. I'll squ=
ash it in. Do you want me to put your S-o-b on the combined patch?

  Paul

>=20
> diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
> index 91f5b58993..c6ec1d9543 100644
> --- a/hw/block/xen-block.c
> +++ b/hw/block/xen-block.c
> @@ -653,43 +653,23 @@ static char *xen_block_blockdev_add(const char *id,
> QDict *qdict,
>=20
>  static void xen_block_drive_destroy(XenBlockDrive *drive, Error **errp)
>  {
> -    while (drive->layers-- !=3D 0) {
> -        char *node_name =3D drive->node_name[drive->layers];
> +    char *node_name =3D drive->node_name;
> +
> +    if (node_name) {
>          Error *local_err =3D NULL;
>=20
>          xen_block_blockdev_del(node_name, &local_err);
>          if (local_err) {
>              error_propagate(errp, local_err);
> -            drive->layers++;
>              return;
>          }
> +        g_free(node_name);
> +        drive->node_name =3D NULL;
>      }
>      g_free(drive->id);
>      g_free(drive);
>  }
>=20
> -static void xen_block_drive_layer_add(XenBlockDrive *drive, QDict *qdict=
,
> -                                      Error **errp)
> -{
> -    unsigned int i =3D drive->layers;
> -    char *node_name;
> -
> -    g_assert(drive->layers < ARRAY_SIZE(drive->node_name));
> -
> -    if (i !=3D 0) {
> -        /* Link to the lower layer */
> -        qdict_put_str(qdict, "file", drive->node_name[i - 1]);
> -    }
> -
> -    node_name =3D xen_block_blockdev_add(drive->id, qdict, errp);
> -    if (!node_name) {
> -        return;
> -    }
> -
> -    drive->node_name[i] =3D node_name;
> -    drive->layers++;
> -}
> -
>  static XenBlockDrive *xen_block_drive_create(const char *id,
>                                               const char *device_type,
>                                               QDict *opts, Error **errp)
> @@ -702,7 +682,8 @@ static XenBlockDrive *xen_block_drive_create(const
> char *id,
>      char *filename =3D NULL;
>      XenBlockDrive *drive =3D NULL;
>      Error *local_err =3D NULL;
> -    QDict *qdict;
> +    QDict *file_layer;
> +    QDict *driver_layer;
>=20
>      if (params) {
>          char **v =3D g_strsplit(params, ":", 2);
> @@ -733,13 +714,13 @@ static XenBlockDrive *xen_block_drive_create(const
> char *id,
>      drive =3D g_new0(XenBlockDrive, 1);
>      drive->id =3D g_strdup(id);
>=20
> -    qdict =3D qdict_new();
> +    file_layer =3D qdict_new();
>=20
> -    qdict_put_str(qdict, "driver", "file");
> -    qdict_put_str(qdict, "filename", filename);
> +    qdict_put_str(file_layer, "driver", "file");
> +    qdict_put_str(file_layer, "filename", filename);
>=20
>      if (mode && *mode !=3D 'w') {
> -        qdict_put_bool(qdict, "read-only", true);
> +        qdict_put_bool(file_layer, "read-only", true);
>      }
>=20
>      if (direct_io_safe) {
> @@ -749,9 +730,9 @@ static XenBlockDrive *xen_block_drive_create(const
> char *id,
>              QDict *cache_qdict =3D qdict_new();
>=20
>              qdict_put_bool(cache_qdict, "direct", true);
> -            qdict_put_obj(qdict, "cache", QOBJECT(cache_qdict));
> +            qdict_put_obj(file_layer, "cache", QOBJECT(cache_qdict));
>=20
> -            qdict_put_str(qdict, "aio", "native");
> +            qdict_put_str(file_layer, "aio", "native");
>          }
>      }
>=20
> @@ -759,7 +740,7 @@ static XenBlockDrive *xen_block_drive_create(const
> char *id,
>          unsigned long value;
>=20
>          if (!qemu_strtoul(discard_enable, NULL, 2, &value) && !!value) {
> -            qdict_put_str(qdict, "discard", "unmap");
> +            qdict_put_str(file_layer, "discard", "unmap");
>          }
>      }
>=20
> @@ -767,22 +748,16 @@ static XenBlockDrive *xen_block_drive_create(const
> char *id,
>       * It is necessary to turn file locking off as an emulated device
>       * may have already opened the same image file.
>       */
> -    qdict_put_str(qdict, "locking", "off");
> -
> -    xen_block_drive_layer_add(drive, qdict, &local_err);
> -    qobject_unref(qdict);
> -
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        goto done;
> -    }
> +    qdict_put_str(file_layer, "locking", "off");
>=20
> -    qdict =3D qdict_new();
> +    driver_layer =3D qdict_new();
>=20
> -    qdict_put_str(qdict, "driver", driver);
> +    qdict_put_str(driver_layer, "driver", driver);
> +    qdict_put_obj(driver_layer, "file", QOBJECT(file_layer));
>=20
> -    xen_block_drive_layer_add(drive, qdict, &local_err);
> -    qobject_unref(qdict);
> +    g_assert(!drive->node_name);
> +    drive->node_name =3D xen_block_blockdev_add(drive->id, driver_layer,
> +                                              &local_err);
>=20
>  done:
>      g_free(driver);
> @@ -798,7 +773,7 @@ static XenBlockDrive *xen_block_drive_create(const
> char *id,
>=20
>  static const char *xen_block_drive_get_node_name(XenBlockDrive *drive)
>  {
> -    return drive->layers ? drive->node_name[drive->layers - 1] : "";
> +    return drive->node_name ? drive->node_name : "";
>  }
>=20
>  static void xen_block_iothread_destroy(XenBlockIOThread *iothread,
> diff --git a/include/hw/xen/xen-block.h b/include/hw/xen/xen-block.h
> index 6f5d675edb..11d351b4b3 100644
> --- a/include/hw/xen/xen-block.h
> +++ b/include/hw/xen/xen-block.h
> @@ -39,8 +39,7 @@ typedef struct XenBlockProperties {
>=20
>  typedef struct XenBlockDrive {
>      char *id;
> -    char *node_name[2];
> -    unsigned int layers;
> +    char *node_name;
>  } XenBlockDrive;
>=20
>  typedef struct XenBlockIOThread {
> --
> Anthony PERARD
>=20
> --
> Anthony PERARD
