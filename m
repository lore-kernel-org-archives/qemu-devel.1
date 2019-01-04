Received: from eggs.gnu.org ([208.118.235.92]:43025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=900e14805=Paul.Durrant@citrix.com>)
	id 1gfLas-0006qe-Bz
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 04:16:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=900e14805=Paul.Durrant@citrix.com>)
	id 1gfLao-0007nL-4c
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 04:16:42 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Fri, 4 Jan 2019 09:13:01 +0000
Message-ID: <91392585f2cb4a508d658c7f901ccef9@AMSPEX02CL03.citrite.net>
References: <20181220171439.11159-1-paul.durrant@citrix.com>
	<20181220171439.11159-17-paul.durrant@citrix.com>
In-Reply-To: <20181220171439.11159-17-paul.durrant@citrix.com>
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
To: Paul Durrant <Paul.Durrant@citrix.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Anthony
	Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>

Ping Anthony & Kevin?

I believe this version is purged of all legacy interface use.

> -----Original Message-----
> From: Paul Durrant [mailto:paul.durrant@citrix.com]
> Sent: 20 December 2018 17:15
> To: qemu-devel@nongnu.org; qemu-block@nongnu.org; xen-
> devel@lists.xenproject.org
> Cc: Paul Durrant <Paul.Durrant@citrix.com>; Anthony Perard
> <anthony.perard@citrix.com>; Kevin Wolf <kwolf@redhat.com>; Max Reitz
> <mreitz@redhat.com>; Stefano Stabellini <sstabellini@kernel.org>
> Subject: [PATCH v7 16/18] xen: automatically create XenBlockDevice-s
>=20
> This patch adds create and destroy function for XenBlockDevice-s so that
> they can be created automatically when the Xen toolstack instantiates a
> new
> PV backend via xenstore. When the XenBlockDevice is created this way it i=
s
> also necessary to create a 'drive' which matches the configuration that
> the
> Xen toolstack has written into xenstore. This is done by formulating the
> parameters necessary for each 'blockdev' layer of the drive and then usin=
g
> qmp_blockdev_add() to create the layers. Also, for compatibility with the
> legacy 'xen_disk' implementation, an iothread is automatically created fo=
r
> the new XenBlockDevice. This, like the driver layers, will be destroyed
> after the XenBlockDevice is unrealized.
>=20
> The legacy backend scan for 'qdisk' is removed by this patch, which makes
> the 'xen_disk' code is redundant. The code will be removed by a subsequen=
t
> patch.
>=20
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> ---
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
>=20
> v7:
>  - Don't use qobject_input_visitor_new_flat_confused()
>=20
> v5:
>  - Extensively re-worked to avoid using drive_new() and use
>    qmp_blockdev_add() instead
>  - Also use qmp_object_add() for IOThread
>  - Dropped Anthony's R-b because of the code changes
>=20
> v2:
>  - Get rid of error_abort
>  - Don't use qdev_init_nofail()
>  - Explain why file locking needs to be off
> ---
>  hw/block/trace-events       |   4 +
>  hw/block/xen-block.c        | 404 ++++++++++++++++++++++++++++++++++++
>  hw/xen/xen-legacy-backend.c |   1 -
>  include/hw/xen/xen-block.h  |  13 ++
>  4 files changed, 421 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index 89e258319c..55e5a5500c 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -137,3 +137,7 @@ xen_disk_realize(void) ""
>  xen_disk_unrealize(void) ""
>  xen_cdrom_realize(void) ""
>  xen_cdrom_unrealize(void) ""
> +xen_block_blockdev_add(char *str) "%s"
> +xen_block_blockdev_del(const char *node_name) "%s"
> +xen_block_device_create(unsigned int number) "%u"
> +xen_block_device_destroy(unsigned int number) "%u"
> diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
> index a7c37c185a..1e34fe1527 100644
> --- a/hw/block/xen-block.c
> +++ b/hw/block/xen-block.c
> @@ -7,12 +7,20 @@
>=20
>  #include "qemu/osdep.h"
>  #include "qemu/cutils.h"
> +#include "qemu/option.h"
>  #include "qapi/error.h"
> +#include "qapi/qapi-commands-block-core.h"
> +#include "qapi/qapi-commands-misc.h"
> +#include "qapi/qapi-visit-block-core.h"
> +#include "qapi/qobject-input-visitor.h"
>  #include "qapi/visitor.h"
> +#include "qapi/qmp/qdict.h"
> +#include "qapi/qmp/qstring.h"
>  #include "hw/hw.h"
>  #include "hw/xen/xen_common.h"
>  #include "hw/block/xen_blkif.h"
>  #include "hw/xen/xen-block.h"
> +#include "hw/xen/xen-backend.h"
>  #include "sysemu/blockdev.h"
>  #include "sysemu/block-backend.h"
>  #include "sysemu/iothread.h"
> @@ -474,6 +482,7 @@ static void xen_block_class_init(ObjectClass *class,
> void *data)
>      DeviceClass *dev_class =3D DEVICE_CLASS(class);
>      XenDeviceClass *xendev_class =3D XEN_DEVICE_CLASS(class);
>=20
> +    xendev_class->backend =3D "qdisk";
>      xendev_class->device =3D "vbd";
>      xendev_class->get_name =3D xen_block_get_name;
>      xendev_class->realize =3D xen_block_realize;
> @@ -586,3 +595,398 @@ static void xen_block_register_types(void)
>  }
>=20
>  type_init(xen_block_register_types)
> +
> +static void xen_block_blockdev_del(const char *node_name, Error **errp)
> +{
> +    trace_xen_block_blockdev_del(node_name);
> +
> +    qmp_blockdev_del(node_name, errp);
> +}
> +
> +static char *xen_block_blockdev_add(const char *id, QDict *qdict,
> +                                    Error **errp)
> +{
> +    const char *driver =3D qdict_get_try_str(qdict, "driver");
> +    BlockdevOptions *options =3D NULL;
> +    Error *local_err =3D NULL;
> +    char *node_name;
> +    Visitor *v;
> +
> +    if (!driver) {
> +        error_setg(errp, "no 'driver' parameter");
> +        return NULL;
> +    }
> +
> +    node_name =3D g_strdup_printf("%s-%s", id, driver);
> +    qdict_put_str(qdict, "node-name", node_name);
> +
> +    trace_xen_block_blockdev_add(node_name);
> +
> +    v =3D qobject_input_visitor_new(QOBJECT(qdict));
> +    visit_type_BlockdevOptions(v, NULL, &options, &local_err);
> +    visit_free(v);
> +
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        goto fail;
> +    }
> +
> +    qmp_blockdev_add(options, &local_err);
> +
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        goto fail;
> +    }
> +
> +    qapi_free_BlockdevOptions(options);
> +
> +    return node_name;
> +
> +fail:
> +    if (options) {
> +        qapi_free_BlockdevOptions(options);
> +    }
> +    g_free(node_name);
> +
> +    return NULL;
> +}
> +
> +static void xen_block_drive_destroy(XenBlockDrive *drive, Error **errp)
> +{
> +    while (drive->layers-- !=3D 0) {
> +        char *node_name =3D drive->node_name[drive->layers];
> +        Error *local_err =3D NULL;
> +
> +        xen_block_blockdev_del(node_name, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            drive->layers++;
> +            return;
> +        }
> +    }
> +    g_free(drive->id);
> +    g_free(drive);
> +}
> +
> +static void xen_block_drive_layer_add(XenBlockDrive *drive, QDict *qdict=
,
> +                                      Error **errp)
> +{
> +    unsigned int i =3D drive->layers;
> +    char *node_name;
> +
> +    g_assert(drive->layers < ARRAY_SIZE(drive->node_name));
> +
> +    if (i !=3D 0) {
> +        /* Link to the lower layer */
> +        qdict_put_str(qdict, "file", drive->node_name[i - 1]);
> +    }
> +
> +    node_name =3D xen_block_blockdev_add(drive->id, qdict, errp);
> +    if (!node_name) {
> +        return;
> +    }
> +
> +    drive->node_name[i] =3D node_name;
> +    drive->layers++;
> +}
> +
> +static XenBlockDrive *xen_block_drive_create(const char *id,
> +                                             const char *device_type,
> +                                             QDict *opts, Error **errp)
> +{
> +    const char *params =3D qdict_get_try_str(opts, "params");
> +    const char *mode =3D qdict_get_try_str(opts, "mode");
> +    const char *direct_io_safe =3D qdict_get_try_str(opts, "direct-io-
> safe");
> +    const char *discard_enable =3D qdict_get_try_str(opts, "discard-
> enable");
> +    char *driver =3D NULL;
> +    char *filename =3D NULL;
> +    XenBlockDrive *drive =3D NULL;
> +    Error *local_err =3D NULL;
> +    QDict *qdict;
> +
> +    if (params) {
> +        char **v =3D g_strsplit(params, ":", 2);
> +
> +        if (v[1] =3D=3D NULL) {
> +            filename =3D g_strdup(v[0]);
> +            driver =3D g_strdup("file");
> +        } else {
> +            if (strcmp(v[0], "aio") =3D=3D 0) {
> +                driver =3D g_strdup("file");
> +            } else if (strcmp(v[0], "vhd") =3D=3D 0) {
> +                driver =3D g_strdup("vpc");
> +            } else {
> +                driver =3D g_strdup(v[0]);
> +            }
> +            filename =3D g_strdup(v[1]);
> +        }
> +
> +        g_strfreev(v);
> +    }
> +
> +    if (!filename) {
> +        error_setg(errp, "no filename");
> +        goto done;
> +    }
> +    assert(driver);
> +
> +    drive =3D g_new0(XenBlockDrive, 1);
> +    drive->id =3D g_strdup(id);
> +
> +    qdict =3D qdict_new();
> +
> +    qdict_put_str(qdict, "driver", "file");
> +    qdict_put_str(qdict, "filename", filename);
> +
> +    if (mode && *mode !=3D 'w') {
> +        qdict_put_bool(qdict, "read-only", true);
> +    }
> +
> +    if (direct_io_safe) {
> +        unsigned long value;
> +
> +        if (!qemu_strtoul(direct_io_safe, NULL, 2, &value) && !!value) {
> +            QDict *cache_qdict =3D qdict_new();
> +
> +            qdict_put_bool(cache_qdict, "direct", true);
> +            qdict_put_obj(qdict, "cache", QOBJECT(cache_qdict));
> +
> +            qdict_put_str(qdict, "aio", "native");
> +        }
> +    }
> +
> +    if (discard_enable) {
> +        unsigned long value;
> +
> +        if (!qemu_strtoul(discard_enable, NULL, 2, &value) && !!value) {
> +            qdict_put_str(qdict, "discard", "unmap");
> +        }
> +    }
> +
> +    /*
> +     * It is necessary to turn file locking off as an emulated device
> +     * may have already opened the same image file.
> +     */
> +    qdict_put_str(qdict, "locking", "off");
> +
> +    xen_block_drive_layer_add(drive, qdict, &local_err);
> +    qobject_unref(qdict);
> +
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        goto done;
> +    }
> +
> +    /* If the image is a raw file then we are done */
> +    if (!strcmp(driver, "file")) {
> +        goto done;
> +    }
> +
> +    qdict =3D qdict_new();
> +
> +    qdict_put_str(qdict, "driver", driver);
> +
> +    xen_block_drive_layer_add(drive, qdict, &local_err);
> +    qobject_unref(qdict);
> +
> +done:
> +    g_free(driver);
> +    g_free(filename);
> +
> +    if (local_err) {
> +        xen_block_drive_destroy(drive, NULL);
> +        return NULL;
> +    }
> +
> +    return drive;
> +}
> +
> +static const char *xen_block_drive_get_node_name(XenBlockDrive *drive)
> +{
> +    return drive->layers ? drive->node_name[drive->layers - 1] : "";
> +}
> +
> +static void xen_block_iothread_destroy(XenBlockIOThread *iothread,
> +                                       Error **errp)
> +{
> +    qmp_object_del(iothread->id, errp);
> +
> +    g_free(iothread->id);
> +    g_free(iothread);
> +}
> +
> +static XenBlockIOThread *xen_block_iothread_create(const char *id,
> +                                                   Error **errp)
> +{
> +    XenBlockIOThread *iothread =3D g_new(XenBlockIOThread, 1);
> +    Error *local_err =3D NULL;
> +
> +    iothread->id =3D g_strdup(id);
> +
> +    qmp_object_add(TYPE_IOTHREAD, id, false, NULL, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +
> +        g_free(iothread->id);
> +        g_free(iothread);
> +        return NULL;
> +    }
> +
> +    return iothread;
> +}
> +
> +static void xen_block_device_create(XenBackendInstance *backend,
> +                                    QDict *opts, Error **errp)
> +{
> +    XenBus *xenbus =3D xen_backend_get_bus(backend);
> +    const char *name =3D xen_backend_get_name(backend);
> +    unsigned long number;
> +    const char *vdev, *device_type;
> +    XenBlockDrive *drive =3D NULL;
> +    XenBlockIOThread *iothread =3D NULL;
> +    XenDevice *xendev =3D NULL;
> +    Error *local_err =3D NULL;
> +    const char *type;
> +    XenBlockDevice *blockdev;
> +
> +    if (qemu_strtoul(name, NULL, 10, &number)) {
> +        error_setg(errp, "failed to parse name '%s'", name);
> +        goto fail;
> +    }
> +
> +    trace_xen_block_device_create(number);
> +
> +    vdev =3D qdict_get_try_str(opts, "dev");
> +    if (!vdev) {
> +        error_setg(errp, "no dev parameter");
> +        goto fail;
> +    }
> +
> +    device_type =3D qdict_get_try_str(opts, "device-type");
> +    if (!device_type) {
> +        error_setg(errp, "no device-type parameter");
> +        goto fail;
> +    }
> +
> +    if (!strcmp(device_type, "disk")) {
> +        type =3D TYPE_XEN_DISK_DEVICE;
> +    } else if (!strcmp(device_type, "cdrom")) {
> +        type =3D TYPE_XEN_CDROM_DEVICE;
> +    } else {
> +        error_setg(errp, "invalid device-type parameter '%s'",
> device_type);
> +        goto fail;
> +    }
> +
> +    drive =3D xen_block_drive_create(vdev, device_type, opts, &local_err=
);
> +    if (!drive) {
> +        error_propagate_prepend(errp, local_err, "failed to create drive=
:
> ");
> +        goto fail;
> +    }
> +
> +    iothread =3D xen_block_iothread_create(vdev, &local_err);
> +    if (local_err) {
> +        error_propagate_prepend(errp, local_err,
> +                                "failed to create iothread: ");
> +        goto fail;
> +    }
> +
> +    xendev =3D XEN_DEVICE(qdev_create(BUS(xenbus), type));
> +    blockdev =3D XEN_BLOCK_DEVICE(xendev);
> +
> +    object_property_set_str(OBJECT(xendev), vdev, "vdev", &local_err);
> +    if (local_err) {
> +        error_propagate_prepend(errp, local_err, "failed to set 'vdev':
> ");
> +        goto fail;
> +    }
> +
> +    object_property_set_str(OBJECT(xendev),
> +                            xen_block_drive_get_node_name(drive),
> "drive",
> +                            &local_err);
> +    if (local_err) {
> +        error_propagate_prepend(errp, local_err, "failed to set 'drive':
> ");
> +        goto fail;
> +    }
> +
> +    object_property_set_str(OBJECT(xendev), iothread->id, "iothread",
> +                            &local_err);
> +    if (local_err) {
> +        error_propagate_prepend(errp, local_err,
> +                                "failed to set 'iothread': ");
> +        goto fail;
> +    }
> +
> +    blockdev->iothread =3D iothread;
> +    blockdev->drive =3D drive;
> +
> +    object_property_set_bool(OBJECT(xendev), true, "realized",
> &local_err);
> +    if (local_err) {
> +        error_propagate_prepend(errp, local_err,
> +                                "realization of device %s failed: ",
> +                                type);
> +        goto fail;
> +    }
> +
> +    xen_backend_set_device(backend, xendev);
> +    return;
> +
> +fail:
> +    if (xendev) {
> +        object_unparent(OBJECT(xendev));
> +    }
> +
> +    if (iothread) {
> +        xen_block_iothread_destroy(iothread, NULL);
> +    }
> +
> +    if (drive) {
> +        xen_block_drive_destroy(drive, NULL);
> +    }
> +}
> +
> +static void xen_block_device_destroy(XenBackendInstance *backend,
> +                                     Error **errp)
> +{
> +    XenDevice *xendev =3D xen_backend_get_device(backend);
> +    XenBlockDevice *blockdev =3D XEN_BLOCK_DEVICE(xendev);
> +    XenBlockVdev *vdev =3D &blockdev->props.vdev;
> +    XenBlockDrive *drive =3D blockdev->drive;
> +    XenBlockIOThread *iothread =3D blockdev->iothread;
> +
> +    trace_xen_block_device_destroy(vdev->number);
> +
> +    object_unparent(OBJECT(xendev));
> +
> +    if (iothread) {
> +        Error *local_err =3D NULL;
> +
> +        xen_block_iothread_destroy(iothread, &local_err);
> +        if (local_err) {
> +            error_propagate_prepend(errp, local_err,
> +                                "failed to destroy iothread: ");
> +            return;
> +        }
> +    }
> +
> +    if (drive) {
> +        Error *local_err =3D NULL;
> +
> +        xen_block_drive_destroy(drive, &local_err);
> +        if (local_err) {
> +            error_propagate_prepend(errp, local_err,
> +                                "failed to destroy drive: ");
> +        }
> +    }
> +}
> +
> +static const XenBackendInfo xen_block_backend_info =3D {
> +    .type =3D "qdisk",
> +    .create =3D xen_block_device_create,
> +    .destroy =3D xen_block_device_destroy,
> +};
> +
> +static void xen_block_register_backend(void)
> +{
> +    xen_backend_register(&xen_block_backend_info);
> +}
> +
> +xen_backend_init(xen_block_register_backend);
> diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
> index 0c26023799..fb227de35d 100644
> --- a/hw/xen/xen-legacy-backend.c
> +++ b/hw/xen/xen-legacy-backend.c
> @@ -753,7 +753,6 @@ void xen_be_register_common(void)
>=20
>      xen_be_register("console", &xen_console_ops);
>      xen_be_register("vkbd", &xen_kbdmouse_ops);
> -    xen_be_register("qdisk", &xen_blkdev_ops);
>  #ifdef CONFIG_VIRTFS
>      xen_be_register("9pfs", &xen_9pfs_ops);
>  #endif
> diff --git a/include/hw/xen/xen-block.h b/include/hw/xen/xen-block.h
> index c4223f9be1..6f5d675edb 100644
> --- a/include/hw/xen/xen-block.h
> +++ b/include/hw/xen/xen-block.h
> @@ -29,6 +29,7 @@ typedef struct XenBlockVdev {
>      unsigned long number;
>  } XenBlockVdev;
>=20
> +
>  typedef struct XenBlockProperties {
>      XenBlockVdev vdev;
>      BlockConf conf;
> @@ -36,12 +37,24 @@ typedef struct XenBlockProperties {
>      IOThread *iothread;
>  } XenBlockProperties;
>=20
> +typedef struct XenBlockDrive {
> +    char *id;
> +    char *node_name[2];
> +    unsigned int layers;
> +} XenBlockDrive;
> +
> +typedef struct XenBlockIOThread {
> +    char *id;
> +} XenBlockIOThread;
> +
>  typedef struct XenBlockDevice {
>      XenDevice xendev;
>      XenBlockProperties props;
>      const char *device_type;
>      unsigned int info;
>      XenBlockDataPlane *dataplane;
> +    XenBlockDrive *drive;
> +    XenBlockIOThread *iothread;
>  } XenBlockDevice;
>=20
>  typedef void (*XenBlockDeviceRealize)(XenBlockDevice *blockdev, Error
> **errp);
> --
> 2.20.1.2.gb21ebb6
