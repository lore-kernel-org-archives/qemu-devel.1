Received: from eggs.gnu.org ([2001:4830:134:3::10]:45445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gST9B-0007ab-Nz
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 15:42:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gSSx1-0005Gl-RC
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 15:30:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1gSSx1-0005FG-E5
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 15:30:19 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wATKSWsd134728
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 15:30:17 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2p2k9uk0q5-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 15:30:16 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Thu, 29 Nov 2018 20:30:15 -0000
References: <1542904555-1136-1-git-send-email-pmorel@linux.ibm.com>
	<1542904555-1136-2-git-send-email-pmorel@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Thu, 29 Nov 2018 15:30:10 -0500
MIME-Version: 1.0
In-Reply-To: <1542904555-1136-2-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <91b8a21b-5dea-f944-1200-4491ad1d69f2@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/6] s390x/vfio: ap: Finding the AP
 bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com
Cc: cohuck@redhat.com, agraf@suse.de, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com, mst@redhat.com, eric.auger@redhat.com, pasic@linux.ibm.com

On 11/22/18 11:35 AM, Pierre Morel wrote:
> In the case we will enter QEMU through interception of instructions,
> we will need to retrieve the AP devices.
> The base device is the AP bridge.
> 
> Let us implement a way to retrieve the AP Bridge from qtree.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   hw/s390x/ap-bridge.c         | 12 ++++++++++++
>   include/hw/s390x/ap-bridge.h |  1 +
>   2 files changed, 13 insertions(+)
> 
> diff --git a/hw/s390x/ap-bridge.c b/hw/s390x/ap-bridge.c
> index 3795d30..831ad5d 100644
> --- a/hw/s390x/ap-bridge.c
> +++ b/hw/s390x/ap-bridge.c
> @@ -14,6 +14,18 @@
>   #include "hw/s390x/ap-bridge.h"
>   #include "cpu.h"
>   
> +DeviceState *s390_get_ap_bridge(void)
> +{
> +    static DeviceState *apb;

Since you are caching a reference to the bridge after
retrieving it, why not make apb a global scope variable
and initialize it in s390_init_ap() when the bridge is
created. You can then declare it as an extern in the
ap-bridge.h header file and you eliminate the need for
this function. If you do make it a global var, I would
name it ap_bridge;

> +
> +    if (!apb) {
> +        apb = DEVICE(object_resolve_path(TYPE_AP_BRIDGE, NULL));
> +        assert(apb != NULL);
> +    }
> +
> +    return apb;
> +}

> +
>   static char *ap_bus_get_dev_path(DeviceState *dev)
>   {
>       /* at most one */
> diff --git a/include/hw/s390x/ap-bridge.h b/include/hw/s390x/ap-bridge.h
> index 470e439..dacb877 100644
> --- a/include/hw/s390x/ap-bridge.h
> +++ b/include/hw/s390x/ap-bridge.h
> @@ -15,5 +15,6 @@
>   #define TYPE_AP_BUS "ap-bus"
>   
>   void s390_init_ap(void);
> +DeviceState *s390_get_ap_bridge(void);
>   
>   #endif
> 
