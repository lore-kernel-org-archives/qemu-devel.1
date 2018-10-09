Received: from eggs.gnu.org ([2001:4830:134:3::10]:37106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g9y2j-0001H0-1Z
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 15:51:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g9y2e-00082F-Qj
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 15:51:44 -0400
References: <20181009175226.22138-1-akrowiak@linux.vnet.ibm.com>
	<20181009175226.22138-6-akrowiak@linux.vnet.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <cd6e06e4-0549-3c1a-96e4-2b2354b9866d@redhat.com>
Date: Tue, 9 Oct 2018 21:51:29 +0200
MIME-Version: 1.0
In-Reply-To: <20181009175226.22138-6-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v10 5/6] s390x/vfio: ap: Introduce VFIO AP
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net, fiuczy@linux.ibm.com, mimu@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>


> +static void vfio_ap_realize(DeviceState *dev, Error **errp)
> +{
> +    int ret;
> +    char *mdevid;
> +    Error *local_err = NULL;
> +    VFIOGroup *vfio_group;
> +    APDevice *apdev = AP_DEVICE(dev);
> +    VFIOAPDevice *vapdev = VFIO_AP_DEVICE(apdev);
> +
> +    vfio_group = vfio_ap_get_group(vapdev, &local_err);
> +    if (!vfio_group) {
> +        goto out_err;
> +    }
> +
> +    vapdev->vdev.ops = &vfio_ap_ops;
> +    vapdev->vdev.type = VFIO_DEVICE_TYPE_AP;
> +    mdevid = basename(vapdev->vdev.sysfsdev);
> +    vapdev->vdev.name = g_strdup_printf("%s", mdevid);
> +    vapdev->vdev.dev = dev;
> +
> +    ret = vfio_get_device(vfio_group, mdevid, &vapdev->vdev, &local_err);
> +    if (ret) {
> +        goto out_get_dev_err;
> +    }
> +
> +    /* Enable hardware to intepret AP instructions executed on the guest */
> +    object_property_set_bool(OBJECT(qdev_get_machine()), true, "apie", NULL);
> +

I commented on the old version that this is wrong (if I am not starting
to lose my memory). This has to go. (there is no such property, this
will simply report an error we ignore)

(can most probably be fixed when applying)

-- 

Thanks,

David / dhildenb
