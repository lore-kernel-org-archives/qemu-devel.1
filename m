Received: from eggs.gnu.org ([2001:4830:134:3::10]:54424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dzVZt-0003Z9-JC
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 18:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dzVZq-0008LO-D3
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 18:22:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47034
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dzVZq-0008LC-6w
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 18:22:10 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v93MJSuv014826
	for <qemu-devel@nongnu.org>; Tue, 3 Oct 2017 18:22:06 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dcgvmy1fc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 18:22:06 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 3 Oct 2017 18:22:05 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <1501119055-4060-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1501119055-4060-1-git-send-email-mdroth@linux.vnet.ibm.com>
Date: Tue, 03 Oct 2017 17:21:57 -0500
Message-Id: <150706931752.3830.12126799989731308076@sif>
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
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, groug@kaod.org, armbru@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

Quoting Michael Roth (2017-07-26 20:30:52)
> This series was motivated by the discussion in this thread:
> =

>   https://www.redhat.com/archives/libvir-list/2017-June/msg01370.html
> =

> The issue this series addresses is that when libvirt unplugs a VFIO PCI d=
evice,
> it may attempt to bind the host device back to the host driver when QEMU =
emits
> the DEVICE_DELETED event for the corresponding vfio-pci device. However, =
the
> VFIO group FD is not actually cleaned up until vfio-pci device is *finali=
zed*
> by QEMU, whereas the event is emitted earlier during device_unparent.
> Depending on the host device and how long certain operations like resetti=
ng the
> device might take, this can in result in libvirt trying to rebind the dev=
ice
> back to the host while it is still in use by VFIO, leading to host crashe=
s or
> other unexpected behavior.
> =

> In particular, Mellanox CX4 adapters on PowerNV hosts might not be fully
> quiesced by vfio-pci's finalize() routine until up to 6s after the
> DEVICE_DELETED was emitted, leading to detach-device on the libvirt side =
pretty
> much always crashing the host.
> =

> Implementing this change requires 2 prereqs to ensure the same informatio=
n is
> available when the DEVICE_DELETED is finally emitted:
> =

> 1) Storing the path in the composition patch, which is addressed by PATCH=
 1,
>    which was plucked from another pending series from Greg Kurz:
> =

>    https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg07922.html
> =

>    since we are now "disconnected" at the time the event is emitted, and
> =

> 2) Deferring qemu_opts_del of the DeviceState->QemuOpts till finalize, si=
nce
>    that is where DeviceState->id is stored. This was actually how it was
>    done in the past, so PATCH 2 simply reverts the change which moved it =
to
>    device_unparent.
> =

> From there it's just a mechanical move of the event from device_unparent =
to
> device_finalize.

Ping.

The situation has changed somewhat since original posting as Alex now
has a fix on the kernel side for the VFIO issue noted above:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D6586b561a91cd80a91c8f107ed0d144feb3eadc2

However, I think this series would still be useful for addressing the
issue for hosts using older kernels, and there seems to be general
interest from the libvirt side in aligning "DEVICE_DELETED" events
with the notion that QEMU is completely finished with a device.

Patch 1/3 is also needed for another series that Greg is working on
and I don't want to hold that up for this series, so if it's
preferred that we just post that patch separately in the meantime
please let me know.

Thanks!

> =

>  hw/core/qdev.c         | 30 +++++++++++++++++++-----------
>  include/hw/qdev-core.h |  1 +
>  2 files changed, 20 insertions(+), 11 deletions(-)
> =

>=20
