Received: from eggs.gnu.org ([2001:4830:134:3::10]:57951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1cMVIU-0004rD-2k
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 02:38:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1cMVIQ-0006i7-Vx
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 02:38:46 -0500
Received: from mga11.intel.com ([192.55.52.93]:35010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1cMVIQ-0006hp-N4
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 02:38:42 -0500
From: "Liu, Yi L" <yi.l.liu@intel.com>
Date: Thu, 29 Dec 2016 07:38:38 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257438FEF893@shsmsx102.ccr.corp.intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC PATCH 12/13] intel_iommu: do replay when
 context invalidate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "', Peter Xu'" <peterx@redhat.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Lan, Tianyu" <tianyu.lan@intel.com>, "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>, "'bd.aviv@gmail.com'" <bd.aviv@gmail.com>

> Before this one we only invalidate context cache when we receive context
> entry invalidations. However it's possible that the invalidation also
> contains a domain switch (only if cache-mode is enabled for vIOMMU). In
> that case we need to notify all the registered components about the new
> mapping.
>=20
> Signed-off-by: Peter Xu <address@hidden>
> ---
>  hw/i386/intel_iommu.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 2fcd7af..0220e63 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -1188,6 +1188,7 @@ static void vtd_context_device_invalidate(IntelIOMM=
UState=20
> *s,
>                  trace_vtd_inv_desc_cc_device(bus_n, (devfn_it >> 3) & 0x=
1f,
>                                               devfn_it & 3);
>                  vtd_as->context_cache_entry.context_cache_gen =3D 0;
> +                memory_region_iommu_replay_all(&vtd_as->iommu);

Hi Peter,

It looks like all the device context invalidation would result in replay ev=
en the
device is not an assigned device. Is it necessary to do replay for a virtua=
l device?

Regards,
Yi L
>              }
>          }
>      }
> --=20
> 2.7.4
