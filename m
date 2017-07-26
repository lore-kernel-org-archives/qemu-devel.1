Received: from eggs.gnu.org ([2001:4830:134:3::10]:50945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1daHwe-0004WN-7N
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:45:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1daHwZ-0005CP-B1
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:45:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37882)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1daHwZ-0005Bp-0l
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:45:23 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6Q8hxxo075899
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 04:45:21 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bxm0ksd9e-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 04:45:21 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Wed, 26 Jul 2017 04:45:19 -0400
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
	[9.57.199.107])
	by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v6Q8jGbD26935326
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 08:45:16 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C537412403D
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 04:42:41 -0400 (EDT)
Received: from zyimindembp.cn.ibm.com (unknown [9.115.193.8])
	by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP id 3F6F1124037
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 04:42:40 -0400 (EDT)
References: <20170725153330.14966-1-cohuck@redhat.com>
	<20170725153330.14966-5-cohuck@redhat.com>
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Wed, 26 Jul 2017 16:45:14 +0800
MIME-Version: 1.0
In-Reply-To: <20170725153330.14966-5-cohuck@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Message-Id: <fb9b7be0-2258-774f-b76f-ebf82c5e13d1@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
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
To: qemu-devel@nongnu.org

Good. This patch resolves the problem I mentioned in previous verion.

Thanks for your work.


=D4=DA 2017/7/25 =CF=C2=CE=E711:33, Cornelia Huck =D0=B4=B5=C0:
> Only set the zpci feature bit on builds that actually support pci.
>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   hw/s390x/s390-pci-bus.c  | 5 +++++
>   hw/s390x/s390-pci-bus.h  | 1 +
>   hw/s390x/s390-ci-stub.c | 4 ++++
>   target/s390x/kvm.c       | 2 +-
>   4 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index c57f6ebae0..7b30d4c7bd 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -34,6 +34,11 @@
>           }                                                         \
>       } while (0)
>
> +void pci_enable_zpci_feature(S390CPUModel *model)
> +{
> +    set_bit(S390_FEAT_ZPCI, model->features);
> +}
> +
>   S390pciState *s390_get_phb(void)
>   {
>       static S390pciState *phb;
> diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
> index 5df6292509..d8796536b0 100644
> --- a/hw/s390x/s390-pci-bus.h
> +++ b/hw/s390x/s390-pci-bus.h
> @@ -333,4 +333,5 @@ S390PCIBusDevice *s390_pci_find_dev_by_fid(S390pciS=
tate *s, uint32_t fid);
>   S390PCIBusDevice *s390_pci_find_next_avail_dev(S390pciState *s,
>                                                  S390PCIBusDevice *pbde=
v);
>
> +void pci_enable_zpci_feature(S390CPUModel *model);
>   #endif
> diff --git a/hw/s390x/s390-pci-stub.c b/hw/s390x/s390-pci-stub.c
> index cc7278a865..8ceaf482e7 100644
> --- a/hw/s390x/s390-pci-stub.c
> +++ b/hw/s390x/s390-pci-stub.c
> @@ -72,3 +72,7 @@ S390PCIBusDevice *s390_pci_find_dev_by_idx(S390pciSta=
te *s, uint32_t idx)
>   {
>       return NULL;
>   }
> +
> +void pci_enable_zpci_feature(S390CPUModel *model)
> +{
> +}
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index c4c5791d27..866ac3d414 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -2662,7 +2662,7 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *mo=
del, Error **errp)
>       }
>
>       /* We emulate a zPCI bus and AEN, therefore we don't need HW supp=
ort */
> -    set_bit(S390_FEAT_ZPCI, model->features);
> +    pci_enable_zpci_feature(model);
>       set_bit(S390_FEAT_ADAPTER_EVENT_NOTIFICATION, model->features);
>
>       if (s390_known_cpu_type(cpu_type)) {
