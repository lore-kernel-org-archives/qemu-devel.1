Received: from eggs.gnu.org ([2001:4830:134:3::10]:50257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dufSv-0001Sr-Tf
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:55:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dufSs-0005PL-Mn
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:55:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dufSs-0005OP-Dr
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:54:58 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8KCdlx6108928
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 08:39:56 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d3r0paam2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 08:39:56 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 20 Sep 2017 13:39:53 +0100
References: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
	<1500028867-134709-34-git-send-email-borntraeger@de.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 20 Sep 2017 14:39:50 +0200
MIME-Version: 1.0
In-Reply-To: <1500028867-134709-34-git-send-email-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <5eb9a7bd-2761-bea1-738a-da7a6d3fbfcf@de.ibm.com>
Subject: Re: [Qemu-devel] [PULL 33/40] s390x/flic: migrate ais states
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Looks like this patch broke migration from 2.10 to 2.9 (and older)
when ais is active. 

2.9 says
error while loading state for instance 0x0 of device 's390-flic'

So we need to fence this for older machines types than 2.10.
This should also go in 2.10.1.

Will have a look.



On 07/14/2017 12:41 PM, Christian Borntraeger wrote:
> From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> 
> During migration we should transfer ais states to the target guest.
> This patch introduces a subsection to kvm_s390_flic_vmstate and new
> vmsd for qemu_flic. The ais states need to be migrated only when
> ais is supported.
> 
> Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/intc/s390_flic.c          | 20 +++++++++++
>  hw/intc/s390_flic_kvm.c      | 81 ++++++++++++++++++++++++++++++++++++++++++++
>  include/hw/s390x/s390_flic.h |  1 +
>  3 files changed, 102 insertions(+)
> 
> diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
> index 6e7c610..6eaf178 100644
> --- a/hw/intc/s390_flic.c
> +++ b/hw/intc/s390_flic.c
> @@ -134,12 +134,32 @@ static void qemu_s390_flic_reset(DeviceState *dev)
>      flic->nimm = 0;
>  }
> 
> +bool ais_needed(void *opaque)
> +{
> +    S390FLICState *s = opaque;
> +
> +    return s->ais_supported;
> +}
> +
> +static const VMStateDescription qemu_s390_flic_vmstate = {
> +    .name = "qemu-s390-flic",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = ais_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT8(simm, QEMUS390FLICState),
> +        VMSTATE_UINT8(nimm, QEMUS390FLICState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static void qemu_s390_flic_class_init(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(oc);
>      S390FLICStateClass *fsc = S390_FLIC_COMMON_CLASS(oc);
> 
>      dc->reset = qemu_s390_flic_reset;
> +    dc->vmsd = &qemu_s390_flic_vmstate;
>      fsc->register_io_adapter = qemu_s390_register_io_adapter;
>      fsc->io_adapter_map = qemu_s390_io_adapter_map;
>      fsc->add_adapter_routes = qemu_s390_add_adapter_routes;
> diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
> index d93503f..be3fd00 100644
> --- a/hw/intc/s390_flic_kvm.c
> +++ b/hw/intc/s390_flic_kvm.c
> @@ -413,7 +413,84 @@ out:
>      return r;
>  }
> 
> +typedef struct KVMS390FLICStateMigTmp {
> +    KVMS390FLICState *parent;
> +    uint8_t simm;
> +    uint8_t nimm;
> +} KVMS390FLICStateMigTmp;
> +
> +static void kvm_flic_ais_pre_save(void *opaque)
> +{
> +    KVMS390FLICStateMigTmp *tmp = opaque;
> +    KVMS390FLICState *flic = tmp->parent;
> +    struct kvm_s390_ais_all ais;
> +    struct kvm_device_attr attr = {
> +        .group = KVM_DEV_FLIC_AISM_ALL,
> +        .addr = (uint64_t)&ais,
> +        .attr = sizeof(ais),
> +    };
> +
> +    if (ioctl(flic->fd, KVM_GET_DEVICE_ATTR, &attr)) {
> +        error_report("Failed to retrieve kvm flic ais states");
> +        return;
> +    }
> +
> +    tmp->simm = ais.simm;
> +    tmp->nimm = ais.nimm;
> +}
> +
> +static int kvm_flic_ais_post_load(void *opaque, int version_id)
> +{
> +    KVMS390FLICStateMigTmp *tmp = opaque;
> +    KVMS390FLICState *flic = tmp->parent;
> +    struct kvm_s390_ais_all ais = {
> +        .simm = tmp->simm,
> +        .nimm = tmp->nimm,
> +    };
> +    struct kvm_device_attr attr = {
> +        .group = KVM_DEV_FLIC_AISM_ALL,
> +        .addr = (uint64_t)&ais,
> +    };
> +
> +    /* This can happen when the user mis-configures its guests in an
> +     * incompatible fashion or without a CPU model. For example using
> +     * qemu with -cpu host (which is not migration safe) and do a
> +     * migration from a host that has AIS to a host that has no AIS.
> +     * In that case the target system will reject the migration here.
> +     */
> +    if (!ais_needed(flic)) {
> +        return -ENOSYS;
> +    }
> +
> +    return ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr) ? -errno : 0;
> +}
> +
> +static const VMStateDescription kvm_s390_flic_ais_tmp = {
> +    .name = "s390-flic-ais-tmp",
> +    .pre_save = kvm_flic_ais_pre_save,
> +    .post_load = kvm_flic_ais_post_load,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT8(simm, KVMS390FLICStateMigTmp),
> +        VMSTATE_UINT8(nimm, KVMS390FLICStateMigTmp),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const VMStateDescription kvm_s390_flic_vmstate_ais = {
> +    .name = "s390-flic/ais",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = ais_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_WITH_TMP(KVMS390FLICState, KVMS390FLICStateMigTmp,
> +                         kvm_s390_flic_ais_tmp),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription kvm_s390_flic_vmstate = {
> +    /* should have been like kvm-s390-flic,
> +     * can't change without breaking compat */
>      .name = "s390-flic",
>      .version_id = FLIC_SAVEVM_VERSION,
>      .minimum_version_id = FLIC_SAVEVM_VERSION,
> @@ -428,6 +505,10 @@ static const VMStateDescription kvm_s390_flic_vmstate = {
>              .flags = VMS_SINGLE,
>          },
>          VMSTATE_END_OF_LIST()
> +    },
> +    .subsections = (const VMStateDescription * []) {
> +        &kvm_s390_flic_vmstate_ais,
> +        NULL
>      }
>  };
> 
> diff --git a/include/hw/s390x/s390_flic.h b/include/hw/s390x/s390_flic.h
> index 2f173d9..7aab6ef 100644
> --- a/include/hw/s390x/s390_flic.h
> +++ b/include/hw/s390x/s390_flic.h
> @@ -89,6 +89,7 @@ typedef struct QEMUS390FLICState {
>  void s390_flic_init(void);
> 
>  S390FLICState *s390_get_flic(void);
> +bool ais_needed(void *opaque);
> 
>  #ifdef CONFIG_KVM
>  DeviceState *s390_flic_kvm_create(void);
> 
