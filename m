Received: from eggs.gnu.org ([2001:4830:134:3::10]:48722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1dQoGc-0005xu-6M
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 01:14:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1dQoGX-0004ub-B8
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 01:14:54 -0400
Received: from mga09.intel.com ([134.134.136.24]:2739)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kevin.tian@intel.com>)
	id 1dQoGX-0004s4-2M
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 01:14:49 -0400
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Fri, 30 Jun 2017 05:14:40 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190D1F630@SHSMSX101.ccr.corp.intel.com>
References: <1491301684-24367-1-git-send-email-yulei.zhang@intel.com>
	<20170626141906.6e38b235@w520.home>
	<01FDBDDE256B79498DC57789713132D469DCC1EE@SHSMSX101.ccr.corp.intel.com>
	<20170627134431.5947c771@w520.home>
	<AADFC41AFE54684AB9EE6CBC0274A5D190D1956B@SHSMSX101.ccr.corp.intel.com>
	<20170628095938.1329c358@w520.home>
	<AADFC41AFE54684AB9EE6CBC0274A5D190D1CF1C@SHSMSX101.ccr.corp.intel.com>
	<20170629145722.4af0a0fa@w520.home>
In-Reply-To: <20170629145722.4af0a0fa@w520.home>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC 5/5] vifo: introduce new VFIO ioctl
 VFIO_DEVICE_PCI_GET_DIRTY_BITMAP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "Zhang, Yulei" <yulei.zhang@intel.com>, "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>, "Zheng, Xiao" <xiao.zheng@intel.com>, "Wang, Zhi A" <zhi.a.wang@intel.com>

> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Friday, June 30, 2017 4:57 AM
>=20
> On Thu, 29 Jun 2017 00:10:59 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
>=20
> > > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > > Sent: Thursday, June 29, 2017 12:00 AM
> > > Thanks Kevin.  So really it's not really a dirty bitmap, it's just a
> > > bitmap of pages that the device has access to and may have dirtied.
> > > Don't we have this more generally in the vfio type1 IOMMU backend?  F=
or
> > > a mediated device, we know all the pages that the vendor driver has
> > > asked to be pinned.  Should we perhaps make this interface on the vfi=
o
> > > container rather than the device?  Any mediated device can provide th=
is
> > > level of detail without specific vendor support.  If we had DMA page
> > > faulting, this would be the natural place to put it as well, so maybe
> > > we should design the interface there to support everything similarly.
> > > Thanks,
> > >
> >
> > That's a nice idea. Just two comments:
> >
> > 1) If some mediated device has its own way to construct true dirty
> > bitmap (not thru DMA page faulting), the interface is better designed
> > to allow that flexibility. Maybe an optional callback if not registered
> > then use common type1 IOMMU logic otherwise prefers to vendor
> > specific callback
>=20
> I'm not sure what that looks like, but I agree with the idea.  Could
> the pages that type1 knows about every be anything other than a
> superset of the dirty pages?  Perhaps a device ioctl to flush unused
> mappings would be sufficient.

sorry I didn't quite get your idea here. My understanding is that
type1 is OK as an alternative in case mediated device has no way
to track dirtied pages (as for Intel GPU), so we can use type1 pinned
pages as an indirect way to indicate dirtied pages. But if mediated
device has its own way (e.g. a device private MMU) to track dirty
pages, then we should allow that device to provide dirty bitmap
instead of using type1.

>=20
> > 2) If there could be multiple mediated devices from different vendors
> > in same container while not all mediated devices support live migration=
,
> > would container-level interface impose some limitation?
>=20
> Dirty page logging is only one small part of migration, each
> migrate-able device would still need to provide a device-level
> interface to save/restore state.  The migration would fail when we get
> to the device(s) that don't provide that.  Thanks,
>=20

Agree here. Yulei, can you investigate this direction and report back
whether it's feasible or anything overlooked?

Thanks
Kevin
