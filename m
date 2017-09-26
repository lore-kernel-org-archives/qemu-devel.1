Received: from eggs.gnu.org ([2001:4830:134:3::10]:56000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dwowS-0005hw-2n
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 08:26:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dwowN-0001NW-5W
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 08:26:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dwowM-0001NA-T5
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 08:26:19 -0400
References: <20170922083855.102341-1-borntraeger@de.ibm.com>
	<20170922083855.102341-4-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a19a2b4f-af68-12d1-ee34-fbd174785c6f@redhat.com>
Date: Tue, 26 Sep 2017 14:26:15 +0200
MIME-Version: 1.0
In-Reply-To: <20170922083855.102341-4-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH/RFC 3/3] s390x/ais: disable ais for compat
 machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 22.09.2017 10:38, Christian Borntraeger wrote:
> With newer kernels that do support the ais feature (4.13) a qemu 2.11
> will not only enable the ais feature for the 2.11 machine, but also
> for a <=2.10 compat machine. As this feature is not available in
> QEMU <=2.9 (and QEMU 2.10.1), this guest will fail to migrate
> back to an older qemu like 2.9 with:
> 
> _snip_
> error while loading state for instance 0x0 of device 's390-flic'
> _snip_
> 
> making the whole compat machine dis-functional. As a permanent fix, we
> need to fence the ais feature for machines <= 2.10
> 
> Due to ais being enabled on 2.10.0 (fixed in 2.10.1) this will prevent
> migration of ais-enabled guests from 2.10.0 with
> 
> _snip_
> qemu-system-s390x: Failed to load s390-flic/ais:tmp
> qemu-system-s390x: error while loading state for instance 0x0 of device 's390-flic'
> qemu-system-s390x: load of migration failed: Function not implemented
> _snip_
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/intc/s390_flic_kvm.c            |  4 +++-
>  hw/s390x/s390-virtio-ccw.c         | 10 ++++++++++
>  include/hw/s390x/s390-virtio-ccw.h |  3 +++
>  3 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
> index a655567..2a94bfc 100644
> --- a/hw/intc/s390_flic_kvm.c
> +++ b/hw/intc/s390_flic_kvm.c
> @@ -22,6 +22,7 @@
>  #include "hw/s390x/s390_flic.h"
>  #include "hw/s390x/adapter.h"
>  #include "hw/s390x/css.h"
> +#include "hw/s390x/s390-virtio-ccw.h"
>  #include "trace.h"
>  
>  #define FLIC_SAVE_INITIAL_SIZE getpagesize()
> @@ -559,7 +560,8 @@ static void kvm_s390_flic_realize(DeviceState *dev, Error **errp)
>                                              KVM_HAS_DEVICE_ATTR, test_attr);
>      /* try enable the AIS facility */
>      test_attr.group = KVM_DEV_FLIC_AISM_ALL;
> -    if (!ioctl(flic_state->fd, KVM_HAS_DEVICE_ATTR, test_attr)) {
> +    if (ais_allowed() &&
> +        !ioctl(flic_state->fd, KVM_HAS_DEVICE_ATTR, test_attr)) {
>              kvm_vm_enable_cap(kvm_state, KVM_CAP_S390_AIS, 0);
>      }
>  

Wondering if this is really necessary. Shouldn't the CPU model feature
make sure that migration works?


-- 

Thanks,

David
