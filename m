Received: from eggs.gnu.org ([2001:4830:134:3::10]:36060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d12Om-0005Xf-8y
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 23:04:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d12Oi-0008US-7N
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 23:04:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d12Oh-0008U5-VJ
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 23:04:44 -0400
Date: Thu, 20 Apr 2017 11:04:27 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170420030427.GA26087@pxdev.xzpeter.org>
References: <1492428730-13438-1-git-send-email-peterx@redhat.com>
	<1492428730-13438-8-git-send-email-peterx@redhat.com>
	<A2975661238FB949B60364EF0F2C257439054049@shsmsx102.ccr.corp.intel.com>
	<20170418045400.GC22226@pxdev.xzpeter.org>
	<A2975661238FB949B60364EF0F2C2574390540D1@shsmsx102.ccr.corp.intel.com>
	<20170418072717.GD22226@pxdev.xzpeter.org>
	<A2975661238FB949B60364EF0F2C257439054360@shsmsx102.ccr.corp.intel.com>
	<672ae592-e6ba-9152-b775-ec2bde931ef1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <672ae592-e6ba-9152-b775-ec2bde931ef1@intel.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 7/7] intel_iommu: support passthrough
 (PT)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, "Tian, Kevin" <kevin.tian@intel.com>

On Wed, Apr 19, 2017 at 03:27:52PM +0800, Lan Tianyu wrote:
> Hi All:
> 	Sorry for later response.
> On 2017=E5=B9=B404=E6=9C=8818=E6=97=A5 17:04, Liu, Yi L wrote:
> >> -----Original Message-----
> >> From: Peter Xu [mailto:peterx@redhat.com]
> >> Sent: Tuesday, April 18, 2017 3:27 PM
> >> To: Liu, Yi L <yi.l.liu@intel.com>
> >> Cc: qemu-devel@nongnu.org; Lan, Tianyu <tianyu.lan@intel.com>; Micha=
el S .
> >> Tsirkin <mst@redhat.com>; Jason Wang <jasowang@redhat.com>; Marcel
> >> Apfelbaum <marcel@redhat.com>; David Gibson <david@gibson.dropbear.i=
d.au>
> >> Subject: Re: [Qemu-devel] [PATCH v2 7/7] intel_iommu: support passth=
rough (PT)
> >>
> >> On Tue, Apr 18, 2017 at 06:02:44AM +0000, Liu, Yi L wrote:
> >>>>> Hi Peter,
> >>>>>
> >>>>> Skip address space switching is a good idea to support Passthru m=
ode.
> >>>>> However, without the address space, the vfio notifier would not b=
e
> >>>>> registered, thus vIOMMU emulator has no way to connect to host. I=
t
> >>>>> is no harm if there is only map/unmap notifier. But if we have
> >>>>> more notifiers other than map/unmap, it may be a problem.
> >>>>>
> >>>>> I think we need to reconsider it here.
> >>>>
> >>>> For now I think as switching is good to us in general. Could I kno=
w
> >>>> more context about this? Would it be okay to work on top of this i=
n the future?
> >>>>
> >>>
> >>> Let me explain. For vSVM enabling, it needs to add new notifier to
> >>> bind gPASID table to host. If an assigned device uses SVM in guest,=
 as
> >>> designed guest IOMMU driver would set "pt" for it. This is to make
> >>> sure the host second-level page table stores GPA->HPA mapping. So t=
hat
> >>> pIOMMU can do nested translation to achieve gVA->GPA GPA->HPA mappi=
ng.
> >>
> >> That should mean that in the guest it will only enable first level t=
ranslation, while in
> >> the host it'll be nested (first + second)? Then you should be trappi=
ng the guest
> >> extended context entry invalidation, then pass the PASID table point=
er downward to
> >> the host IOMMU, am I correct?
> >=20
> > exactly.
> >=20
> >>
> >>>
> >>> So the situation is if we want to keep GPA->HPA mapping, we should
> >>> skip address space switch, but the vfio listener would not know vIO=
MMU
> >>> is added, so no vfio notifier would be registered. But if we do the
> >>> switch, the GPA->HPA mapping is unmapped. And need another way to b=
uild the
> >> GPA->HPA mapping.
> >>
> >> If my understanding above is correct, current IOMMU notifier may not=
 satisfy your
