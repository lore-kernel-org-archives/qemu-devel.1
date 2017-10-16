Received: from eggs.gnu.org ([2001:4830:134:3::10]:38319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1e49nc-0003tx-81
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 14:07:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1e49nW-0008QH-Fh
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 14:07:36 -0400
References: <1507630928-28307-1-git-send-email-Jim.Quigley@oracle.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <78aed453-49b8-a9e4-ae7c-39c731158eaa@msgid.tls.msk.ru>
Date: Mon, 16 Oct 2017 21:07:29 +0300
MIME-Version: 1.0
In-Reply-To: <1507630928-28307-1-git-send-email-Jim.Quigley@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/vfio: improve error message when cannot
 init vfio event notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jim Quigley <Jim.Quigley@oracle.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, alex.williamson@redhat.com, laurent@vivier.eu

10.10.2017 13:22, Jim Quigley wrote:
> More information is required to assist trouble-shooting when
> QEMU fails to initialise the event notifications for devices
> assigned with VFIO-PCI. Instead of supplying the user with a cryptic
> error number only, print out a proper error message with strerror()
> so that the user has a better way to figure out what the problem is.
> 
> Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
> Signed-off-by: Jim Quigley <Jim.Quigley@oracle.com>
> ---
> Cc: qemu-trivial@nongnu.org
> Cc: mjt@tls.msk.ru
> Cc: laurent@vivier.eu
> Cc: alex.williamson@redhat.com
> ---
>  hw/vfio/pci.c | 35 ++++++++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 31e1edf..3bffb93 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -430,13 +430,16 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
>  static void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
>                                    int vector_n, bool msix)
>  {
> -    int virq;
> +    int virq, ret;
>  
>      if ((msix && vdev->no_kvm_msix) || (!msix && vdev->no_kvm_msi)) {
>          return;
>      }
>  
> -    if (event_notifier_init(&vector->kvm_interrupt, 0)) {
> +    ret = event_notifier_init(&vector->kvm_interrupt, 0);
> +    if (ret) {
> +        error_report("vfio (%s): Error: unable to init event notifier: %s (%d)",
> +                     __func__, strerror(-ret), -ret);

Since this pattern gets repeated again and again, maybe we can either
use a common wrapper or move that eror reporting into event_notifier_init()?
Note there are other users of this function, besides hw/vfio, and maybe
these, too, can benefit from better error reporting?

Thanks,

/mjt
