Received: from eggs.gnu.org ([2001:4830:134:3::10]:41354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fC06M-0008Hx-1s
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:55:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fC06I-00026Z-43
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:55:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39330 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fC06H-00026B-VZ
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:55:34 -0400
Date: Fri, 27 Apr 2018 17:55:27 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180427095527.GE13269@xz-mi>
References: <20180425045129.17449-1-peterx@redhat.com>
	<20180425045129.17449-9-peterx@redhat.com>
	<2b05e076-0af9-0ee9-c076-7acc29714913@redhat.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19113B5D2@SHSMSX101.ccr.corp.intel.com>
	<20180427072810.GB13269@xz-mi>
	<AADFC41AFE54684AB9EE6CBC0274A5D19113C1C9@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19113C1C9@SHSMSX101.ccr.corp.intel.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/10] intel-iommu: maintain per-device
 iova ranges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Jason Wang <jasowang@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>

On Fri, Apr 27, 2018 at 07:44:07AM +0000, Tian, Kevin wrote:
> > From: Peter Xu [mailto:peterx@redhat.com]
> > Sent: Friday, April 27, 2018 3:28 PM
> >=20
> > On Fri, Apr 27, 2018 at 07:02:14AM +0000, Tian, Kevin wrote:
> > > > From: Jason Wang [mailto:jasowang@redhat.com]
> > > > Sent: Friday, April 27, 2018 2:08 PM
> > > >
> > > > On 2018=E5=B9=B404=E6=9C=8825=E6=97=A5 12:51, Peter Xu wrote:
> > > > > For each VTDAddressSpace, now we maintain what IOVA ranges we
> > have
> > > > > mapped and what we have not.  With that information, now we onl=
y
> > > > send
> > > > > MAP or UNMAP when necessary.  Say, we don't send MAP notifies i=
f
> > we
> > > > know
> > > > > we have already mapped the range, meanwhile we don't send
> > UNMAP
> > > > notifies
> > > > > if we know we never mapped the range at all.
> > > > >
> > > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > > ---
> > > > >   include/hw/i386/intel_iommu.h |  2 ++
> > > > >   hw/i386/intel_iommu.c         | 28 ++++++++++++++++++++++++++=
++
> > > > >   hw/i386/trace-events          |  2 ++
> > > > >   3 files changed, 32 insertions(+)
> > > > >
> > > > > diff --git a/include/hw/i386/intel_iommu.h
> > > > b/include/hw/i386/intel_iommu.h
> > > > > index 486e205e79..09a2e94404 100644
> > > > > --- a/include/hw/i386/intel_iommu.h
> > > > > +++ b/include/hw/i386/intel_iommu.h
> > > > > @@ -27,6 +27,7 @@
> > > > >   #include "hw/i386/ioapic.h"
> > > > >   #include "hw/pci/msi.h"
> > > > >   #include "hw/sysbus.h"
> > > > > +#include "qemu/interval-tree.h"
> > > > >
> > > > >   #define TYPE_INTEL_IOMMU_DEVICE "intel-iommu"
> > > > >   #define INTEL_IOMMU_DEVICE(obj) \
> > > > > @@ -95,6 +96,7 @@ struct VTDAddressSpace {
> > > > >       QLIST_ENTRY(VTDAddressSpace) next;
> > > > >       /* Superset of notifier flags that this address space has=
 */
> > > > >       IOMMUNotifierFlag notifier_flags;
> > > > > +    ITTree *iova_tree;          /* Traces mapped IOVA ranges *=
/
> > > > >   };
> > > > >
> > > > >   struct VTDBus {
> > > > > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > > > > index a19c18b8d4..8f396a5d13 100644
> > > > > --- a/hw/i386/intel_iommu.c
> > > > > +++ b/hw/i386/intel_iommu.c
> > > > > @@ -768,12 +768,37 @@ typedef struct {
> > > > >   static int vtd_page_walk_one(IOMMUTLBEntry *entry, int level,
> > > > >                                vtd_page_walk_info *info)
> > > > >   {
> > > > > +    VTDAddressSpace *as =3D info->as;
> > > > >       vtd_page_walk_hook hook_fn =3D info->hook_fn;
> > > > >       void *private =3D info->private;
> > > > > +    ITRange *mapped =3D it_tree_find(as->iova_tree, entry->iov=
a,
> > > > > +                                   entry->iova + entry->addr_m=
ask);
> > > > >
> > > > >       assert(hook_fn);
> > > > > +
> > > > > +    /* Update local IOVA mapped ranges */
> > > > > +    if (entry->perm) {
> > > > > +        if (mapped) {
> > > > > +            /* Skip since we have already mapped this range */
> > > > > +            trace_vtd_page_walk_one_skip_map(entry->iova, entr=
y-
> > > > >addr_mask,
> > > > > +                                             mapped->start, ma=
pped->end);
> > > > > +            return 0;
> > > > > +        }
> > > > > +        it_tree_insert(as->iova_tree, entry->iova,
> > > > > +                       entry->iova + entry->addr_mask);
> > > >
> > > > I was consider a case e.g:
> > > >
> > > > 1) map A (iova) to B (pa)
> > > > 2) invalidate A
> > > > 3) map A (iova) to C (pa)
> > > > 4) invalidate A
> > > >
> > > > In this case, we will probably miss a walk here. But I'm not sure=
 it was
