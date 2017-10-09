Received: from eggs.gnu.org ([2001:4830:134:3::10]:49062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e1TeH-0006Ff-Uj
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 04:43:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e1TeD-0008HO-OW
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 04:42:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e1TeD-0008H5-FY
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 04:42:49 -0400
Date: Mon, 9 Oct 2017 10:42:44 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171009104244.02d60070.cohuck@redhat.com>
In-Reply-To: <1507124979-8880-4-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1507124979-8880-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1507124979-8880-4-git-send-email-pmorel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 3/5] s390x/intc: Emulate Adapter
 Interrupt Suppression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

On Wed,  4 Oct 2017 15:49:37 +0200
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> Emulate the Adapter Interrupt Suppression in the KVM FLIC interface when
> the kernel does not support AIS.
> 
> When the kernel KVM does not support AIS, we can not support VFIO PCI
> devices but we still can support emulated devices if we emulate AIS
> inside QEMU.
> Let's emulate AIS, allowing to use emulated PCI devices without KVM AIS
> support.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> ---
>  hw/intc/s390_flic.c     |  3 +-
>  hw/intc/s390_flic_kvm.c | 76 ++++++++++++++++++++++++++++++++++++++++---------
>  2 files changed, 64 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
> index 6eaf178..33a7cde 100644
> --- a/hw/intc/s390_flic.c
> +++ b/hw/intc/s390_flic.c
> @@ -185,8 +185,7 @@ static void s390_flic_common_realize(DeviceState *dev, Error **errp)
>                     " (%d > %d)", max_batch, ADAPTER_ROUTES_MAX_GSI);
>          return;
>      }
> -
> -    fs->ais_supported = s390_has_feat(S390_FEAT_ADAPTER_INT_SUPPRESSION);
> +    fs->ais_supported = false;
>  }
>  
>  static void s390_flic_class_init(ObjectClass *oc, void *data)
> diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
> index 7ead17a..fd1aa22 100644
> --- a/hw/intc/s390_flic_kvm.c
> +++ b/hw/intc/s390_flic_kvm.c
> @@ -33,6 +33,8 @@ typedef struct KVMS390FLICState {
>  
>      uint32_t fd;
>      bool clear_io_supported;
> +    uint8_t simm;
> +    uint8_t nimm;
>  } KVMS390FLICState;

Instead of duplicating this, move simm/nimm into the common flic state?

>  
>  DeviceState *s390_flic_kvm_create(void)
> @@ -164,11 +166,24 @@ static int kvm_s390_modify_ais_mode(S390FLICState *fs, uint8_t isc,
>          .addr = (uint64_t)&req,
>      };
>  
> -    if (!fs->ais_supported) {
> -        return -ENOSYS;
> +    if (fs->ais_supported) {
> +        return ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr) ? -errno : 0;
>      }
>  
> -    return ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr) ? -errno : 0;
> +    /* Kernel does not support AIS, emulate it here */
> +    switch (mode) {
> +    case SIC_IRQ_MODE_ALL:
> +        flic->simm &= ~AIS_MODE_MASK(isc);
> +        flic->nimm &= ~AIS_MODE_MASK(isc);
> +        break;
> +    case SIC_IRQ_MODE_SINGLE:
> +        flic->simm |= AIS_MODE_MASK(isc);
> +        flic->nimm &= ~AIS_MODE_MASK(isc);
> +        break;
> +    default:
> +        return -EINVAL;
> +    }

That's just the same as for the qemu flic. What about creating a
wrapper (to be called from css.c) in the common flic code that calls a
specific callback (only needed for kvm) and falls back to emulating if
it was not successful?

> +    return 0;
>  }
>  
>  static int kvm_s390_inject_airq(S390FLICState *fs, uint8_t type,
> @@ -180,12 +195,23 @@ static int kvm_s390_inject_airq(S390FLICState *fs, uint8_t type,
>          .group = KVM_DEV_FLIC_AIRQ_INJECT,
>          .attr = id,
>      };
> +    uint32_t io_int_word = (isc << 27) | IO_INT_WORD_AI;
>  
> -    if (!fs->ais_supported) {
> -        return -ENOSYS;
> +    if (fs->ais_supported) {
> +        return ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr) ? -errno : 0;
>      }
>  
> -    return ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr) ? -errno : 0;
> +    /* Kernel does not support AIS, emulate it here */
> +    if (flags && (flic->nimm & AIS_MODE_MASK(isc))) {
> +        return 0;
> +    }
> +
> +    s390_io_interrupt(0, 0, 0, io_int_word);
> +
> +    if (flags && (flic->simm & AIS_MODE_MASK(isc))) {
> +        flic->nimm |= AIS_MODE_MASK(isc);
> +    }

Same here: I think doing this in the generic flic would make sense.

> +    return 0;
>  }
>  
>  /**
> @@ -557,6 +583,32 @@ static void kvm_s390_flic_realize(DeviceState *dev, Error **errp)
>      test_attr.group = KVM_DEV_FLIC_CLEAR_IO_IRQ;
>      flic_state->clear_io_supported = !ioctl(flic_state->fd,
>                                              KVM_HAS_DEVICE_ATTR, test_attr);
> +    /* To support ais we need all these three FLIC attributes */
> +    test_attr.group = KVM_DEV_FLIC_AISM;
> +    ret = !ioctl(flic_state->fd, KVM_HAS_DEVICE_ATTR, test_attr);
> +    flic_state->parent_obj.ais_supported &= ret;
> +
> +    test_attr.group = KVM_DEV_FLIC_AIRQ_INJECT;
> +    ret = !ioctl(flic_state->fd, KVM_HAS_DEVICE_ATTR, test_attr);
> +    flic_state->parent_obj.ais_supported &= ret;
> +
> +    test_attr.group = KVM_DEV_FLIC_AISM_ALL;
> +    ret &= !ioctl(flic_state->fd, KVM_HAS_DEVICE_ATTR, test_attr);
> +    flic_state->parent_obj.ais_supported &= ret;
> +
> +    /* For buggy kernels we need to really test that the attribute is supported */

Ugh.

> +    {
> +        struct kvm_s390_ais_req req = {
> +            .mode = SIC_IRQ_MODE_ALL,
> +        };
> +        struct kvm_device_attr attr = {
> +            .group = KVM_DEV_FLIC_AISM,
> +            .addr = (uint64_t)&req,
> +        };
> +        ret = !ioctl(flic_state->fd, KVM_SET_DEVICE_ATTR, &attr);
> +    }
> +    flic_state->parent_obj.ais_supported &= ret;
> +
>      return;
>  fail:
>      error_propagate(errp, errp_local);
> @@ -578,13 +630,11 @@ static void kvm_s390_flic_reset(DeviceState *dev)
>  
>      flic_disable_wait_pfault(flic);
>  
> -    if (fs->ais_supported) {
> -        for (isc = 0; isc <= MAX_ISC; isc++) {
> -            rc = kvm_s390_modify_ais_mode(fs, isc, SIC_IRQ_MODE_ALL);
> -            if (rc) {
> -                error_report("Failed to reset ais mode for isc %d: %s",
> -                             isc, strerror(-rc));
> -            }
> +    for (isc = 0; isc <= MAX_ISC; isc++) {
> +        rc = kvm_s390_modify_ais_mode(fs, isc, SIC_IRQ_MODE_ALL);
> +        if (rc) {
> +            error_report("Failed to reset ais mode for isc %d: %s",
> +                         isc, strerror(-rc));
>          }
>      }
>  
