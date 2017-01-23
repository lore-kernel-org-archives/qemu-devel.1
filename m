Received: from eggs.gnu.org ([2001:4830:134:3::10]:48012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cVc2x-0001rF-Rq
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:40:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cVc2t-0000rb-Sg
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:40:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cVc2t-0000rK-Nh
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:40:19 -0500
References: <1484917736-32056-1-git-send-email-peterx@redhat.com>
	<1484917736-32056-20-git-send-email-peterx@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <cddf837c-24ca-b6f2-67cf-256e6b1e0bec@redhat.com>
Date: Mon, 23 Jan 2017 18:40:12 +0800
MIME-Version: 1.0
In-Reply-To: <1484917736-32056-20-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v4 19/20] intel_iommu: unmap existing
 pages before replay
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



On 2017=E5=B9=B401=E6=9C=8820=E6=97=A5 21:08, Peter Xu wrote:
>   static int vtd_replay_hook(IOMMUTLBEntry *entry, void *private)
>   {
>       memory_region_notify_one((IOMMUNotifier *)private, entry);
> @@ -2711,13 +2768,16 @@ static void vtd_iommu_replay(MemoryRegion *mr, =
IOMMUNotifier *n)
>  =20
>       if (vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce) =3D=3D=
 0) {
>           /*
> -         * Scanned a valid context entry, walk over the pages and
> -         * notify when needed.
> +         * Scanned a valid context entry, we first make sure to remove
> +         * all existing mappings in old domain, by sending UNMAP to
> +         * all the notifiers. Then, we walk over the pages and notify
> +         * with existing mapped new entries in the new domain.
>            */

A question is what if the context cache was invalidated but the device=20
were not moved to a new domain. Then the code here does not do anything=20
I believe? I think we should move vtd_address_space_unmap() in the=20
context entry invalidation processing.

Thanks

>           trace_vtd_replay_ce_valid(bus_n, PCI_SLOT(vtd_as->devfn),
>                                     PCI_FUNC(vtd_as->devfn),
>                                     VTD_CONTEXT_ENTRY_DID(ce.hi),
>                                     ce.hi, ce.lo);
> +        vtd_address_space_unmap(vtd_as, n);
>           vtd_page_walk(&ce, 0, ~0, vtd_replay_hook, (void *)n, false);
>       } else {
>           trace_vtd_replay_ce_invalid(bus_n, PCI_SLOT(vtd_as->devfn),
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_inter=
n
