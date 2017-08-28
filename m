Received: from eggs.gnu.org ([2001:4830:134:3::10]:59046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dmBXB-0008QU-H8
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 00:20:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dmBX8-00081u-Ag
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 00:20:21 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:34491)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1dmBX7-0007zp-Tf
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 00:20:18 -0400
Received: by mail-pg0-x242.google.com with SMTP id 63so5450050pgc.1
	for <qemu-devel@nongnu.org>; Sun, 27 Aug 2017 21:20:16 -0700 (PDT)
References: <20170720072231.35054-1-aik@ozlabs.ru>
	<20170720072231.35054-3-aik@ozlabs.ru>
	<20170825062153.GF2772@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <477eff2f-42bf-585d-84a4-1b2e5554bf38@ozlabs.ru>
Date: Mon, 28 Aug 2017 14:20:09 +1000
MIME-Version: 1.0
In-Reply-To: <20170825062153.GF2772@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="up00IW0NVjOGkms4bxs9vv71V5s7AnJeg"
Subject: Re: [Qemu-devel] [PATCH qemu v4 2/3] vfio/spapr: Add a notifier for
 PPC64 HV/PR KVM about new group attached to LIOBN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--up00IW0NVjOGkms4bxs9vv71V5s7AnJeg
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>
Message-ID: <477eff2f-42bf-585d-84a4-1b2e5554bf38@ozlabs.ru>
Subject: Re: [PATCH qemu v4 2/3] vfio/spapr: Add a notifier for PPC64 HV/PR
 KVM about new group attached to LIOBN
References: <20170720072231.35054-1-aik@ozlabs.ru>
 <20170720072231.35054-3-aik@ozlabs.ru>
 <20170825062153.GF2772@umbus.fritz.box>
In-Reply-To: <20170825062153.GF2772@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25/08/17 16:21, David Gibson wrote:
> On Thu, Jul 20, 2017 at 05:22:30PM +1000, Alexey Kardashevskiy wrote:
>> This implements a notification for a new IOMMU group attached to
>> sPAPR's logical IO bus (LIOBN) to enable in-kernel TCE acceleration.
>>
>> This extends the TYPE_SPAPR_IOMMU_MEMORY_REGION class with a get_fd()
>> callback which returns KVM fd associated with LIOBN, the notifier uses=
 it
>> to establish link between LIOBN and IOMMU group in the KVM.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>
>> The practical reason for adding get_fd() as a callback is avoiding sta=
tic
>> linking to spapt_tce_get_fd(): hw/vfio/spapr.c compiles when
>> CONFIG_SOFTMMU=3Dy to avoid multiple "ifdef PSERIES"'s in the rest
>> of VFIO code but hw/ppc/spapr_iommu.c (where spapt_tce_get_fd() beside=
s)
>> compiles only when CONFIG_PSERIES=3Dy.
>=20
> Ok.  Nonetheless I don't think the get_fd() method is a good idea.
> First, it's basically an abstraction violation, exposing the region's
> internal fd.  Second, it's a method which only plausibly has one
> implementation which is rarely sensible.
>=20
> What this comes down to is that the guest IOMMU mechanism needs
> information about host vfio groups mapped - for an optimization in
> this case.
>=20
> So what would make sense to me is to put an "add_vfio_group" method
> into IOMMUMemoryRegionClass (or even MemoryRegionClass).  In most
> cases that will be NULL (=3D=3D no-op).  For the spapr IOMMU region, it=

> will (attempt to) connect the host group to the guest liobn.


Like this?

IOMMUMemoryRegionClass::add_vfio_group_kvm(int kvm_device_fd, int groupfd=
);

It is just cleaner to keep kvm_device_fd and its ioclts() in the same pla=
ce
but ok.


