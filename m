Received: from eggs.gnu.org ([2001:4830:134:3::10]:40952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fC04z-0006zk-Ny
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:54:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fC04v-0001Qs-Q0
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:54:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36820 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fC04v-0001QY-LB
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:54:09 -0400
Date: Fri, 27 Apr 2018 17:53:52 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180427095352.GD13269@xz-mi>
References: <20180425045129.17449-1-peterx@redhat.com>
	<20180425045129.17449-4-peterx@redhat.com>
	<2492f7d8-ed63-6f1c-773f-baa223020022@redhat.com>
	<20180427062615.GY9036@xz-mi>
	<AADFC41AFE54684AB9EE6CBC0274A5D19113B628@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19113B628@SHSMSX101.ccr.corp.intel.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/10] intel-iommu: add iommu lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Jason Wang <jasowang@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>, Alex Williamson <alex.williamson@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>

On Fri, Apr 27, 2018 at 07:19:25AM +0000, Tian, Kevin wrote:
> > From: Peter Xu
> > Sent: Friday, April 27, 2018 2:26 PM
> >=20
> > On Fri, Apr 27, 2018 at 01:13:02PM +0800, Jason Wang wrote:
> > >
> > >
> > > On 2018=E5=B9=B404=E6=9C=8825=E6=97=A5 12:51, Peter Xu wrote:
> > > > Add a per-iommu big lock to protect IOMMU status.  Currently the =
only
> > > > thing to be protected is the IOTLB cache, since that can be acces=
sed
> > > > even without BQL, e.g., in IO dataplane.
> > > >
> > > > Note that device page tables should not need any protection.  The
> > safety
> > > > of that should be provided by guest OS.  E.g., when a page entry =
is
> > > > freed, the guest OS should be responsible to make sure that no de=
vice
> > > > will be using that page any more.
>=20
> device page table definitely doesn't require protection, since it is
> in-memory structure managed by guest. However the reason
> above is not accurate - there is no way that guest OS can make
> sure no device uses non-present page entry, otherwise it doesn't
> require virtual IOMMU to protect itself. There could be bogus/
> malicious drivers which surely may program the device to attempt so.

How about this:

  Note that we don't need to protect device page tables since that's
  fully controlled by the guest kernel.  However there is still
  possibilities that malicious drivers will still program the device
  to not disobey the rule.  In that case QEMU can't really do anything
  useful, instead the guest itself will be responsible for all
  uncertainties.

>=20
> > > >
> > > > Reported-by: Fam Zheng<famz@redhat.com>
> > > > Signed-off-by: Peter Xu<peterx@redhat.com>
> > > > ---
> > > >   include/hw/i386/intel_iommu.h |  8 ++++++++
> > > >   hw/i386/intel_iommu.c         | 31 ++++++++++++++++++++++++++++=
+--
> > > >   2 files changed, 37 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/include/hw/i386/intel_iommu.h
> > b/include/hw/i386/intel_iommu.h
> > > > index 220697253f..1a8ba8e415 100644
> > > > --- a/include/hw/i386/intel_iommu.h
> > > > +++ b/include/hw/i386/intel_iommu.h
> > > > @@ -262,6 +262,14 @@ struct IntelIOMMUState {
> > > >       uint8_t w1cmask[DMAR_REG_SIZE]; /* RW1C(Write 1 to Clear) b=
ytes
> > */
> > > >       uint8_t womask[DMAR_REG_SIZE];  /* WO (write only - read re=
turns
> > 0) */
> > > >       uint32_t version;
> > > > +    /*
> > > > +     * Protects IOMMU states in general.  Normally we don't need=
 to
> > > > +     * take this lock when we are with BQL held.  However we hav=
e code
> > > > +     * paths that may run even without BQL.  In those cases, we =
need
> > > > +     * to take the lock when we have access to IOMMU state
> > > > +     * informations, e.g., the IOTLB.
>=20
> better if you can whitelist those paths here to clarify.

Sure. Basically it's the translation path (vtd_iommu_translate).

>=20
> > > > +     */
> > > > +    QemuMutex iommu_lock;
> > >
> > > Some questions:
> > >
> > > 1) Do we need to protect context cache too?
> >=20
> > IMHO the context cache entry should work even without lock.  That's a
> > bit trickly since we have two cases that this cache will be updated:
> >=20
> >   (1) first translation of the address space of a device
> >   (2) invalidation of context entries
> >=20
> > For (2) IMHO we don't need to worry about since guest OS should be
> > controlling that part, say, device should not be doing any translatio=
n
> > (DMA operations) when the context entry is invalidated.
>=20
> again above cannot be assumed.

Yeah, but in that case IMHO it's still the same just like page tables
- we can't control anything really, and the guest itself will be
responsible for any undefined subsequences.

Anyway, let me protect that field too in my next version.

Thanks,

--=20
Peter Xu
