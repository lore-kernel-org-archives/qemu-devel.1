Received: from eggs.gnu.org ([2001:4830:134:3::10]:47539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eEcg1-0003HC-Qi
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 09:59:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eEcfx-00042N-Oy
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 09:59:01 -0500
Date: Tue, 14 Nov 2017 15:58:44 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171114155844.60e10e1d.cohuck@redhat.com>
In-Reply-To: <1509033294-4945-2-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1509033294-4945-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1509033294-4945-2-git-send-email-akrowiak@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 1/5] s390x/ap-matrix: Adjunct Processor (AP)
 matrix object model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, qemu-s390x@nongnu.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, qemu-devel@nongnu.org

On Thu, 26 Oct 2017 11:54:50 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> This patch introduces the base object model for an AP matrix device. An AP
> matrix is comprised of the AP adapters, usage domains and control domains
> assigned to a KVM guest. The matrix is represented in three bit masks:
> 
> * The AP Mask (APM) specifies the AP adapters assigned to the
>   KVM guest. The APM controls which adapters are valid for the KVM guest.
>   The bits in the mask, from left to right, correspond to APIDs
>   0 up to the number of adapters that can be assigned to the LPAR. If a bit
>   is set, the corresponding adapter is valid for use by the KVM guest.
> 
> * The AP Queue Mask (AQM) specifies the AP usage domains assigned
>   to the KVM guest. The bits in the mask, from left to right, correspond
>   to the usage domains, from 0 up to the number of domains that can be
>   assigned to the LPAR. If a bit is set, the corresponding usage domain is
>   valid for use by the KVM guest.
> 
> * The AP Domain Mask specifies the AP control domains assigned to the
>   KVM guest. The ADM bitmask controls which domains can be changed by an AP
>   command-request message sent to a usage domain from the guest. The bits in
>   the mask, from left to right, correspond to domain 0 up to the number of
>   domains that can be assigned to the LPAR. If a bit is set, the
>   corresponding domain can be modified by an AP command-request message
>   sent to a usage domain configured for the KVM guest.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> ---
>  hw/s390x/Makefile.objs            |    2 +
>  hw/s390x/ap-matrix-device.c       |   33 +++++++++++++++++++++++
>  hw/s390x/ap-matrix-device.h       |   53 +++++++++++++++++++++++++++++++++++++
>  hw/s390x/s390-ap-matrix.c         |   52 ++++++++++++++++++++++++++++++++++++
>  include/hw/s390x/s390-ap-matrix.h |   39 +++++++++++++++++++++++++++
>  5 files changed, 179 insertions(+), 0 deletions(-)
>  create mode 100644 hw/s390x/ap-matrix-device.c
>  create mode 100644 hw/s390x/ap-matrix-device.h
>  create mode 100644 hw/s390x/s390-ap-matrix.c
>  create mode 100644 include/hw/s390x/s390-ap-matrix.h
> 

> diff --git a/hw/s390x/ap-matrix-device.c b/hw/s390x/ap-matrix-device.c
> new file mode 100644
> index 0000000..d036ce2
> --- /dev/null
> +++ b/hw/s390x/ap-matrix-device.c
> @@ -0,0 +1,33 @@
> +/*
> + * Common device infrastructure for AP matrix devices
> + *
> + * Copyright 2016 IBM Corp.

Hm?             ^^^^

> + * Author(s): Jing Liu <liujbjl@linux.vnet.ibm.com>

If Jing is the author, shouldn't the patch carry her s-o-b as well?

(I'm a bit confused about the history of this.)

> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */
> +#include <ctype.h>
> +
> +#include "qemu/osdep.h"
> +#include "qemu/bitops.h"
> +#include "qemu/module.h"
> +#include "qapi/error.h"
> +#include "qapi/visitor.h"
> +#include "ap-matrix-device.h"
> +
> +static const TypeInfo ap_matrix_device_info = {
> +    .name = TYPE_AP_MATRIX_DEVICE,
> +    .parent = TYPE_DEVICE,
> +    .instance_size = sizeof(APMatrixDevice),
> +    .class_size = sizeof(APMatrixDeviceClass),
> +    .abstract = true,
> +};
> +
> +static void ap_matrix_device_register(void)
> +{
> +    type_register_static(&ap_matrix_device_info);
> +}
> +
> +type_init(ap_matrix_device_register)
> diff --git a/hw/s390x/ap-matrix-device.h b/hw/s390x/ap-matrix-device.h
> new file mode 100644
> index 0000000..af7ae2c
> --- /dev/null
> +++ b/hw/s390x/ap-matrix-device.h
> @@ -0,0 +1,53 @@
> +/*
> + * Adjunct Processor (AP) matrix device structures
> + *
> + * Copyright 2016 IBM Corp.
> + * Author(s): Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */
> +
> +#ifndef HW_S390X_AP_MATRIX_DEVICE_H
> +#define HW_S390X_AP_MATRIX_DEVICE_H
> +#include "qom/object.h"
> +#include "hw/qdev.h"
> +
> +#define AP_MATRIX_MASK_INDICES 4
> +#define AP_MATRIX_MAX_MASK_BITS 256
> +
> +typedef struct APMatrixMasks {
> +    uint64_t apm[AP_MATRIX_MASK_INDICES];
> +    uint64_t aqm[AP_MATRIX_MASK_INDICES];
> +    uint64_t adm[AP_MATRIX_MASK_INDICES];
> +} APMatrixMasks;
> +
> +typedef struct APMatrixDevice {
> +    DeviceState parent_obj;
> +    APMatrixMasks masks;
> +} APMatrixDevice;
> +
> +extern const VMStateDescription vmstate_ap_matrix_dev;
> +#define VMSTATE_AP_MATRIX_DEVICE(_field, _state)                     \
> +    VMSTATE_STRUCT(_field, _state, 1, vmstate_ap_matrix_dev, APMatrixDevice)

