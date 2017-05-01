Received: from eggs.gnu.org ([2001:4830:134:3::10]:51065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1d5AKY-0000n8-JM
	for qemu-devel@nongnu.org; Mon, 01 May 2017 08:21:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1d5AKU-000599-Ja
	for qemu-devel@nongnu.org; Mon, 01 May 2017 08:21:30 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:34027)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1d5AKU-00058u-8b
	for qemu-devel@nongnu.org; Mon, 01 May 2017 08:21:26 -0400
Received: by mail-pf0-x242.google.com with SMTP id g23so27589325pfj.1
	for <qemu-devel@nongnu.org>; Mon, 01 May 2017 05:21:25 -0700 (PDT)
References: <20170401123741.38469-1-aik@ozlabs.ru>
	<20170401123741.38469-4-aik@ozlabs.ru>
	<20170403030122.GB10997@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <1fa0998d-6bbe-5bd7-88db-7f466c1f79c5@ozlabs.ru>
Date: Mon, 1 May 2017 22:21:18 +1000
MIME-Version: 1.0
In-Reply-To: <20170403030122.GB10997@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="t06OhFxB9Sig6sbx6OtxrFMqQPslKdduW"
Subject: Re: [Qemu-devel] [RFC PATCH qemu v3 3/4] vfio/spapr: Add a notifier
 for PPC64 HV/PR KVM about new group attached to LIOBN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--t06OhFxB9Sig6sbx6OtxrFMqQPslKdduW
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1fa0998d-6bbe-5bd7-88db-7f466c1f79c5@ozlabs.ru>
Subject: Re: [RFC PATCH qemu v3 3/4] vfio/spapr: Add a notifier for PPC64
 HV/PR KVM about new group attached to LIOBN
References: <20170401123741.38469-1-aik@ozlabs.ru>
 <20170401123741.38469-4-aik@ozlabs.ru>
 <20170403030122.GB10997@umbus.fritz.box>
In-Reply-To: <20170403030122.GB10997@umbus.fritz.box>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable

On 03/04/17 13:01, David Gibson wrote:
> On Sat, Apr 01, 2017 at 11:37:40PM +1100, Alexey Kardashevskiy wrote:
>> This implements a notification for a new IOMMU group attached to
>> sPAPR's logical IO bus (LIOBN) to enable in-kernel TCE acceleration.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>  include/hw/ppc/spapr.h        |  1 +
>>  include/hw/vfio/vfio-common.h |  2 ++
>>  hw/ppc/spapr_iommu.c          |  5 +++++
>>  hw/vfio/common.c              | 10 ++++++++++
>>  hw/vfio/spapr.c               | 31 +++++++++++++++++++++++++++++++
>>  hw/vfio/trace-events          |  1 +
>>  6 files changed, 50 insertions(+)
>>
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index 6997ed7e98..8a1b32f89a 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -617,6 +617,7 @@ void spapr_tce_table_enable(sPAPRTCETable *tcet,
>>                              uint32_t page_shift, uint64_t bus_offset,=

>>                              uint32_t nb_table);
>>  void spapr_tce_table_disable(sPAPRTCETable *tcet);
>> +int spapr_tce_get_fd(sPAPRTCETable *tcet);
>>  void spapr_tce_set_need_vfio(sPAPRTCETable *tcet, bool need_vfio);
>> =20
>>  MemoryRegion *spapr_tce_get_iommu(sPAPRTCETable *tcet);
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-comm=
on.h
>> index 7a4135ae6f..b99f4af96e 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -175,6 +175,8 @@ extern const MemoryListener vfio_prereg_listener;
>>  int vfio_spapr_create_window(VFIOContainer *container,
>>                               MemoryRegionSection *section,
>>                               hwaddr *pgsize);
>> +int vfio_spapr_notify_kvm(int vfio_kvm_device_fd, int groupfd,
>> +                          IOMMUMemoryRegion *iommumr);
>>  int vfio_spapr_remove_window(VFIOContainer *container,
>>                               hwaddr offset_within_address_space);
>> =20
>> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
>> index 5051110b9d..f7531a6408 100644
>> --- a/hw/ppc/spapr_iommu.c
>> +++ b/hw/ppc/spapr_iommu.c
>> @@ -171,6 +171,11 @@ static void spapr_tce_notify_flag_changed(IOMMUMe=
moryRegion *iommu,
>>      }
>>  }
>> =20
>> +int spapr_tce_get_fd(sPAPRTCETable *tcet)
>> +{
>> +    return tcet->fd;
>> +}
>> +
>=20
> I don't think this actually abstracts anything worthwhile.  The caller
> needs the sPAPRTCETable definition anyway to use container_of(), so it
> might as well just grab the field directly.