> > > > allowed by the spec (though I think so).
> > > >
> >=20
> > Hi, Kevin,
> >=20
> > Thanks for joining the discussion.
> >=20
> > >
> > > I thought it was wrong in a glimpse, but then changed my mind after
> > > another thinking. As long as device driver can quiescent the device
> > > to not access A (iova) within above window, then above sequence
> > > has no problem since any stale mappings (A->B) added before step 4)
> > > won't be used and then will get flushed after step 4). Regarding to
> > > that actually the 1st invalidation can be skipped:
> > >
> > > 1) map A (iova) to B (pa)
> > > 2) driver programs device to use A
> > > 3) driver programs device to not use A
> > > 4) map A (iova) to C (pa)
> > > 	A->B may be still valid in IOTLB
> > > 5) invalidate A
> > > 6) driver programs device to use A
> >=20
> > Note that IMHO this is a bit different from Jason's example, and it'l=
l
> > be fine.  Current code should work well with this scenario since the
> > emulation code will not aware of the map A until step (5).  Then we'l=
l
> > have the correct mapping.
>=20
> you are right. we still need the extra PSI otherwise the 1st mapping
> is problematic for use. So back to Jason's example.
>=20
> >=20
> > While for Jason's example it's exactly the extra PSI that might cause
> > stale mappings (though again I think it's still problematic...).
>=20
> problematic in software side (e.g. that way IOMMU core relies on
> device drivers which conflict with the value of using IOMMU) but
> it is OK from hardware p.o.v. btw the extra PSI itself doesn't cause
> stale mapping. Instead it is device activity after that PSI may cause i=
t.
>=20
> >=20
> > Actually I think I can just fix up the code even if Jason's case
> > happens by unmapping that first then remap:
> >=20
> > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > index 31e9b52452..2a9584f9d8 100644
> > --- a/hw/i386/intel_iommu.c
> > +++ b/hw/i386/intel_iommu.c
> > @@ -778,13 +778,21 @@ static int vtd_page_walk_one(IOMMUTLBEntry
> > *entry, int level,
> >      /* Update local IOVA mapped ranges */
> >      if (entry->perm) {
> >          if (mapped) {
> > -            /* Skip since we have already mapped this range */
> > -            trace_vtd_page_walk_one_skip_map(entry->iova, entry-
> > >addr_mask,
> > -                                             mapped->start, mapped->=
end);
> > -            return 0;
> > +            int ret;
> > +            /* Cache the write permission */
> > +            IOMMUAccessFlags flags =3D entry->perm;
> > +
> > +            /* UNMAP the old first then remap.  No need to touch IOV=
A tree */
> > +            entry->perm =3D IOMMU_NONE;
> > +            ret =3D hook_fn(entry, private);
> > +            if (ret) {
> > +                return ret;
> > +            }
> > +            entry->perm =3D flags;
> > +        } else {
> > +            it_tree_insert(as->iova_tree, entry->iova,
> > +                           entry->iova + entry->addr_mask);
> >          }
> > -        it_tree_insert(as->iova_tree, entry->iova,
> > -                       entry->iova + entry->addr_mask);
> >      } else {
> >          if (!mapped) {
> >              /* Skip since we didn't map this range at all */
> >=20
> > If we really think it necessary, I can squash this in, though this is
> > a bit ugly.  But I just want to confirm whether this would be anythin=
g
> > we want...
> >=20
>=20
> I didn=E2=80=99t look into your actual code yet. If others think above
> change is OK then it's definitely good as we conform to hardware
> behavior here. Otherwise if there is a way to detect such unusual=20
> usage and then adopt some action (say kill the VM), it's also fine=20
> since user knows he runs a bad OS which is not supported by=20
> Qemu. It's just not good if such situation is not handled, which=20
> leads to some undefined behavior which nobody knows the reason=20
> w/o hard debug into. :-)

Yeah, then let me do this. :)

Jason, would you be good with above change squashed?

Thanks,

--=20
Peter Xu
