Received: from eggs.gnu.org ([209.51.188.92]:45936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1ggu1Y-0001TZ-Aa
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:14:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1ggu1V-0002JK-HK
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:14:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59806)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1ggu1V-00022s-2c
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:14:37 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x08G9PZB131411
	for <qemu-devel@nongnu.org>; Tue, 8 Jan 2019 11:14:32 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2pvy4t0b06-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 11:14:32 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Tue, 8 Jan 2019 16:14:31 -0000
References: <1546963310-17024-1-git-send-email-akrowiak@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Tue, 8 Jan 2019 11:14:26 -0500
MIME-Version: 1.0
In-Reply-To: <1546963310-17024-1-git-send-email-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <acef92c0-d3d3-c3e4-583f-8c4e1057981e@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] s390x/vfio-ap: Implement hot plug/unplug
 of vfio-ap device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com, pmorel@linux.ibm.com, alifm@linux.ibm.com, mjrosato@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.vnet.ibm.com, alex.williamson@redhat.com, peter.maydell@linaro.org, rth@twiddle.net, fiuczy@linux.ibm.com

On 1/8/19 11:01 AM, Tony Krowiak wrote:
> Introduces hot plug/unplug support for the vfio-ap device. Note that only one
> vfio-ap device can be attached to the ap-bus, so a vfio-ap device can only be
> hot plugged if the '-device vfio-ap,sysfsdev=$path_to_mdev' option is not
> specified on the QEMU command line.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>
> Tested-by: Pierre Morel<pmorel@linux.ibm.com>
> ---
>   hw/s390x/ap-bridge.c | 12 +++++++++++-
>   hw/vfio/ap.c         |  2 +-
>   2 files changed, 12 insertions(+), 2 deletions(-)
> 

Please note: During testing of this patch I discovered a bug whereby an
attempt to plug in a vfio-ap device subsequent to an unplug of the
device will result in the following error:

error: Failed to attach device from /root/conf/vfio-ap.xml
error: internal error: unable to execute QEMU command 'device_add': No 
'ap-bus' bus found for device 'vfio-ap'

I wrote a patch for this bug:
Message ID: <1545062250-7573-1-git-send-email-akrowiak@linux.ibm.com>
