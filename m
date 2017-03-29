Received: from eggs.gnu.org ([2001:4830:134:3::10]:52014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ct5qx-00083x-Mi
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 01:09:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ct5qt-0000Ps-7n
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 01:09:03 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:35901)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1ct5qs-0000Pd-R7
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 01:08:59 -0400
Received: by mail-pg0-x243.google.com with SMTP id 81so1157983pgh.3
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 22:08:58 -0700 (PDT)
References: <20170328090530.20052-1-aik@ozlabs.ru>
	<20170328090530.20052-2-aik@ozlabs.ru>
	<20170328114829.25656146@t450s.home>
	<20170329033542.GP21068@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <67a98eb4-0411-c5f7-0057-1a88342a6655@ozlabs.ru>
Date: Wed, 29 Mar 2017 16:08:52 +1100
MIME-Version: 1.0
In-Reply-To: <20170329033542.GP21068@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wFn5fOQ4FU3GflOTqxl39BEUqvl3JfJdD"
Subject: Re: [Qemu-devel] [RFC PATCH qemu 1/3] memory: Add get_fd() hook for
 IOMMU MR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wFn5fOQ4FU3GflOTqxl39BEUqvl3JfJdD
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Message-ID: <67a98eb4-0411-c5f7-0057-1a88342a6655@ozlabs.ru>
Subject: Re: [RFC PATCH qemu 1/3] memory: Add get_fd() hook for IOMMU MR
References: <20170328090530.20052-1-aik@ozlabs.ru>
 <20170328090530.20052-2-aik@ozlabs.ru> <20170328114829.25656146@t450s.home>
 <20170329033542.GP21068@umbus.fritz.box>
In-Reply-To: <20170329033542.GP21068@umbus.fritz.box>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable

