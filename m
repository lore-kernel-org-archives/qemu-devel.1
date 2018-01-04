Received: from eggs.gnu.org ([2001:4830:134:3::10]:55098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eX7ut-0007Zo-9R
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 10:58:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eX7uk-0003O5-Hx
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 10:58:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eX7uk-0003JN-2V
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 10:58:42 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	w04FsbOR031974
	for <qemu-devel@nongnu.org>; Thu, 4 Jan 2018 10:58:39 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2f9n6b6afk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 04 Jan 2018 10:58:38 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 4 Jan 2018 10:58:36 -0500
References: <20171222145518.24733-1-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 4 Jan 2018 10:58:33 -0500
MIME-Version: 1.0
In-Reply-To: <20171222145518.24733-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <5c86648e-d12f-cea6-cc70-5ea309e770c1@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] TPM: add CRB device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: amarnath.valluri@intel.com, ehabkost@redhat.com

On 12/22/2017 09:55 AM, Marc-Andr=C3=A9 Lureau wrote:
> tpm_crb is a device for TPM 2.0 Command Response Buffer (CRB)
> Interface as defined in TCG PC Client Platform TPM Profile (PTP)
> Specification Family =E2=80=9C2.0=E2=80=9D Level 00 Revision 01.03 v22.
>
> The PTP allows device implementation to switch between TIS and CRB
> model at run time, but given that CRB is a simpler device to
> implement, I chose to implement it as a different device.
>
> The device doesn't implement other locality than 0 for now (my laptop
> TPM doesn't either, so I assume this isn't so bad)
>
> The command/reply memory region is statically allocated after the CRB
> registers address TPM_CRB_ADDR_BASE + sizeof(struct crb_regs) (I
> wonder if the BIOS could or should allocate it instead, or what size
> to use, again this seems to fit well expectations)
>
> The PTP doesn't specify a particular bus to put the device. So I added
> it on the system bus directly, so it could hopefully be used easily on
> a different platform than x86. Currently, it fails to init on piix,
> because error_on_sysbus_device() check. The check may be changed in a
> near future, see discussion on the qemu-devel ML.
>
> Tested with some success with Linux upstream and Windows 10, seabios &
> modified ovmf. The device is recognized and correctly transmit
> command/response with passthrough & emu.

When you say 'some success', you mean that a test suite wasn't passing=20
all tests, right? I didn't run the test suite so far, but what I tested=20
looks good to me so far.

We have one ACPI part missing in the implementation and that's this=20
mailbox thing that allows one to send a code to the firmware that the=20
firmware then reads and acts upon and reconfigures the TPM during the=20
next warm-boot.

https://trustedcomputinggroup.org/wp-content/uploads/Physical-Presence-In=
terface_1-30_0-52.pdf

It was challenging to implement this interface 'back then' using ACPI's=20
AML, but now it's even more low level with the programming interface.

I know we have to wait for that other patch. Nevertheless ...

>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

