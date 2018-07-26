Received: from eggs.gnu.org ([2001:4830:134:3::10]:47282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fijwL-00081j-UL
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 13:20:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fijwG-00084s-Ty
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 13:20:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45028
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fijwG-00084S-My
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 13:20:32 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6QHJReb015168
	for <qemu-devel@nongnu.org>; Thu, 26 Jul 2018 13:20:31 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2kfj32scht-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 26 Jul 2018 13:20:30 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 26 Jul 2018 11:20:29 -0600
References: <1513111443-22790-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1513111443-22790-2-git-send-email-stefanb@linux.vnet.ibm.com>
	<20180726052617.GE12001@umbus.fritz.box>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 26 Jul 2018 13:20:21 -0400
MIME-Version: 1.0
In-Reply-To: <20180726052617.GE12001@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-MW
Message-Id: <a4e97817-0025-a5ab-a025-25a7d70e527f@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 1/2] tpm_spapr: Support TPM
 for ppc64 using CRQ based interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: lo1@us.ibm.com, qemu-devel@nongnu.org, James.Bottomley@hansenpartnership.com, qemu-ppc@nongnu.org, clg@kaod.org, marcandre.lureau@redhat.com

On 07/26/2018 01:26 AM, David Gibson wrote:
> On Tue, Dec 12, 2017 at 03:44:02PM -0500, Stefan Berger wrote:
>> Implement support for TPM on ppc64 by implementing the vTPM CRQ
>> interface as a frontend. It can use the tpm_emulator driver
>> backend with the external swtpm.
>>
>> The Linux vTPM driver for ppc64 works with this emulation.
>>
>> This TPM emulator also handles the TPM 2 case.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Sorry, this slipped through the cracks and I completely forgot about
> it for a very long time.  I don't know enough about TPMs to review in
> detail, but nothing looks obviously bogus, so,
>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>
> However, it looks like it will need a rebase against the current
> ppc-for-3.1 tree in order to be applied.

Thanks a lot for the review. I have to see what I will do with it now=20
since it requires a lot of extensions to the SLOF firmware as well...

 =A0=A0=A0 Stefan

