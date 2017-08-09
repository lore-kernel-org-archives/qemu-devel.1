Received: from eggs.gnu.org ([2001:4830:134:3::10]:44325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dfSML-0000L4-P7
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 10:53:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dfSME-0008T0-PS
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 10:53:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1dfSME-0008Sd-G6
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 10:53:14 -0400
References: <1501119055-4060-1-git-send-email-mdroth@linux.vnet.ibm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <d358266e-f14f-90eb-a74c-689c2ef0332e@redhat.com>
Date: Wed, 9 Aug 2017 16:53:07 +0200
MIME-Version: 1.0
In-Reply-To: <1501119055-4060-1-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/3] qdev/vfio: defer DEVICE_DEL
 to avoid races with libvirt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, groug@kaod.org, armbru@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

Hi Michael,

On 27/07/2017 03:30, Michael Roth wrote:
> This series was motivated by the discussion in this thread:
> 
>   https://www.redhat.com/archives/libvir-list/2017-June/msg01370.html
> 
> The issue this series addresses is that when libvirt unplugs a VFIO PCI device,
> it may attempt to bind the host device back to the host driver when QEMU emits
> the DEVICE_DELETED event for the corresponding vfio-pci device. However, the
> VFIO group FD is not actually cleaned up until vfio-pci device is *finalized*
> by QEMU, whereas the event is emitted earlier during device_unparent.
> Depending on the host device and how long certain operations like resetting the
> device might take, this can in result in libvirt trying to rebind the device
> back to the host while it is still in use by VFIO, leading to host crashes or
> other unexpected behavior.
> 
> In particular, Mellanox CX4 adapters on PowerNV hosts might not be fully
> quiesced by vfio-pci's finalize() routine until up to 6s after the
> DEVICE_DELETED was emitted, leading to detach-device on the libvirt side pretty
> much always crashing the host.
> 
> Implementing this change requires 2 prereqs to ensure the same information is
> available when the DEVICE_DELETED is finally emitted:
> 
> 1) Storing the path in the composition patch, which is addressed by PATCH 1,
>    which was plucked from another pending series from Greg Kurz:
> 
>    https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg07922.html
> 
>    since we are now "disconnected" at the time the event is emitted, and
> 
> 2) Deferring qemu_opts_del of the DeviceState->QemuOpts till finalize, since
>    that is where DeviceState->id is stored. This was actually how it was
>    done in the past, so PATCH 2 simply reverts the change which moved it to
>    device_unparent.
> 
> From there it's just a mechanical move of the event from device_unparent to
> device_finalize.
> 
>  hw/core/qdev.c         | 30 +++++++++++++++++++-----------
>  include/hw/qdev-core.h |  1 +
>  2 files changed, 20 insertions(+), 11 deletions(-)
> 
> 

Tested-by: Eric Auger <eric.auger@redhat.com>


Without the series I get the following warning when detaching a pci host
dev from virt-manager:
2017-08-09T14:28:44.825925Z qemu-system-aarch64: Failed to remove group
53 from KVM VFIO device: No such file or directory

as KVM_DEV_VFIO_GROUP_DEL returns -ENOENT due to the fact the fd for the
VFIO group does not exist anymore as libvirt already started to unbind
the device from vfio-pci at vfio_instance_finalize() time.

With the series I don't see the message anymore.

Thanks

Eric
