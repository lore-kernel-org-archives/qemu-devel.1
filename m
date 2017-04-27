Received: from eggs.gnu.org ([2001:4830:134:3::10]:38282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d3h1U-0004Rv-Vv
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 06:51:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d3h1R-0000Ou-SH
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 06:51:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d3h1R-0000Oj-JI
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 06:51:41 -0400
Date: Thu, 27 Apr 2017 18:51:32 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170427105132.GA19917@pxdev.xzpeter.org>
References: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
	<1493201210-14357-13-git-send-email-yi.l.liu@linux.intel.com>
	<0f2966cf-4e5a-a2cc-5eb3-7e7d4f62bb85@redhat.com>
	<20170427023719.GA14925@sky-dev>
	<20170427061427.GA1542@pxdev.xzpeter.org>
	<20170427102537.GE14925@sky-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170427102537.GE14925@sky-dev>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 12/20] Memory: Add func to fire
 pasidt_bind notifier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, ashok.raj@intel.com, kvm@vger.kernel.org, jean-philippe.brucker@arm.com, jasowang@redhat.com, qemu-devel@nongnu.org, iommu@lists.linux-foundation.org, alex.williamson@redhat.com, jacob.jun.pan@intel.com, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Apr 27, 2017 at 06:25:37PM +0800, Liu, Yi L wrote:
> On Thu, Apr 27, 2017 at 02:14:27PM +0800, Peter Xu wrote:
> > On Thu, Apr 27, 2017 at 10:37:19AM +0800, Liu, Yi L wrote:
> > > On Wed, Apr 26, 2017 at 03:50:16PM +0200, Paolo Bonzini wrote:
> > > >=20
> > > >=20
> > > > On 26/04/2017 12:06, Liu, Yi L wrote:
> > > > > +void memory_region_notify_iommu_svm_bind(MemoryRegion *mr,
> > > > > +                                         void *data)
> > > > > +{
> > > > > +    IOMMUNotifier *iommu_notifier;
> > > > > +    IOMMUNotifierFlag request_flags;
> > > > > +
> > > > > +    assert(memory_region_is_iommu(mr));
> > > > > +
> > > > > +    /*TODO: support other bind requests with smaller gran,
> > > > > +     * e.g. bind signle pasid entry
> > > > > +     */
> > > > > +    request_flags =3D IOMMU_NOTIFIER_SVM_PASIDT_BIND;
> > > > > +
> > > > > +    QLIST_FOREACH(iommu_notifier, &mr->iommu_notify, node) {
> > > > > +        if (iommu_notifier->notifier_flags & request_flags) {
> > > > > +            iommu_notifier->notify(iommu_notifier, data);
> > > > > +            break;
> > > > > +        }
> > > > > +    }
> > > >=20
> > > > Peter,
> > > >=20
> > > > should this reuse ->notify, or should it be different function po=
inter
> > > > in IOMMUNotifier?
> > >=20
> > > Hi Paolo,
> > >=20
> > > Thx for your review.
> > >=20
> > > I think it should be =E2=80=9C->notify=E2=80=9D here. In this patch=
set, the new notifier
> > > is registered with the existing notifier registration API. So the a=
ll the
> > > notifiers are in the mr->iommu_notify list. And notifiers are label=
ed
> > > by notify flag, so it is able to differentiate the IOMMUNotifier no=
des.
> > > When the flag meets, trigger it by =E2=80=9C->notify=E2=80=9D. The =
diagram below shows
> > > my understanding , wish it helps to make me understood.
> > >=20
> > > VFIOContainer
> > >        |
> > >        giommu_list(VFIOGuestIOMMU)
> > >                 \
> > >                  VFIOGuestIOMMU1 ->   VFIOGuestIOMMU2 -> VFIOGuestI=
OMMU3 ...
> > >                     |                     |                 |
> > > mr->iommu_notify: IOMMUNotifier   ->    IOMMUNotifier  ->  IOMMUNot=
ifier
> > >                   (Flag:MAP/UNMAP)     (Flag:SVM bind)  (Flag:tlb i=
nvalidate)
> > >=20
> > >=20
> > > Actually, compared with the MAP/UNMAP notifier, the newly added not=
ifier has
> > > no start/end check, and there may be other types of bind notfier fl=
ag in
> > > future, so I added a separate fire func for SVM bind notifier.
> >=20
> > I agree with Paolo that this interface might not be the suitable plac=
e
> > for the SVM notifiers (just like what I worried about in previous
> > discussions).
> >=20
> > The biggest problem is that, if you see current notifier mechanism,
> > it's per-memory-region. However iiuc your messages should be
> > per-iommu, or say, per translation unit.
>=20
> Hi Peter,
>=20
> yes, you're right. the newly added notifier is per-iommu.
>=20
> > While, for each iommu, there
> > can be more than one memory regions (ppc can be an example). When
> > there are more than one MRs binded to the same iommu unit, which
> > memory region should you register to? Any one of them, or all?
>=20
> Honestly, I'm not expert on ppc. According to the current code,
> I can only find one MR initialized with memory_region_init_iommu()
> in spapr_tce_table_realize(). So to better get your point, let me
> check. Do you mean there may be multiple of iommu MRs behind a iommu?

I am not either. :)

But yes, that's what I mean. At least that's how I understand it.

>=20
> I admit it must be considered if there are multiple iommu MRs. I may
> choose to register for one of them since the notifier is per-iommu as
> you've pointed. Then vIOMMU emulator need to trigger the notifier with
> the correct MR. Not sure if ppc vIOMMU is fine with it.
>=20
> > So my conclusion is, it just has nothing to do with memory regions...
> >
> > Instead of a different function pointer in IOMMUNotifer, IMHO we can
> > even move a step further, to isolate IOTLB notifications (targeted at
> > memory regions and with start/end ranges) out of SVM/other
> > notifications, since they are different in general. So we basically
> > need two notification mechanism:
> >=20
> > - one for memory regions, currently what I can see is IOTLB
> >   notifications
> >=20
> > - one for translation units, currently I see all the rest of
> >   notifications needed in virt-svm in this category
> >=20
> > Maybe some RFC patches would be good to show what I mean... I'll see
> > whether I can prepare some.
>=20
> I agree that it would be helpful to split the two kinds of notifiers. I
> marked it as a FIXME in patch 0006 of this series. Just saw your RFC pa=
tch
> for common IOMMUObject. Thx for your work, would try to review it.

Thanks, looking forward to your review comments.

>=20
> Besides the notifier registration, pls also help to review the SVM
> virtualization itself. Would be glad to know your comments.

Yes. It's on my list. Thanks,

--=20
Peter Xu
