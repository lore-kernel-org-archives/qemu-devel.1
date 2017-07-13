Received: from eggs.gnu.org ([2001:4830:134:3::10]:38287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVdDP-0006Nq-F3
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:27:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVdDL-0006p5-D7
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:27:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:20592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dVdDL-0006ok-3O
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:27:27 -0400
Date: Thu, 13 Jul 2017 14:27:21 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170713142721.3a40e083@gondolin>
In-Reply-To: <1499942429-55449-4-git-send-email-borntraeger@de.ibm.com>
References: <1499942429-55449-1-git-send-email-borntraeger@de.ibm.com>
	<1499942429-55449-4-git-send-email-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH/s390-next 3/3] s390x/flic: migrate ais
 states
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>

On Thu, 13 Jul 2017 12:40:29 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> 
> During migration we should transfer ais states to the target guest.
> This patch introduces a subsection to kvm_s390_flic_vmstate and new
> vmsd for qemu_flic. The ais states need to be migrated only when
> ais is supported.
> 
> Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  hw/intc/s390_flic.c          | 20 ++++++++++++
>  hw/intc/s390_flic_kvm.c      | 75 ++++++++++++++++++++++++++++++++++++++++++++
>  include/hw/s390x/s390_flic.h |  1 +
>  3 files changed, 96 insertions(+)
> 

> diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
> index d93503f..4cf73ee 100644
> --- a/hw/intc/s390_flic_kvm.c
> +++ b/hw/intc/s390_flic_kvm.c
> @@ -413,7 +413,78 @@ out:
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

There's not much else we can do in that case, is there?

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
> +    if (!ais_needed(flic)) {
> +        return -ENOSYS;
> +    }

I do not understand this... does that mean that
- we should never get here or 
- we should not try to change the fields or
- I need coffee?

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

:/

>      .name = "s390-flic",
>      .version_id = FLIC_SAVEVM_VERSION,
>      .minimum_version_id = FLIC_SAVEVM_VERSION,
