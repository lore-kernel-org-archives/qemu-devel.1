Received: from eggs.gnu.org ([2001:4830:134:3::10]:59280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1daIcF-0006Q8-7r
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 05:28:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1daIcC-0000cv-3q
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 05:28:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1daIcB-0000cb-Q7
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 05:28:24 -0400
References: <20170725153330.14966-1-cohuck@redhat.com>
	<20170725153330.14966-5-cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <94e8efb0-0cde-0a3f-339f-28647eec5f82@redhat.com>
Date: Wed, 26 Jul 2017 11:28:17 +0200
MIME-Version: 1.0
In-Reply-To: <20170725153330.14966-5-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 4/9] s390x/pci: do not advertise pci on
 non-pci builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, zyimin@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, agraf@suse.de, borntraeger@de.ibm.com

On 25.07.2017 17:33, Cornelia Huck wrote:
> Only set the zpci feature bit on builds that actually support pci.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/s390x/s390-pci-bus.c  | 5 +++++
>  hw/s390x/s390-pci-bus.h  | 1 +
>  hw/s390x/s390-pci-stub.c | 4 ++++
>  target/s390x/kvm.c       | 2 +-
>  4 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index c57f6ebae0..7b30d4c7bd 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -34,6 +34,11 @@
>          }                                                         \
>      } while (0)
>  
> +void pci_enable_zpci_feature(S390CPUModel *model)
> +{
> +    set_bit(S390_FEAT_ZPCI, model->features);
> +}
> +
>  S390pciState *s390_get_phb(void)
>  {
>      static S390pciState *phb;
> diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
> index 5df6292509..d8796536b0 100644
> --- a/hw/s390x/s390-pci-bus.h
> +++ b/hw/s390x/s390-pci-bus.h
> @@ -333,4 +333,5 @@ S390PCIBusDevice *s390_pci_find_dev_by_fid(S390pciState *s, uint32_t fid);
>  S390PCIBusDevice *s390_pci_find_next_avail_dev(S390pciState *s,
>                                                 S390PCIBusDevice *pbdev);
>  
> +void pci_enable_zpci_feature(S390CPUModel *model);
>  #endif
> diff --git a/hw/s390x/s390-pci-stub.c b/hw/s390x/s390-pci-stub.c
> index cc7278a865..8ceaf482e7 100644
> --- a/hw/s390x/s390-pci-stub.c
> +++ b/hw/s390x/s390-pci-stub.c
> @@ -72,3 +72,7 @@ S390PCIBusDevice *s390_pci_find_dev_by_idx(S390pciState *s, uint32_t idx)
>  {
>      return NULL;
>  }
> +
> +void pci_enable_zpci_feature(S390CPUModel *model)
> +{
> +}
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index c4c5791d27..866ac3d414 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -2662,7 +2662,7 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
>      }
>  
>      /* We emulate a zPCI bus and AEN, therefore we don't need HW support */
> -    set_bit(S390_FEAT_ZPCI, model->features);
> +    pci_enable_zpci_feature(model);

While I see how this solves the problem, I don't really like it. If
there is a function "save_the_world()" I expect it to save the world in
all scenarios ;)

What about the same approach but rather

if(pci_configured())
	set_bit(S390_FEAT_ZPCI, model->features);

Or of course zpci_configured(), pci_zpci_bus_available() ...

>      set_bit(S390_FEAT_ADAPTER_EVENT_NOTIFICATION, model->features);
>  
>      if (s390_known_cpu_type(cpu_type)) {
> 


-- 

Thanks,

David
