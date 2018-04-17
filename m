Received: from eggs.gnu.org ([2001:4830:134:3::10]:55702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1f8LiF-0004AR-6Q
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 04:11:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1f8LiC-0000d1-0k
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 04:11:39 -0400
Received: from mga03.intel.com ([134.134.136.65]:22681)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yulei.zhang@intel.com>)
	id 1f8LiB-0000c8-MS
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 04:11:35 -0400
From: "Zhang, Yulei" <yulei.zhang@intel.com>
Date: Tue, 17 Apr 2018 08:11:12 +0000
Message-ID: <01FDBDDE256B79498DC57789713132D46A18E8D0@SHSMSX101.ccr.corp.intel.com>
References: <1523340193-9024-1-git-send-email-yulei.zhang@intel.com>
	<20180416143745.3cb868d9@w520.home>
In-Reply-To: <20180416143745.3cb868d9@w520.home>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC PATCH V4 3/4] vfio: Add SaveVMHanlders for
 VFIO device to support live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Tian, Kevin" <kevin.tian@intel.com>, "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>, "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "Wang, Zhi A" <zhi.a.wang@intel.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "quintela@redhat.com" <quintela@redhat.com>


> -----Original Message-----
> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Tuesday, April 17, 2018 4:38 AM
> To: Zhang, Yulei <yulei.zhang@intel.com>
> Cc: qemu-devel@nongnu.org; Tian, Kevin <kevin.tian@intel.com>;
> joonas.lahtinen@linux.intel.com; zhenyuw@linux.intel.com;
> kwankhede@nvidia.com; Wang, Zhi A <zhi.a.wang@intel.com>;
> dgilbert@redhat.com; quintela@redhat.com
> Subject: Re: [RFC PATCH V4 3/4] vfio: Add SaveVMHanlders for VFIO device
> to support live migration
>=20
> On Tue, 10 Apr 2018 14:03:13 +0800
> Yulei Zhang <yulei.zhang@intel.com> wrote:
>=20
> > Instead of using vm state description, add SaveVMHandlers for VFIO
> > device to support live migration.
> >
> > Introduce new Ioctl VFIO_DEVICE_GET_DIRTY_BITMAP to fetch the
> memory
> > bitmap that dirtied by vfio device during the iterative precopy stage
> > to shorten the system downtime afterward.
> >
> > For vfio pci device status migrate, during the system downtime, it
> > will save the following states 1. pci configuration space addr0~addr5
> > 2. pci configuration space msi_addr msi_data 3. pci device status
> > fetch from device driver
> >
> > And on the target side the vfio_load will restore the same states 1.
> > re-setup the pci bar configuration 2. re-setup the pci device msi
> > configuration 3. restore the pci device status
>=20
> Interrupts are configured via ioctl, but I don't see any code here to con=
figure
> the device into the correct interrupt state.  How do we know the target
> device is compatible with the source device?  Do we rely on the vendor
> driver to implicitly include some kind of device and version information =
and
> fail at the very end of the migration?  It seems like we need to somehow
> front-load that sort of device compatibility checking since a vfio-pci de=
vice
> can be anything (ex. what happens if a user tries to migrate a GVT-g vGPU=
 to
> an NVIDIA vGPU?).  Thanks,
>=20
> Alex

We emulate the write to the pci configure space in vfio_load() which will h=
elp
setup the interrupt state.=20
For compatibility I think currently the vendor driver would put version num=
ber=20
or device specific info in the device state region, so during the pre-copy =
stage
the target side will discover the difference and call off the migration.