On 29/03/17 14:35, David Gibson wrote:
> On Tue, Mar 28, 2017 at 11:48:29AM -0600, Alex Williamson wrote:
>> On Tue, 28 Mar 2017 20:05:28 +1100
>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>
>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>> ---
>>>  include/exec/memory.h | 2 ++
>>>  hw/ppc/spapr_iommu.c  | 8 ++++++++
>>>  2 files changed, 10 insertions(+)
>>>
>>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>>> index e39256ad03..925c10b35b 100644
>>> --- a/include/exec/memory.h
>>> +++ b/include/exec/memory.h
>>> @@ -174,6 +174,8 @@ struct MemoryRegionIOMMUOps {
>>>      void (*notify_flag_changed)(MemoryRegion *iommu,
>>>                                  IOMMUNotifierFlag old_flags,
>>>                                  IOMMUNotifierFlag new_flags);
>>> +    /* Returns a kernel fd for IOMMU */
>>> +    int (*get_fd)(MemoryRegion *iommu);
>>
>> What if we used this as a prototype:
>>
>> int (*get_fd)(IOMMUFdType type, MemoryRegion *iommu);
>>
>> And then we defined:
>>
>> typedef enum {
>>     SPAPR_IOMMU_TABLE_FD =3D 0,
>> } IOMMUFdType;
>=20
> Are we expecting any new types of fd?  Maybe it would be simpler just
> to name this spapr_tce_fd() or something more specific, and only
> generalize if we really need it for another fd type.


So far we managed to keep VFIO and sPAPR-IOMMU relatively separate - they=

do not include each others headers and interact via memory regions and
kernel uapi interface. The only direct connection between VFIO and sPAPR =
at
all is vfio_eeh_as_ok/vfio_eeh_as_op which is rather workaround. I like
this separation tbh.



>=20
>>
>> Such that you're actually asking the IOMMUOps for a specific type of F=
D
>> and it either has it or not, so the caller doesn't need to assume what=

>> it is they get back.
>>
>> Furthermore, add:
>>
>> int memory_region_iommu_get_fd(IOMMUFdType type, MemoryRegion *mr)
>> {
>>     assert(memory_region_is_iommu(mr));
>>
>>     if (mr->iommu_ops && mr->iommu_ops->get_fd) {
>>         return mr->iommu_ops->get_fd(type, mr);
>>     }
>>
>>     return -1;
>> }
>>
>>>  };
>>>
>>
>> This should be two patches, patch 1 above, patch 2 below
>>  =20
>>>  typedef struct CoalescedMemoryRange CoalescedMemoryRange;
>>> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
>>> index 9e30e148d6..b61c8f053e 100644
>>> --- a/hw/ppc/spapr_iommu.c
>>> +++ b/hw/ppc/spapr_iommu.c
>>> @@ -170,6 +170,13 @@ static void spapr_tce_notify_flag_changed(Memory=
Region *iommu,
>>>      }
>>>  }
>>> =20
>>> +static int spapr_tce_get_fd(MemoryRegion *iommu)
>>> +{
>>> +    sPAPRTCETable *tcet =3D container_of(iommu, sPAPRTCETable, iommu=
);
>>> +
>>> +    return tcet->fd;
>>
>>
>> This would then be:
>>
>>     return type =3D=3D SPAPR_IOMMU_TABLE_FD ? tcet->fd : -1;
>>
>>> +}
>>> +
>>>  static int spapr_tce_table_post_load(void *opaque, int version_id)
>>>  {
>>>      sPAPRTCETable *tcet =3D SPAPR_TCE_TABLE(opaque);
>>> @@ -251,6 +258,7 @@ static MemoryRegionIOMMUOps spapr_iommu_ops =3D {=

>>>      .translate =3D spapr_tce_translate_iommu,
>>>      .get_min_page_size =3D spapr_tce_get_min_page_size,
>>>      .notify_flag_changed =3D spapr_tce_notify_flag_changed,
>>> +    .get_fd =3D spapr_tce_get_fd,
>>>  };
>>> =20
>>>  static int spapr_tce_table_realize(DeviceState *dev)
>>
>=20


--=20
Alexey


--wFn5fOQ4FU3GflOTqxl39BEUqvl3JfJdD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJY20FkDhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5rmsP/iJS
lrxm+nqPoglGA022HHbjMYRBOoujfC7acHRirylazG7hXi3kZJUY3BEYLShowsuX
ffdjt3u+V6OcsKFa3MLxgESM7ZGAnCMpLYqAK5vGpk/kTsASZ7VqBI4BlUqW6UhF
mSv+nv9Xjkwy/D/uKwJAlA1W3o8nVs8yQ+aEKFeg0U946CI2yPGWQDjhzEIlN6Bb
wHPzL4ddNxCIWC1WbYWCPKd0CH+h14JWRdbwkQHgQkgaMLOuv9okw+P9XUSBzVtt
zntxNx9x1HoKEqYNEysLWacJKk+DMjFiiuAd4+V3K0b3N3MkgZnM/XkXLYcQboWQ
N4ZNK4W/ztufXQOPr8WnGVI1IrkHBqKfr8wrJN6oNckHHx9mBnhEk62wmw0g52R4
FTpBc/yOsDMs55uXy4zx1zrjjQ5pV/DO2m9qZfGA2NlWluM69uXCxzJFcpPZBBmw
K3hIz09z9XJjql7RYMcoAyqgLvTN+t6C+Kg8Fp9u+odcWIJvLIBt1c7B7JVr878f
RW5a/mk65NHCWZMiUKXuhezbu1kv8C+VFoZhaJZx/nSuaOAn2qfeitmTBf1q78YI
OM7K0Zry4DGJFlH7AmKaTmBLma+97JfSv7k19Z6Ic+UyP5vyn+0vw/CeiSrhmfYB
mDP/oYNPhLMscg7KSLmQkeOqKcvBacVKup1tjugv
=gSaM
-----END PGP SIGNATURE-----

--wFn5fOQ4FU3GflOTqxl39BEUqvl3JfJdD--
