Received: from eggs.gnu.org ([2001:4830:134:3::10]:39376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dfnBh-0004oV-8t
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 09:07:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dfnBd-0006WW-SC
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 09:07:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dfnBd-0006W4-MF
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 09:07:41 -0400
References: <20170810123741.30449-1-cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <19dbd7b5-495b-4e8e-1af1-25501a342a63@redhat.com>
Date: Thu, 10 Aug 2017 15:07:37 +0200
MIME-Version: 1.0
In-Reply-To: <20170810123741.30449-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11] s390x: introduce 2.11 compat
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, thuth@redhat.com

On 10.08.2017 14:37, Cornelia Huck wrote:
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
> 
> It's that time again. I plan to put this into my first 2.11 pullreq.
> Yes, and I assume that the next version is indeed 2.11 :)
> 
> ---
>  hw/s390x/s390-virtio-ccw.c | 17 ++++++++++++++++-
>  include/hw/compat.h        |  3 +++
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 1c7af39ce6..d3d67b8d77 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -432,6 +432,9 @@ bool css_migration_enabled(void)
>      }                                                                         \
>      type_init(ccw_machine_register_##suffix)
>  
> +#define CCW_COMPAT_2_10 \
> +        HW_COMPAT_2_10
> +
>  #define CCW_COMPAT_2_9 \
>          HW_COMPAT_2_9 \
>          {\
> @@ -506,8 +509,18 @@ bool css_migration_enabled(void)
>              .value    = "0",\
>          },
>  
> +static void ccw_machine_2_11_instance_options(MachineState *machine)
> +{
> +}
> +
> +static void ccw_machine_2_11_class_options(MachineClass *mc)
> +{
> +}
> +DEFINE_CCW_MACHINE(2_11, "2.11", true);
> +
>  static void ccw_machine_2_10_instance_options(MachineState *machine)
>  {
> +    ccw_machine_2_11_instance_options(machine);
>      if (css_migration_enabled()) {
>          css_register_vmstate();
>      }
> @@ -515,8 +528,10 @@ static void ccw_machine_2_10_instance_options(MachineState *machine)
>  
>  static void ccw_machine_2_10_class_options(MachineClass *mc)
>  {
> +    ccw_machine_2_11_class_options(mc);
> +    SET_MACHINE_COMPAT(mc, CCW_COMPAT_2_10);
>  }
> -DEFINE_CCW_MACHINE(2_10, "2.10", true);
> +DEFINE_CCW_MACHINE(2_10, "2.10", false);
>  
>  static void ccw_machine_2_9_instance_options(MachineState *machine)
>  {
> diff --git a/include/hw/compat.h b/include/hw/compat.h
> index 08f36004da..3e101f8f67 100644
> --- a/include/hw/compat.h
> +++ b/include/hw/compat.h
> @@ -1,6 +1,9 @@
>  #ifndef HW_COMPAT_H
>  #define HW_COMPAT_H
>  
> +#define HW_COMPAT_2_10 \
> +    /* empty */
> +
>  #define HW_COMPAT_2_9 \
>      {\
>          .driver   = "pci-bridge",\
> 

Looks just fine to me.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David
