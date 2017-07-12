Received: from eggs.gnu.org ([2001:4830:134:3::10]:45208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVJEX-0002hH-QI
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:07:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVJEU-0004Pf-D7
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:07:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dVJEU-0004PE-4C
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:07:18 -0400
Date: Wed, 12 Jul 2017 17:07:13 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170712170713.1f5cf6b2@dhcp-192-215.str.redhat.com>
In-Reply-To: <1499864265-144136-9-git-send-email-borntraeger@de.ibm.com>
References: <1499864265-144136-1-git-send-email-borntraeger@de.ibm.com>
	<1499864265-144136-9-git-send-email-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/11] s390x/flic: introduce
 modify_ais_mode callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Fei Li <sherrylf@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>

On Wed, 12 Jul 2017 14:57:42 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Fei Li <sherrylf@linux.vnet.ibm.com>
> 
> In order to emulate the adapter interruption suppression (AIS)
> facility properly, the guest needs to be able to modify the AIS mask.
> Interrupt suppression will be handled via the flic (for kvm, via a
> recently introduced kernel backend; for !kvm, in the flic code), so
> let's introduce a method to change the mode via the flic interface.
> 
> Co-authored-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> Signed-off-by: Fei Li <sherrylf@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  hw/intc/s390_flic.c          | 37 ++++++++++++++++++++++++++++++++++++-
>  hw/intc/s390_flic_kvm.c      | 36 ++++++++++++++++++++++++++++++++++++
>  include/hw/s390x/s390_flic.h |  9 ++++++++-
>  3 files changed, 80 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
> index d3938b3..ce7f355 100644
> --- a/hw/intc/s390_flic.c
> +++ b/hw/intc/s390_flic.c
> @@ -79,15 +79,47 @@ static int qemu_s390_clear_io_flic(S390FLICState *fs, uint16_t subchannel_id,
>      return -ENOSYS;
>  }
>  
> +static int qemu_s390_modify_ais_mode(S390FLICState *fs, uint8_t isc,
> +                                     uint16_t mode)
> +{
> +    QEMUS390FLICState *flic  = QEMU_S390_FLIC(fs);
> +
> +    switch (mode) {
> +    case SIC_IRQ_MODE_ALL:
> +        flic->simm &= ~AIS_MODE_MASK(isc);
> +        flic->nimm &= ~AIS_MODE_MASK(isc);
> +        break;
> +    case SIC_IRQ_MODE_SINGLE:
> +        flic->simm |= AIS_MODE_MASK(isc);
> +        flic->nimm &= ~AIS_MODE_MASK(isc);

Can we have some documentation about the meaning of simm/nimm in qemu?
The one from the patch description of the respective kernel patch would
be fine.

> +        break;
> +    default:
> +        return -EINVAL;
> +    }
> +
> +    return 0;
> +}
> +
>

(...)

> @@ -406,6 +427,7 @@ typedef struct KVMS390FLICStateClass {
>  
>  static void kvm_s390_flic_realize(DeviceState *dev, Error **errp)
>  {
> +    S390FLICState *fs = S390_FLIC_COMMON(dev);
>      KVMS390FLICState *flic_state = KVM_S390_FLIC(dev);
>      struct kvm_create_device cd = {0};
>      struct kvm_device_attr test_attr = {0};
> @@ -438,6 +460,7 @@ static void kvm_s390_flic_realize(DeviceState *dev, Error **errp)
>      flic_state->clear_io_supported = !ioctl(flic_state->fd,
>                                              KVM_HAS_DEVICE_ATTR, test_attr);
>  
> +    fs->ais_supported = false;

The patch actually enabling this for kvm is in the next batch of
patches, I assume?

>      return;
>  fail:
>      error_propagate(errp, errp_local);
