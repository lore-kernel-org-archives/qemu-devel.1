Received: from eggs.gnu.org ([2001:4830:134:3::10]:45103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCNeY-0001KY-F4
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 07:36:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCNeW-0005uo-M2
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 07:36:46 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38374)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gCNeS-0005cA-S2
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 07:36:43 -0400
Received: by mail-ot1-x341.google.com with SMTP id l1so22141524otj.5
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 04:36:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181012100101.29058-7-cohuck@redhat.com>
References: <20181012100101.29058-1-cohuck@redhat.com>
	<20181012100101.29058-7-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 12:36:18 +0100
Message-ID: <CAFEAcA8tRTaRnQVPcrTsAbFAU_gmejLruLA5eeaZ9o9x12_B3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 6/8] s390x/vfio: ap: Introduce VFIO AP device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Tony Krowiak <akrowiak@linux.ibm.com>

On 12 October 2018 at 11:00, Cornelia Huck <cohuck@redhat.com> wrote:
> From: Tony Krowiak <akrowiak@linux.ibm.com>
>
> Introduces a VFIO based AP device. The device is defined via
> the QEMU command line by specifying:
>
>     -device vfio-ap,sysfsdev=<path-to-mediated-matrix-device>
>
> There may be only one vfio-ap device configured for a guest.
>
> The mediated matrix device is created by the VFIO AP device
> driver by writing a UUID to a sysfs attribute file (see
> docs/vfio-ap.txt). The mediated matrix device will be named
> after the UUID. Symbolic links to the $uuid are created in
> many places, so the path to the mediated matrix device $uuid
> can be specified in any of the following ways:
>
> /sys/devices/vfio_ap/matrix/$uuid
> /sys/devices/vfio_ap/matrix/mdev_supported_types/vfio_ap-passthrough/devices/$uuid
> /sys/bus/mdev/devices/$uuid
> /sys/bus/mdev/drivers/vfio_mdev/$uuid
>
> When the vfio-ap device is realized, it acquires and opens the
> VFIO iommu group to which the mediated matrix device is
> bound. This causes a VFIO group notification event to be
> signaled. The vfio_ap device driver's group notification
> handler will get called at which time the device driver
> will configure the the AP devices to which the guest will
> be granted access.
>
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Tested-by: Pierre Morel <pmorel@linux.ibm.com>
> Acked-by: Halil Pasic <pasic@linux.ibm.com>
> Tested-by: Pierre Morel <pmorel@linux.ibm.com>
> Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Message-Id: <20181010170309.12045-6-akrowiak@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> [CH: added missing g_free and device category]
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Hi; Coverity has pointed out a bug in this function
(CID 1396176):

> +static void vfio_ap_reset(DeviceState *dev)
> +{
> +    int ret;
> +    APDevice *apdev = AP_DEVICE(dev);
> +    VFIOAPDevice *vapdev = VFIO_AP_DEVICE(apdev);
> +
> +    ret = ioctl(vapdev->vdev.fd, VFIO_DEVICE_RESET);
> +    if (ret) {
> +        error_report("%s: failed to reset %s device: %s", __func__,
> +                     vapdev->vdev.name, strerror(ret));

ioctl returns -1 and sets errno, so "strerror(ret)" is
the wrong thing here; we want "strerror(errno)".

thanks
-- PMM