I'm wondering about migration: can the other side easily reconstruct
the state on the target?

> +
> +typedef struct APMatrixDeviceClass {
> +    DeviceClass parent_class;
> +} APMatrixDeviceClass;
> +
> +static inline APMatrixDevice *to_ap_matrix_dev(DeviceState *dev)
> +{
> +    return container_of(dev, APMatrixDevice, parent_obj);
> +}
> +
> +#define TYPE_AP_MATRIX_DEVICE "ap-matrix-device"
> +
> +#define AP_MATRIX_DEVICE(obj) \
> +    OBJECT_CHECK(APMatrixDevice, (obj), TYPE_AP_MATRIX_DEVICE)
> +#define AP_MATRIX_DEVICE_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(AP_MATRIXDeviceClass, (obj), TYPE_AP_MATRIX_DEVICE)
> +#define AP_MATRIX_DEVICE_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(AP_MATRIXDeviceClass, (klass), TYPE_AP_MATRIX_DEVICE)
> +
> +#endif
> diff --git a/hw/s390x/s390-ap-matrix.c b/hw/s390x/s390-ap-matrix.c
> new file mode 100644
> index 0000000..6d2e234
> --- /dev/null
> +++ b/hw/s390x/s390-ap-matrix.c
> @@ -0,0 +1,52 @@
> +/*
> + * s390 AP Matrix Assignment Support
> + *
> + * Copyright 2017 IBM Corp
> + * Author(s): Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2
> + * or (at your option) any later version. See the COPYING file in the
> + * top-level directory.
> + */
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/sysbus.h"
> +#include "libgen.h"
> +#include "hw/s390x/s390-ap-matrix.h"
> +
> +static void s390_ap_matrix_device_realize(S390APMatrixDevice *sapmdev,
> +                                          APMatrixMasks *masks,
> +                                          Error **errp)
> +{
> +    size_t i;
> +    APMatrixDevice *apmdev = AP_MATRIX_DEVICE(sapmdev);
> +
> +    for (i = 0; i < AP_MATRIX_MASK_INDICES; i++) {
> +        apmdev->masks.apm[i] = masks->apm[i];
> +        apmdev->masks.aqm[i] = masks->aqm[i];
> +        apmdev->masks.adm[i] = masks->adm[i];

These masks are presumably provided in a later patch?

> +    }
> +}
> +
> +static void s390_ap_matrix_class_init(ObjectClass *klass, void *data)
> +{
> +    S390APMatrixDeviceClass *apmc = S390_AP_MATRIX_DEVICE_CLASS(klass);
> +
> +    apmc->realize = s390_ap_matrix_device_realize;
> +}
> +
> +static const TypeInfo s390_ap_matrix_info = {
> +    .name          = TYPE_S390_AP_MATRIX_DEVICE,
> +    .parent        = TYPE_AP_MATRIX_DEVICE,
> +    .instance_size = sizeof(S390APMatrixDevice),
> +    .class_size    = sizeof(S390APMatrixDeviceClass),
> +    .class_init    = s390_ap_matrix_class_init,
> +    .abstract      = true,
> +};
> +
> +static void register_s390_ap_matrix_type(void)
> +{
> +    type_register_static(&s390_ap_matrix_info);
> +}
> +
> +type_init(register_s390_ap_matrix_type)
> diff --git a/include/hw/s390x/s390-ap-matrix.h b/include/hw/s390x/s390-ap-matrix.h
> new file mode 100644
> index 0000000..b088841
> --- /dev/null
> +++ b/include/hw/s390x/s390-ap-matrix.h
> @@ -0,0 +1,39 @@
> +/*
> + * s390 AP Matrix Assignment Support
> + *
> + * Copyright 2017 IBM Corp.
> + * Author(s): Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */
> +
> +#ifndef HW_S390_AP_MATRIX_H
> +#define HW_S390_AP_MATRIX_H
> +
> +#include "hw/s390x/ap-matrix-device.h"
> +
> +#define AP_MATRIX_ADAPTERS_PROP_NAME    "adapters"
> +#define AP_MATRIX_DOMAINS_PROP_NAME     "domains"
> +#define AP_MATRIX_CONTROLS_PROP_NAME    "controls"

Also used in a later patch?

> +#define TYPE_S390_AP_MATRIX_DEVICE "s390-ap-matrix"
> +#define S390_AP_MATRIX_DEVICE(obj) \
> +    OBJECT_CHECK(S390APMatrixDevice, (obj), TYPE_S390_AP_MATRIX_DEVICE)
> +#define S390_AP_MATRIX_DEVICE_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(S390APMatrixDeviceClass, (klass), \
> +                       TYPE_S390_AP_MATRIX_DEVICE)
> +#define S390_AP_MATRIX_DEVICE_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(S390APMatrixDeviceClass, (obj), TYPE_S390_AP_MATRIX_DEVICE)
> +
> +typedef struct S390APMatrixDevice {
> +    APMatrixDevice parent_obj;
> +} S390APMatrixDevice;
> +
> +typedef struct S390APMatrixDeviceClass {
> +    APMatrixDeviceClass parent_class;
> +    void (*realize)(S390APMatrixDevice *sapmdev, APMatrixMasks *masks,
> +                    Error **errp);
> +} S390APMatrixDeviceClass;
> +
> +#endif
