Received: from eggs.gnu.org ([2001:4830:134:3::10]:59361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dGO64-0002nN-0n
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:16:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dGO60-0007NE-N4
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:16:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55129)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1dGO60-0007Lt-Cj
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:16:52 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v51BDh5R070460
	for <qemu-devel@nongnu.org>; Thu, 1 Jun 2017 07:16:51 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2at9k9fhen-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 07:16:50 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 1 Jun 2017 12:16:47 +0100
Date: Thu, 1 Jun 2017 13:16:43 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170529135520.101429-4-pasic@linux.vnet.ibm.com>
References: <20170529135520.101429-1-pasic@linux.vnet.ibm.com>
	<20170529135520.101429-4-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170601131643.0cf0402b.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/7] s390x: add css_migration_enabled to
 machine class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org

On Mon, 29 May 2017 15:55:16 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> Currently the migration of the channel subsystem (css) is only partial
> and is done by the virtio ccw proxies -- the only migratable  css devices

extra blank ---------------------------------------------------^

> existing at the moment.
> 
> With the current work on emulated and passthrough devices we need to
> decouple the migration of the channel subsystem state from virtio ccw,
> and have a separate section for it. A new section  however necessarily
> breaks the migration compatibility.
> 
> So let us introduce a switch at the machine class, and put it in 'off'
> state for now. We will turn the switch 'on' for future machines once all
> preparations are met. For compatibility  machines the switch will stay
> 'off'.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  hw/s390x/s390-virtio-ccw.c         | 13 +++++++++++++
>  include/hw/s390x/s390-virtio-ccw.h |  7 +++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 04148916ed..95256d3982 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -196,6 +196,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
> 
>      s390mc->ri_allowed = true;
>      s390mc->cpu_model_allowed = true;
> +    s390mc->css_migration_enabled = false; /* TODO: set to true */
>      mc->init = ccw_init;
>      mc->reset = s390_machine_reset;
>      mc->hot_add_cpu = s390_hot_add_cpu;
> @@ -344,6 +345,11 @@ static const TypeInfo ccw_machine_info = {
>      },
>  };
> 
> +bool css_migration_enabled(void)
> +{
> +    return get_machine_class()->css_migration_enabled;
> +}
> +
>  #define DEFINE_CCW_MACHINE(suffix, verstr, latest)                            \
>      static void ccw_machine_##suffix##_class_init(ObjectClass *oc,            \
>                                                    void *data)                 \
> @@ -445,6 +451,10 @@ static const TypeInfo ccw_machine_info = {
> 
>  static void ccw_machine_2_10_instance_options(MachineState *machine)
>  {
> +    /*
> +     * TODO Once preparations are done register vmstate for the css if
> +     * css_migration_enabled().
> +     */
>  }
> 
>  static void ccw_machine_2_10_class_options(MachineClass *mc)
> @@ -459,8 +469,11 @@ static void ccw_machine_2_9_instance_options(MachineState *machine)
> 
>  static void ccw_machine_2_9_class_options(MachineClass *mc)
>  {
> +    S390CcwMachineClass *s390mc = S390_MACHINE_CLASS(mc);
> +
>      ccw_machine_2_10_class_options(mc);
>      SET_MACHINE_COMPAT(mc, CCW_COMPAT_2_9);
> +    s390mc->css_migration_enabled = false;
>  }
>  DEFINE_CCW_MACHINE(2_9, "2.9", false);
> 
> diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
> index 7b8a3e4d74..e9c4f4182b 100644
> --- a/include/hw/s390x/s390-virtio-ccw.h
> +++ b/include/hw/s390x/s390-virtio-ccw.h
> @@ -38,6 +38,7 @@ typedef struct S390CcwMachineClass {
>      /*< public >*/
>      bool ri_allowed;
>      bool cpu_model_allowed;
> +    bool css_migration_enabled;
>  } S390CcwMachineClass;
> 
>  /* runtime-instrumentation allowed by the machine */
> @@ -45,4 +46,10 @@ bool ri_allowed(void);
>  /* cpu model allowed by the machine */
>  bool cpu_model_allowed(void);
> 
> +/**
> + * Returns true if (vmstate based) migration of the channel subsystem
> + * is enabled, false if it is disabled.
> + */
> +bool css_migration_enabled(void);
> +
>  #endif

Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
