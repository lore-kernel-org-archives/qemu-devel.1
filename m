Received: from eggs.gnu.org ([2001:4830:134:3::10]:38771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gKN8y-0001Ml-MU
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 07:41:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gKN8x-0000cq-FK
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 07:41:12 -0500
Date: Wed, 7 Nov 2018 13:40:53 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181107134053.0f5929d3.cohuck@redhat.com>
In-Reply-To: <1541154621-22423-5-git-send-email-pmorel@linux.ibm.com>
References: <1541154621-22423-1-git-send-email-pmorel@linux.ibm.com>
	<1541154621-22423-5-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 4/5] s390x/vfio: ap: Intercepting AP
 Queue Interrupt Control
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com, mst@redhat.com, eric.auger@redhat.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com

On Fri,  2 Nov 2018 11:30:20 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> From: Pierre Morel <pmorel@linux.vnet.ibm.com>

Meta: you may want to rewrite your authorship to the shorter address.

> 
> We intercept the PQAP(AQIC) instruction.
> 
> Until we implement AQIC we return a PGM_OPERATION.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  hw/vfio/ap.c                 | 10 ++++++++++
>  include/hw/s390x/ap-device.h |  9 +++++++++
>  target/s390x/kvm.c           | 20 ++++++++++++++++++++
>  3 files changed, 39 insertions(+)
> 
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 3962bb74e5..d8d9cadc46 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -38,6 +38,16 @@ typedef struct VFIOAPDevice {
>  #define VFIO_AP_DEVICE(obj) \
>          OBJECT_CHECK(VFIOAPDevice, (obj), VFIO_AP_DEVICE_TYPE)
>  
> +/*
> + * ap_pqap
> + * @env: environment pointing to registers
> + * return value: Code Condition
> + */
> +int ap_pqap(CPUS390XState *env)
> +{
> +    return -PGM_OPERATION;
> +}

I'm not sure whether it makes sense to add such a skeleton handler
here; perhaps we should merge with the next patch that actually does
something for AQCI?

> +
>  static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
>  {
>      vdev->needs_reset = false;
> diff --git a/include/hw/s390x/ap-device.h b/include/hw/s390x/ap-device.h
> index 765e9082a3..a83ea096c7 100644
> --- a/include/hw/s390x/ap-device.h
> +++ b/include/hw/s390x/ap-device.h
> @@ -19,4 +19,13 @@ typedef struct APDevice {
>  #define AP_DEVICE(obj) \
>      OBJECT_CHECK(APDevice, (obj), AP_DEVICE_TYPE)
>  
> +#define AP_DEVICE_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(APDeviceClass, (obj), AP_DEVICE_TYPE)
> +
> +#define AP_DEVICE_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(APDeviceClass, (klass), AP_DEVICE_TYPE)

Looks like an unrelated change -- does that maybe belong into the next
patch?

> +
> +#include "cpu.h"
> +int ap_pqap(CPUS390XState *env);
> +
>  #endif /* HW_S390X_AP_DEVICE_H */

The wiring up looks reasonable.
