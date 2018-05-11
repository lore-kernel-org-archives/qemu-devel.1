Received: from eggs.gnu.org ([2001:4830:134:3::10]:48919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1fH3xK-0006h9-0n
	for qemu-devel@nongnu.org; Fri, 11 May 2018 05:03:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1fH3xE-0007kB-1R
	for qemu-devel@nongnu.org; Fri, 11 May 2018 05:03:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38612
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1fH3xD-0007jb-TA
	for qemu-devel@nongnu.org; Fri, 11 May 2018 05:03:07 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4B8wxTh138337
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 05:03:05 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2hw4upraw6-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 05:03:05 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Fri, 11 May 2018 10:03:03 +0100
Reply-To: pmorel@linux.ibm.com
References: <1525782303-16940-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1525782303-16940-5-git-send-email-akrowiak@linux.vnet.ibm.com>
	<c36ec83f-8cba-cf7b-3054-35cf4cd65c14@linux.ibm.com>
	<1806faa3-dc46-f638-5c87-8a7415c9025a@linux.vnet.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri, 11 May 2018 11:02:56 +0200
MIME-Version: 1.0
In-Reply-To: <1806faa3-dc46-f638-5c87-8a7415c9025a@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <369a35de-4313-ee41-bb11-634c6bc45a72@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
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
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

On 10/05/2018 15:10, Tony Krowiak wrote:
> On 05/09/2018 10:28 AM, Halil Pasic wrote:
>>
>>
>> On 05/08/2018 02:25 PM, Tony Krowiak wrote:
>>> Introduces a VFIO based AP device. The device is defined via
>>> the QEMU command line by specifying:
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 -device vfio-ap,sysfsdev=3D<path-to-mediated=
-matrix-device>
>>>
>>> There may be only one vfio-ap device configured for a guest.
>>>
>>> The mediated matrix device is created by the VFIO AP device
>> [..]
>>> + * directory.
>>> + */
>>> +
>>> +#include <linux/vfio.h>
>>> +#include <sys/ioctl.h>
>>> +#include "qemu/osdep.h"
>>> +#include "qapi/error.h"
>>> +#include "hw/sysbus.h"
>>> +#include "hw/vfio/vfio.h"
>>> +#include "hw/vfio/vfio-common.h"
>>> +#include "hw/s390x/ap-device.h"
>>> +#include "qemu/error-report.h"
>>> +#include "qemu/queue.h"
>>> +#include "qemu/option.h"
>>> +#include "qemu/config-file.h"
>>> +#include "cpu.h"
>>> +#include "kvm_s390x.h"
>>> +#include "sysemu/sysemu.h"
>>> +
>>> +#define VFIO_AP_DEVICE_TYPE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "vfio-ap"
>>> +
>>> +typedef struct VFIOAPDevice {
>>> +=C2=A0=C2=A0=C2=A0 APDevice apdev;
>>> +=C2=A0=C2=A0=C2=A0 VFIODevice vdev;
>>> +=C2=A0=C2=A0=C2=A0 QTAILQ_ENTRY(VFIOAPDevice) sibling;
>>> +} VFIOAPDevice;
>>> +
>>> +VFIOAPDevice *vfio_apdev;
>>> +
>>> +static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 vdev->needs_reset =3D false;
>>> +}
>>> +
>>> +/*
>>> + * We don't need vfio_hot_reset_multi and vfio_eoi operations for
>>> + * vfio-ap-matrix device now.
>>> + */
>>> +struct VFIODeviceOps vfio_ap_ops =3D {
>>> +=C2=A0=C2=A0=C2=A0 .vfio_compute_needs_reset =3D vfio_ap_compute_nee=
ds_reset,
>>> +};
>>> +
>>
>> I'm not familiar with the vfio infrastructure, but AFAIR I
>> haven't seen any substantial reset handling (QEMU or kernel).
>> Did I miss something?
>
> No, you didn't miss anything, there is no reset handling.
>
>>
>> If I did not. I think this is a big problem. We need to at least
>> zeroize the queues (e.g. on system reset)=C2=A0 to avoid leaking
>> sensitive information. Without this, there is no sane way to use
>> ap-passthrough. Or am I wrong?
>
> I do not have a definitive answer, I will have to look into it.
> I'm thinking that since we are using ap-passthrough, the AP bus
> running on the guest would be responsible for handling reset possibly
> by resetting or zeroizing its queues. I'll get back to you on this.
>
>>
>> Regards,
>> Halil
>>
>
On the host, on system reset or subsystem reset, the queues are zeroized.

It means we must do the same for the guest and implement both cold and=20
hot reset.

One of the patches in the interrupt handling serie I sent last wednesday=20
zeroize
the queues on starting and stopping the guest so no data leak occurs=20
between
host and guests or between guests.

However we should follow the machine specification and zeroize the=20
queues between
two guest reset too. i.e. in the "reset" call back. and implement the=20
VFIO_DEVICE_RESET
ioctl.


Regards,

Pierre

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
