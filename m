Received: from eggs.gnu.org ([2001:4830:134:3::10]:49014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eOOeT-0001vY-Fh
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 09:01:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eOOeO-0002aI-V6
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 09:01:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50222
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eOOeO-0002Yy-Qv
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 09:01:44 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBBE1K5G160318
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 09:01:42 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2essfgeygm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 09:01:31 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 11 Dec 2017 14:00:38 -0000
References: <20171211134740.8235-1-david@redhat.com>
	<20171211134740.8235-5-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 11 Dec 2017 15:00:35 +0100
MIME-Version: 1.0
In-Reply-To: <20171211134740.8235-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <d44df505-7746-d11f-0779-ae956f22d331@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 for-2-12 04/15] s390x/flic: simplify
 flic initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Thomas Huth <thuth@redhat.com>

On 12/11/2017 02:47 PM, David Hildenbrand wrote:
> This makes it clearer, which device is used for which accelerator.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
nice.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>


> ---
>  hw/intc/s390_flic.c          |  9 +++++++--
>  hw/intc/s390_flic_kvm.c      | 12 ------------
>  include/hw/s390x/s390_flic.h |  9 ---------
>  3 files changed, 7 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
> index 6eaf178d79..a78bdf1d90 100644
> --- a/hw/intc/s390_flic.c
> +++ b/hw/intc/s390_flic.c
> @@ -40,11 +40,16 @@ void s390_flic_init(void)
>  {
>      DeviceState *dev;
> 
> -    dev = s390_flic_kvm_create();
> -    if (!dev) {
> +    if (kvm_enabled()) {
> +        dev = qdev_create(NULL, TYPE_KVM_S390_FLIC);
> +        object_property_add_child(qdev_get_machine(), TYPE_KVM_S390_FLIC,
> +                                  OBJECT(dev), NULL);
> +    } else if (tcg_enabled()) {
>          dev = qdev_create(NULL, TYPE_QEMU_S390_FLIC);
>          object_property_add_child(qdev_get_machine(), TYPE_QEMU_S390_FLIC,
>                                    OBJECT(dev), NULL);
> +    } else {
> +        g_assert_not_reached();
>      }
>      qdev_init_nofail(dev);
>  }
> diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
> index d208cb81c4..0cb5feab0c 100644
> --- a/hw/intc/s390_flic_kvm.c
> +++ b/hw/intc/s390_flic_kvm.c
> @@ -35,18 +35,6 @@ typedef struct KVMS390FLICState {
>      bool clear_io_supported;
>  } KVMS390FLICState;
> 
> -DeviceState *s390_flic_kvm_create(void)
> -{
> -    DeviceState *dev = NULL;
> -
> -    if (kvm_enabled()) {
> -        dev = qdev_create(NULL, TYPE_KVM_S390_FLIC);
> -        object_property_add_child(qdev_get_machine(), TYPE_KVM_S390_FLIC,
> -                                  OBJECT(dev), NULL);
> -    }
> -    return dev;
> -}
> -
>  /**
>   * flic_get_all_irqs - store all pending irqs in buffer
>   * @buf: pointer to buffer which is passed to kernel
> diff --git a/include/hw/s390x/s390_flic.h b/include/hw/s390x/s390_flic.h
> index 7aab6ef7f0..5b00e936fa 100644
> --- a/include/hw/s390x/s390_flic.h
> +++ b/include/hw/s390x/s390_flic.h
> @@ -91,13 +91,4 @@ void s390_flic_init(void);
>  S390FLICState *s390_get_flic(void);
>  bool ais_needed(void *opaque);
> 
> -#ifdef CONFIG_KVM
> -DeviceState *s390_flic_kvm_create(void);
> -#else
> -static inline DeviceState *s390_flic_kvm_create(void)
> -{
> -    return NULL;
> -}
> -#endif
> -
>  #endif /* HW_S390_FLIC_H */
> 
