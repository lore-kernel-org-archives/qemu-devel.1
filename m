Received: from eggs.gnu.org ([2001:4830:134:3::10]:39085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dBLFr-0000Bk-HQ
	for qemu-devel@nongnu.org; Thu, 18 May 2017 09:14:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dBLFn-0000vQ-Hr
	for qemu-devel@nongnu.org; Thu, 18 May 2017 09:14:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34817)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1dBLFn-0000vG-7h
	for qemu-devel@nongnu.org; Thu, 18 May 2017 09:14:07 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4IDDxLn070359
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 09:14:05 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ah87fm54t-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 09:14:05 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 18 May 2017 14:14:02 +0100
Date: Thu, 18 May 2017 15:13:56 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170517004813.58227-1-bjsdjshi@linux.vnet.ibm.com>
References: <20170517004813.58227-1-bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170518151356.3dfc4207.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v8 00/13] basic channel IO passthrough
 infrastructure based on vfio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, eric.auger@redhat.com

On Wed, 17 May 2017 02:48:00 +0200
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> The patch series introduce a basic channel I/O passthrough
> infrastructure based on vfio.
> - Focus on supporting dasd-eckd(cu_type/dev_type = 0x3990/0x3390) as
>   the target device. 
> - Support new qemu parameters in the style of:
>     -machine s390-ccw-virtio(,s390-squash-mcss=on|off) \
>     -device vfio-ccw,sysfsdev=$MDEV_PATH
>   We want to support real (i.e. not virtual) channel devices even for
>   guests that do not support MCSS-E (where guests may see devices from
>   any channel subsystem image at once). As all virtio-ccw devices are in
>   css 0xfe (and show up in the default css 0 for guests not activating
>   MCSS-E), we need an option to squash e.g. passed-through channel devices
>   from their real css (0-3, or 0 for hosts not activating MCSS-E) into
>   the default css, that is what the new machine option s390-squash-css is
>   added.

Patches queued, with minor changes (see my comments).

I'll push out to s390-next once this passes some of my tests.

> 
> Build and install:
> 1. kernel configuration
>   CONFIG_S390_CCW_IOMMU=m
>   CONFIG_VFIO=m
>   CONFIG_VFIO_MDEV=m
>   CONFIG_VFIO_MDEV_DEVICE=m
>   CONFIG_VFIO_CCW=m
> 2. modules required
>   modprobe vfio.ko
>   modprobe mdev.ko
>   modprobe vfio_mdev.ko
>   modprobe vfio_iommu_type1.ko
>   modprobe vfio_ccw.ko
> 3. find a subchannel(0.0."%schid") of a DASD-ECKD device and bind it to
>   vfio_ccw driver
>   #find the dasd you can use with lsdasd on your host. e.g.:
>   devno="7e52"
>   schid="16ca"
>   #unbind the ccw device from the subchannel
>   echo 0.0."$devno" > /sys/bus/ccw/devices/0.0."$devno"/driver/unbind
>   #unbind the subchannel from io_subchannel driver
>   echo 0.0."$schid" > /sys/bus/css/devices/0.0."$schid"/driver/unbind
>   #bind the subchannel with vfio_ccw driver
>   echo 0.0."$schid" > /sys/bus/css/drivers/vfio_ccw/bind
> 4. create a mediated device
>   #generate a uuid with uuidgen. e.g.:
>   uuid="6dfd3ec5-e8b3-4e18-a6fe-57bc9eceb920"
>   echo "$uuid" > \
>   /sys/bus/css/devices/0.0."$schid"/mdev_supported_types/vfio_ccw-io/create
> 5. pass-through this device to a vm
>   -M s390-ccw-virtio,s390-squash-css=on \
>   -device vfio-ccw,sysfsdev=/sys/bus/mdev/devices/$uuid \
>   ... ...

These instructions would be helpful to preserve in the qemu wiki and
could even be expanded upon. Ping me if you need an account (hint,
hint ;)
