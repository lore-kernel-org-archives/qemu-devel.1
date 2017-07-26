Received: from eggs.gnu.org ([2001:4830:134:3::10]:54028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1daGHy-0001zv-OZ
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 02:59:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1daGHv-00083s-NZ
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 02:59:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1daGHv-00083P-E7
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 02:59:19 -0400
References: <20170725153330.14966-1-cohuck@redhat.com>
	<20170725153330.14966-4-cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1b71d39d-602e-08fa-4805-81cbfeffd073@redhat.com>
Date: Wed, 26 Jul 2017 08:59:10 +0200
MIME-Version: 1.0
In-Reply-To: <20170725153330.14966-4-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/9] s390x: chsc nt2 events are pci-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, david@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com

On 25.07.2017 17:33, Cornelia Huck wrote:
> The nt2 event class is pci-only - don't look for events if pci is
> not in the active cpu model.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/s390x/s390-pci-bus.c  |  4 ++--
>  hw/s390x/s390-pci-bus.h  |  4 ++--
>  hw/s390x/s390-pci-stub.c |  4 ++--
>  target/s390x/ioinst.c    | 16 ++++++++++++++++
>  4 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 61cfd2138f..c57f6ebae0 100644
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
> index 67af2c12ff..5df6292509 100644
> --- a/hw/s390x/s390-pci-bus.h
> +++ b/hw/s390x/s390-pci-bus.h
> @@ -319,8 +319,8 @@ typedef struct S390pciState {
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
> diff --git a/hw/s390x/s390-pci-stub.c b/hw/s390x/s390-pci-stub.c
> index 2e7e42a2af..cc7278a865 100644
> --- a/hw/s390x/s390-pci-stub.c
> +++ b/hw/s390x/s390-pci-stub.c
> @@ -7,12 +7,12 @@
>  #include "s390-pci-bus.h"
>  
>  /* target/s390x/ioinst.c */
> -int chsc_sei_nt2_get_event(void *res)
> +int pci_chsc_sei_nt2_get_event(void *res)
>  {
>      return 1;
>  }
>  
> -int chsc_sei_nt2_have_event(void)
> +int pci_chsc_sei_nt2_have_event(void)
>  {
>      return 0;
>  }
> diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
> index 51fbea620d..3fa3301f50 100644
> --- a/target/s390x/ioinst.c
> +++ b/target/s390x/ioinst.c
> @@ -599,6 +599,22 @@ static int chsc_sei_nt0_have_event(void)
>      return 0;
>  }
>  
> +static int chsc_sei_nt2_get_event(void *res)
> +{
> +    if (s390_has_feat(S390_FEAT_ZPCI)) {
> +        return pci_chsc_sei_nt2_get_event(res);
> +    }
> +    return 1;
> +}
> +
> +static int chsc_sei_nt2_have_event(void)
> +{
> +    if (s390_has_feat(S390_FEAT_ZPCI)) {
> +        return pci_chsc_sei_nt2_have_event();
> +    }
> +    return 0;
> +}

Not sure whether it is nicer/better, but you could also do the check
only once in ioinst_handle_chsc_sei() and then get along without these
wrapper functions?

 Thomas
