Received: from eggs.gnu.org ([2001:4830:134:3::10]:45276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eefJc-0000Kg-QP
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 06:03:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eefJZ-0005BG-LX
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 06:03:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50000
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eefJZ-00059t-G0
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 06:03:29 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0PAxW6q121416
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 06:03:27 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fqdf2sh1b-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 06:03:26 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 25 Jan 2018 11:03:24 -0000
References: <20180117174047.6382-1-david@redhat.com>
	<20180117174047.6382-18-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 25 Jan 2018 12:03:20 +0100
MIME-Version: 1.0
In-Reply-To: <20180117174047.6382-18-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <9fc18846-c2c1-1436-4c94-c913ce1200dd@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 17/18] s390x/kvm: cache the kvm flic in
 a central function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>



On 01/17/2018 06:40 PM, David Hildenbrand wrote:
> This avoids tons of conversions when handling interrupts.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>


> ---
>  hw/intc/s390_flic_kvm.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
> index d277ffdd2e..3f804ad52e 100644
> --- a/hw/intc/s390_flic_kvm.c
> +++ b/hw/intc/s390_flic_kvm.c
> @@ -35,6 +35,17 @@ typedef struct KVMS390FLICState {
>      bool clear_io_supported;
>  } KVMS390FLICState;
> 
> +static KVMS390FLICState *s390_get_kvm_flic(S390FLICState *fs)
> +{
> +    static KVMS390FLICState *flic;
> +
> +    if (!flic) {
> +        /* we only have one flic device, so this is fine to cache */
> +        flic = KVM_S390_FLIC(fs);
> +    }
> +    return flic;
> +}
> +
>  /**
>   * flic_get_all_irqs - store all pending irqs in buffer
>   * @buf: pointer to buffer which is passed to kernel
> @@ -117,7 +128,7 @@ static void kvm_s390_inject_flic(S390FLICState *fs, struct kvm_s390_irq *irq)
>      int r;
> 
>      if (use_flic) {
> -        r = flic_enqueue_irqs(irq, sizeof(*irq), KVM_S390_FLIC(fs));
> +        r = flic_enqueue_irqs(irq, sizeof(*irq), s390_get_kvm_flic(fs));
>          if (r == -ENOSYS) {
>              use_flic = false;
>          }
> @@ -174,7 +185,7 @@ static void kvm_s390_inject_crw_mchk(S390FLICState *fs)
>  static int kvm_s390_clear_io_flic(S390FLICState *fs, uint16_t subchannel_id,
>                             uint16_t subchannel_nr)
>  {
> -    KVMS390FLICState *flic = KVM_S390_FLIC(fs);
> +    KVMS390FLICState *flic = s390_get_kvm_flic(fs);
>      int rc;
>      uint32_t sid = subchannel_id << 16 | subchannel_nr;
>      struct kvm_device_attr attr = {
> @@ -192,7 +203,7 @@ static int kvm_s390_clear_io_flic(S390FLICState *fs, uint16_t subchannel_id,
>  static int kvm_s390_modify_ais_mode(S390FLICState *fs, uint8_t isc,
>                                      uint16_t mode)
>  {
> -    KVMS390FLICState *flic = KVM_S390_FLIC(fs);
> +    KVMS390FLICState *flic = s390_get_kvm_flic(fs);
>      struct kvm_s390_ais_req req = {
>          .isc = isc,
>          .mode = mode,
> @@ -212,7 +223,7 @@ static int kvm_s390_modify_ais_mode(S390FLICState *fs, uint8_t isc,
>  static int kvm_s390_inject_airq(S390FLICState *fs, uint8_t type,
>                                  uint8_t isc, uint8_t flags)
>  {
> -    KVMS390FLICState *flic = KVM_S390_FLIC(fs);
> +    KVMS390FLICState *flic = s390_get_kvm_flic(fs);
>      uint32_t id = css_get_adapter_id(type, isc);
>      struct kvm_device_attr attr = {
>          .group = KVM_DEV_FLIC_AIRQ_INJECT,
> @@ -301,7 +312,7 @@ static int kvm_s390_io_adapter_map(S390FLICState *fs, uint32_t id,
>          .group = KVM_DEV_FLIC_ADAPTER_MODIFY,
>          .addr = (uint64_t)&req,
>      };
> -    KVMS390FLICState *flic = KVM_S390_FLIC(fs);
> +    KVMS390FLICState *flic = s390_get_kvm_flic(fs);
>      int r;
> 
>      if (!kvm_gsi_routing_enabled()) {
> 
