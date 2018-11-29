Received: from eggs.gnu.org ([2001:4830:134:3::10]:48023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gSKhj-00075G-UC
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 06:42:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gSKhg-0003mK-8a
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 06:41:59 -0500
Date: Thu, 29 Nov 2018 12:41:25 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181129124125.10c418d4.cohuck@redhat.com>
In-Reply-To: <1542904555-1136-2-git-send-email-pmorel@linux.ibm.com>
References: <1542904555-1136-1-git-send-email-pmorel@linux.ibm.com>
	<1542904555-1136-2-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com, mst@redhat.com, eric.auger@redhat.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com

On Thu, 22 Nov 2018 17:35:50 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> In the case we will enter QEMU through interception of instructions,
> we will need to retrieve the AP devices.
> The base device is the AP bridge.
> 
> Let us implement a way to retrieve the AP Bridge from qtree.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  hw/s390x/ap-bridge.c         | 12 ++++++++++++
>  include/hw/s390x/ap-bridge.h |  1 +
>  2 files changed, 13 insertions(+)
> 
> diff --git a/hw/s390x/ap-bridge.c b/hw/s390x/ap-bridge.c
> index 3795d30..831ad5d 100644
> --- a/hw/s390x/ap-bridge.c
> +++ b/hw/s390x/ap-bridge.c
> @@ -14,6 +14,18 @@
>  #include "hw/s390x/ap-bridge.h"
>  #include "cpu.h"
>  
> +DeviceState *s390_get_ap_bridge(void)
> +{
> +    static DeviceState *apb;
> +
> +    if (!apb) {
> +        apb = DEVICE(object_resolve_path(TYPE_AP_BRIDGE, NULL));
> +        assert(apb != NULL);

As you won't have an ap bridge if the ap feature is not provided,
better do a quick exit if the feature bit is not set? I'd naively
assume that this function can return NULL as well.

> +    }
> +
> +    return apb;
> +}
> +
>  static char *ap_bus_get_dev_path(DeviceState *dev)
>  {
>      /* at most one */
