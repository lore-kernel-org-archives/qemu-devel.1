Received: from eggs.gnu.org ([2001:4830:134:3::10]:46256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dVYfG-0003ha-Ke
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 03:35:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dVYfD-0006nW-Eo
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 03:35:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58817)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dVYfD-0006kw-8C
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 03:35:55 -0400
References: <1499864265-144136-1-git-send-email-borntraeger@de.ibm.com>
	<1499864265-144136-4-git-send-email-borntraeger@de.ibm.com>
	<92a0944a-156a-6800-88f1-ae39b5263730@redhat.com>
	<83795acd-ddfd-e039-80bb-78a785fb7669@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0445c2d0-c810-8d1e-4075-8251eb79a166@redhat.com>
Date: Thu, 13 Jul 2017 09:35:51 +0200
MIME-Version: 1.0
In-Reply-To: <83795acd-ddfd-e039-80bb-78a785fb7669@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/11] s390x/migration: Storage attributes
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On 13.07.2017 09:11, Christian Borntraeger wrote:
> Thanks for the review, all valid. Claudio has provided me the following fixup.
> 
> I plan to fold that in the base patch (retest pending).
> 
> Christian
> 
> 
> ---
>  hw/s390x/s390-stattrib-kvm.c          | 26 +++++++++++++++++++-------
>  hw/s390x/s390-stattrib.c              | 12 +++---------
>  include/hw/s390x/storage-attributes.h |  9 +++++++++
>  3 files changed, 31 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
> index 2e7f144..2ab3060 100644
> --- a/hw/s390x/s390-stattrib-kvm.c
> +++ b/hw/s390x/s390-stattrib-kvm.c
> @@ -11,7 +11,6 @@
> 
>  #include "qemu/osdep.h"
>  #include "hw/boards.h"
> -#include "qmp-commands.h"
>  #include "migration/qemu-file.h"
>  #include "hw/s390x/storage-attributes.h"
>  #include "qemu/error-report.h"
> @@ -19,6 +18,15 @@
>  #include "exec/ram_addr.h"
>  #include "cpu.h"
> 
> +Object *kvm_s390_stattrib_create(void)
> +{
> +    if (kvm_enabled() &&
> +                kvm_check_extension(kvm_state, KVM_CAP_S390_CMMA_MIGRATION)) {
> +        return object_new(TYPE_KVM_S390_STATTRIB);
> +    }
> +    return object_new(TYPE_QEMU_S390_STATTRIB);
> +}

I think you could also return NULL here instead of
object_new(TYPE_QEMU_S390_STATTRIB) since ...

> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
> index b9533b4..bac9aea 100644
> --- a/hw/s390x/s390-stattrib.c
> +++ b/hw/s390x/s390-stattrib.c
> @@ -40,16 +40,10 @@ void s390_stattrib_init(void)
>  {
>      Object *obj;
> 
> -#ifdef CONFIG_KVM
> -    if (kvm_enabled() &&
> -            kvm_check_extension(kvm_state, KVM_CAP_S390_CMMA_MIGRATION)) {
> -        obj = object_new(TYPE_KVM_S390_STATTRIB);
> -    } else {
> +    obj = kvm_s390_stattrib_create();
> +    if (!obj) {
>          obj = object_new(TYPE_QEMU_S390_STATTRIB);
>      }

... the object will be created here, too.

 Thomas