> ---
>   qapi/tpm.json                      |   5 +-
>   include/hw/acpi/tpm.h              |  72 ++++++++
>   include/sysemu/tpm.h               |   3 +
>   hw/i386/acpi-build.c               |  34 +++-
>   hw/tpm/tpm_crb.c                   | 325 ++++++++++++++++++++++++++++=
+++++++++
>   default-configs/i386-softmmu.mak   |   1 +
>   default-configs/x86_64-softmmu.mak |   1 +
>   hw/tpm/Makefile.objs               |   1 +
>   8 files changed, 432 insertions(+), 10 deletions(-)
>   create mode 100644 hw/tpm/tpm_crb.c
>
> diff --git a/qapi/tpm.json b/qapi/tpm.json
> index 7093f268fb..d50deef5e9 100644
> --- a/qapi/tpm.json
> +++ b/qapi/tpm.json
> @@ -11,10 +11,11 @@
>   # An enumeration of TPM models
>   #
>   # @tpm-tis: TPM TIS model
> +# @tpm-crb: TPM CRB model (since 2.12)
>   #
>   # Since: 1.5
>   ##
> -{ 'enum': 'TpmModel', 'data': [ 'tpm-tis' ] }
> +{ 'enum': 'TpmModel', 'data': [ 'tpm-tis', 'tpm-crb' ] }
>  =20
>   ##
>   # @query-tpm-models:
> @@ -28,7 +29,7 @@
>   # Example:
>   #
>   # -> { "execute": "query-tpm-models" }
> -# <- { "return": [ "tpm-tis" ] }
> +# <- { "return": [ "tpm-tis", "tpm-crb" ] }
>   #
>   ##
>   { 'command': 'query-tpm-models', 'returns': ['TpmModel'] }
> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
> index 6d516c6a7f..b0048515fa 100644
> --- a/include/hw/acpi/tpm.h
> +++ b/include/hw/acpi/tpm.h
> @@ -16,11 +16,82 @@
>   #ifndef HW_ACPI_TPM_H
>   #define HW_ACPI_TPM_H
>  =20
> +#include "qemu/osdep.h"
> +
>   #define TPM_TIS_ADDR_BASE           0xFED40000
>   #define TPM_TIS_ADDR_SIZE           0x5000
>  =20
>   #define TPM_TIS_IRQ                 5
>  =20
> +struct crb_regs {
> +    union {
> +        uint32_t reg;
> +        struct {
> +            unsigned tpm_established:1;
> +            unsigned loc_assigned:1;
> +            unsigned active_locality:3;
> +            unsigned reserved:2;
> +            unsigned tpm_reg_valid_sts:1;
> +        } bits;
> +    } loc_state;
> +    uint32_t reserved1;
> +    uint32_t loc_ctrl;
> +    union {
> +        uint32_t reg;
> +        struct {
> +            unsigned granted:1;
> +            unsigned been_seized:1;
> +        } bits;
> +    } loc_sts;
> +    uint8_t reserved2[32];
> +    union {
> +        uint64_t reg;
> +        struct {
> +            unsigned type:4;
> +            unsigned version:4;
> +            unsigned cap_locality:1;
> +            unsigned cap_crb_idle_bypass:1;
> +            unsigned reserved1:1;
> +            unsigned cap_data_xfer_size_support:2;
> +            unsigned cap_fifo:1;
> +            unsigned cap_crb:1;
> +            unsigned cap_if_res:2;
> +            unsigned if_selector:2;
> +            unsigned if_selector_lock:1;
> +            unsigned reserved2:4;
> +            unsigned rid:8;
> +            unsigned vid:16;
> +            unsigned did:16;
> +        } bits;
> +    } intf_id;
> +    uint64_t ctrl_ext;
> +
> +    uint32_t ctrl_req;
> +    union {
> +        uint32_t reg;
> +        struct {
> +            unsigned tpm_sts:1;
> +            unsigned tpm_idle:1;
> +            unsigned reserved:30;
> +        } bits;
> +    } ctrl_sts;
> +    uint32_t ctrl_cancel;
> +    uint32_t ctrl_start;
> +    uint32_t ctrl_int_enable;
> +    uint32_t ctrl_int_sts;
> +    uint32_t ctrl_cmd_size;
> +    uint32_t ctrl_cmd_pa_low;
> +    uint32_t ctrl_cmd_pa_high;
> +    uint32_t ctrl_rsp_size;
> +    uint64_t ctrl_rsp_pa;
> +    uint8_t reserved3[0x10];
> +} QEMU_PACKED;
> +
> +#define TPM_CRB_ADDR_BASE           0xFED40000
> +#define TPM_CRB_ADDR_SIZE           0x1000
> +#define TPM_CRB_ADDR_CTRL \
> +    (TPM_CRB_ADDR_BASE + offsetof(struct crb_regs, ctrl_req))
> +
>   #define TPM_LOG_AREA_MINIMUM_SIZE   (64 * 1024)
>  =20
>   #define TPM_TCPA_ACPI_CLASS_CLIENT  0
> @@ -30,5 +101,6 @@
>   #define TPM2_ACPI_CLASS_SERVER      1
>  =20
>   #define TPM2_START_METHOD_MMIO      6
> +#define TPM2_START_METHOD_CRB       7
>  =20
>   #endif /* HW_ACPI_TPM_H */
> diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
> index 852e02687c..4bc7b09f49 100644
> --- a/include/sysemu/tpm.h
> +++ b/include/sysemu/tpm.h
> @@ -46,9 +46,12 @@ typedef struct TPMIfClass {
>   } TPMIfClass;
>  =20
>   #define TYPE_TPM_TIS                "tpm-tis"
> +#define TYPE_TPM_CRB                "tpm-crb"
>  =20
>   #define TPM_IS_TIS(chr)                             \
>       object_dynamic_cast(OBJECT(chr), TYPE_TPM_TIS)
> +#define TPM_IS_CRB(chr)                             \
> +    object_dynamic_cast(OBJECT(chr), TYPE_TPM_CRB)
>  =20
>   /* returns NULL unless there is exactly one TPM device */
>   static inline TPMIf *tpm_find(void)
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 18b939e469..86a1aa86ba 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2224,6 +2224,22 @@ build_dsdt(GArray *table_data, BIOSLinker *linke=
r,
>               aml_append(sb_scope, scope);
>           }
>       }
> +
> +    if (TPM_IS_CRB(tpm_find())) {
> +        dev =3D aml_device("TPM");
> +        aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101")))=
;
> +        crs =3D aml_resource_template();
> +        aml_append(crs, aml_memory32_fixed(TPM_CRB_ADDR_BASE,
> +                                           TPM_CRB_ADDR_SIZE, AML_READ=
_WRITE));
> +        aml_append(dev, aml_name_decl("_CRS", crs));
> +
> +        method =3D aml_method("_STA", 0, AML_NOTSERIALIZED);
> +        aml_append(method, aml_return(aml_int(0x0f)));
> +        aml_append(dev, method);
> +
> +        aml_append(sb_scope, dev);
> +    }
> +
>       aml_append(dsdt, sb_scope);
>  =20
>       /* copy AML table into ACPI tables blob and patch header there */
> @@ -2285,18 +2301,20 @@ build_tpm2(GArray *table_data, BIOSLinker *link=
er, GArray *tcpalog)
>       if (TPM_IS_TIS(tpm_find())) {
>           tpm2_ptr->control_area_address =3D cpu_to_le64(0);
>           tpm2_ptr->start_method =3D cpu_to_le32(TPM2_START_METHOD_MMIO=
);
> -
> -        tpm2_ptr->log_area_minimum_length =3D
> -            cpu_to_le32(TPM_LOG_AREA_MINIMUM_SIZE);
> -
> -        /* log area start address to be filled by Guest linker */
> -        bios_linker_loader_add_pointer(linker,
> -            ACPI_BUILD_TABLE_FILE, log_addr_offset, log_addr_size,
> -            ACPI_BUILD_TPMLOG_FILE, 0);
> +    } else if (TPM_IS_CRB(tpm_find())) {
> +        tpm2_ptr->control_area_address =3D cpu_to_le64(TPM_CRB_ADDR_CT=
RL);
> +        tpm2_ptr->start_method =3D cpu_to_le32(TPM2_START_METHOD_CRB);
>       } else {
>           g_warn_if_reached();
>       }
>  =20
> +    tpm2_ptr->log_area_minimum_length =3D
> +        cpu_to_le32(TPM_LOG_AREA_MINIMUM_SIZE);
> +
> +    /* log area start address to be filled by Guest linker */
> +    bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
> +                                   log_addr_offset, log_addr_size,
> +                                   ACPI_BUILD_TPMLOG_FILE, 0);
>       build_header(linker, table_data,
>                    (void *)tpm2_ptr, "TPM2", sizeof(*tpm2_ptr), 4, NULL=
, NULL);
>   }
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> new file mode 100644
> index 0000000000..d70de79459
> --- /dev/null
> +++ b/hw/tpm/tpm_crb.c
> @@ -0,0 +1,325 @@
> +/*
> + * tpm_crb.c - QEMU's TPM CRB interface emulator
> + *
> + * Copyright (c) 2017 Red Hat, Inc.
> + *
> + * Authors:
> + *   Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> + * See the COPYING file in the top-level directory.
> + *
> + * tpm_crb is a device for TPM 2.0 Command Response Buffer (CRB) Inter=
face
> + * as defined in TCG PC Client Platform TPM Profile (PTP) Specificatio=
n
> + * Family =E2=80=9C2.0=E2=80=9D Level 00 Revision 01.03 v22
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "qemu-common.h"
> +#include "qapi/error.h"
> +#include "hw/sysbus.h"
> +#include "exec/address-spaces.h"
> +
> +#include "hw/pci/pci_ids.h"
> +#include "hw/acpi/tpm.h"
> +#include "sysemu/tpm_backend.h"
> +#include "tpm_int.h"
> +#include "tpm_util.h"
> +
> +typedef struct CRBState {
> +    SysBusDevice parent_obj;
> +
> +    TPMBackend *tpmbe;
> +    TPMBackendCmd cmd;
> +    struct crb_regs regs;
> +    MemoryRegion mmio;
> +    MemoryRegion cmdmem;
> +} CRBState;
> +
> +#define CRB(obj) OBJECT_CHECK(CRBState, (obj), TYPE_TPM_CRB)
> +
> +#define DEBUG_CRB 0
> +
> +#define DPRINTF(fmt, ...) do {                  \
> +        if (DEBUG_CRB) {                        \
> +            printf(fmt, ## __VA_ARGS__);        \
> +        }                                       \
> +    } while (0);
> +
> +#define CRB_ADDR_LOC_STATE offsetof(struct crb_regs, loc_state)
> +#define CRB_ADDR_LOC_CTRL offsetof(struct crb_regs, loc_ctrl)
> +#define CRB_ADDR_CTRL_REQ offsetof(struct crb_regs, ctrl_req)
> +#define CRB_ADDR_CTRL_CANCEL offsetof(struct crb_regs, ctrl_cancel)
> +#define CRB_ADDR_CTRL_START offsetof(struct crb_regs, ctrl_start)
> +
> +#define CRB_INTF_TYPE_CRB_ACTIVE 0b1
> +#define CRB_INTF_VERSION_CRB 0b1
> +#define CRB_INTF_CAP_LOCALITY_0_ONLY 0b0
> +#define CRB_INTF_CAP_IDLE_FAST 0b0
> +#define CRB_INTF_CAP_XFER_SIZE_64 0b11
> +#define CRB_INTF_CAP_FIFO_NOT_SUPPORTED 0b0
> +#define CRB_INTF_CAP_CRB_SUPPORTED 0b1
> +#define CRB_INTF_IF_SELECTOR_CRB 0b1
> +#define CRB_INTF_IF_SELECTOR_UNLOCKED 0b0
> +
> +#define CRB_CTRL_CMD_SIZE (TPM_CRB_ADDR_SIZE - sizeof(struct crb_regs)=
)
> +
> +enum crb_loc_ctrl {
> +    CRB_LOC_CTRL_REQUEST_ACCESS =3D BIT(0),
> +    CRB_LOC_CTRL_RELINQUISH =3D BIT(1),
> +    CRB_LOC_CTRL_SEIZE =3D BIT(2),
> +    CRB_LOC_CTRL_RESET_ESTABLISHMENT_BIT =3D BIT(3),
> +};
> +
> +enum crb_ctrl_req {
> +    CRB_CTRL_REQ_CMD_READY =3D BIT(0),
> +    CRB_CTRL_REQ_GO_IDLE =3D BIT(1),
> +};
> +
> +enum crb_ctrl_sts {
> +    CRB_CTRL_STS_ERROR =3D BIT(0),
> +    CRB_CTRL_STS_TPM_IDLE =3D BIT(1),
> +};
> +
> +enum crb_start {
> +    CRB_START_INVOKE =3D BIT(0),
> +};
> +
> +enum crb_cancel {
> +    CRB_CANCEL_INVOKE =3D BIT(0),
> +};
> +
> +static const char *addr_desc(unsigned off)
> +{
> +    struct crb_regs crb;
> +
> +    switch (off) {
> +#define CASE(field)                                                 \
> +    case offsetof(struct crb_regs, field) ...                       \
> +        offsetof(struct crb_regs, field) + sizeof(crb.field) - 1:   \
> +        return G_STRINGIFY(field);
> +        CASE(loc_state);
> +        CASE(reserved1);
> +        CASE(loc_ctrl);
> +        CASE(loc_sts);
> +        CASE(reserved2);
> +        CASE(intf_id);
> +        CASE(ctrl_ext);
> +        CASE(ctrl_req);
> +        CASE(ctrl_sts);
> +        CASE(ctrl_cancel);
> +        CASE(ctrl_start);
> +        CASE(ctrl_int_enable);
> +        CASE(ctrl_int_sts);
> +        CASE(ctrl_cmd_size);
> +        CASE(ctrl_cmd_pa_low);
> +        CASE(ctrl_cmd_pa_high);
> +        CASE(ctrl_rsp_size);
> +        CASE(ctrl_rsp_pa);
> +#undef CASE
> +    }
> +    return NULL;
> +}
> +
> +static uint64_t tpm_crb_mmio_read(void *opaque, hwaddr addr,
> +                                  unsigned size)
> +{
> +    CRBState *s =3D CRB(opaque);
> +    DPRINTF("CRB read 0x%lx:%s len:%u\n",
> +            addr, addr_desc(addr), size);
> +    void *regs =3D (void *)&s->regs + addr;
> +
> +    switch (size) {
> +    case 1:
> +        return *(uint8_t *)regs;
> +    case 2:
> +        return *(uint16_t *)regs;
> +    case 4:
> +        return *(uint32_t *)regs;
> +    default:
> +        g_return_val_if_reached(-1);
> +    }
> +}
> +
> +static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
> +                               uint64_t val, unsigned size)
> +{
> +    CRBState *s =3D CRB(opaque);
> +    DPRINTF("CRB write 0x%lx:%s len:%u val:%lu\n",
> +            addr, addr_desc(addr), size, val);
> +
> +    switch (addr) {
> +    case CRB_ADDR_CTRL_REQ:
> +        switch (val) {
> +        case CRB_CTRL_REQ_CMD_READY:
> +            s->regs.ctrl_sts.bits.tpm_idle =3D 0;
> +            break;
> +        case CRB_CTRL_REQ_GO_IDLE:
> +            s->regs.ctrl_sts.bits.tpm_idle =3D 1;
> +            break;
> +        }
> +        break;
> +    case CRB_ADDR_CTRL_CANCEL:
> +        if (val =3D=3D CRB_CANCEL_INVOKE && s->regs.ctrl_start & CRB_S=
TART_INVOKE) {
> +            tpm_backend_cancel_cmd(s->tpmbe);
> +        }
> +        break;
> +    case CRB_ADDR_CTRL_START:
> +        if (val =3D=3D CRB_START_INVOKE &&
> +            !(s->regs.ctrl_start & CRB_START_INVOKE)) {
> +            void *mem =3D memory_region_get_ram_ptr(&s->cmdmem);
> +
> +            s->regs.ctrl_start |=3D CRB_START_INVOKE;
> +            s->cmd =3D (TPMBackendCmd) {
> +                .in =3D mem,
> +                .in_len =3D MIN(tpm_cmd_get_size(mem), CRB_CTRL_CMD_SI=
ZE),
> +                .out =3D mem,
> +                .out_len =3D CRB_CTRL_CMD_SIZE,
> +            };
> +
> +            tpm_backend_deliver_request(s->tpmbe, &s->cmd);
> +        }
> +        break;
> +    case CRB_ADDR_LOC_CTRL:
> +        switch (val) {
> +        case CRB_LOC_CTRL_RESET_ESTABLISHMENT_BIT:
> +            /* not loc 3 or 4 */
> +            break;
> +        case CRB_LOC_CTRL_RELINQUISH:
> +            break;
> +        case CRB_LOC_CTRL_REQUEST_ACCESS:
> +            s->regs.loc_sts.bits.granted =3D 1;
> +            s->regs.loc_sts.bits.been_seized =3D 0;
> +            s->regs.loc_state.bits.loc_assigned =3D 1;
> +            s->regs.loc_state.bits.tpm_reg_valid_sts =3D 1;
> +            break;
> +        }
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps tpm_crb_memory_ops =3D {
> +    .read =3D tpm_crb_mmio_read,
> +    .write =3D tpm_crb_mmio_write,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 4,
> +    },
> +};
> +
> +static void tpm_crb_reset(DeviceState *dev)
> +{
> +    CRBState *s =3D CRB(dev);
> +
> +    tpm_backend_reset(s->tpmbe);
> +
> +    s->regs =3D (struct crb_regs) {
> +        .intf_id.bits =3D {
> +            .type =3D CRB_INTF_TYPE_CRB_ACTIVE,
> +            .version =3D CRB_INTF_VERSION_CRB,
> +            .cap_locality =3D CRB_INTF_CAP_LOCALITY_0_ONLY,
> +            .cap_crb_idle_bypass =3D CRB_INTF_CAP_IDLE_FAST,
> +            .cap_data_xfer_size_support =3D CRB_INTF_CAP_XFER_SIZE_64,
> +            .cap_fifo =3D CRB_INTF_CAP_FIFO_NOT_SUPPORTED,
> +            .cap_crb =3D CRB_INTF_CAP_CRB_SUPPORTED,
> +            .cap_if_res =3D 0b0,
> +            .if_selector =3D CRB_INTF_IF_SELECTOR_CRB,
> +            .if_selector_lock =3D CRB_INTF_IF_SELECTOR_UNLOCKED,
> +            .rid =3D 0b0001,
> +            .vid =3D PCI_VENDOR_ID_IBM,
> +            .did =3D 0b0001,
> +        },
> +        .ctrl_cmd_size =3D CRB_CTRL_CMD_SIZE,
> +        .ctrl_cmd_pa_low =3D TPM_CRB_ADDR_BASE + sizeof(struct crb_reg=
s),
> +        .ctrl_rsp_size =3D CRB_CTRL_CMD_SIZE,
> +        .ctrl_rsp_pa =3D TPM_CRB_ADDR_BASE + sizeof(struct crb_regs),
> +    };
> +
> +    tpm_backend_startup_tpm(s->tpmbe, CRB_CTRL_CMD_SIZE);
> +}
> +
> +static void tpm_crb_request_completed(TPMIf *ti)
> +{
> +    CRBState *s =3D CRB(ti);
> +
> +    s->regs.ctrl_start &=3D ~CRB_START_INVOKE;
> +    /* TODO, in case of error: s->regs.ctrl_sts =3D CRB_CTRL_STS_ERROR=
 */
> +}
> +
> +static enum TPMVersion tpm_crb_get_version(TPMIf *ti)
> +{
> +    CRBState *s =3D CRB(ti);
> +
> +    return tpm_backend_get_tpm_version(s->tpmbe);
> +}
> +
> +static const VMStateDescription vmstate_tpm_crb =3D {
> +    .name =3D "tpm-crb",
> +    .unmigratable =3D 1,
> +};
> +
> +static Property tpm_crb_properties[] =3D {
> +    DEFINE_PROP_TPMBE("tpmdev", CRBState, tpmbe),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void tpm_crb_realizefn(DeviceState *dev, Error **errp)
> +{
> +    CRBState *s =3D CRB(dev);
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> +
> +    if (!tpm_find()) {
> +        error_setg(errp, "at most one TPM device is permitted");
> +        return;
> +    }
> +    if (!s->tpmbe) {
> +        error_setg(errp, "'tpmdev' property is required");
> +        return;
> +    }
> +
> +    memory_region_init_io(&s->mmio, OBJECT(s), &tpm_crb_memory_ops, s,
> +        "tpm-crb-mmio", sizeof(struct crb_regs));
> +    memory_region_init_ram(&s->cmdmem, OBJECT(s),
> +        "tpm-crb-cmd", CRB_CTRL_CMD_SIZE, errp);
> +
> +    sysbus_init_mmio(sbd, &s->mmio);
> +    sysbus_mmio_map(sbd, 0, TPM_CRB_ADDR_BASE);
> +    /* allocate ram in bios instead? */
> +    memory_region_add_subregion(get_system_memory(),
> +        TPM_CRB_ADDR_BASE + sizeof(struct crb_regs), &s->cmdmem);
> +}
> +
> +static void tpm_crb_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    TPMIfClass *tc =3D TPM_IF_CLASS(klass);
> +
> +    dc->realize =3D tpm_crb_realizefn;
> +    dc->props =3D tpm_crb_properties;
> +    dc->reset =3D tpm_crb_reset;
> +    dc->vmsd  =3D &vmstate_tpm_crb;
> +    dc->user_creatable =3D true;
> +    tc->model =3D TPM_MODEL_TPM_CRB;
> +    tc->get_version =3D tpm_crb_get_version;
> +    tc->request_completed =3D tpm_crb_request_completed;
> +}
> +
> +static const TypeInfo tpm_crb_info =3D {
> +    .name =3D TYPE_TPM_CRB,
> +    .parent =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(CRBState),
> +    .class_init  =3D tpm_crb_class_init,
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { TYPE_TPM_IF },
> +        { }
> +    }
> +};
> +
> +static void tpm_crb_register(void)
> +{
> +    type_register_static(&tpm_crb_info);
> +}
> +
> +type_init(tpm_crb_register)
> diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-so=
ftmmu.mak
> index 95ac4b464a..ac27700e79 100644
> --- a/default-configs/i386-softmmu.mak
> +++ b/default-configs/i386-softmmu.mak
> @@ -37,6 +37,7 @@ CONFIG_APPLESMC=3Dy
>   CONFIG_I8259=3Dy
>   CONFIG_PFLASH_CFI01=3Dy
>   CONFIG_TPM_TIS=3D$(CONFIG_TPM)
> +CONFIG_TPM_CRB=3D$(CONFIG_TPM)
>   CONFIG_MC146818RTC=3Dy
>   CONFIG_PCI_PIIX=3Dy
>   CONFIG_WDT_IB700=3Dy
> diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_6=
4-softmmu.mak
> index 0221236825..b2104ade19 100644
> --- a/default-configs/x86_64-softmmu.mak
> +++ b/default-configs/x86_64-softmmu.mak
> @@ -37,6 +37,7 @@ CONFIG_APPLESMC=3Dy
>   CONFIG_I8259=3Dy
>   CONFIG_PFLASH_CFI01=3Dy
>   CONFIG_TPM_TIS=3D$(CONFIG_TPM)
> +CONFIG_TPM_CRB=3D$(CONFIG_TPM)
>   CONFIG_MC146818RTC=3Dy
>   CONFIG_PCI_PIIX=3Dy
>   CONFIG_WDT_IB700=3Dy
> diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
> index 7a93b24636..1dc9f8bf2c 100644
> --- a/hw/tpm/Makefile.objs
> +++ b/hw/tpm/Makefile.objs
> @@ -1,4 +1,5 @@
>   common-obj-y +=3D tpm_util.o
>   common-obj-$(CONFIG_TPM_TIS) +=3D tpm_tis.o
> +common-obj-$(CONFIG_TPM_CRB) +=3D tpm_crb.o
>   common-obj-$(CONFIG_TPM_PASSTHROUGH) +=3D tpm_passthrough.o
>   common-obj-$(CONFIG_TPM_EMULATOR) +=3D tpm_emulator.o