>=20
>> ---
>>  include/hw/ppc/spapr.h        | 15 +++++++++++++++
>>  include/hw/vfio/vfio-common.h |  2 ++
>>  hw/ppc/spapr_iommu.c          | 10 ++++++++++
>>  hw/vfio/common.c              | 10 ++++++++++
>>  hw/vfio/spapr.c               | 39 ++++++++++++++++++++++++++++++++++=
+++++
>>  hw/vfio/trace-events          |  1 +
>>  6 files changed, 77 insertions(+)
>>
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index 2a303a705c..c1d37e6356 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -591,6 +591,7 @@ void spapr_load_rtas(sPAPRMachineState *spapr, voi=
d *fdt, hwaddr addr);
>>  #define RTAS_EVENT_SCAN_RATE    1
>> =20
>>  typedef struct sPAPRTCETable sPAPRTCETable;
>> +typedef struct sPAPRIOMMUMemoryRegionClass sPAPRIOMMUMemoryRegionClas=
s;
>> =20
>>  #define TYPE_SPAPR_TCE_TABLE "spapr-tce-table"
>>  #define SPAPR_TCE_TABLE(obj) \
>> @@ -599,6 +600,12 @@ typedef struct sPAPRTCETable sPAPRTCETable;
>>  #define TYPE_SPAPR_IOMMU_MEMORY_REGION "spapr-iommu-memory-region"
>>  #define SPAPR_IOMMU_MEMORY_REGION(obj) \
>>          OBJECT_CHECK(IOMMUMemoryRegion, (obj), TYPE_SPAPR_IOMMU_MEMOR=
Y_REGION)
>> +#define SPAPR_IOMMU_MEMORY_REGION_GET_CLASS(obj) \
>> +        OBJECT_GET_CLASS(sPAPRIOMMUMemoryRegionClass, obj, \
>> +                         TYPE_SPAPR_IOMMU_MEMORY_REGION)
>> +#define SPAPR_IOMMU_MEMORY_REGION_CLASS(klass) \
>> +        OBJECT_CLASS_CHECK(sPAPRIOMMUMemoryRegionClass, klass, \
>> +                           TYPE_SPAPR_IOMMU_MEMORY_REGION)
>> =20
>>  struct sPAPRTCETable {
>>      DeviceState parent;
>> @@ -618,6 +625,14 @@ struct sPAPRTCETable {
>>      QLIST_ENTRY(sPAPRTCETable) list;
>>  };
>> =20
>> +struct sPAPRIOMMUMemoryRegionClass {
>> +    /* private */
>> +    IOMMUMemoryRegionClass parent_class;
>> +
>> +    /* public */
>> +    int (*get_fd)(IOMMUMemoryRegion *iommu_mr);
>> +};
>> +
>>  sPAPRTCETable *spapr_tce_find_by_liobn(target_ulong liobn);
>=20
> To make sure I'm understanding correctly: the MR subclass here is
> representing a guest-side property, yes?  It means that on the guest
> side the IOMMU mappings are managed by the PAPR {GET,PUT}_TCE
> interface.

I do not understand the question, sorry. MR is a QEMU thing, only QEMU
devices use these MRs as MRs.


>>  struct sPAPREventLogEntry {
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-comm=
on.h
>> index f3a2ac9fee..d245d3cecc 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -177,6 +177,8 @@ extern const MemoryListener vfio_prereg_listener;
>>  int vfio_spapr_create_window(VFIOContainer *container,
>>                               MemoryRegionSection *section,
>>                               hwaddr *pgsize);
>> +int vfio_spapr_notify_kvm(int vfio_kvm_device_fd, int groupfd,
>> +                          IOMMUMemoryRegion *iommumr);
>>  int vfio_spapr_remove_window(VFIOContainer *container,
>>                               hwaddr offset_within_address_space);
>> =20
>> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
>> index 307dc3021e..82fca61a75 100644
>> --- a/hw/ppc/spapr_iommu.c
>> +++ b/hw/ppc/spapr_iommu.c
>> @@ -171,6 +171,13 @@ static void spapr_tce_notify_flag_changed(IOMMUMe=
moryRegion *iommu,
>>      }
>>  }
>> =20
>> +static int spapr_tce_get_fd(IOMMUMemoryRegion *iommu_mr)
>> +{
>> +    sPAPRTCETable *tcet =3D container_of(iommu_mr, sPAPRTCETable, iom=
mu);
>> +
>> +    return tcet->fd;
>=20
> Does this have a well defined value if there's no KVM?


It is -1 in TCG, any other value is undefined.


>=20
>> +}
>> +
>>  static int spapr_tce_table_post_load(void *opaque, int version_id)
>>  {
>>      sPAPRTCETable *tcet =3D SPAPR_TCE_TABLE(opaque);
>> @@ -631,16 +638,19 @@ static TypeInfo spapr_tce_table_info =3D {
>>  static void spapr_iommu_memory_region_class_init(ObjectClass *klass, =
void *data)
>>  {
>>      IOMMUMemoryRegionClass *imrc =3D IOMMU_MEMORY_REGION_CLASS(klass)=
;
>> +    sPAPRIOMMUMemoryRegionClass *simrc =3D SPAPR_IOMMU_MEMORY_REGION_=
CLASS(klass);
>> =20
>>      imrc->translate =3D spapr_tce_translate_iommu;
>>      imrc->get_min_page_size =3D spapr_tce_get_min_page_size;
>>      imrc->notify_flag_changed =3D spapr_tce_notify_flag_changed;
>> +    simrc->get_fd =3D spapr_tce_get_fd;
>>  }
>> =20
>>  static const TypeInfo spapr_iommu_memory_region_info =3D {
>>      .parent =3D TYPE_IOMMU_MEMORY_REGION,
>>      .name =3D TYPE_SPAPR_IOMMU_MEMORY_REGION,
>>      .class_init =3D spapr_iommu_memory_region_class_init,
>> +    .class_size =3D sizeof(sPAPRIOMMUMemoryRegionClass),
>>  };
>> =20
>>  static void register_types(void)
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 7b2924c0ef..92f1f88ae8 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -454,6 +454,16 @@ static void vfio_listener_region_add(MemoryListen=
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
>=20
> So, here you're informing the region of the groups when the region is
> mapped in.  But don't you similarly need to notify if a group is added
> to an existing address space?=20

It is either in VFIO for ages (forever? in vfio_connect_container()), or =
I
did not understand the question...


> And won't you also need notifications
> of groups/regions being removed?

Same comment. vfio_disconnect_container()?


>=20
>> +#endif
>>          vfio_host_win_add(container, section->offset_within_address_s=
pace,
>>                            section->offset_within_address_space +
>>                            int128_get64(section->size) - 1, pgsize);
>> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
>> index 32fd6a9b54..2b9af75c03 100644
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
>> @@ -188,6 +192,41 @@ int vfio_spapr_create_window(VFIOContainer *conta=
iner,
>>      return 0;
>>  }
>> =20
>> +int vfio_spapr_notify_kvm(int vfio_kvm_device_fd, int groupfd,
>> +                          IOMMUMemoryRegion *iommu_mr)
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
>> +    IOMMUMemoryRegion *spapr_iommu_mr =3D SPAPR_IOMMU_MEMORY_REGION(i=
ommu_mr);
>=20
> This will assert if you have a non-spapr guest IOMMU on a ppc host
> (e.g. emulating an x86 with VT-d under TCG).


Sure but this should not execute when TCG, hence "_kvm" in
"vfio_spapr_notify_kvm".


>=20
>> +    sPAPRIOMMUMemoryRegionClass *simrc =3D
>> +            SPAPR_IOMMU_MEMORY_REGION_GET_CLASS(spapr_iommu_mr);
>> +
>> +    if (!simrc->get_fd) {
>> +        error_report("vfio: No get_fd defined for IOMMU MR");
>> +        return -EFAULT;
>> +    }
>> +
>> +    param.tablefd =3D simrc->get_fd(spapr_iommu_mr);
>> +
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


--up00IW0NVjOGkms4bxs9vv71V5s7AnJeg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJZo5n5DhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5hcAP/3pr
50bEePXuca5GOi93v2KADK5BMNjUxi6shhXZ9XjhHijXQ88nsHi+BEnccvtmA3Am
zprq6U0HrONiUsutgwsCjPtDbW6qY3ECJ5o3VUneQMoLuPlG3Nkx3g9a5cKF0+tY
/xA2ozrOtKM/k7QDY9XsDcHonNtjiw/prCvA+bGKeO4Tw5ckwbx3oXh1OwI3n7Qd
jWMM72r+7fVzny5qBCDIEsds7nSSQvQIwsn+AEOHZfvHdxRghwlYABy8dKCiGd9t
W7BFwW7tYtPH/syoInntOY+8yGakJcEwkNIn3OfwO421TnPstmkenGcIKlWilwyL
jFEy4Szr+rUq9h2yFERN7C7nheoSQ2HNe7QEa0uyjBzq4oan1jnT7vMHqp33R6yy
xBeAKR1S/fqfbLZce/gLhnX0B6qiksry04fmDYhmgGnQuDGcm09SmMbSs15r/gyR
YH/804RRs550uz1y6q7Rxgs3nUo6keN1C3n9r+4ztvHslJath2vmwaPwmf9LCj4G
aqq0T869Q5oxRPQMG/fdwm6PpsiN9iLgnjPRnkfUtYaPwFmWwN4UnteMjwmUYAmC
naiaTmhgcggchC1AyUKWaUIAsbsDlqSOyrfcdROZMTJ3dSd5l+5x+OyCf8Fa1Z3a
Cmsz3CN8G+ZggTbHhKJZvm9F/taTvt2es5nmx8P5
=LDKF
-----END PGP SIGNATURE-----

--up00IW0NVjOGkms4bxs9vv71V5s7AnJeg--
