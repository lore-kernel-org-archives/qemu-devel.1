Received: from eggs.gnu.org ([2001:4830:134:3::10]:37980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1csQ7Q-0006Im-Uo
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 04:35:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1csQ7N-0008OU-2B
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 04:35:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:65081)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1csQ7M-0008NO-M8
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 04:35:12 -0400
From: "Liu, Yi L" <yi.l.liu@intel.com>
Date: Mon, 27 Mar 2017 08:35:05 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439032C79@shsmsx102.ccr.corp.intel.com>
References: <1486456099-7345-1-git-send-email-peterx@redhat.com>
	<1486456099-7345-15-git-send-email-peterx@redhat.com>
In-Reply-To: <1486456099-7345-15-git-send-email-peterx@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v7 14/17] memory: add
 MemoryRegionIOMMUOps.replay() callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "alex.williamson@redhat.com" <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: "Lan, Tianyu" <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, "mst@redhat.com" <mst@redhat.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "bd.aviv@gmail.com" <bd.aviv@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> -----Original Message-----
> From: Qemu-devel [mailto:qemu-devel-bounces+yi.l.liu=3Dintel.com@nongnu.o=
rg] On
> Behalf Of Peter Xu
> Sent: Tuesday, February 7, 2017 4:28 PM
> To: qemu-devel@nongnu.org
> Cc: Lan, Tianyu <tianyu.lan@intel.com>; Tian, Kevin <kevin.tian@intel.com=
>;
> mst@redhat.com; jan.kiszka@siemens.com; jasowang@redhat.com;
> peterx@redhat.com; alex.williamson@redhat.com; bd.aviv@gmail.com; David
> Gibson <david@gibson.dropbear.id.au>
> Subject: [Qemu-devel] [PATCH v7 14/17] memory: add
> MemoryRegionIOMMUOps.replay() callback
>=20
> Originally we have one memory_region_iommu_replay() function, which is th=
e
> default behavior to replay the translations of the whole IOMMU region. Ho=
wever,
> on some platform like x86, we may want our own replay logic for IOMMU reg=
ions.
> This patch add one more hook for IOMMUOps for the callback, and it'll ove=
rride the
> default if set.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/exec/memory.h | 2 ++
>  memory.c              | 6 ++++++
>  2 files changed, 8 insertions(+)
>=20
> diff --git a/include/exec/memory.h b/include/exec/memory.h index
> 0767888..30b2a74 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -191,6 +191,8 @@ struct MemoryRegionIOMMUOps {
>      void (*notify_flag_changed)(MemoryRegion *iommu,
>                                  IOMMUNotifierFlag old_flags,
>                                  IOMMUNotifierFlag new_flags);
> +    /* Set this up to provide customized IOMMU replay function */
> +    void (*replay)(MemoryRegion *iommu, IOMMUNotifier *notifier);
>  };
>=20
>  typedef struct CoalescedMemoryRange CoalescedMemoryRange; diff --git
> a/memory.c b/memory.c index 7a4f2f9..9c253cc 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1630,6 +1630,12 @@ void memory_region_iommu_replay(MemoryRegion
> *mr, IOMMUNotifier *n,
>      hwaddr addr, granularity;
>      IOMMUTLBEntry iotlb;
> +    /* If the IOMMU has its own replay callback, override */
> +    if (mr->iommu_ops->replay) {
> +        mr->iommu_ops->replay(mr, n);
> +        return;
> +    }

Hi Alex, Peter,

Will all the other vendors(e.g. PPC, s390, ARM) add their own replay callba=
ck
as well? I guess it depends on whether the original replay algorithm work w=
ell
for them? Do you have such knowledge?

Regards,
Yi L

> +
>      granularity =3D memory_region_iommu_get_min_page_size(mr);
>=20
>      for (addr =3D 0; addr < memory_region_size(mr); addr +=3D granularit=
y) {
> --
> 2.7.4
>=20
