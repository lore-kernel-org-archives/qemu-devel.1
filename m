Received: from eggs.gnu.org ([209.51.188.92]:60138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1h3M4R-00066e-0W
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:38:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1h3M4P-0008IX-SF
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:38:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42486
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1h3M4P-0008IF-Lk
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:38:25 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x2BEYKxQ071777
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 10:38:25 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2r5pg4h9hj-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 10:37:46 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Mon, 11 Mar 2019 14:37:22 -0000
References: <1550519397-25359-1-git-send-email-akrowiak@linux.ibm.com>
	<20190225134238.4ad9b951.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Mon, 11 Mar 2019 10:37:14 -0400
MIME-Version: 1.0
In-Reply-To: <20190225134238.4ad9b951.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <44fd99ea-13b4-6dc7-7190-387dd4776005@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/2] s390x/vfio-ap: hot plug/unplug
 vfio-ap device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, borntraeger@de.ibm.com, david@redhat.com, pmorel@linux.ibm.com, alifm@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, fiuczy@linux.ibm.com

On 2/25/19 7:42 AM, Cornelia Huck wrote:
> On Mon, 18 Feb 2019 14:49:55 -0500
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> 
>> This patch series introduces hot plug/unplug of a vfio-ap device.
>>
>> To hot plug a vfio-ap device, the QEMU device_add function may be used:
>>
>>     (qemu) device_add vfio-ap,sysfsdev=$path-to-mdev
>>
>>     Where $path-to-mdev is the absolute path to the mediated matrix device
>>     to which AP resources to be used by the guest have been assigned.
>>
>>     A vfio-ap device can be hot plugged only if:
>>
>>     1. A vfio-ap device has not been attached to the ap-bus (only one is
>>        allowed per guest) either via the QEMU command line or a prior hot
>>        plug action.
>>
>>     2. The guest was started with the CPU model feature for AP enabled
>>        (e.g., -cpu host,ap=on).
>>
>> To hot unplug a vfio-ap device, the QEMU device-del function may be used:
>>
>>     (qemu) device_del vfio-ap,sysfsdev=$path-to-mdev
>>
>>     Where $path-to-mdev is the absolute path to the mediated matrix device
>>     specified when the vfio-ap device was attached to the virtual machine's
>>     ap-bus.
>>
>>     A vfio-ap device can be hot unplugged only if:
>>
>>     1. A vfio-ap device has been attached to the virtual machine's ap-abus
>>        either via the QEMU command line or a prior hot plug action.
>>
>>     2. The guest was started with the CPU model feature for AP enabled
>>        (e.g., -cpu host,ap=on).
>>
>> Tony Krowiak (2):
>>    s390x/vfio-ap: Implement hot plug/unplug of vfio-ap device
>>    s390x/vfio-ap: document hot plug/unplug of vfio-ap device
>>
>>   docs/vfio-ap.txt     | 58 +++++++++++++++++++++++++++++++++++++++++++++++-----
>>   hw/s390x/ap-bridge.c | 12 ++++++++++-
>>   hw/vfio/ap.c         |  2 +-
>>   3 files changed, 65 insertions(+), 7 deletions(-)
>>
> 
> In the meantime, the signature of qbus_set_hotplug_handler() has
> changed to take an Object instead of a DeviceState, but I just went
> ahead and did that trivial change myself.
> 
> Thanks, applied.

Thanks Connie.

> 
