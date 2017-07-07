Received: from eggs.gnu.org ([2001:4830:134:3::10]:50249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dTSte-0007Gp-IT
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:02:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dTStb-0007Pr-GF
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:02:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54242
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dTStb-0007Ph-90
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:02:07 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v67CsEJi036211
	for <qemu-devel@nongnu.org>; Fri, 7 Jul 2017 09:02:06 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bj3v6yfhr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 07 Jul 2017 09:02:06 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 7 Jul 2017 09:02:05 -0400
References: <20170707122159.24714-1-cohuck@redhat.com>
	<20170707122159.24714-3-cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 7 Jul 2017 15:01:59 +0200
MIME-Version: 1.0
In-Reply-To: <20170707122159.24714-3-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <6db8b473-7531-4684-0d6d-88a83f8420fc@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC 2/7] s390x: chsc nt2 events are pci-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: agraf@suse.de, thuth@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com

On 07/07/2017 02:21 PM, Cornelia Huck wrote:
> The nt2 event class is pci-only and therefore implemented in
> the s390x pci code. Properly stub it out for non-pci builds.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/s390x/s390-pci-bus.c |  4 ++--
>  hw/s390x/s390-pci-bus.h |  4 ++--
>  target/s390x/ioinst.c   | 18 ++++++++++++++++++
>  3 files changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 5651483781..eee9a04eac 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -47,7 +47,7 @@ S390pciState *s390_get_phb(void)
>      return phb;
>  }
> 
> -int chsc_sei_nt2_get_event(void *res)
> +int pci_chsc_sei_nt2_get_event(void *res)
>  {
>      ChscSeiNt2Res *nt2_res = (ChscSeiNt2Res *)res;
>      PciCcdfAvail *accdf;
> @@ -87,7 +87,7 @@ int chsc_sei_nt2_get_event(void *res)
>      return rc;
>  }
> 
> -int chsc_sei_nt2_have_event(void)
> +int pci_chsc_sei_nt2_have_event(void)
>  {
>      S390pciState *s = s390_get_phb();
> 
> diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
> index cf142a3e68..29d3da10f6 100644
> --- a/hw/s390x/s390-pci-bus.h
> +++ b/hw/s390x/s390-pci-bus.h
> @@ -318,8 +318,8 @@ typedef struct S390pciState {
>  } S390pciState;
> 
>  S390pciState *s390_get_phb(void);
> -int chsc_sei_nt2_get_event(void *res);
> -int chsc_sei_nt2_have_event(void);
> +int pci_chsc_sei_nt2_get_event(void *res);
> +int pci_chsc_sei_nt2_have_event(void);
>  void s390_pci_sclp_configure(SCCB *sccb);
>  void s390_pci_sclp_deconfigure(SCCB *sccb);
>  void s390_pci_iommu_enable(S390PCIIOMMU *iommu);
> diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
> index d5e6b8066b..a552f53167 100644
> --- a/target/s390x/ioinst.c
> +++ b/target/s390x/ioinst.c
> @@ -599,6 +599,24 @@ static int chsc_sei_nt0_have_event(void)
>      return 0;
>  }
> 
> +static int chsc_sei_nt2_get_event(void *res)
> +{
> +#ifdef CONFIG_PCI
> +    return pci_chsc_sei_nt2_get_event(res);
> +#else
> +    return 1;
> +#endif
> +}
> +
> +static int chsc_sei_nt2_have_event(void)
> +{
> +#ifdef CONFIG_PCI
> +    return pci_chsc_sei_nt2_have_event();
> +#else
> +    return 0;
> +#endif

I think this is similar to the io instructions. We should use the CPU
model to decide what to return. This will then cover the 3 cases
- CONFIG_PCI off
- CONFIG_PCI on, but PCI disabled via cpu model
- CONFIG_PCI on, and PCI enabled via cpu model

no?


> +}
> +
>  #define CHSC_SEI_NT0    (1ULL << 63)
>  #define CHSC_SEI_NT2    (1ULL << 61)
>  static void ioinst_handle_chsc_sei(ChscReq *req, ChscResp *res)
> 
