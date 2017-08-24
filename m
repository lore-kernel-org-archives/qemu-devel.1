Received: from eggs.gnu.org ([2001:4830:134:3::10]:47507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dkoSk-00013H-LB
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 05:30:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dkoSf-0007EU-IV
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 05:30:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dkoSf-0007EK-9M
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 05:30:01 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7O9TDRr001939
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 05:29:59 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2chuvv1dcy-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 05:29:59 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 24 Aug 2017 10:29:57 +0100
References: <20170823155458.19601-1-cohuck@redhat.com>
	<20170823155458.19601-8-cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 24 Aug 2017 11:29:47 +0200
MIME-Version: 1.0
In-Reply-To: <20170823155458.19601-8-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <1a48b3f1-938a-fcaf-00d9-da27edfeec77@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 7/9] s390x/sclp: properly guard
 pci-specific functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, zyimin@linux.vnet.ibm.com, david@redhat.com, pmorel@linux.vnet.ibm.com, agraf@suse.de, borntraeger@de.ibm.com



On 08/23/2017 05:54 PM, Cornelia Huck wrote:
> If we do not provide zpci, pci reconfiguration via sclp is not available
> either. I/O adapter configuration, however, should always be present.
> 
> Rename the values that refer to I/O adapter configuration (instead of only
> pci) to make things clearer.
> 
> Move length checking of the sccb for I/O adapter configuration into the
> common sclp code (out of the pci code). This also fixes an issue that
> the pci code would refer to a field in the sccb before checking whether
> it was actually long enough.
> 
> Check for the adapter type in the sccb and return unrecognized adapter
> type if the guest tries to issue I/O adapter configure/deconfigure for
> a type other than pci or for pci if the zpci facility is not provided.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/s390x/s390-pci-bus.c  | 14 ++------------
>  hw/s390x/s390-pci-bus.h  |  8 --------
>  hw/s390x/s390-pci-stub.c |  2 ++
>  hw/s390x/sclp.c          | 39 ++++++++++++++++++++++++++++++++++-----
>  include/hw/s390x/sclp.h  | 17 +++++++++++++----
>  5 files changed, 51 insertions(+), 29 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index c57f6ebae0..0a31a4ae88 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -122,16 +122,11 @@ S390PCIBusDevice *s390_pci_find_dev_by_fid(S390pciState *s, uint32_t fid)
> 
>  void s390_pci_sclp_configure(SCCB *sccb)
>  {
> -    PciCfgSccb *psccb = (PciCfgSccb *)sccb;
> +    IoaCfgSccb *psccb = (IoaCfgSccb *)sccb;
>      S390PCIBusDevice *pbdev = s390_pci_find_dev_by_fid(s390_get_phb(),
>                                                         be32_to_cpu(psccb->aid));
>      uint16_t rc;
> 
> -    if (be16_to_cpu(sccb->h.length) < 16) {
> -        rc = SCLP_RC_INSUFFICIENT_SCCB_LENGTH;
> -        goto out;
> -    }
> -
>      if (!pbdev) {
>          DPRINTF("sclp config no dev found\n");
>          rc = SCLP_RC_ADAPTER_ID_NOT_RECOGNIZED;
> @@ -155,16 +150,11 @@ out:
> 
>  void s390_pci_sclp_deconfigure(SCCB *sccb)
>  {
> -    PciCfgSccb *psccb = (PciCfgSccb *)sccb;
> +    IoaCfgSccb *psccb = (IoaCfgSccb *)sccb;
>      S390PCIBusDevice *pbdev = s390_pci_find_dev_by_fid(s390_get_phb(),
>                                                         be32_to_cpu(psccb->aid));
>      uint16_t rc;
> 
> -    if (be16_to_cpu(sccb->h.length) < 16) {
> -        rc = SCLP_RC_INSUFFICIENT_SCCB_LENGTH;
> -        goto out;
> -    }
> -
>      if (!pbdev) {
>          DPRINTF("sclp deconfig no dev found\n");
>          rc = SCLP_RC_ADAPTER_ID_NOT_RECOGNIZED;
> diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
> index 5df6292509..bd636abc28 100644
> --- a/hw/s390x/s390-pci-bus.h
> +++ b/hw/s390x/s390-pci-bus.h
> @@ -244,14 +244,6 @@ typedef struct ChscSeiNt2Res {
>      uint8_t ccdf[4016];
>  } QEMU_PACKED ChscSeiNt2Res;
> 
> -typedef struct PciCfgSccb {
> -    SCCBHeader header;
> -    uint8_t atype;
> -    uint8_t reserved1;
> -    uint16_t reserved2;
> -    uint32_t aid;
> -} QEMU_PACKED PciCfgSccb;
> -
>  typedef struct S390MsixInfo {
>      bool available;
>      uint8_t table_bar;
> diff --git a/hw/s390x/s390-pci-stub.c b/hw/s390x/s390-pci-stub.c
> index cc7278a865..7a642d376c 100644
> --- a/hw/s390x/s390-pci-stub.c
> +++ b/hw/s390x/s390-pci-stub.c
> @@ -20,10 +20,12 @@ int pci_chsc_sei_nt2_have_event(void)
>  /* hw/s390x/sclp.c */
>  void s390_pci_sclp_configure(SCCB *sccb)
>  {
> +    sccb->h.response_code = cpu_to_be16(SCLP_RC_ADAPTER_TYPE_NOT_RECOGNIZED);
>  }
> 
>  void s390_pci_sclp_deconfigure(SCCB *sccb)
>  {
> +    sccb->h.response_code = cpu_to_be16(SCLP_RC_ADAPTER_TYPE_NOT_RECOGNIZED);
>  }
> 
>  /* target/s390x/kvm.c */
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index 9253dbbc64..7ae6a0e37a 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -80,7 +80,7 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
>      prepare_cpu_entries(sclp, read_info->entries, cpu_count);
> 
>      read_info->facilities = cpu_to_be64(SCLP_HAS_CPU_INFO |
> -                                        SCLP_HAS_PCI_RECONFIG);
> +                                        SCLP_HAS_IOA_RECONFIG);
> 
>      /* Memory Hotplug is only supported for the ccw machine type */
>      if (mhd) {
> @@ -354,6 +354,35 @@ static void sclp_read_cpu_info(SCLPDevice *sclp, SCCB *sccb)
>      sccb->h.response_code = cpu_to_be16(SCLP_RC_NORMAL_READ_COMPLETION);
>  }
> 
> +static void sclp_configure_io_adapter(SCLPDevice *sclp, SCCB *sccb,
> +                                      bool configure)

Just an idea. This could be called reconfigure instead
of configure (that's sclp_reconfigure_io_adapter) as the
facility providing both conf and deconf is called reconf.

It ain't important. Patch looks good!

Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
