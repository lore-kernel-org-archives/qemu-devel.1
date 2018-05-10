Received: from eggs.gnu.org ([2001:4830:134:3::10]:43331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1fGlL2-000582-LZ
	for qemu-devel@nongnu.org; Thu, 10 May 2018 09:10:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1fGlKz-0007bB-BD
	for qemu-devel@nongnu.org; Thu, 10 May 2018 09:10:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50526
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.vnet.ibm.com>)
	id 1fGlKz-0007aj-5y
	for qemu-devel@nongnu.org; Thu, 10 May 2018 09:10:25 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4AD8ELP075061
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 09:10:24 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2hvmt95dd6-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 09:10:24 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.vnet.ibm.com>;
	Thu, 10 May 2018 09:10:22 -0400
References: <1525782303-16940-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1525782303-16940-5-git-send-email-akrowiak@linux.vnet.ibm.com>
	<c36ec83f-8cba-cf7b-3054-35cf4cd65c14@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Thu, 10 May 2018 09:10:15 -0400
MIME-Version: 1.0
In-Reply-To: <c36ec83f-8cba-cf7b-3054-35cf4cd65c14@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <1806faa3-dc46-f638-5c87-8a7415c9025a@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 4/6] s390x/vfio: ap: Introduce VFIO AP
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

On 05/09/2018 10:28 AM, Halil Pasic wrote:
>
>
> On 05/08/2018 02:25 PM, Tony Krowiak wrote:
>> Introduces a VFIO based AP device. The device is defined via
>> the QEMU command line by specifying:
>>
>>      -device vfio-ap,sysfsdev=<path-to-mediated-matrix-device>
>>
>> There may be only one vfio-ap device configured for a guest.
>>
>> The mediated matrix device is created by the VFIO AP device
> [..]
>> + * directory.
>> + */
>> +
>> +#include <linux/vfio.h>
>> +#include <sys/ioctl.h>
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "hw/sysbus.h"
>> +#include "hw/vfio/vfio.h"
>> +#include "hw/vfio/vfio-common.h"
>> +#include "hw/s390x/ap-device.h"
>> +#include "qemu/error-report.h"
>> +#include "qemu/queue.h"
>> +#include "qemu/option.h"
>> +#include "qemu/config-file.h"
>> +#include "cpu.h"
>> +#include "kvm_s390x.h"
>> +#include "sysemu/sysemu.h"
>> +
>> +#define VFIO_AP_DEVICE_TYPE      "vfio-ap"
>> +
>> +typedef struct VFIOAPDevice {
>> +    APDevice apdev;
>> +    VFIODevice vdev;
>> +    QTAILQ_ENTRY(VFIOAPDevice) sibling;
>> +} VFIOAPDevice;
>> +
>> +VFIOAPDevice *vfio_apdev;
>> +
>> +static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
>> +{
>> +    vdev->needs_reset = false;
>> +}
>> +
>> +/*
>> + * We don't need vfio_hot_reset_multi and vfio_eoi operations for
>> + * vfio-ap-matrix device now.
>> + */
>> +struct VFIODeviceOps vfio_ap_ops = {
>> +    .vfio_compute_needs_reset = vfio_ap_compute_needs_reset,
>> +};
>> +
>
> I'm not familiar with the vfio infrastructure, but AFAIR I
> haven't seen any substantial reset handling (QEMU or kernel).
> Did I miss something?

No, you didn't miss anything, there is no reset handling.

>
> If I did not. I think this is a big problem. We need to at least
> zeroize the queues (e.g. on system reset)  to avoid leaking
> sensitive information. Without this, there is no sane way to use
> ap-passthrough. Or am I wrong?

I do not have a definitive answer, I will have to look into it.
I'm thinking that since we are using ap-passthrough, the AP bus
running on the guest would be responsible for handling reset possibly
by resetting or zeroizing its queues. I'll get back to you on this.

>
> Regards,
> Halil
>
