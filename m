Received: from eggs.gnu.org ([2001:4830:134:3::10]:59562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eK4U2-0007XM-QC
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:41:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eK4U1-0006Ag-Rf
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:41:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1eK4U1-00069M-Lq
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:41:09 -0500
Date: Wed, 29 Nov 2017 08:41:04 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20171129084104.44f8b8c2@t450s.home>
In-Reply-To: <1511337482-15505-1-git-send-email-yi.l.liu@linux.intel.com>
References: <1511337482-15505-1-git-send-email-yi.l.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vfio/common: init giommu_list and
 hostwin_list of vfio container
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au, pbonzini@redhat.com, aik@ozlabs.ru, yi.l.liu@intel.com

On Wed, 22 Nov 2017 15:58:02 +0800
"Liu, Yi L" <yi.l.liu@linux.intel.com> wrote:

> The init of giommu_list and hostwin_list is missed during container
> initialization.
> 
> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> ---
>  hw/vfio/common.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 7b2924c..14c5940 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -990,6 +990,8 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>      container = g_malloc0(sizeof(*container));
>      container->space = space;
>      container->fd = fd;
> +    QLIST_INIT(&container->giommu_list);
> +    QLIST_INIT(&container->hostwin_list);

container is g_malloc0'd above and QLIST_INIT does:

#define QLIST_INIT(head) do {                                           \
        (head)->lh_first = NULL;                                        \
} while (/*CONSTCOND*/0)

So the only net change is the explicit initialization, which is a fair
fix, but given the current QLIST implementation is not actually a
bug.  Let's save it for after QEMU-2.11.  Thanks,

Alex

>      if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1_IOMMU) ||
>          ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU)) {
>          bool v2 = !!ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU);
