Received: from eggs.gnu.org ([2001:4830:134:3::10]:54183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eK4Fw-0001jP-Sa
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:26:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eK4Fv-0007SO-Rp
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:26:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1eK4Fv-0007Rg-Lb
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:26:35 -0500
Date: Wed, 29 Nov 2017 08:26:32 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20171129082632.0ba2f118@t450s.home>
In-Reply-To: <20171122051552.3529-1-aik@ozlabs.ru>
References: <20171122051552.3529-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu] vfio/spapr: Allow fallback to SPAPR
 TCE IOMMU v1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Wed, 22 Nov 2017 16:15:52 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> The vfio_iommu_spapr_tce driver always advertises v1 and v2 IOMMU support,
> however PR KVM (a special version of KVM designed to work in
> a paravirtualized system; these days used for nested virtualizaion) only
> supports the "pseries" platform which does not support v2. Since there is
> no way to choose the IOMMU version in QEMU, it fails to start.

Seems like the bug is then in advertising v2 support when it doesn't
exist.  Isn't that a kernel bug?  Otherwise I think this is a long
standing bug, since QEMU-2.7 and probably not 2.11 material this late
into the freeze.  A "Fixes" tag would probably also be appropriate,
identifying the commit where this was introduced (318f67ce1371) if it
is a QEMU bug.  Thanks,

Alex

> This adds a fallback to the v1 IOMMU if v2 cannot be used.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  hw/vfio/common.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 7b2924c..cd81cc9 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1040,6 +1040,11 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>              v2 ? VFIO_SPAPR_TCE_v2_IOMMU : VFIO_SPAPR_TCE_IOMMU;
>          ret = ioctl(fd, VFIO_SET_IOMMU, container->iommu_type);
>          if (ret) {
> +            container->iommu_type = VFIO_SPAPR_TCE_IOMMU;
> +            v2 = false;
> +            ret = ioctl(fd, VFIO_SET_IOMMU, container->iommu_type);
> +        }
> +        if (ret) {
>              error_setg_errno(errp, errno, "failed to set iommu for container");
>              ret = -errno;
>              goto free_container_exit;
