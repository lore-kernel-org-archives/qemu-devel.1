Received: from eggs.gnu.org ([2001:4830:134:3::10]:42071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cVTly-00014J-3X
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 20:50:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cVTlv-0006zy-23
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 20:50:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cVTlu-0006zs-PH
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 20:50:14 -0500
References: <1484917736-32056-1-git-send-email-peterx@redhat.com>
	<1484917736-32056-16-git-send-email-peterx@redhat.com>
	<f2cceaa6-b3cf-9ed1-2c9c-f9222a0ab7ce@redhat.com>
	<20170122085118.GA26526@pxdev.xzpeter.org>
	<20170122093625.GD26526@pxdev.xzpeter.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <de864860-6083-b97b-019e-659856f7e23f@redhat.com>
Date: Mon, 23 Jan 2017 09:50:07 +0800
MIME-Version: 1.0
In-Reply-To: <20170122093625.GD26526@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v4 15/20] intel_iommu: provide its own
 replay() callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, bd.aviv@gmail.com, qemu-devel@nongnu.org, alex.williamson@redhat.com



On 2017=E5=B9=B401=E6=9C=8822=E6=97=A5 17:36, Peter Xu wrote:
> Besides this one, I tried to fix the comments in this function as
> below, hope this is better (I removed 1-3 thing since I think that's
> clearer from below code):
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index e958f53..f3fe8c4 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -735,15 +735,6 @@ static int vtd_page_walk_level(dma_addr_t addr, ui=
nt64_t start,
>           offset =3D vtd_iova_level_offset(iova, level);
>           slpte =3D vtd_get_slpte(addr, offset);
>
> -        /*
> -         * When one of the following case happens, we assume the whole
> -         * range is invalid:
> -         *
> -         * 1. read block failed
> -         * 3. reserved area non-zero
> -         * 2. both read & write flag are not set
> -         */
> -
>           if (slpte =3D=3D (uint64_t)-1) {
>               trace_vtd_page_walk_skip_read(iova, iova_next);
>               skipped_local++;
> @@ -761,20 +752,16 @@ static int vtd_page_walk_level(dma_addr_t addr, u=
int64_t start,
>           write_cur =3D write && (slpte & VTD_SL_W);
>
>           /*
> -         * As long as we have either read/write permission, this is
> -         * a valid entry. The rule works for both page or page tables.
> +         * As long as we have either read/write permission, this is a
> +         * valid entry. The rule works for both page entries and page
> +         * table entries.
>            */
>           entry_valid =3D read_cur | write_cur;
>
>           if (vtd_is_last_slpte(slpte, level)) {
>               entry.target_as =3D &address_space_memory;
>               entry.iova =3D iova & subpage_mask;
> -            /*
> -             * This might be meaningless addr if (!read_cur &&
> -             * !write_cur), but after all this field will be
> -             * meaningless in that case, so let's share the code to
> -             * generate the IOTLBs no matter it's an MAP or UNMAP
> -             */
> +            /* NOTE: this is only meaningful if entry_valid =3D=3D tru=
e */
>               entry.translated_addr =3D vtd_get_slpte_addr(slpte);
>               entry.addr_mask =3D ~subpage_mask;
>               entry.perm =3D IOMMU_ACCESS_FLAG(read_cur, write_cur);
>
> Thanks,
>
> -- peterx

I still prefer to do this on patch 18 probably.

Thanks
