Received: from eggs.gnu.org ([2001:4830:134:3::10]:55838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1f8kmk-0006fT-C1
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 06:57:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1f8kmh-0004V6-A9
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 06:57:58 -0400
Received: from mga05.intel.com ([192.55.52.43]:32919)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yulei.zhang@intel.com>)
	id 1f8kmg-0004Ud-UR
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 06:57:55 -0400
From: "Zhang, Yulei" <yulei.zhang@intel.com>
Date: Wed, 18 Apr 2018 10:57:50 +0000
Message-ID: <01FDBDDE256B79498DC57789713132D46A193FFB@SHSMSX101.ccr.corp.intel.com>
References: <1523340193-9024-1-git-send-email-yulei.zhang@intel.com>
	<20180416143745.3cb868d9@w520.home>
	<01FDBDDE256B79498DC57789713132D46A18E8D0@SHSMSX101.ccr.corp.intel.com>
	<20180417083434.7a0ec81c@w520.home>
In-Reply-To: <20180417083434.7a0ec81c@w520.home>
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
> Sent: Tuesday, April 17, 2018 10:35 PM
> To: Zhang, Yulei <yulei.zhang@intel.com>
> Cc: qemu-devel@nongnu.org; Tian, Kevin <kevin.tian@intel.com>;
> joonas.lahtinen@linux.intel.com; zhenyuw@linux.intel.com;
> kwankhede@nvidia.com; Wang, Zhi A <zhi.a.wang@intel.com>;
> dgilbert@redhat.com; quintela@redhat.com
> Subject: Re: [RFC PATCH V4 3/4] vfio: Add SaveVMHanlders for VFIO device
> to support live migration
>=20
> On Tue, 17 Apr 2018 08:11:12 +0000
> "Zhang, Yulei" <yulei.zhang@intel.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > > Sent: Tuesday, April 17, 2018 4:38 AM
> > > To: Zhang, Yulei <yulei.zhang@intel.com>
> > > Cc: qemu-devel@nongnu.org; Tian, Kevin <kevin.tian@intel.com>;
> > > joonas.lahtinen@linux.intel.com; zhenyuw@linux.intel.com;
> > > kwankhede@nvidia.com; Wang, Zhi A <zhi.a.wang@intel.com>;
> > > dgilbert@redhat.com; quintela@redhat.com
> > > Subject: Re: [RFC PATCH V4 3/4] vfio: Add SaveVMHanlders for VFIO
> device
> > > to support live migration
> > >
> > > On Tue, 10 Apr 2018 14:03:13 +0800
> > > Yulei Zhang <yulei.zhang@intel.com> wrote:
> > >
> > > > Instead of using vm state description, add SaveVMHandlers for VFIO
> > > > device to support live migration.
> > > >
> > > > Introduce new Ioctl VFIO_DEVICE_GET_DIRTY_BITMAP to fetch the
> > > memory
> > > > bitmap that dirtied by vfio device during the iterative precopy sta=
ge
> > > > to shorten the system downtime afterward.
> > > >
> > > > For vfio pci device status migrate, during the system downtime, it
> > > > will save the following states 1. pci configuration space addr0~add=
r5
> > > > 2. pci configuration space msi_addr msi_data 3. pci device status
> > > > fetch from device driver
> > > >
> > > > And on the target side the vfio_load will restore the same states 1=
.
> > > > re-setup the pci bar configuration 2. re-setup the pci device msi
> > > > configuration 3. restore the pci device status
> > >
> > > Interrupts are configured via ioctl, but I don't see any code here to
> configure
> > > the device into the correct interrupt state.  How do we know the targ=
et
> > > device is compatible with the source device?  Do we rely on the vendo=
r
> > > driver to implicitly include some kind of device and version informat=
ion
> and
> > > fail at the very end of the migration?  It seems like we need to some=
how
> > > front-load that sort of device compatibility checking since a vfio-pc=
i
> device
> > > can be anything (ex. what happens if a user tries to migrate a GVT-g
> vGPU to
> > > an NVIDIA vGPU?).  Thanks,
> > >
> > > Alex
> >
> > We emulate the write to the pci configure space in vfio_load() which wi=
ll
> help
> > setup the interrupt state.
>=20
> But you're only doing that for MSI, not MSI-X, we cannot simply say
> that we don't have an MSI-X devices right now and add it later or we'll
> end up with incompatible vmstate, we need to plan for how we'll support
> it within the save state stream now.
>=20
Agree with u.=20

> > For compatibility I think currently the vendor driver would put version
> number
> > or device specific info in the device state region, so during the pre-c=
opy
> stage
> > the target side will discover the difference and call off the migration=
.
>=20
> Those sorts of things should be built into the device state region, we
> shouldn't rely on vendor drivers to make these kinds of considerations,
> we should build it into the API, which also allows QEMU to check state
> compatibility before attempting a migration.  Thanks,
>=20
> Alex

Not sure about how to check the compatibility before attempting a migration=
,
to my understanding, qemu doesn't know the configuration on target side,
target may call off the migration when it finds the input device state isn'=
t compatible,
and source vm will resume.
