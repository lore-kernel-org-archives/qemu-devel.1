Received: from eggs.gnu.org ([2001:4830:134:3::10]:45447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1dkYTX-0001NO-IO
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1dkYTU-0000zB-61
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:25:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1dkYTT-0000xZ-S7
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:25:48 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7NGPbhV059109
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 12:25:46 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2chb4mqjca-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 12:25:40 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Wed, 23 Aug 2017 17:25:09 +0100
References: <20170823155458.19601-1-cohuck@redhat.com>
	<20170823155458.19601-8-cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Wed, 23 Aug 2017 18:25:05 +0200
MIME-Version: 1.0
In-Reply-To: <20170823155458.19601-8-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <ceb4412f-7909-73f8-5de1-4bbc7bd86079@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
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
Cc: borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, david@redhat.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

On 23/08/2017 17:54, Cornelia Huck wrote:
> If we do not provide zpci, pci reconfiguration via sclp is not availabl=
e
> either. I/O adapter configuration, however, should always be present.
>=20
> Rename the values that refer to I/O adapter configuration (instead of o=
nly
> pci) to make things clearer.
>=20
> Move length checking of the sccb for I/O adapter configuration into the
> common sclp code (out of the pci code). This also fixes an issue that
> the pci code would refer to a field in the sccb before checking whether
> it was actually long enough.
>=20
> Check for the adapter type in the sccb and return unrecognized adapter
> type if the guest tries to issue I/O adapter configure/deconfigure for
> a type other than pci or for pci if the zpci facility is not provided.
>=20
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   hw/s390x/s390-pci-bus.c  | 14 ++------------
>   hw/s390x/s390-pci-bus.h  |  8 --------
>   hw/s390x/s390-pci-stub.c |  2 ++
>   hw/s390x/sclp.c          | 39 ++++++++++++++++++++++++++++++++++-----
>   include/hw/s390x/sclp.h  | 17 +++++++++++++----
>   5 files changed, 51 insertions(+), 29 deletions(-)
>=20
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index c57f6ebae0..0a31a4ae88 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -122,16 +122,11 @@ S390PCIBusDevice *s390_pci_find_dev_by_fid(S390pc=
iState *s, uint32_t fid)
>=20
>   void s390_pci_sclp_configure(SCCB *sccb)
>   {
> -    PciCfgSccb *psccb =3D (PciCfgSccb *)sccb;
> +    IoaCfgSccb *psccb =3D (IoaCfgSccb *)sccb;
>       S390PCIBusDevice *pbdev =3D s390_pci_find_dev_by_fid(s390_get_phb=
(),
>                                                          be32_to_cpu(ps=
ccb->aid));
>       uint16_t rc;
>=20
> -    if (be16_to_cpu(sccb->h.length) < 16) {
> -        rc =3D SCLP_RC_INSUFFICIENT_SCCB_LENGTH;
> -        goto out;
> -    }
> -
>       if (!pbdev) {
>           DPRINTF("sclp config no dev found\n");
>           rc =3D SCLP_RC_ADAPTER_ID_NOT_RECOGNIZED;
> @@ -155,16 +150,11 @@ out:
>=20
>   void s390_pci_sclp_deconfigure(SCCB *sccb)
>   {
> -    PciCfgSccb *psccb =3D (PciCfgSccb *)sccb;
> +    IoaCfgSccb *psccb =3D (IoaCfgSccb *)sccb;
>       S390PCIBusDevice *pbdev =3D s390_pci_find_dev_by_fid(s390_get_phb=
(),
>                                                          be32_to_cpu(ps=
ccb->aid));
>       uint16_t rc;
>=20
> -    if (be16_to_cpu(sccb->h.length) < 16) {
> -        rc =3D SCLP_RC_INSUFFICIENT_SCCB_LENGTH;
> -        goto out;
> -    }
> -
>       if (!pbdev) {
>           DPRINTF("sclp deconfig no dev found\n");
>           rc =3D SCLP_RC_ADAPTER_ID_NOT_RECOGNIZED;
> diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
> index 5df6292509..bd636abc28 100644
> --- a/hw/s390x/s390-pci-bus.h
> +++ b/hw/s390x/s390-pci-bus.h
> @@ -244,14 +244,6 @@ typedef struct ChscSeiNt2Res {
>       uint8_t ccdf[4016];
>   } QEMU_PACKED ChscSeiNt2Res;
>=20
> -typedef struct PciCfgSccb {
> -    SCCBHeader header;
> -    uint8_t atype;
> -    uint8_t reserved1;
> -    uint16_t reserved2;
> -    uint32_t aid;
> -} QEMU_PACKED PciCfgSccb;
> -
>   typedef struct S390MsixInfo {
>       bool available;
>       uint8_t table_bar;
> diff --git a/hw/s390x/s390-pci-stub.c b/hw/s390x/s390-pci-stub.c
> index cc7278a865..7a642d376c 100644
> --- a/hw/s390x/s390-pci-stub.c
> +++ b/hw/s390x/s390-pci-stub.c
> @@ -20,10 +20,12 @@ int pci_chsc_sei_nt2_have_event(void)
>   /* hw/s390x/sclp.c */
>   void s390_pci_sclp_configure(SCCB *sccb)
>   {
> +    sccb->h.response_code =3D cpu_to_be16(SCLP_RC_ADAPTER_TYPE_NOT_REC=
OGNIZED);
>   }
>=20
>   void s390_pci_sclp_deconfigure(SCCB *sccb)
>   {
> +    sccb->h.response_code =3D cpu_to_be16(SCLP_RC_ADAPTER_TYPE_NOT_REC=
OGNIZED);
>   }
>=20
>   /* target/s390x/kvm.c */
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index 9253dbbc64..7ae6a0e37a 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -80,7 +80,7 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *scc=
b)
>       prepare_cpu_entries(sclp, read_info->entries, cpu_count);
>=20
>       read_info->facilities =3D cpu_to_be64(SCLP_HAS_CPU_INFO |
> -                                        SCLP_HAS_PCI_RECONFIG);
> +                                        SCLP_HAS_IOA_RECONFIG);
>=20
>       /* Memory Hotplug is only supported for the ccw machine type */
>       if (mhd) {
> @@ -354,6 +354,35 @@ static void sclp_read_cpu_info(SCLPDevice *sclp, S=
CCB *sccb)
>       sccb->h.response_code =3D cpu_to_be16(SCLP_RC_NORMAL_READ_COMPLET=
ION);
>   }
>=20
> +static void sclp_configure_io_adapter(SCLPDevice *sclp, SCCB *sccb,
> +                                      bool configure)
> +{
> +    int rc;
> +
> +    if (be16_to_cpu(sccb->h.length) < 16) {
> +        rc =3D SCLP_RC_INSUFFICIENT_SCCB_LENGTH;
> +        goto out_err;
> +    }
> +
> +    switch (((IoaCfgSccb *)sccb)->atype) {
> +    case SCLP_RECONFIG_PCI_ATYPE:
> +        if (s390_has_feat(S390_FEAT_ZPCI)) {
> +            if (configure) {
> +                s390_pci_sclp_configure(sccb);
> +            } else {
> +                s390_pci_sclp_deconfigure(sccb);
> +            }
> +            return;
> +        }
> +        /* fallthrough */
> +    default:
> +        rc =3D SCLP_RC_ADAPTER_TYPE_NOT_RECOGNIZED;
> +    }
> +
> + out_err:
> +    sccb->h.response_code =3D cpu_to_be16(rc);
> +}
> +
>   static void sclp_execute(SCLPDevice *sclp, SCCB *sccb, uint32_t code)
>   {
>       SCLPDeviceClass *sclp_c =3D SCLP_GET_CLASS(sclp);
> @@ -384,11 +413,11 @@ static void sclp_execute(SCLPDevice *sclp, SCCB *=
sccb, uint32_t code)
>       case SCLP_UNASSIGN_STORAGE:
>           sclp_c->unassign_storage(sclp, sccb);
>           break;
> -    case SCLP_CMDW_CONFIGURE_PCI:
> -        s390_pci_sclp_configure(sccb);
> +    case SCLP_CMDW_CONFIGURE_IOA:
> +        sclp_configure_io_adapter(sclp, sccb, true);
>           break;
> -    case SCLP_CMDW_DECONFIGURE_PCI:
> -        s390_pci_sclp_deconfigure(sccb);
> +    case SCLP_CMDW_DECONFIGURE_IOA:
> +        sclp_configure_io_adapter(sclp, sccb, false);
>           break;
>       default:
>           efc->command_handler(ef, sccb, code);
> diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
> index e71d526605..a72d096081 100644
> --- a/include/hw/s390x/sclp.h
> +++ b/include/hw/s390x/sclp.h
> @@ -44,10 +44,10 @@
>   #define SCLP_CMDW_DECONFIGURE_CPU               0x00100001
>=20
>   /* SCLP PCI codes */
> -#define SCLP_HAS_PCI_RECONFIG                   0x0000000040000000ULL
> -#define SCLP_CMDW_CONFIGURE_PCI                 0x001a0001
> -#define SCLP_CMDW_DECONFIGURE_PCI               0x001b0001
> -#define SCLP_RECONFIG_PCI_ATPYE                 2
> +#define SCLP_HAS_IOA_RECONFIG                   0x0000000040000000ULL
> +#define SCLP_CMDW_CONFIGURE_IOA                 0x001a0001
> +#define SCLP_CMDW_DECONFIGURE_IOA               0x001b0001
> +#define SCLP_RECONFIG_PCI_ATYPE                 2
>=20
>   /* SCLP response codes */
>   #define SCLP_RC_NORMAL_READ_COMPLETION          0x0010
> @@ -59,6 +59,7 @@
>   #define SCLP_RC_INSUFFICIENT_SCCB_LENGTH        0x0300
>   #define SCLP_RC_STANDBY_READ_COMPLETION         0x0410
>   #define SCLP_RC_ADAPTER_IN_RESERVED_STATE       0x05f0
> +#define SCLP_RC_ADAPTER_TYPE_NOT_RECOGNIZED     0x06f0
>   #define SCLP_RC_ADAPTER_ID_NOT_RECOGNIZED       0x09f0
>   #define SCLP_RC_INVALID_FUNCTION                0x40f0
>   #define SCLP_RC_NO_EVENT_BUFFERS_STORED         0x60f0
> @@ -167,6 +168,14 @@ typedef struct AssignStorage {
>       uint16_t rn;
>   } QEMU_PACKED AssignStorage;
>=20
> +typedef struct IoaCfgSccb {
> +    SCCBHeader header;
> +    uint8_t atype;
> +    uint8_t reserved1;
> +    uint16_t reserved2;
> +    uint32_t aid;
> +} QEMU_PACKED IoaCfgSccb;
> +
>   typedef struct SCCB {
>       SCCBHeader h;
>       char data[SCCB_DATA_LEN];
>=20

LGTM and
I could also test the all serie on the hardware (sure is sure) :)
with VFIO and virtio PCI... so

Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
