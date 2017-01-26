Received: from eggs.gnu.org ([2001:4830:134:3::10]:52279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cWjUp-0000Nj-Lk
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 07:49:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cWjUl-0001pU-MZ
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 07:49:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cWjUl-0001pP-Db
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 07:49:43 -0500
References: <20170126123411.5412.44769.stgit@PASHA-ISP>
	<20170126123429.5412.94368.stgit@PASHA-ISP>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e00dfc17-9dec-ea53-e86e-cf3089da659a@redhat.com>
Date: Thu, 26 Jan 2017 13:49:38 +0100
MIME-Version: 1.0
In-Reply-To: <20170126123429.5412.94368.stgit@PASHA-ISP>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 3/9] apic: save apic_delivered flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com, quintela@redhat.com, kraxel@redhat.com



On 26/01/2017 13:34, Pavel Dovgalyuk wrote:
> This patch implements saving/restoring of static apic_delivered variable.
> 
> v8: saving static variable only for one of the APICs
> 
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> ---
>  hw/intc/apic_common.c           |   37 +++++++++++++++++++++++++++++++++++++
>  include/hw/i386/apic_internal.h |    2 ++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
> index d78c885..edacb16 100644
> --- a/hw/intc/apic_common.c
> +++ b/hw/intc/apic_common.c
> @@ -384,6 +384,29 @@ static bool apic_common_sipi_needed(void *opaque)
>      return s->wait_for_sipi != 0;
>  }
>  
> +static bool apic_irq_delivered_needed(void *opaque)
> +{
> +    static APICCommonState *first_apic;
> +    APICCommonState *s = APIC_COMMON(opaque);
> +    if (!first_apic) {
> +        first_apic = s;
> +    }
> +    return s == first_apic;

Should also check " && apic_irq_delivered != 0".

Paolo

> +}
> +
> +static void apic_irq_delivered_pre_save(void *opaque)
> +{
> +    APICCommonState *s = APIC_COMMON(opaque);
> +    s->apic_irq_delivered = apic_irq_delivered;
> +}
> +
> +static int apic_irq_delivered_post_load(void *opaque, int version_id)
> +{
> +    APICCommonState *s = APIC_COMMON(opaque);
> +    apic_irq_delivered = s->apic_irq_delivered;
> +    return 0;
> +}
> +
>  static const VMStateDescription vmstate_apic_common_sipi = {
>      .name = "apic_sipi",
>      .version_id = 1,
> @@ -396,6 +419,19 @@ static const VMStateDescription vmstate_apic_common_sipi = {
>      }
>  };
>  
> +static const VMStateDescription vmstate_apic_irq_delivered = {
> +    .name = "apic_irq_delivered",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = apic_irq_delivered_needed,
> +    .pre_save = apic_irq_delivered_pre_save,
> +    .post_load = apic_irq_delivered_post_load,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_INT32(apic_irq_delivered, APICCommonState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_apic_common = {
>      .name = "apic",
>      .version_id = 3,
> @@ -430,6 +466,7 @@ static const VMStateDescription vmstate_apic_common = {
>      },
>      .subsections = (const VMStateDescription*[]) {
>          &vmstate_apic_common_sipi,
> +        &vmstate_apic_irq_delivered,
>          NULL
>      }
>  };
> diff --git a/include/hw/i386/apic_internal.h b/include/hw/i386/apic_internal.h
> index 1209eb4..20ad28c 100644
> --- a/include/hw/i386/apic_internal.h
> +++ b/include/hw/i386/apic_internal.h
> @@ -189,6 +189,8 @@ struct APICCommonState {
>      DeviceState *vapic;
>      hwaddr vapic_paddr; /* note: persistence via kvmvapic */
>      bool legacy_instance_id;
> +
> +    int apic_irq_delivered; /* for saving static variable */
>  };
>  
>  typedef struct VAPICState {
> 
