Received: from eggs.gnu.org ([2001:4830:134:3::10]:49059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eIG1D-00033q-Qx
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 10:36:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eIG1C-00041d-2Z
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 10:35:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57276
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eIG1B-00041U-Tf
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 10:35:54 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAOFZZgR017144
	for <qemu-devel@nongnu.org>; Fri, 24 Nov 2017 10:35:51 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2eek8r7vv7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 24 Nov 2017 10:35:50 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 24 Nov 2017 15:35:49 -0000
References: <20171124153344.22972-1-cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 24 Nov 2017 16:35:45 +0100
MIME-Version: 1.0
In-Reply-To: <20171124153344.22972-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <c38453e2-d738-9cb4-5ba3-217ea1a9e9a8@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12] s390x: introduce 2.12 compat
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: agraf@suse.de, rth@twiddle.net, thuth@redhat.com, david@redhat.com



On 11/24/2017 04:33 PM, Cornelia Huck wrote:
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Just to be ahead of ARM again? ;-)

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>+


> ---
>  hw/s390x/s390-virtio-ccw.c | 17 ++++++++++++++++-
>  include/hw/compat.h        |  3 +++
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 6a57f94197..a23b8aec9f 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -639,6 +639,9 @@ bool css_migration_enabled(void)
>      }                                                                         \
>      type_init(ccw_machine_register_##suffix)
> 
> +#define CCW_COMPAT_2_11 \
> +        HW_COMPAT_2_11
> +
>  #define CCW_COMPAT_2_10 \
>          HW_COMPAT_2_10
> 
> @@ -716,14 +719,26 @@ bool css_migration_enabled(void)
>              .value    = "0",\
>          },
> 
> +static void ccw_machine_2_12_instance_options(MachineState *machine)
> +{
> +}
> +
> +static void ccw_machine_2_12_class_options(MachineClass *mc)
> +{
> +}
> +DEFINE_CCW_MACHINE(2_12, "2.12", true);
> +
>  static void ccw_machine_2_11_instance_options(MachineState *machine)
>  {
> +    ccw_machine_2_12_instance_options(machine);
>  }
> 
>  static void ccw_machine_2_11_class_options(MachineClass *mc)
>  {
> +    ccw_machine_2_12_class_options(mc);
> +    SET_MACHINE_COMPAT(mc, CCW_COMPAT_2_11);
>  }
> -DEFINE_CCW_MACHINE(2_11, "2.11", true);
> +DEFINE_CCW_MACHINE(2_11, "2.11", false);
> 
>  static void ccw_machine_2_10_instance_options(MachineState *machine)
>  {
> diff --git a/include/hw/compat.h b/include/hw/compat.h
> index cf389b4e85..263de973a7 100644
> --- a/include/hw/compat.h
> +++ b/include/hw/compat.h
> @@ -1,6 +1,9 @@
>  #ifndef HW_COMPAT_H
>  #define HW_COMPAT_H
> 
> +#define HW_COMPAT_2_11 \
> +    /* empty */
> +
>  #define HW_COMPAT_2_10 \
>      {\
>          .driver   = "virtio-mouse-device",\
> 
