Received: from eggs.gnu.org ([2001:4830:134:3::10]:54366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eK4G9-0002LD-Rz
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:26:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eK4G4-0007VF-4T
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:26:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eK4G3-0007V8-VG
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:26:44 -0500
References: <1511958793-15217-1-git-send-email-mgamal@redhat.com>
	<1511958793-15217-3-git-send-email-mgamal@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <39e50952-4377-645b-5bde-5b8ea63d4cb7@redhat.com>
Date: Wed, 29 Nov 2017 16:26:28 +0100
MIME-Version: 1.0
In-Reply-To: <1511958793-15217-3-git-send-email-mgamal@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RESEND 2/2] x86_iommu: check if machine has
 PCI bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mohammed Gamal <mgamal@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com, mjt@tls.msk.ru, lvivier@redhat.com
Cc: peterx@redhat.com, ehabkost@redhat.com, pbonzini@redhat.com

On 29.11.2017 13:33, Mohammed Gamal wrote:
> Starting qemu with
> qemu-system-x86_64 -S -M isapc -device {amd|intel}-iommu
> leads to a segfault. The code assume PCI bus is present and
> tries to access the bus structure without checking.
> 
> Since Intel VT-d and AMDVI should only work with PCI, add a
> check for PCI bus and return error if not present.
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
> ---
>  hw/i386/x86-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
> index 51de519..8a01a2d 100644
> --- a/hw/i386/x86-iommu.c
> +++ b/hw/i386/x86-iommu.c
> @@ -88,7 +88,7 @@ static void x86_iommu_realize(DeviceState *dev, Error **errp)
>          PC_MACHINE(object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE));
>      QLIST_INIT(&x86_iommu->iec_notifiers);
>  
> -    if (!pcms) {
> +    if (!pcms || !pcms->bus) {
>          error_setg(errp, "Machine-type '%s' not supported by IOMMU",
>                     mc->name);
>          return;
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
