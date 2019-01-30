Received: from eggs.gnu.org ([209.51.188.92]:34332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gonY2-0001ig-Co
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:56:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gonY1-0003dV-5u
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:56:50 -0500
Date: Wed, 30 Jan 2019 11:56:38 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190130115638.7112339f.cohuck@redhat.com>
In-Reply-To: <1548707317-21854-1-git-send-email-akrowiak@linux.ibm.com>
References: <1548707317-21854-1-git-send-email-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] s390x/vfio-ap: Implement hot
 plug/unplug of vfio-ap device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, borntraeger@de.ibm.com, david@redhat.com, pmorel@linux.ibm.com, alifm@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, fiuczy@linux.ibm.com

On Mon, 28 Jan 2019 15:28:37 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> Introduces hot plug/unplug support for the vfio-ap device. Note that only one
> vfio-ap device can be attached to the ap-bus, so a vfio-ap device can only be
> hot plugged if the '-device vfio-ap,sysfsdev=$path_to_mdev' option is not
> specified on the QEMU command line.
> 
> Please note that a hot plug handler is not necessary for the vfio-ap device
> because the AP matrix configuration for the guest is performed by the
> kernel device driver when the vfio-ap device is realized. The vfio-ap device
> represents a VFIO mediated device created in the host sysfs for use by a guest.
> The mdev device is configured with an AP matrix (i.e., adapters and domains) via
> its sysfs attribute interfaces prior to starting the guest or plugging a vfio-ap
> device in. When the device is realized, a file descriptor is opened on the mdev
> device which results in a callback to the vfio_ap kernel device driver. The
> device driver then configures the AP matrix in the guest's SIE state description
> from the AP matrix assigned via the mdev device's sysfs interfaces. The AP
> devices will be created for the guest when the AP bus running on the guest
> subsequently performs its periodic scan for AP devices.
> 
> The qdev_simple_device_unplug_cb() callback function is used for the same
> reaons; namely, the vfio_ap kernel device driver will perform the AP resource
> de-configuration for the guest when the vfio-ap device is unplugged. When the
> vfio-ap device is unrealized, the mdev device file descriptor is closed which
> results in a callback to the vfio_ap kernel device driver. The device driver
> then clears the AP matrix configuration in the guest's SIE state description
> and resets all of the affected queues. The AP devices created for the guest
> will be removed when the AP bus running on the guest subsequently performs
> its periodic scan and finds there are no longer any AP resources assigned to the
> guest.

Code looks sane, I just have some comments for the documentation.

> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Tested-by: Pierre Morel<pmorel@linux.ibm.com>
> ---
>  docs/vfio-ap.txt     | 58 +++++++++++++++++++++++++++++++++++++++++++++++-----
>  hw/s390x/ap-bridge.c | 12 ++++++++++-
>  hw/vfio/ap.c         |  2 +-
>  3 files changed, 65 insertions(+), 7 deletions(-)
> 
> diff --git a/docs/vfio-ap.txt b/docs/vfio-ap.txt
> index 12339684cd52..fae40f218620 100644
> --- a/docs/vfio-ap.txt
> +++ b/docs/vfio-ap.txt
> @@ -440,8 +440,7 @@ unassign_control_domain
>     'unassign_domain' file. This may be done multiple times to unassign more than
>     one control domain.
>  
> -Notes: Hot plug/unplug is not currently supported for mediated AP matrix
> -devices, so no changes to the AP matrix will be allowed while a guest using
> +Notes: No changes to the AP matrix will be allowed while a guest using
>  the mediated matrix device is running. Attempts to assign an adapter,
>  domain or control domain will be rejected and an error (EBUSY) returned.
>  
> @@ -562,6 +561,51 @@ facilities:
>                       for guest usage, no AP devices can be made accessible to a
>                       guest started without APFT installed.
>  
> +Hot plug a vfio-ap device into a running guest:
> +==============================================
> +Only one vfio-ap device can be attached to the guest's ap-bus, so a vfio-ap

s/guest/virtual machine/ ?

It's about QEMU's bus layout, not about what the guest sees in the end
(and it confused me for a moment ;) Or do others have a better
suggestion for the wording?

> +device can be hot plugged if and only if the 
> +'-device vfio-ap,sysfsdev=$path-to-mdev' option was NOT specified on the QEMU
> +command line when the guest was started.

Hm... "if and only if no vfio-ap device is attached to the bus already,
either via the QEMU command line or via a prior hotplug action" ?

> +
> +To hot plug a vfio-ap device, use the QEMU device_add command:
> +
> +    (qemu) device_add vfio-ap,sysfsdev="$path-to-mdev"
> +
> +    Where the '$path-to-mdev' value specifies the absolute path to a mediated
> +    device configured with an AP matrix identifying the AP resources assigned
> +    to the guest.
> +
> +The AP devices will be created in the /sys/bus/ap/devices directory on the

"Note that on Linux guests, the AP devices will be created..."

> +guest when the AP bus subsequently performs its periodic scan, so there may be
> +a short delay before the AP devices are accessible on the guest.
> +
> +The command will fail if:
> +
> +* The KVM guest was started with the '-device vfio-ap,sysfs=$path-to-mdev'
> +  QEMU command line option.

"A vfio-ap device has already been attached to the virtual machine
via..." (see above)

> +
> +* The CPU model features for controlling guest access to AP facilities are not
> +  enabled (see 'CPU model features' subsection in the previous section).
> +
> +Hot unplug a vfio-ap device from a running guest:
> +================================================
> +A vfio-ap device can be unplugged from a running KVM guest if the
> +'-device vfio-ap,sysfsdev=$path-to-mdev' option was specified on the QEMU
> +command line when the guest was started.

Can't you unplug as well if the vfio-ap device had been hotplugged?

> +
> +To hot unplug a vfio-ap device, use the QEMU device_del command:
> +
> +    (qemu) device_del vfio-ap,sysfsdev="$path-to-mdev"
> +
> +The AP devices will be removed from the /sys/bus/ap/devices directory on the

"On a Linux guest, the AP devices will be..."

> +guest when the AP bus subsequently performs its periodic scan, so there may be
> +a short delay before the AP devices are no longer accessible by the guest.
> +
> +The command will fail if the $path-to-mdev specified on the device_del command
> +does not match the value specified on the '-device vfio-ap,sysfs=$path-to-mdev'
> +QEMU command line used to start the guest.

Same comment, doesn't that also apply to hotplugged devices?

> +
>  Example: Configure AP Matrixes for Three Linux Guests:
>  =====================================================
>  Let's now provide an example to illustrate how KVM guests may be given
> @@ -819,7 +863,11 @@ Limitations
>    assigned lest the host be given access to the private data of the AP queue
>    device, such as a private key configured specifically for the guest.
>  
> -* Dynamically modifying the AP matrix for a running guest (which would amount to
> -  hot(un)plug of AP devices for the guest) is currently not supported
> +* Dynamically assigning AP resources to or unassigning AP resources from a
> +  mediated matrix device - see 'Configuring an AP matrix for a linux guest'
> +  section above - while a running guest is using it is currently not supported.
>  
> -* Live guest migration is not supported for guests using AP devices.
> +* Live guest migration is not supported for guests using AP devices. If a guest
> +  is using AP devices, the vfio-ap device configured for the guest must be
> +  unplugged before migrating the guest (see 'Hot unplug a vfio-ap device from a
> +  running guest' section above.