> >> need. If you see the current notify interface, it's delivering IOMMU=
TLBEntry. I
> >> suspect it only suites for IOTLB notifications, but not if you want =
to pass some
> >> pointer (one GPA) downward somewhere.
> >=20
> > Yeah, you got it more than absolutely. One of my patch is to modify t=
he para to be
> > void * and let each notifiers to translate separately. I think it sho=
uld be a reasonable
> > change.
> >=20
> > Supposedly, I would send RFC for vSVM soon. We may talk more it at th=
at thread.

I suspect whether it'll be good that we hang everything under current
IOMMU notifiers... But sure I'm looking forward to your RFC. :)

> >=20
> >>>
> >>> I think we may have two choice here. Pls let me know your ideas.
> >>>
> >>> 1. skip the switch for "pt" mode, find other way to register vfio
> >>> notifiers. not sure if this is workable. Just a quick thought.
> >>>
> >>> 2. do the switch, and rebuild GPA->HPA mapping if device use "pt"
> >>> mode. For this option, I also have two way to build the GPA->HPA ma=
pping.
> >>> a) walk all the memory region sections in address_space_memory, and=
 build the
> >> mapping.
> >>> address_space_memory.dispatch->map.sections, sections stores all th=
e mapped
> >> sections.
> >>>
> >>> b) let guest iommu driver mimics a 1:1 mapping for the devices use
> >>> "pt" mode. in this way, the GPA->HPA mapping could be setup by walk=
ing
> >>> the guest SL page table. This is consistent with your vIOVA replay =
solution.
> >>
> >> I'll prefer (1). Reason explained above.
> >>
> >>>
> >>> Also I'm curious if Tianyu's fault report framework needs to regist=
er new notifiers.
> >>
> >> For Tianyu's case, I feel like we need other kind of notifier as wel=
l, but not the
> >> current IOTLB one. And, of course in this case it'll be in an revert=
ed direction, which
> >> is from device to vIOMMU.
> >>
> >> (I am thinking whether it's a good time now to let any PCI device ab=
le  to fetch its
> >> direct owner IOMMU object, then it can register anything  it want on=
to that object
> >> maybe?)
> >>
> > Hmmm, let's see Tianyu's comment as he's driving fault report. Let's =
keep in touch on
> > this Passthru-Mode enabling.
>=20
> In my previous RFC patchset of fault event reporting, I registered faul=
t
> notifier when there is a VFIO group attached to VFIO container and used
> the address space to check whether vIOMMU is added. The address space i=
s
> returned by vtd_host_dma_iommu(). vtd_find_add_as() initializes device'=
s
> IOMMU memory region and put it into device's address space as root
> memory region.
> Does this make sense?
>=20
> @@ -1103,6 +1132,14 @@ static int vfio_connect_container(VFIOGroup
> *group, AddressSpace *as,
>          goto listener_release_exit;
>      }
>=20
> +    if (memory_region_is_iommu(container->space->as->root)) {

I would suggest we don't play with as->root any more. After vtd vfio
series, this may not be true if passthrough mode is enabled (then the
root may be switched to an system memory alias). I don't know the best
way to check this, one alternative might be that we check whether
container->space->as =3D=3D system_memory(), it should be workable, but i=
n
a slightly hackish way.

Thanks,

> +        if (vfio_set_iommu_fault_notifier(container)) {
> +            error_setg_errno(errp, -ret,
> +                "Fail to set IOMMU fault notifier");
> +            goto listener_release_exit;
> +        }
> +    }
> +
>      container->initialized =3D true;
>=20
> --=20
> Best regards
> Tianyu Lan

--=20
Peter Xu
