Received: from eggs.gnu.org ([2001:4830:134:3::10]:42465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1djoAG-0000rA-8I
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 10:58:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1djoAC-0004uq-5r
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 10:58:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45560)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1djoAB-0004u7-Sk
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 10:58:48 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7LEveRt027079
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 10:58:45 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cg125jgrd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 10:58:45 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Mon, 21 Aug 2017 15:58:42 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
	[9.149.105.232])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id v7LEwfcg24379510
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 14:58:41 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5305452043
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 14:54:20 +0100 (BST)
Received: from [9.152.224.86] (unknown [9.152.224.86])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3ADC752047
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 14:54:20 +0100 (BST)
References: <20170821091614.28251-1-cohuck@redhat.com>
	<20170821091614.28251-8-cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Mon, 21 Aug 2017 16:58:41 +0200
MIME-Version: 1.0
In-Reply-To: <20170821091614.28251-8-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <0d8dcac1-f536-5d69-0187-23656d003348@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 07/10] s390x/sclp: properly guard
 pci-specific functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 21/08/2017 11:16, Cornelia Huck wrote:
> If we do not provide zpci, pci reconfiguration via sclp is not availabl=
e
> either. Don't indicate it in the sclp facilities and return an invalid
> command if the guest tries to issue pci configure/deconfigure.
>=20
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   hw/s390x/sclp.c | 19 +++++++++++++++----
>   1 file changed, 15 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index 9253dbbc64..d0104cd784 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -59,6 +59,7 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *scc=
b)
>       int rnsize, rnmax;
>       int slots =3D MIN(machine->ram_slots, s390_get_memslot_count(kvm_=
state));
>       IplParameterBlock *ipib =3D s390_ipl_get_iplb();
> +    uint64_t sclp_facilities =3D SCLP_HAS_CPU_INFO;
>=20
>       CPU_FOREACH(cpu) {
>           cpu_count++;
> @@ -79,8 +80,10 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sc=
cb)
>=20
>       prepare_cpu_entries(sclp, read_info->entries, cpu_count);
>=20
> -    read_info->facilities =3D cpu_to_be64(SCLP_HAS_CPU_INFO |
> -                                        SCLP_HAS_PCI_RECONFIG);
> +    if (s390_has_feat(S390_FEAT_ZPCI)) {
> +        sclp_facilities |=3D SCLP_HAS_PCI_RECONFIG;
> +    }
> +    read_info->facilities =3D cpu_to_be64(sclp_facilities);
>=20
>       /* Memory Hotplug is only supported for the ccw machine type */
>       if (mhd) {
> @@ -385,10 +388,18 @@ static void sclp_execute(SCLPDevice *sclp, SCCB *=
sccb, uint32_t code)
>           sclp_c->unassign_storage(sclp, sccb);
>           break;
>       case SCLP_CMDW_CONFIGURE_PCI:
> -        s390_pci_sclp_configure(sccb);
> +        if (s390_has_feat(S390_FEAT_ZPCI)) {
> +            s390_pci_sclp_configure(sccb);
> +        } else {
> +            sccb->h.response_code =3D cpu_to_be16(SCLP_RC_INVALID_SCLP=
_COMMAND);

Hello Conny,

I find more logical if the response would be 0x06F0 : "Adapter type in=20
SCCB not recognized"
Since we could have more than one adapter type... someday.
then the SCLP command would be valid but not the adapter type.

However, I will try to find a real hardware to test this since I noticed=20
that my logic sometime... :) .

Another point is that don't you think that this test on S390_FEAT_ZPCI=20
better belong to the dedicated PCI code inside of the=20
s390_pci_sclp_configure().

best regards,

Pierre


> +        }
>           break;
>       case SCLP_CMDW_DECONFIGURE_PCI:
> -        s390_pci_sclp_deconfigure(sccb);
> +        if (s390_has_feat(S390_FEAT_ZPCI)) {
> +            s390_pci_sclp_deconfigure(sccb);
> +        } else {
> +            sccb->h.response_code =3D cpu_to_be16(SCLP_RC_INVALID_SCLP=
_COMMAND);
> +        }
>           break;
>       default:
>           efc->command_handler(ef, sccb, code);
>=20


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
