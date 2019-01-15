Received: from eggs.gnu.org ([209.51.188.92]:41932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gjXR1-0002Zd-CD
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 17:43:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gjXQx-0004e8-Ur
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 17:43:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1gjXQx-0004NW-9e
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 17:43:47 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0FMcUpR061196
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 17:43:26 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q1pd1xh9h-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 17:43:26 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Tue, 15 Jan 2019 22:43:25 -0000
References: <20190114103110.10909-1-david@redhat.com>
	<20190114103110.10909-4-david@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Tue, 15 Jan 2019 17:43:21 -0500
MIME-Version: 1.0
In-Reply-To: <20190114103110.10909-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <2a356708-03b9-e907-5ab0-9f5018bdf911@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/6] s390x/pci: Always delete and free
 the release_timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>

On 1/14/19 5:31 AM, David Hildenbrand wrote:
> We should always get rid of it. I don't see a reason to keep the timer
> alive if the devices are going away. This looks like a memory leak.
> 
> (hmp) device_add virtio-mouse-pci,id=test
> (hmp) device_del test
> -> guest notified, timer pending.
> -> guest does not react for some reason (e.g. crash)
> -> s390_pcihost_timer_cb(). Timer not pending anymore. qmp_unplug().
> 
> -> Device deleted. Timer expired (not pending) but not freed.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   hw/s390x/s390-pci-bus.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 1775388524..59325cae3b 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -982,7 +982,7 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>           return;
>       }
>   
> -    if (pbdev->release_timer && timer_pending(pbdev->release_timer)) {
> +    if (pbdev->release_timer) {
>           timer_del(pbdev->release_timer);
>           timer_free(pbdev->release_timer);
>           pbdev->release_timer = NULL;
> 

Looks like the only time we would hit this is when the device is already 
in standby (i.e. not configured). So this makes sense to me.

Reviewed-by: Collin Walling <walling@linux.ibm.com>
