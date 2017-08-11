Received: from eggs.gnu.org ([2001:4830:134:3::10]:44241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dg88L-000797-Q0
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 07:29:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dg88G-0000ai-TE
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 07:29:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dg88G-0000aM-JV
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 07:29:36 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7BBTJn8034207
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 07:29:35 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2c99gxppcn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 07:29:34 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 11 Aug 2017 12:29:32 +0100
References: <20170810123741.30449-1-cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 11 Aug 2017 13:29:26 +0200
MIME-Version: 1.0
In-Reply-To: <20170810123741.30449-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <cd652715-48bc-727d-ce31-b3d048564f64@linux.vnet.ibm.com>
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
Cc: thuth@redhat.com, david@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, rth@twiddle.net

;

On 08/10/2017 02:37 PM, Cornelia Huck wrote:
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

LGTM

Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
