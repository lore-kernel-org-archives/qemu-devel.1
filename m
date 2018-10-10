Received: from eggs.gnu.org ([2001:4830:134:3::10]:49948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gAAFF-0002wz-OT
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 04:53:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gAAFB-0004ie-Ix
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 04:53:29 -0400
Date: Wed, 10 Oct 2018 10:52:56 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181010105256.1ee6e099.cohuck@redhat.com>
In-Reply-To: <3df292ed-acbf-19da-484e-3aa4ad9536f0@redhat.com>
References: <20181009175226.22138-1-akrowiak@linux.vnet.ibm.com>
	<20181009175226.22138-6-akrowiak@linux.vnet.ibm.com>
	<3df292ed-acbf-19da-484e-3aa4ad9536f0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Thomas Huth <thuth@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, david@redhat.com, pmorel@linux.vnet.ibm.com, fiuczy@linux.ibm.com, eskultet@redhat.com, borntraeger@de.ibm.com, jjherne@linux.vnet.ibm.com, mimu@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>, heiko.carstens@de.ibm.com, eric.auger@redhat.com, alex.williamson@redhat.com, bjsdjshi@linux.vnet.ibm.com, rth@twiddle.net, mjrosato@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, alifm@linux.vnet.ibm.com, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com

On Wed, 10 Oct 2018 10:25:22 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 2018-10-09 19:52, Tony Krowiak wrote:

> [...]
> > +static VFIOGroup *vfio_ap_get_group(VFIOAPDevice *vapdev, Error **errp)
> > +{
> > +    GError *gerror;
> > +    char *symlink, *group_path;
> > +    int groupid;
> > +
> > +    symlink = g_strdup_printf("%s/iommu_group", vapdev->vdev.sysfsdev);
> > +    group_path = g_file_read_link(symlink, &gerror);
> > +    g_free(symlink);
> > +
> > +    if (!group_path) {
> > +        error_setg(errp, "%s: no iommu_group found for %s: %s",
> > +                   VFIO_AP_DEVICE_TYPE, vapdev->vdev.sysfsdev, gerror->message);
> > +        return NULL;
> > +    }
> > +
> > +    if (sscanf(basename(group_path), "%d", &groupid) != 1) {
> > +        error_setg(errp, "vfio: failed to read %s", group_path);
> > +        return NULL;
> > +    }
> > +
> > +    return vfio_get_group(groupid, &address_space_memory, errp);
> > +}  
> 
> I think you've got to g_free(group_path) after you don't need it anymore.
> 
> > +static void vfio_ap_realize(DeviceState *dev, Error **errp)
> > +{
> > +    int ret;
> > +    char *mdevid;
> > +    Error *local_err = NULL;
> > +    VFIOGroup *vfio_group;
> > +    APDevice *apdev = AP_DEVICE(dev);
> > +    VFIOAPDevice *vapdev = VFIO_AP_DEVICE(apdev);
> > +
> > +    vfio_group = vfio_ap_get_group(vapdev, &local_err);
> > +    if (!vfio_group) {
> > +        goto out_err;
> > +    }
> > +
> > +    vapdev->vdev.ops = &vfio_ap_ops;
> > +    vapdev->vdev.type = VFIO_DEVICE_TYPE_AP;
> > +    mdevid = basename(vapdev->vdev.sysfsdev);
> > +    vapdev->vdev.name = g_strdup_printf("%s", mdevid);
> > +    vapdev->vdev.dev = dev;
> > +
> > +    ret = vfio_get_device(vfio_group, mdevid, &vapdev->vdev, &local_err);
> > +    if (ret) {
> > +        goto out_get_dev_err;
> > +    }
> > +
> > +    /* Enable hardware to intepret AP instructions executed on the guest */
> > +    object_property_set_bool(OBJECT(qdev_get_machine()), true, "apie", NULL);
> > +
> > +    return;
> > +
> > +out_get_dev_err:
> > +    vfio_ap_put_device(vapdev);
> > +    vfio_put_group(vfio_group);
> > +out_err:
> > +    error_propagate(errp, local_err);
> > +}
> > +
> > +static void vfio_ap_unrealize(DeviceState *dev, Error **errp)
> > +{
> > +    APDevice *apdev = DO_UPCAST(APDevice, parent_obj, dev);
> > +    VFIOAPDevice *vapdev = DO_UPCAST(VFIOAPDevice, apdev, apdev);  
> 
> Didn't you want to remove the DO_UPCASTs ?
> 
> > +    VFIOGroup *group = vapdev->vdev.group;
> > +
> > +    vfio_ap_put_device(vapdev);
> > +    vfio_put_group(group);
> > +}
> > +
> > +static Property vfio_ap_properties[] = {
> > +    DEFINE_PROP_STRING("sysfsdev", VFIOAPDevice, vdev.sysfsdev),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void vfio_ap_reset(DeviceState *dev)
> > +{
> > +    int ret;
> > +    APDevice *apdev = DO_UPCAST(APDevice, parent_obj, dev);
> > +    VFIOAPDevice *vapdev = DO_UPCAST(VFIOAPDevice, apdev, apdev);  
> 
> dito
> 
> > +    ret = ioctl(vapdev->vdev.fd, VFIO_DEVICE_RESET);
> > +    if (ret) {
> > +        error_report("%s: failed to reset %s device: %s", __func__,
> > +                     vapdev->vdev.name, strerror(ret));
> > +    }
> > +}  

OK, this is now a bit too much stuff all in all to change while
applying...

Tony, can you please do a respin with these changes and the other
things people have noticed? Thanks!