>
>> ---
>>   hw/tpm/Makefile.objs |   1 +
>>   hw/tpm/tpm_spapr.c   | 382 +++++++++++++++++++++++++++++++++++++++++=
++++++++++
>>   include/sysemu/tpm.h |   3 +
>>   qapi/tpm.json        |   5 +-
>>   4 files changed, 389 insertions(+), 2 deletions(-)
>>   create mode 100644 hw/tpm/tpm_spapr.c
>>
>> diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
>> index 41f0b7a..71ea63e 100644
>> --- a/hw/tpm/Makefile.objs
>> +++ b/hw/tpm/Makefile.objs
>> @@ -1,3 +1,4 @@
>>   common-obj-$(CONFIG_TPM_TIS) +=3D tpm_tis.o
>>   common-obj-$(CONFIG_TPM_PASSTHROUGH) +=3D tpm_passthrough.o tpm_util=
.o
>>   common-obj-$(CONFIG_TPM_EMULATOR) +=3D tpm_emulator.o tpm_util.o
>> +obj-$(CONFIG_PSERIES) +=3D tpm_spapr.o
>> diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
>> new file mode 100644
>> index 0000000..ef5e62d
>> --- /dev/null
>> +++ b/hw/tpm/tpm_spapr.c
>> @@ -0,0 +1,382 @@
>> +/*
>> + * QEMU PowerPC pSeries Logical Partition (aka sPAPR) hardware System=
 Emulator
>> + *
>> + * PAPR Virtual TPM
>> + *
>> + * Copyright (c) 2015, 2017 IBM Corporation.
>> + *
>> + * Authors:
>> + *    Stefan Berger <stefanb@linux.vnet.ibm.com>
>> + *
>> + * This code is licensed under the GPL version 2 or later. See the
>> + * COPYING file in the top-level directory.
>> + *
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/error-report.h"
>> +#include "qapi/error.h"
>> +
>> +#include "sysemu/tpm_backend.h"
>> +#include "tpm_int.h"
>> +#include "tpm_util.h"
>> +
>> +#include "hw/ppc/spapr.h"
>> +#include "hw/ppc/spapr_vio.h"
>> +
>> +#define DEBUG_SPAPR_VTPM 0
>> +
>> +#define DPRINTF(fmt, ...) do { \
>> +    if (DEBUG_SPAPR_VTPM) { \
>> +        printf(fmt, ## __VA_ARGS__); \
>> +    } \
>> +} while (0)
>> +
>> +#define VIO_SPAPR_VTPM(obj) \
>> +     OBJECT_CHECK(SPAPRvTPMState, (obj), TYPE_TPM_SPAPR)
>> +
>> +typedef struct VioCRQ {
>> +    uint8_t valid;  /* 0x80: cmd; 0xc0: init crq
>> +                       0x81-0x83: CRQ message response */
>> +    uint8_t msg;    /* see below */
>> +    uint16_t len;   /* len of TPM request; len of TPM response */
>> +    uint32_t data;  /* rtce_dma_handle when sending TPM request */
>> +    uint64_t reserved;
>> +} VioCRQ;
>> +
>> +typedef union TPMSpaprCRQ {
>> +    VioCRQ s;
>> +    uint8_t raw[sizeof(VioCRQ)];
>> +} TPMSpaprCRQ;
>> +
>> +#define SPAPR_VTPM_VALID_INIT_CRQ_COMMAND  0xC0
>> +#define SPAPR_VTPM_VALID_COMMAND           0x80
>> +#define SPAPR_VTPM_MSG_RESULT              0x80
>> +
>> +/* msg types for valid =3D SPAPR_VTPM_VALID_INIT_CRQ */
>> +#define SPAPR_VTPM_INIT_CRQ_RESULT           0x1
>> +#define SPAPR_VTPM_INIT_CRQ_COMPLETE_RESULT  0x2
>> +
>> +/* msg types for valid =3D SPAPR_VTPM_VALID_CMD */
>> +#define SPAPR_VTPM_GET_VERSION               0x1
>> +#define SPAPR_VTPM_TPM_COMMAND               0x2
>> +#define SPAPR_VTPM_GET_RTCE_BUFFER_SIZE      0x3
>> +#define SPAPR_VTPM_PREPARE_TO_SUSPEND        0x4
>> +
>> +/* response error messages */
>> +#define SPAPR_VTPM_VTPM_ERROR                0xff
>> +
>> +/* error codes */
>> +#define SPAPR_VTPM_ERR_COPY_IN_FAILED        0x3
>> +#define SPAPR_VTPM_ERR_COPY_OUT_FAILED       0x4
>> +
>> +#define MAX_BUFFER_SIZE TARGET_PAGE_SIZE
>> +
>> +typedef struct {
>> +    VIOsPAPRDevice vdev;
>> +
>> +    TPMSpaprCRQ crq; /* track single TPM command */
>> +
>> +    uint8_t state;
>> +#define SPAPR_VTPM_STATE_NONE         0
>> +#define SPAPR_VTPM_STATE_EXECUTION    1
>> +#define SPAPR_VTPM_STATE_COMPLETION   2
>> +
>> +    unsigned char buffer[MAX_BUFFER_SIZE];
>> +
>> +    TPMBackendCmd cmd;
>> +
>> +    TPMBackend *be_driver;
>> +    TPMVersion be_tpm_version;
>> +
>> +    size_t be_buffer_size;
>> +} SPAPRvTPMState;
>> +
>> +static void tpm_spapr_show_buffer(const unsigned char *buffer,
>> +                                  size_t buffer_len, const char *stri=
ng)
>> +{
>> +#if DEBUG_SPAPR_VTPM
>> +    size_t i, len;
>> +
>> +    len =3D MIN(tpm_cmd_get_size(buffer), buffer_len);
>> +    printf("spapr_vtpm: %s length =3D %zu\n", string, len);
>> +    for (i =3D 0; i < len; i++) {
>> +        if (i && !(i % 16)) {
>> +            printf("\n");
>> +        }
>> +        printf("%.2X ", buffer[i]);
>> +    }
>> +    printf("\n");
>> +#endif
>> +}
>> +
>> +/*
>> + * Send a request to the TPM.
>> + */
>> +static void tpm_spapr_tpm_send(SPAPRvTPMState *s)
>> +{
>> +    tpm_spapr_show_buffer(s->buffer, sizeof(s->buffer), "spapr_vtpm: =
Tx TPM");
>> +
>> +    s->state =3D SPAPR_VTPM_STATE_EXECUTION;
>> +    s->cmd =3D (TPMBackendCmd) {
>> +        .locty =3D 0,
>> +        .in =3D s->buffer,
>> +        .in_len =3D MIN(tpm_cmd_get_size(s->buffer), sizeof(s->buffer=
)),
>> +        .out =3D s->buffer,
>> +        .out_len =3D sizeof(s->buffer),
>> +    };
>> +
>> +    tpm_backend_deliver_request(s->be_driver, &s->cmd);
>> +}
>> +
>> +static int tpm_spapr_process_cmd(SPAPRvTPMState *s, uint64_t dataptr)
>> +{
>> +    long rc;
>> +
>> +    /* a max. of be_buffer_size bytes can be transported */
>> +    rc =3D spapr_vio_dma_read(&s->vdev, dataptr,
>> +                            s->buffer, s->be_buffer_size);
>> +    if (rc) {
>> +        error_report("tpm_spapr_got_payload: DMA read failure !\n");
>> +    } else {
>> +        /* let vTPM handle any malformed request */
>> +        tpm_spapr_tpm_send(s);
>> +    }
>> +
>> +    return rc;
>> +}
>> +
>> +static int tpm_spapr_do_crq(struct VIOsPAPRDevice *dev, uint8_t *crq_=
data)
>> +{
>> +    SPAPRvTPMState *s =3D VIO_SPAPR_VTPM(dev);
>> +    TPMSpaprCRQ local_crq;
>> +    TPMSpaprCRQ *crq =3D &s->crq; /* requests only */
>> +    int rc;
>> +
>> +    memcpy(&local_crq.raw, crq_data, sizeof(local_crq.raw));
>> +
>> +    DPRINTF("VTPM: do_crq %02x %02x ...\n",
>> +            local_crq.raw[0], local_crq.raw[1]);
>> +
>> +    switch (local_crq.s.valid) {
>> +    case SPAPR_VTPM_VALID_INIT_CRQ_COMMAND: /* Init command/response =
*/
>> +
>> +        /* Respond to initialization request */
>> +        switch (local_crq.s.msg) {
>> +        case SPAPR_VTPM_INIT_CRQ_RESULT:
>> +            DPRINTF("vtpm_do_crq: SPAPR_VTPM_INIT_CRQ_RESULT\n");
>> +            memset(local_crq.raw, 0, sizeof(local_crq.raw));
>> +            local_crq.s.valid =3D SPAPR_VTPM_VALID_INIT_CRQ_COMMAND;
>> +            local_crq.s.msg =3D SPAPR_VTPM_INIT_CRQ_RESULT;
>> +            spapr_vio_send_crq(dev, local_crq.raw);
>> +            break;
>> +
>> +        case SPAPR_VTPM_INIT_CRQ_COMPLETE_RESULT:
>> +            DPRINTF("vtpm_do_crq: SPAPR_VTPM_INIT_CRQ_COMP_RESULT\n")=
;
>> +            memset(local_crq.raw, 0, sizeof(local_crq.raw));
>> +            local_crq.s.valid =3D SPAPR_VTPM_VALID_INIT_CRQ_COMMAND;
>> +            local_crq.s.msg =3D SPAPR_VTPM_INIT_CRQ_COMPLETE_RESULT;
>> +            spapr_vio_send_crq(dev, local_crq.raw);
>> +            break;
>> +        }
>> +
>> +        break;
>> +    case SPAPR_VTPM_VALID_COMMAND: /* Payloads */
>> +        switch (local_crq.s.msg) {
>> +        case SPAPR_VTPM_TPM_COMMAND:
>> +            DPRINTF("vtpm_do_crq: got TPM command payload!\n");
>> +            if (s->state =3D=3D SPAPR_VTPM_STATE_EXECUTION)
>> +                return H_BUSY;
>> +            /* this crq is tracked */
>> +            memcpy(crq->raw, crq_data, sizeof(crq->raw));
>> +
>> +            rc =3D tpm_spapr_process_cmd(s, be32_to_cpu(crq->s.data))=
;
>> +
>> +            if (rc =3D=3D H_SUCCESS) {
>> +                crq->s.valid =3D be16_to_cpu(0);
>> +            } else {
>> +                local_crq.s.valid =3D SPAPR_VTPM_MSG_RESULT;
>> +                local_crq.s.msg =3D SPAPR_VTPM_VTPM_ERROR;
>> +                local_crq.s.data =3D cpu_to_be32(SPAPR_VTPM_ERR_COPY_=
IN_FAILED);
>> +                spapr_vio_send_crq(dev, local_crq.raw);
>> +            }
>> +            break;
>> +
>> +        case SPAPR_VTPM_GET_RTCE_BUFFER_SIZE:
>> +            DPRINTF("vtpm_do_crq: resp: buffer size is %zu\n",
>> +                    s->be_buffer_size);
>> +            local_crq.s.msg |=3D SPAPR_VTPM_MSG_RESULT;
>> +            local_crq.s.len =3D cpu_to_be16(s->be_buffer_size);
>> +            spapr_vio_send_crq(dev, local_crq.raw);
>> +            break;
>> +
>> +        case SPAPR_VTPM_GET_VERSION:
>> +            local_crq.s.msg |=3D SPAPR_VTPM_MSG_RESULT;
>> +            local_crq.s.len =3D cpu_to_be16(0);
>> +            switch (s->be_tpm_version) {
>> +            case TPM_VERSION_UNSPEC:
>> +                local_crq.s.data =3D cpu_to_be32(0);
>> +                break;
>> +            case TPM_VERSION_1_2:
>> +                local_crq.s.data =3D cpu_to_be32(1);
>> +                break;
>> +            case TPM_VERSION_2_0:
>> +                local_crq.s.data =3D cpu_to_be32(2);
>> +                break;
>> +            }
>> +            DPRINTF("vtpm_do_crq: resp: version %u\n",
>> +                    local_crq.s.data);
>> +            spapr_vio_send_crq(dev, local_crq.raw);
>> +            break;
>> +
>> +        case SPAPR_VTPM_PREPARE_TO_SUSPEND:
>> +            DPRINTF("vtpm_do_crq: resp: prep to suspend\n");
>> +            local_crq.s.msg |=3D SPAPR_VTPM_MSG_RESULT;
>> +            spapr_vio_send_crq(dev, local_crq.raw);
>> +            break;
>> +
>> +        default:
>> +            DPRINTF("vtpm_do_crq: Unknown message type %02x\n",
>> +                    crq->s.msg);
>> +        }
>> +        break;
>> +    default:
>> +        DPRINTF("vtpm_do_crq: unknown CRQ %02x %02x ...\n",
>> +                local_crq.raw[0], local_crq.raw[1]);
>> +    };
>> +
>> +    return H_SUCCESS;
>> +}
>> +
>> +static void tpm_spapr_request_completed(TPMIf *ti)
>> +{
>> +    SPAPRvTPMState *s =3D VIO_SPAPR_VTPM(ti);
>> +    TPMSpaprCRQ *crq =3D &s->crq;
>> +    uint32_t len;
>> +    int rc;
>> +
>> +    tpm_spapr_show_buffer(s->buffer, sizeof(s->buffer), "spapr_vtpm: =
Rx TPM");
>> +
>> +    s->state =3D SPAPR_VTPM_STATE_COMPLETION;
>> +
>> +    /* a max. of be_buffer_size bytes can be transported */
>> +    len =3D MIN(tpm_cmd_get_size(s->buffer), s->be_buffer_size);
>> +    rc =3D spapr_vio_dma_write(&s->vdev, be32_to_cpu(crq->s.data),
>> +                             s->buffer, len);
>> +
>> +    crq->s.valid =3D SPAPR_VTPM_MSG_RESULT;
>> +    if (rc =3D=3D H_SUCCESS) {
>> +        crq->s.msg =3D SPAPR_VTPM_TPM_COMMAND | SPAPR_VTPM_MSG_RESULT=
;
>> +        crq->s.len =3D cpu_to_be16(len);
>> +    } else {
>> +        error_report("%s: DMA write failure\n", __func__);
>> +        crq->s.msg =3D SPAPR_VTPM_VTPM_ERROR;
>> +        crq->s.len =3D cpu_to_be16(0);
>> +        crq->s.data =3D cpu_to_be32(SPAPR_VTPM_ERR_COPY_OUT_FAILED);
>> +    }
>> +
>> +    rc =3D spapr_vio_send_crq(&s->vdev, crq->raw);
>> +    if (rc) {
>> +        error_report("%s: Error sending response\n", __func__);
>> +    }
>> +}
>> +
>> +static int tpm_spapr_do_startup_tpm(SPAPRvTPMState *s, size_t buffers=
ize)
>> +{
>> +    return tpm_backend_startup_tpm(s->be_driver, buffersize);
>> +}
>> +
>> +static void tpm_spapr_reset(VIOsPAPRDevice *dev)
>> +{
>> +    SPAPRvTPMState *s =3D VIO_SPAPR_VTPM(dev);
>> +
>> +    s->state =3D SPAPR_VTPM_STATE_NONE;
>> +
>> +    s->be_tpm_version =3D tpm_backend_get_tpm_version(s->be_driver);
>> +
>> +    s->be_buffer_size =3D MAX(ROUND_UP(tpm_backend_get_buffer_size(s-=
>be_driver),
>> +                                     TARGET_PAGE_SIZE),
>> +                            sizeof(s->buffer));
>> +
>> +    tpm_backend_reset(s->be_driver);
>> +    tpm_spapr_do_startup_tpm(s, s->be_buffer_size);
>> +}
>> +
>> +static enum TPMVersion tpm_spapr_get_version(TPMIf *ti)
>> +{
>> +    SPAPRvTPMState *s =3D VIO_SPAPR_VTPM(ti);
>> +
>> +    if (tpm_backend_had_startup_error(s->be_driver)) {
>> +        return TPM_VERSION_UNSPEC;
>> +    }
>> +
>> +    return tpm_backend_get_tpm_version(s->be_driver);
>> +}
>> +
>> +static const VMStateDescription vmstate_spapr_vtpm =3D {
>> +    .name =3D "tpm_spapr",
>> +    .unmigratable =3D 1,
>> +};
>> +
>> +static Property tpm_spapr_properties[] =3D {
>> +    DEFINE_SPAPR_PROPERTIES(SPAPRvTPMState, vdev),
>> +    DEFINE_PROP_TPMBE("tpmdev", SPAPRvTPMState, be_driver),
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>> +static void tpm_spapr_realizefn(VIOsPAPRDevice *dev, Error **errp)
>> +{
>> +    SPAPRvTPMState *s =3D VIO_SPAPR_VTPM(dev);
>> +
>> +    if (!tpm_find()) {
>> +        error_setg(errp, "at most one TPM device is permitted");
>> +        return;
>> +    }
>> +
>> +    dev->crq.SendFunc =3D tpm_spapr_do_crq;
>> +
>> +    if (!s->be_driver) {
>> +        error_setg(errp, "'tpmdev' property is required");
>> +        return;
>> +    }
>> +}
>> +
>> +static void tpm_spapr_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> +    VIOsPAPRDeviceClass *k =3D VIO_SPAPR_DEVICE_CLASS(klass);
>> +    TPMIfClass *tc =3D TPM_IF_CLASS(klass);
>> +
>> +    k->realize =3D tpm_spapr_realizefn;
>> +    k->reset =3D tpm_spapr_reset;
>> +    k->dt_name =3D "vtpm";
>> +    k->dt_type =3D "IBM,vtpm";
>> +    k->dt_compatible =3D "IBM,vtpm";
>> +    k->signal_mask =3D 0x00000001;
>> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>> +    dc->props =3D tpm_spapr_properties;
>> +    k->rtce_window_size =3D 0x10000000;
>> +    dc->vmsd =3D &vmstate_spapr_vtpm;
>> +
>> +    tc->model =3D TPM_MODEL_TPM_SPAPR;
>> +    tc->get_version =3D tpm_spapr_get_version;
>> +    tc->request_completed =3D tpm_spapr_request_completed;
>> +}
>> +
>> +static const TypeInfo tpm_spapr_info =3D {
>> +    .name          =3D TYPE_TPM_SPAPR,
>> +    .parent        =3D TYPE_VIO_SPAPR_DEVICE,
>> +    .instance_size =3D sizeof(SPAPRvTPMState),
>> +    .class_init    =3D tpm_spapr_class_init,
>> +    .interfaces =3D (InterfaceInfo[]) {
>> +        { TYPE_TPM_IF },
>> +        { }
>> +    }
>> +};
>> +
>> +static void tpm_spapr_register_types(void)
>> +{
>> +    type_register_static(&tpm_spapr_info);
>> +}
>> +
>> +type_init(tpm_spapr_register_types)
>> diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
>> index 852e026..afefadd 100644
>> --- a/include/sysemu/tpm.h
>> +++ b/include/sysemu/tpm.h
>> @@ -46,9 +46,12 @@ typedef struct TPMIfClass {
>>   } TPMIfClass;
>>  =20
>>   #define TYPE_TPM_TIS                "tpm-tis"
>> +#define TYPE_TPM_SPAPR              "tpm-spapr"
>>  =20
>>   #define TPM_IS_TIS(chr)                             \
>>       object_dynamic_cast(OBJECT(chr), TYPE_TPM_TIS)
>> +#define TPM_IS_SPAPR(chr)                           \
>> +    object_dynamic_cast(OBJECT(chr), TYPE_TPM_SPAPR)
>>  =20
>>   /* returns NULL unless there is exactly one TPM device */
>>   static inline TPMIf *tpm_find(void)
>> diff --git a/qapi/tpm.json b/qapi/tpm.json
>> index 7093f26..dfa6a32 100644
>> --- a/qapi/tpm.json
>> +++ b/qapi/tpm.json
>> @@ -11,10 +11,11 @@
>>   # An enumeration of TPM models
>>   #
>>   # @tpm-tis: TPM TIS model
>> +# @tpm-spapr: TPM PAPR model (since 2.12)
>>   #
>>   # Since: 1.5
>>   ##
>> -{ 'enum': 'TpmModel', 'data': [ 'tpm-tis' ] }
>> +{ 'enum': 'TpmModel', 'data': [ 'tpm-tis', 'tpm-spapr' ] }
>>  =20
>>   ##
>>   # @query-tpm-models:
>> @@ -28,7 +29,7 @@
>>   # Example:
>>   #
>>   # -> { "execute": "query-tpm-models" }
>> -# <- { "return": [ "tpm-tis" ] }
>> +# <- { "return": [ "tpm-tis", "tpm-spapr" ] }
>>   #
>>   ##
>>   { 'command': 'query-tpm-models', 'returns': ['TpmModel'] }