So far @fd has only been accesses from hw/ppc/spapr_iommu.c and I'd like =
to
keep it that way ("encapsulation"?).


>=20
>>  static int spapr_tce_table_post_load(void *opaque, int version_id)
>>  {
>>      sPAPRTCETable *tcet =3D SPAPR_TCE_TABLE(opaque);
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index e8188eb3d5..b94b29be15 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -440,6 +440,16 @@ static void vfio_listener_region_add(MemoryListen=
er *listener,
>>              goto fail;
>>          }
>> =20
>> +#ifdef CONFIG_KVM
>> +        if (kvm_enabled()) {
>> +            VFIOGroup *group;
>> +
>> +            QLIST_FOREACH(group, &container->group_list, container_ne=
xt) {
>> +                vfio_spapr_notify_kvm(vfio_kvm_device_fd, group->fd,
>> +                                      IOMMU_MEMORY_REGION(section->mr=
));
>> +            }
>> +        }
>> +#endif
>>          vfio_host_win_add(container, section->offset_within_address_s=
pace,
>>                            section->offset_within_address_space +
>>                            int128_get64(section->size) - 1, pgsize);
>> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
>> index 551870d46b..6410438e62 100644
>> --- a/hw/vfio/spapr.c
>> +++ b/hw/vfio/spapr.c
>> @@ -15,8 +15,12 @@
>> =20
>>  #include "hw/vfio/vfio-common.h"
>>  #include "hw/hw.h"
>> +#include "hw/ppc/spapr.h"
>>  #include "qemu/error-report.h"
>>  #include "trace.h"
>> +#ifdef CONFIG_KVM
>> +#include "linux/kvm.h"
>> +#endif
>> =20
>>  static bool vfio_prereg_listener_skipped_section(MemoryRegionSection =
*section)
>>  {
>> @@ -188,6 +192,33 @@ int vfio_spapr_create_window(VFIOContainer *conta=
iner,
>>      return 0;
>>  }
>> =20
>> +int vfio_spapr_notify_kvm(int vfio_kvm_device_fd, int groupfd,
>> +                          IOMMUMemoryRegion *iommumr)
>> +{
>> +#ifdef CONFIG_KVM
>> +    struct kvm_vfio_spapr_tce param =3D {
>> +        .groupfd =3D groupfd,
>> +    };
>> +    struct kvm_device_attr attr =3D {
>> +        .group =3D KVM_DEV_VFIO_GROUP,
>> +        .attr =3D KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE,
>> +        .addr =3D (uint64_t)(unsigned long)&param,
>> +    };
>> +    sPAPRTCETable *tcet =3D container_of(iommumr, sPAPRTCETable, iomm=
u);
>=20
> This isn't safe.  The caller has verified that the host backend IOMMU
> is sPAPR TCE, but you haven't verified that the *guest* IOMMU is TCE
> based.  I suspect other details would prevent a TCG x86 machine with
> VT-d running on a Power host from getting this far, but it's not good
> to rely on that.
>=20
> So, you need to explicitly verify that the guest IOMMU region really
> is a PAPR TCE region.  The obvious way would be to continue your
> QOMification and make sPAPRTCETable a subtype of IOMMUMemoryRegion,
> rather than just including it by composition.

sPAPRTCETable is a device now, with 2 memory regions - one for entire 64b=
it
space and different sPAPRTCETable root MRs overlap, another one is the
actual IOMMU MR - may be QOM just this one, not the entire sPAPRTCETable
thingy?




>=20
>> +
>> +    param.tablefd =3D spapr_tce_get_fd(tcet);
>> +    if (param.tablefd !=3D -1) {
>> +        if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
>> +            error_report("vfio: failed to setup fd %d for a group wit=
h fd %d: %s",
>> +                         param.tablefd, param.groupfd, strerror(errno=
));
>> +            return -errno;
>> +        }
>> +    }
>> +    trace_vfio_spapr_notify_kvm(groupfd, param.tablefd);
>> +#endif
>> +    return 0;
>> +}
>> +
>>  int vfio_spapr_remove_window(VFIOContainer *container,
>>                               hwaddr offset_within_address_space)
>>  {
>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>> index 2561c6d31a..084a92f7c2 100644
>> --- a/hw/vfio/trace-events
>> +++ b/hw/vfio/trace-events
>> @@ -123,3 +123,4 @@ vfio_prereg_register(uint64_t va, uint64_t size, i=
nt ret) "va=3D%"PRIx64" size=3D%"P
>>  vfio_prereg_unregister(uint64_t va, uint64_t size, int ret) "va=3D%"P=
RIx64" size=3D%"PRIx64" ret=3D%d"
>>  vfio_spapr_create_window(int ps, uint64_t ws, uint64_t off) "pageshif=
t=3D0x%x winsize=3D0x%"PRIx64" offset=3D0x%"PRIx64
>>  vfio_spapr_remove_window(uint64_t off) "offset=3D%"PRIx64
>> +vfio_spapr_notify_kvm(int groupfd, int tablefd) "Attached groupfd %d =
to liobn fd %d"
>=20


--=20
Alexey


--t06OhFxB9Sig6sbx6OtxrFMqQPslKdduW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJZByg+DhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5QyQP/jjC
aKONdmGijXeexPOJsGWJFL2qQgI7GFAVW2JGIWdUCvsuYKTrsaki5xYoJSHsnbIO
wSPoAChN7izsvYnlN/S5DAkZddi89+aXbJdM4vLop3iu4LxgspCYAJxTrXdvs26a
q/Q6k9JPwlXpqKvcj02Uo4/8YVyVH809PILppaNuME87EWSLeSBnqY8DLnPGOMDr
YDjMxbePJSj4rGkOC3MeepbaZTaRX0XyLxqs4BbBjROWL1NZK8tiL1+adxuLs30J
KOQWpvzhOBia/coxQ/JzYiygG+ZqAEmvMs0wBO+kO6mLk+dElNAfq9SmSF8SbuI5
eq95b0JBKfaKFXB+WTmPB9sqqGgztOLm/Vm+lXfV2JEnmOf3vrpra3k0RjbDk682
IcKnPlO6fOh0uOmmO6UCB4A5NzXetrST2RUtnI3rK75kaQ/D0RSyHFhTLq8+W8iB
i6Rj9gwqYQd3czAHO1p2lJOgXcXzC70CbmWOrFqA/Nwydhnh/OERPqXrnngUtc5X
vlGsWFazjEiqyCNSVlDKbU3+RpTzloa5wqlmX+esYgeKognFXa3CQX79AxSjxjZZ
mU6JId+z6UiekWnH50nCw0ij8YO6zN81+XkcmBE29oJioHjJUK6I0pGG+2YATxtc
eHtdLkfw9vUx1R4BeVMLH3m9TPY+BXSyJLbCLdDN
=AvwV
-----END PGP SIGNATURE-----

--t06OhFxB9Sig6sbx6OtxrFMqQPslKdduW--
