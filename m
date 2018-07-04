Received: from eggs.gnu.org ([2001:4830:134:3::10]:57517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1faftm-0008U2-Cq
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 07:24:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1faftj-0005Tj-9j
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 07:24:38 -0400
Date: Wed, 4 Jul 2018 13:24:29 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180704132429.3444bd18.cohuck@redhat.com>
In-Reply-To: <1530312483-23864-5-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1530312483-23864-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1530312483-23864-5-git-send-email-akrowiak@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 4/5] s390x/vfio: ap: Introduce VFIO AP
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net, Tony Krowiak <akrowiak@linux.ibm.com>

On Fri, 29 Jun 2018 18:48:02 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

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
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>

Nit: You may want to decide one address or the other :)

> ---
>  MAINTAINERS                       |    1 +
>  default-configs/s390x-softmmu.mak |    1 +
>  hw/vfio/Makefile.objs             |    1 +
>  hw/vfio/ap.c                      |  183 +++++++++++++++++++++++++++++++++++++
>  include/hw/vfio/vfio-common.h     |    1 +
>  5 files changed, 187 insertions(+), 0 deletions(-)
>  create mode 100644 hw/vfio/ap.c

No complaints about the code from me.
