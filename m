Received: from eggs.gnu.org ([2001:4830:134:3::10]:43302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1f3hHh-0006kk-Sx
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:13:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1f3hHc-0001E3-Sv
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:13:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34946
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1f3hHc-0000mt-MD
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:12:56 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w34CBe4g070935
	for <qemu-devel@nongnu.org>; Wed, 4 Apr 2018 08:12:08 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h4x8h0ynm-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 08:12:08 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 4 Apr 2018 13:12:06 +0100
References: <20180329113320.8053-1-cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 4 Apr 2018 14:12:02 +0200
MIME-Version: 1.0
In-Reply-To: <20180329113320.8053-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <433ff540-a08c-bb99-4b35-cca998135584@de.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH for-2.13] s390x: introduce
 2.13 compat machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>



On 03/29/2018 01:33 PM, Cornelia Huck wrote:
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

> ---
> Yes, it's that time again :)
> ---
>  hw/s390x/s390-virtio-ccw.c | 17 ++++++++++++++++-
>  include/hw/compat.h        |  3 +++
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 864145a7c6..122f316f6a 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -668,6 +668,9 @@ bool css_migration_enabled(void)
>      }                                                                         \
>      type_init(ccw_machine_register_##suffix)
> 
> +#define CCW_COMPAT_2_12 \
> +        HW_COMPAT_2_12
> +
>  #define CCW_COMPAT_2_11 \
>          HW_COMPAT_2_11 \
>          {\
> @@ -753,14 +756,26 @@ bool css_migration_enabled(void)
>              .value    = "0",\
>          },
> 
> +static void ccw_machine_2_13_instance_options(MachineState *machine)
> +{
> +}
> +
> +static void ccw_machine_2_13_class_options(MachineClass *mc)
> +{
> +}
> +DEFINE_CCW_MACHINE(2_13, "2.13", true);
> +
>  static void ccw_machine_2_12_instance_options(MachineState *machine)
>  {
> +    ccw_machine_2_13_instance_options(machine);
>  }
> 
>  static void ccw_machine_2_12_class_options(MachineClass *mc)
>  {
> +    ccw_machine_2_13_class_options(mc);
> +    SET_MACHINE_COMPAT(mc, CCW_COMPAT_2_12);
>  }
> -DEFINE_CCW_MACHINE(2_12, "2.12", true);
> +DEFINE_CCW_MACHINE(2_12, "2.12", false);
> 
>  static void ccw_machine_2_11_instance_options(MachineState *machine)
>  {
> diff --git a/include/hw/compat.h b/include/hw/compat.h
> index bc9e3a6627..6e91491b77 100644
> --- a/include/hw/compat.h
> +++ b/include/hw/compat.h
> @@ -1,6 +1,9 @@
>  #ifndef HW_COMPAT_H
>  #define HW_COMPAT_H
> 
> +#define HW_COMPAT_2_12 \
> +    /* empty */
> +
>  #define HW_COMPAT_2_11 \
>      {\
>          .driver   = "hpet",\
> 
