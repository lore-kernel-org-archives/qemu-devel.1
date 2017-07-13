Received: from eggs.gnu.org ([2001:4830:134:3::10]:59569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVcyW-0006Rg-UV
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:12:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVcyR-0000Ez-Rk
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:12:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dVcyR-0000Et-Hv
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:12:03 -0400
Date: Thu, 13 Jul 2017 14:11:58 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170713141158.32e74897@gondolin>
In-Reply-To: <1499942429-55449-3-git-send-email-borntraeger@de.ibm.com>
References: <1499942429-55449-1-git-send-email-borntraeger@de.ibm.com>
	<1499942429-55449-3-git-send-email-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH/s390-next 2/3] s390x/cpumodel: add zpci,
 aen and ais facilities
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

On Thu, 13 Jul 2017 12:40:28 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> 
> zPCI instructions and facilities are available since IBM zEnterprise
> EC12. To support z/PCI in QEMU we enable zpci, aen and ais facilities
> starting with zEC12 GA1. And we always set zpci and aen bits in max cpu
> model. Later they might be switched off due to applied real cpu model.
> For ais bit, we only provide it in the full cpu model beginning with
> zEC12 and defer its enablement in the default cpu model to a later point
> in time. At the same time, disable them for 2.9 and older machines.
> 
> Because of introducing AIS facility, we could check if it's enabled to
> initialize flic->ais_supported with the real value.
> 
> Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  hw/intc/s390_flic.c             | 3 ++-
>  hw/intc/s390_flic_kvm.c         | 3 ---
>  hw/s390x/s390-virtio-ccw.c      | 3 +++
>  target/s390x/cpu_features.c     | 3 +++
>  target/s390x/cpu_features_def.h | 3 +++
>  target/s390x/gen-features.c     | 5 +++++
>  target/s390x/kvm.c              | 7 +++++++
>  7 files changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
> index ff6e4ec..6e7c610 100644
> --- a/hw/intc/s390_flic.c
> +++ b/hw/intc/s390_flic.c
> @@ -163,9 +163,10 @@ static void s390_flic_common_realize(DeviceState *dev, Error **errp)
>      if (max_batch > ADAPTER_ROUTES_MAX_GSI) {
>          error_setg(errp, "flic property adapter_routes_max_batch too big"
>                     " (%d > %d)", max_batch, ADAPTER_ROUTES_MAX_GSI);
> +        return;

Hunk should go into a previous patch?

(And does it really matter?)

>      }
>  
> -    fs->ais_supported = true;
> +    fs->ais_supported = s390_has_feat(S390_FEAT_ADAPTER_INT_SUPPRESSION);
>  }
>  
>  static void s390_flic_class_init(ObjectClass *oc, void *data)

> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 78ebe83..1901153 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -302,6 +302,9 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>          }
>      }
>  
> +    /* Try to enable AIS facility */
> +    kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0);

What happens if you fail to enable it? You probably don't want to allow
the feature bit, then?

> +
>      qemu_mutex_init(&qemu_sigp_mutex);
>  
>      return 0;

Let's summarize to make sure that I'm not confused:

- Starting with zEC12 GA1, we provide zpci, aen, ais in the full model
- Starting with zEC12 GA1, we provide zpci and aen in the default model
- In the host model, we add zpci and aen; they might be switched off
  after applying the found model
- Compat for 2.9 and earlier switches off zpci, aen, ais
- We unconditionally enable the kvm part of ais

I'm still not sure what's supposed to happen with new qemu + old kernel
(no ais) + full zEC12 GA1 or later model.
