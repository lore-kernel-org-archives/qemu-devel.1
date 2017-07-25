Received: from eggs.gnu.org ([2001:4830:134:3::10]:41186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1da4ta-0006EJ-P3
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:49:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1da4tX-0001wu-LL
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:49:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48635
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1da4tX-0001wQ-FT
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:49:23 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6PImhGN130369
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 14:49:22 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bx8auhh6u-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 14:49:22 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 25 Jul 2017 12:49:21 -0600
References: <20170725153330.14966-1-cohuck@redhat.com>
	<20170725153330.14966-5-cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 25 Jul 2017 20:49:13 +0200
MIME-Version: 1.0
In-Reply-To: <20170725153330.14966-5-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <ad8644c1-8679-378b-680e-813b3840fe1f@de.ibm.com>
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
Cc: agraf@suse.de, thuth@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com

On 07/25/2017 05:33 PM, Cornelia Huck wrote:
> Only set the zpci feature bit on builds that actually support pci.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

I like this variant.
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

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
>      set_bit(S390_FEAT_ADAPTER_EVENT_NOTIFICATION, model->features);
> 
>      if (s390_known_cpu_type(cpu_type)) {
> 
