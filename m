Received: from eggs.gnu.org ([2001:4830:134:3::10]:41880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cT0F6-0008JT-25
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 00:54:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cT0F2-00056H-62
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 00:54:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cT0F2-00055y-05
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 00:54:04 -0500
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<1484276800-26814-13-git-send-email-peterx@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <397afe71-b4cd-ba48-6d76-a7b27e1128f9@redhat.com>
Date: Mon, 16 Jan 2017 13:53:54 +0800
MIME-Version: 1.0
In-Reply-To: <1484276800-26814-13-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v3 12/14] intel_iommu: do replay when
 context invalidate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, alex.williamson@redhat.com, bd.aviv@gmail.com



On 2017=E5=B9=B401=E6=9C=8813=E6=97=A5 11:06, Peter Xu wrote:
> Before this one we only invalidate context cache when we receive contex=
t
> entry invalidations. However it's possible that the invalidation also
> contains a domain switch (only if cache-mode is enabled for vIOMMU).

So let's check for CM before replaying?

>   In
> that case we need to notify all the registered components about the new
> mapping.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/i386/intel_iommu.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 59bf683..fd75112 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -1162,6 +1162,7 @@ static void vtd_context_device_invalidate(IntelIO=
MMUState *s,
>                   trace_vtd_inv_desc_cc_device(bus_n, (devfn_it >> 3) &=
 0x1f,
>                                                devfn_it & 3);
>                   vtd_as->context_cache_entry.context_cache_gen =3D 0;
> +                memory_region_iommu_replay_all(&vtd_as->iommu);
>               }
>           }
>       }
