Received: from eggs.gnu.org ([2001:4830:134:3::10]:39535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fy0bC-0004PC-T3
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 16:09:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fy0b9-0006Rv-Dm
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 16:09:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fy0b9-0006Py-1j
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 16:09:51 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w86K41aH026239
	for <qemu-devel@nongnu.org>; Thu, 6 Sep 2018 16:09:48 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2mbauj8g74-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 06 Sep 2018 16:09:47 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 6 Sep 2018 16:09:46 -0400
References: <20180906032949.13753-1-marcandre.lureau@redhat.com>
	<20180906032949.13753-7-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 6 Sep 2018 16:09:42 -0400
MIME-Version: 1.0
In-Reply-To: <20180906032949.13753-7-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <13e351e8-5037-ad9a-e49b-31e364cb0245@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 6/6] tpm: add ACPI memory clear
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 09/05/2018 11:29 PM, Marc-Andr=C3=A9 Lureau wrote:
> This allows to pass the last failing test from the Windows HLK TPM 2.0
> TCG PPI 1.3 tests.
>
> The interface is described in the "TCG Platform Reset Attack
> Mitigation Specification", chapter 6 "ACPI _DSM Function". According
> to Laszlo, it's not so easy to implement in OVMF, he suggested to do
> it in qemu instead.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/tpm/tpm_ppi.h     |  2 ++
>   hw/i386/acpi-build.c | 46 +++++++++++++++++++++++++++++++++++++++++++=
+
>   hw/tpm/tpm_crb.c     |  1 +
>   hw/tpm/tpm_ppi.c     | 23 ++++++++++++++++++++++
>   hw/tpm/tpm_tis.c     |  1 +
>   docs/specs/tpm.txt   |  2 ++
>   hw/tpm/trace-events  |  3 +++
>   7 files changed, 78 insertions(+)
>
> diff --git a/hw/tpm/tpm_ppi.h b/hw/tpm/tpm_ppi.h
> index c2ab2ed300..b8f67962c7 100644
> --- a/hw/tpm/tpm_ppi.h
> +++ b/hw/tpm/tpm_ppi.h
> @@ -23,4 +23,6 @@ typedef struct TPMPPI {
>   bool tpm_ppi_init(TPMPPI *tpmppi, struct MemoryRegion *m,
>                     hwaddr addr, Object *obj, Error **errp);
>  =20
> +void tpm_ppi_reset(TPMPPI *tpmppi);
> +
>   #endif /* TPM_TPM_PPI_H */
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index c5e9a6e11d..2ab3e8fae7 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1824,6 +1824,13 @@ build_tpm_ppi(TPMIf *tpm, Aml *dev)
>       pprq =3D aml_name("PPRQ");
>       pprm =3D aml_name("PPRM");
>  =20
> +    aml_append(dev,
> +               aml_operation_region("TPP3", AML_SYSTEM_MEMORY,
> +                                    aml_int(TPM_PPI_ADDR_BASE + 0x15a)=
,
> +                                    0x1));
> +    field =3D aml_field("TPP3", AML_BYTE_ACC, AML_NOLOCK, AML_PRESERVE=
);
> +    aml_append(field, aml_named_field("MOVV", 8));
> +    aml_append(dev, field);
>       /*
>        * DerefOf in Windows is broken with SYSTEM_MEMORY.  Use a dynami=
c
>        * operation region inside of a method for getting FUNC[op].
> @@ -2166,7 +2173,46 @@ build_tpm_ppi(TPMIf *tpm, Aml *dev)
>               aml_append(ifctx, aml_return(aml_buffer(1, zerobyte)));
>           }
>           aml_append(method, ifctx);
> +
> +        ifctx =3D aml_if(
> +            aml_equal(uuid,
> +                      aml_touuid("376054ED-CC13-4675-901C-4756D7F2D45D=
")));
> +        {
> +            /* standard DSM query function */
> +            ifctx2 =3D aml_if(aml_equal(function, zero));
> +            {
> +                uint8_t byte_list[1] =3D { 0x03 };
> +                aml_append(ifctx2, aml_return(aml_buffer(1, byte_list)=
));
> +            }
> +            aml_append(ifctx, ifctx2);
> +
> +            /*
> +             * TCG Platform Reset Attack Mitigation Specification 1.0 =
Ch.6
> +             *
> +             * Arg 2 (Integer): Function Index =3D 1
> +             * Arg 3 (Package): Arguments =3D Package: Type: Integer
> +             *                  Operation Value of the Request
> +             * Returns: Type: Integer
> +             *          0: Success
> +             *          1: General Failure
> +             */
> +            ifctx2 =3D aml_if(aml_equal(function, one));
> +            {
> +                aml_append(ifctx2,
> +                           aml_store(aml_derefof(aml_index(arguments, =
zero)),
> +                                     op));
> +                {
> +                    aml_append(ifctx2, aml_store(op, aml_name("MOVV"))=
);
> +
> +                    /* 0: success */
> +                    aml_append(ifctx2, aml_return(zero));
> +                }
> +            }
> +            aml_append(ifctx, ifctx2);
> +        }
> +        aml_append(method, ifctx);
>       }
> +
>       aml_append(dev, method);
>   }
>  =20
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index b243222fd6..48f6a716ad 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -233,6 +233,7 @@ static void tpm_crb_reset(void *dev)
>   {
>       CRBState *s =3D CRB(dev);
>  =20
> +    tpm_ppi_reset(&s->ppi);
>       tpm_backend_reset(s->tpmbe);
>  =20
>       memset(s->regs, 0, sizeof(s->regs));
> diff --git a/hw/tpm/tpm_ppi.c b/hw/tpm/tpm_ppi.c
> index f2f07f895e..46ca8ea3ea 100644
> --- a/hw/tpm/tpm_ppi.c
> +++ b/hw/tpm/tpm_ppi.c
> @@ -16,8 +16,30 @@
>   #include "qapi/error.h"
>   #include "cpu.h"
>   #include "sysemu/memory_mapping.h"
> +#include "sysemu/reset.h"
>   #include "migration/vmstate.h"
>   #include "tpm_ppi.h"
> +#include "trace.h"
> +
> +void tpm_ppi_reset(TPMPPI *tpmppi)
> +{
> +    char *ptr =3D memory_region_get_ram_ptr(&tpmppi->ram);
> +
> +    if (ptr[0x15a] & 0x1) {
> +        GuestPhysBlockList guest_phys_blocks;
> +        GuestPhysBlock *block;
> +
> +        guest_phys_blocks_init(&guest_phys_blocks);
> +        guest_phys_blocks_append(&guest_phys_blocks);
> +        QTAILQ_FOREACH(block, &guest_phys_blocks.head, next) {
> +            trace_tpm_ppi_memset(block->host_addr,
> +                             block->target_end - block->target_start);
> +            memset(block->host_addr, 0,
> +                   block->target_end - block->target_start);

Does this also clear the PPI memory? If so, could we create a backup of=20
the few relevant bytes the firmware will look at and restore them after=20
the loop? The PPI device likely contains the only data that may need to=20
be preserved across a rebbot, and we are running this loop here in the=20
ppi module itself, so should be able to do that.

 =C2=A0=C2=A0=C2=A0 Stefan
