Received: from eggs.gnu.org ([2001:4830:134:3::10]:54991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d3gMr-0003WD-Tm
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 06:09:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d3gMn-0006oL-01
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 06:09:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d3gMm-0006o3-NI
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 06:09:40 -0400
Date: Thu, 27 Apr 2017 18:09:29 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170427100929.GC1542@pxdev.xzpeter.org>
References: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
	<1493201210-14357-13-git-send-email-yi.l.liu@linux.intel.com>
	<0f2966cf-4e5a-a2cc-5eb3-7e7d4f62bb85@redhat.com>
	<20170427023719.GA14925@sky-dev>
	<20170427061427.GA1542@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170427061427.GA1542@pxdev.xzpeter.org>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, alex.williamson@redhat.com, tianyu.lan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, ashok.raj@intel.com, kvm@vger.kernel.org, jean-philippe.brucker@arm.com, jasowang@redhat.com, iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com

On Thu, Apr 27, 2017 at 02:14:27PM +0800, Peter Xu wrote:
> On Thu, Apr 27, 2017 at 10:37:19AM +0800, Liu, Yi L wrote:
> > On Wed, Apr 26, 2017 at 03:50:16PM +0200, Paolo Bonzini wrote:
> > >=20
> > >=20
> > > On 26/04/2017 12:06, Liu, Yi L wrote:
> > > > +void memory_region_notify_iommu_svm_bind(MemoryRegion *mr,
> > > > +                                         void *data)
> > > > +{
> > > > +    IOMMUNotifier *iommu_notifier;
> > > > +    IOMMUNotifierFlag request_flags;
> > > > +
> > > > +    assert(memory_region_is_iommu(mr));
> > > > +
> > > > +    /*TODO: support other bind requests with smaller gran,
> > > > +     * e.g. bind signle pasid entry
> > > > +     */
> > > > +    request_flags =3D IOMMU_NOTIFIER_SVM_PASIDT_BIND;
> > > > +
> > > > +    QLIST_FOREACH(iommu_notifier, &mr->iommu_notify, node) {
> > > > +        if (iommu_notifier->notifier_flags & request_flags) {
> > > > +            iommu_notifier->notify(iommu_notifier, data);
> > > > +            break;
> > > > +        }
> > > > +    }
> > >=20
> > > Peter,
> > >=20
> > > should this reuse ->notify, or should it be different function poin=
ter
> > > in IOMMUNotifier?
> >=20
> > Hi Paolo,
> >=20
> > Thx for your review.
> >=20
> > I think it should be =E2=80=9C->notify=E2=80=9D here. In this patchse=
t, the new notifier
> > is registered with the existing notifier registration API. So the all=
 the
> > notifiers are in the mr->iommu_notify list. And notifiers are labeled
> > by notify flag, so it is able to differentiate the IOMMUNotifier node=
s.
> > When the flag meets, trigger it by =E2=80=9C->notify=E2=80=9D. The di=
agram below shows
> > my understanding , wish it helps to make me understood.
> >=20
> > VFIOContainer
> >        |
> >        giommu_list(VFIOGuestIOMMU)
> >                 \
> >                  VFIOGuestIOMMU1 ->   VFIOGuestIOMMU2 -> VFIOGuestIOM=
MU3 ...
> >                     |                     |                 |
> > mr->iommu_notify: IOMMUNotifier   ->    IOMMUNotifier  ->  IOMMUNotif=
ier
> >                   (Flag:MAP/UNMAP)     (Flag:SVM bind)  (Flag:tlb inv=
alidate)
> >=20
> >=20
> > Actually, compared with the MAP/UNMAP notifier, the newly added notif=
ier has
> > no start/end check, and there may be other types of bind notfier flag=
 in
> > future, so I added a separate fire func for SVM bind notifier.
>=20
> I agree with Paolo that this interface might not be the suitable place
> for the SVM notifiers (just like what I worried about in previous
> discussions).
>=20
> The biggest problem is that, if you see current notifier mechanism,
> it's per-memory-region. However iiuc your messages should be
> per-iommu, or say, per translation unit. While, for each iommu, there
> can be more than one memory regions (ppc can be an example). When
> there are more than one MRs binded to the same iommu unit, which
> memory region should you register to? Any one of them, or all?
>=20
> So my conclusion is, it just has nothing to do with memory regions...
>=20
> Instead of a different function pointer in IOMMUNotifer, IMHO we can
> even move a step further, to isolate IOTLB notifications (targeted at
> memory regions and with start/end ranges) out of SVM/other
> notifications, since they are different in general. So we basically
> need two notification mechanism:
>=20
> - one for memory regions, currently what I can see is IOTLB
>   notifications
>=20
> - one for translation units, currently I see all the rest of
>   notifications needed in virt-svm in this category
>=20
> Maybe some RFC patches would be good to show what I mean... I'll see
> whether I can prepare some.

Here it is (on qemu-devel):

[RFC PATCH 0/8] IOMMU: introduce common IOMMUObject

Thanks,

--=20
Peter Xu
