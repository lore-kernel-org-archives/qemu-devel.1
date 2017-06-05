Received: from eggs.gnu.org ([2001:4830:134:3::10]:37143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dHuMd-000441-Te
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:56:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dHuMa-0000A6-S0
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:56:19 -0400
Received: from us-smtp-delivery-101.mimecast.com ([216.205.24.101]:29214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1dHuMa-00009Q-HU
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:56:16 -0400
From: Felipe Franciosi <felipe@nutanix.com>
Date: Mon, 5 Jun 2017 15:56:10 +0000
Message-ID: <BACDAB45-08B3-4726-9106-A8650A7A692B@nutanix.com>
References: <1496303518-25638-1-git-send-email-felipe@nutanix.com>
	<20170603115444.GT13397@umbus.fritz.box>
In-Reply-To: <20170603115444.GT13397@umbus.fritz.box>
Content-Language: en-US
Content-ID: <40027F75AEC18A41A2A9E5344828BE7C@namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] spapr: Allow boot from vhost-*-scsi
 backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Felipe Franciosi <felipe@nutanix.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Mike Cui <cui@nutanix.com>


> On 3 Jun 2017, at 12:54, David Gibson <david@gibson.dropbear.id.au> wrote=
:
>=20
> On Thu, Jun 01, 2017 at 08:51:58AM +0100, Felipe Franciosi wrote:
>> This makes VMs bootable on spapr when using vhost-*-scsi.
>=20
> This commit message needs more information: what previously prevented
> vhost-*-scsi from working?

Fair point. I elaborated on the commit message and sent a v2.

Thanks,
F.

>=20
>> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
>> Signed-off-by: Mike Cui <cui@nutanix.com>
>> ---
>> hw/ppc/spapr.c | 8 ++++++++
>> 1 file changed, 8 insertions(+)
>>=20
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index ab3aab1..1c87886 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -57,6 +57,7 @@
>> #include "hw/pci/pci.h"
>> #include "hw/scsi/scsi.h"
>> #include "hw/virtio/virtio-scsi.h"
>> +#include "hw/virtio/vhost-scsi-common.h"
>>=20
>> #include "exec/address-spaces.h"
>> #include "hw/usb.h"
>> @@ -2388,6 +2389,7 @@ static char *spapr_get_fw_dev_path(FWPathProvider =
*p, BusState *bus,
>>     ((type *)object_dynamic_cast(OBJECT(obj), (name)))
>>     SCSIDevice *d =3D CAST(SCSIDevice,  dev, TYPE_SCSI_DEVICE);
>>     sPAPRPHBState *phb =3D CAST(sPAPRPHBState, dev, TYPE_SPAPR_PCI_HOST_=
BRIDGE);
>> +    VHostSCSICommon *vsc =3D CAST(VHostSCSICommon, dev, TYPE_VHOST_SCSI=
_COMMON);
>>=20
>>     if (d) {
>>         void *spapr =3D CAST(void, bus->parent, "spapr-vscsi");
>> @@ -2444,6 +2446,12 @@ static char *spapr_get_fw_dev_path(FWPathProvider=
 *p, BusState *bus,
>>         return g_strdup_printf("pci@%"PRIX64, phb->buid);
>>     }
>>=20
>> +    if (vsc) {
>> +        /* Same logic as virtio above */
>> +        unsigned id =3D 0x1000000 | (vsc->target << 16) | vsc->lun;
>> +        return g_strdup_printf("disk@%"PRIX64, (uint64_t)id << 32);
>> +    }
>> +
>>     return NULL;
>> }
>>=20
>=20
> --=20
> David Gibson=09=09=09| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au=09| minimalist, thank you.  NOT _the_ _oth=
er_
> =09=09=09=09| _way_ _around_!
> http://www.ozlabs.org/~dgibson
