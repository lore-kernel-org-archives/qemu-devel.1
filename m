Received: from eggs.gnu.org ([2001:4830:134:3::10]:43983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1ciy6q-0007UZ-BN
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 01:51:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1ciy6n-0005rE-91
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 01:51:36 -0500
Received: from mga02.intel.com ([134.134.136.20]:19429)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kevin.tian@intel.com>)
	id 1ciy6m-0005oZ-Ve
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 01:51:33 -0500
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Wed, 1 Mar 2017 06:51:22 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190C4FF94@SHSMSX101.ccr.corp.intel.com>
References: <A2975661238FB949B60364EF0F2C257436DE3165@shsmsx102.ccr.corp.intel.com>
	<20170228220719.GD2352@char.us.ORACLE.com>
In-Reply-To: <20170228220719.GD2352@char.us.ORACLE.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC Design Doc v3] Enable Shared Virtual Memory
 feature in pass-through scenarios
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Lan, Tianyu" <tianyu.lan@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Hao, Xudong" <xudong.hao@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, 'Peter Xu' <peterx@redhat.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>

> From: Konrad Rzeszutek Wilk [mailto:konrad.wilk@oracle.com]
> Sent: Wednesday, March 01, 2017 6:07 AM
>=20
> On Wed, Nov 30, 2016 at 08:49:24AM +0000, Liu, Yi L wrote:
> > What's changed from v2:
> > a) Detailed feature description
> > b) refine description in "Address translation in virtual SVM"
> > b) "Terms" is added
> >
> > Content
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > 1. Feature description
> > 2. Why use it?
> > 3. How to enable it
> > 4. How to test
> > 5. Terms
> >
> > Details
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > 1. Feature description
> > Shared virtual memory(SVM) is to let application program share its virt=
ual
> > address with SVM capable devices.
> >
> > Shared virtual memory details:
> > a) SVM feature requires ATS/PRQ/PASID support on both device side and
> > IOMMU side.
> > b) SVM capable devices could send DMA requests with PASID, the address
> > in the request would be a virtual address within a program's virtual ad=
dress
> > space.
> > c) IOMMU would use first level page table to translate the address in t=
he
> > request.
> > d) First level page table is a HVA->HPA mapping on bare metal.
> >
> > Shared Virtual Memory feature in pass-through scenarios is actually SVM
> > virtualization. It is to let application programs(running in guest)shar=
e their
> > virtual address with assigned device(e.g. graphics processors or accele=
rators).
>=20
> I think I am missing something obvious, but the current way that DRM
> works is that the kernel sets up its VA addresses for the GPU and it uses
> that for its ring. It also setups an user level mapping for the GPU if th=
e
> application (Xorg) really wants it - but most of the time the kernel is
> in charge of poking at the ring, and the memory that is shared with the
> Xorg is normal RAM allocated via alloc_pages (see
> drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
> and drivers/gpu/drm/ttm/ttm_page_alloc.c).
>=20
> So are talking about the guest applications having access to the
> ring of the GPU?

No. SVM is purely about sharing CPU address space with device. Command
submission is still through kernel driver which controls rings (with SVM th=
en
you can put VA into those commands). There are other vendor specific=20
features to enable direct user space submission which is orthogonal to SVM.

Thanks
Kevin
