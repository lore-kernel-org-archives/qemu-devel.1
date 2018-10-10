Received: from eggs.gnu.org ([2001:4830:134:3::10]:42375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gA9oU-0003wz-U9
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 04:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gA9oQ-0002Ij-PF
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 04:25:50 -0400
References: <20181009175226.22138-1-akrowiak@linux.vnet.ibm.com>
	<20181009175226.22138-6-akrowiak@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3df292ed-acbf-19da-484e-3aa4ad9536f0@redhat.com>
Date: Wed, 10 Oct 2018 10:25:22 +0200
MIME-Version: 1.0
In-Reply-To: <20181009175226.22138-6-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v10 5/6] s390x/vfio: ap:
 Introduce VFIO AP device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: cohuck@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, fiuczy@linux.ibm.com, eskultet@redhat.com, borntraeger@de.ibm.com, jjherne@linux.vnet.ibm.com, mimu@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>, heiko.carstens@de.ibm.com, eric.auger@redhat.com, alex.williamson@redhat.com, bjsdjshi@linux.vnet.ibm.com, rth@twiddle.net, mjrosato@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, alifm@linux.vnet.ibm.com, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com

On 2018-10-09 19:52, Tony Krowiak wrote:
> Introduces a VFIO based AP device. The device is defined via
> the QEMU command line by specifying:
>=20
>     -device vfio-ap,sysfsdev=3D<path-to-mediated-matrix-device>
>=20
> There may be only one vfio-ap device configured for a guest.
>=20
> The mediated matrix device is created by the VFIO AP device
> driver by writing a UUID to a sysfs attribute file (see
> docs/vfio-ap.txt). The mediated matrix device will be named
> after the UUID. Symbolic links to the $uuid are created in
> many places, so the path to the mediated matrix device $uuid
> can be specified in any of the following ways:
>=20
> /sys/devices/vfio_ap/matrix/$uuid
> /sys/devices/vfio_ap/matrix/mdev_supported_types/vfio_ap-passthrough/de=
vices/$uuid
> /sys/bus/mdev/devices/$uuid
> /sys/bus/mdev/drivers/vfio_mdev/$uuid
>=20
> When the vfio-ap device is realized, it acquires and opens the
> VFIO iommu group to which the mediated matrix device is
> bound. This causes a VFIO group notification event to be
> signaled. The vfio_ap device driver's group notification
> handler will get called at which time the device driver
> will configure the the AP devices to which the guest will
> be granted access.
>=20
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Tested-by: Pierre Morel<pmorel@linux.ibm.com>
> ---
[...]
> +static VFIOGroup *vfio_ap_get_group(VFIOAPDevice *vapdev, Error **errp=
)
> +{
> +    GError *gerror;
> +    char *symlink, *group_path;
> +    int groupid;
> +
> +    symlink =3D g_strdup_printf("%s/iommu_group", vapdev->vdev.sysfsde=
v);
> +    group_path =3D g_file_read_link(symlink, &gerror);
> +    g_free(symlink);
> +
> +    if (!group_path) {
> +        error_setg(errp, "%s: no iommu_group found for %s: %s",
> +                   VFIO_AP_DEVICE_TYPE, vapdev->vdev.sysfsdev, gerror-=
>message);
> +        return NULL;
> +    }
> +
> +    if (sscanf(basename(group_path), "%d", &groupid) !=3D 1) {
> +        error_setg(errp, "vfio: failed to read %s", group_path);
> +        return NULL;
> +    }
> +
> +    return vfio_get_group(groupid, &address_space_memory, errp);
> +}

I think you've got to g_free(group_path) after you don't need it anymore.

> +static void vfio_ap_realize(DeviceState *dev, Error **errp)
> +{
> +    int ret;
> +    char *mdevid;
> +    Error *local_err =3D NULL;
> +    VFIOGroup *vfio_group;
> +    APDevice *apdev =3D AP_DEVICE(dev);
> +    VFIOAPDevice *vapdev =3D VFIO_AP_DEVICE(apdev);
> +
> +    vfio_group =3D vfio_ap_get_group(vapdev, &local_err);
> +    if (!vfio_group) {
> +        goto out_err;
> +    }
> +
> +    vapdev->vdev.ops =3D &vfio_ap_ops;
> +    vapdev->vdev.type =3D VFIO_DEVICE_TYPE_AP;
> +    mdevid =3D basename(vapdev->vdev.sysfsdev);
> +    vapdev->vdev.name =3D g_strdup_printf("%s", mdevid);
> +    vapdev->vdev.dev =3D dev;
> +
> +    ret =3D vfio_get_device(vfio_group, mdevid, &vapdev->vdev, &local_=
err);
> +    if (ret) {
> +        goto out_get_dev_err;
> +    }
> +
> +    /* Enable hardware to intepret AP instructions executed on the gue=
st */
> +    object_property_set_bool(OBJECT(qdev_get_machine()), true, "apie",=
 NULL);
> +
> +    return;
> +
> +out_get_dev_err:
> +    vfio_ap_put_device(vapdev);
> +    vfio_put_group(vfio_group);
> +out_err:
> +    error_propagate(errp, local_err);
> +}
> +
> +static void vfio_ap_unrealize(DeviceState *dev, Error **errp)
> +{
> +    APDevice *apdev =3D DO_UPCAST(APDevice, parent_obj, dev);
> +    VFIOAPDevice *vapdev =3D DO_UPCAST(VFIOAPDevice, apdev, apdev);

Didn't you want to remove the DO_UPCASTs ?

> +    VFIOGroup *group =3D vapdev->vdev.group;
> +
> +    vfio_ap_put_device(vapdev);
> +    vfio_put_group(group);
> +}
> +
> +static Property vfio_ap_properties[] =3D {
> +    DEFINE_PROP_STRING("sysfsdev", VFIOAPDevice, vdev.sysfsdev),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void vfio_ap_reset(DeviceState *dev)
> +{
> +    int ret;
> +    APDevice *apdev =3D DO_UPCAST(APDevice, parent_obj, dev);
> +    VFIOAPDevice *vapdev =3D DO_UPCAST(VFIOAPDevice, apdev, apdev);

dito

> +    ret =3D ioctl(vapdev->vdev.fd, VFIO_DEVICE_RESET);
> +    if (ret) {
> +        error_report("%s: failed to reset %s device: %s", __func__,
> +                     vapdev->vdev.name, strerror(ret));
> +    }
> +}

 Thomas
