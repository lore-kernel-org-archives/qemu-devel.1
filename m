Received: from eggs.gnu.org ([209.51.188.92]:58834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gjXaZ-0005wO-Ds
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 17:53:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gjXaW-0007Za-Ks
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 17:53:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34702
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1gjXaW-0007ML-DE
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 17:53:40 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0FMngo1071223
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 17:53:23 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2q1nqtgyx0-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 17:53:22 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Tue, 15 Jan 2019 22:53:22 -0000
References: <20190114103110.10909-1-david@redhat.com>
	<20190114103110.10909-5-david@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Tue, 15 Jan 2019 17:53:17 -0500
MIME-Version: 1.0
In-Reply-To: <20190114103110.10909-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <e897906c-9e69-16e2-9039-1e55fbac576e@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/6] s390x/pci: Ignore the unplug call
 if we already have a release_timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 1/14/19 5:31 AM, David Hildenbrand wrote:
> ... otherwise two successive calls to qdev_unplug() (e.g. by an impatient
> user) will effectively overwrite pbdev->release_timer, resulting in a
> memory leak. We are already processing the unplug.
> 

Does QEMU not have a way to detect if a device is already in the process 
of being unplugged? Seems like not having that kind of protection could 
cause many problems.

Perhaps that effort would be arduous.

> If there is already a release_timer, the unplug will be performed after
> the timeout.
> 
> Can be easily triggered by
> (hmp) device_add virtio-mouse-pci,id=test
> (hmp) stop
> (hmp) device_del test
> (hmp) device_del test
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   hw/s390x/s390-pci-bus.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 59325cae3b..34a9cb2a80 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -972,6 +972,9 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>       case ZPCI_FS_STANDBY:
>           break;
>       default:
> +        if (pbdev->release_timer) {
> +            return;
> +        }
>           s390_pci_generate_plug_event(HP_EVENT_DECONFIGURE_REQUEST,
>                                        pbdev->fh, pbdev->fid);
>           pbdev->release_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
> 

Looks good to me.

Reviewed-by: Collin Walling <walling@linux.ibm.com>
