Received: from eggs.gnu.org ([2001:4830:134:3::10]:47119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1erggw-0000Sq-Mc
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 04:09:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1erggs-0001O8-Iw
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 04:09:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44408
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1erggs-0001NH-DA
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 04:09:22 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2295Euf135607
	for <qemu-devel@nongnu.org>; Fri, 2 Mar 2018 04:09:21 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gey7tsaqr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 04:09:21 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 2 Mar 2018 09:09:19 -0000
References: <1519407778-23095-1-git-send-email-imbrenda@linux.vnet.ibm.com>
	<1519407778-23095-2-git-send-email-imbrenda@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 2 Mar 2018 10:09:16 +0100
MIME-Version: 1.0
In-Reply-To: <1519407778-23095-2-git-send-email-imbrenda@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <0e88e3af-f976-eded-4284-0f5c61d004d8@de.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v4 1/3] s390x/sclp: proper
 support of larger send and receive masks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, cohuck@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org



On 02/23/2018 06:42 PM, Claudio Imbrenda wrote:
> Until 67915de9f0383ccf4a ("s390x/event-facility: variable-length event masks")
> we only supported sclp event masks with a size of exactly 4 bytes, even
> though the architecture allows the guests to set up sclp event masks
> from 1 to 1021 bytes in length.
> After that patch, the behaviour was almost compliant, but some issues
> were still remaining, in particular regarding the handling of selective
> reads and migration.
> 
> When setting the sclp event mask, a mask size is also specified. Until
> now we only considered the size in order to decide which bits to save
> in the internal state. On the other hand, when a guest performs a
> selective read, it sends a mask, but it does not specify a size; the
> implied size is the size of the last mask that has been set.
> 
> Specifying bits in the mask of selective read that are not available in
> the internal mask should return an error, and bits past the end of the
> mask should obviously be ignored. This can only be achieved by keeping
> track of the lenght of the mask.
> 
> The mask length is thus now part of the internal state that needs to be
> migrated.
> 
> This patch fixes the handling of selective reads, whose size will now
> match the length of the event mask, as per architecture.
> 
> While the default behaviour is to be compliant with the architecture,
> when using older machine models the old broken behaviour is selected
> (allowing only masks of size exactly 4), in order to be able to migrate
> toward older versions.
> 
> Fixes: 67915de9f0383ccf4a ("s390x/event-facility: variable-length event masks")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>

Looks sane and seems to match the docs.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

One question below:

> ---
>  hw/s390x/event-facility.c  | 81 ++++++++++++++++++++++++++++++++++++++--------
>  hw/s390x/s390-virtio-ccw.c |  8 ++++-
>  2 files changed, 75 insertions(+), 14 deletions(-)
[...9
>  static void init_event_facility(Object *obj)
>  {
>      SCLPEventFacility *event_facility = EVENT_FACILITY(obj);
>      DeviceState *sdev = DEVICE(obj);
>      Object *new;
> 
> +    event_facility->mask_length = 4;

Shouldnt we start with 0 here (as no mask is set)

and
> +    event_facility->allow_all_mask_sizes = true;
> +    object_property_add_bool(obj, "allow_all_mask_sizes",
> +                             sclp_event_get_allow_all_mask_sizes,
> +                             sclp_event_set_allow_all_mask_sizes, NULL);
>      /* Spawn a new bus for SCLP events */
>      qbus_create_inplace(&event_facility->sbus, sizeof(event_facility->sbus),
>                          TYPE_SCLP_EVENTS_BUS, sdev, NULL);
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 8b3053f..e9309fd 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -29,6 +29,7 @@
>  #include "s390-pci-bus.h"
>  #include "hw/s390x/storage-keys.h"
>  #include "hw/s390x/storage-attributes.h"
> +#include "hw/s390x/event-facility.h"
>  #include "hw/compat.h"
>  #include "ipl.h"
>  #include "hw/s390x/s390-virtio-ccw.h"
> @@ -671,7 +672,12 @@ bool css_migration_enabled(void)
>      type_init(ccw_machine_register_##suffix)
> 
>  #define CCW_COMPAT_2_11 \
> -        HW_COMPAT_2_11
> +        HW_COMPAT_2_11 \
> +        {\
> +            .driver   = TYPE_SCLP_EVENT_FACILITY,\
> +            .property = "allow_all_mask_sizes",\
> +            .value    = "off",\
> +        },

then set the mask_len here

or is this overkill? In the end it should not matter as the active mask is 0 so the
length does not matter.


> 
>  #define CCW_COMPAT_2_10 \
>          HW_COMPAT_2_10
> 
