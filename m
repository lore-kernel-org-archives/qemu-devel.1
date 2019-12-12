Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD05C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 11:07:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7B792067C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 11:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHfcMH9h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B792067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifMJF-00061w-Qf
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 06:07:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49205)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ifMI7-0004xL-MC
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 06:05:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ifMI5-0004eA-D3
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 06:05:55 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54748)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ifMI0-0004Vk-AZ; Thu, 12 Dec 2019 06:05:48 -0500
Received: by mail-wm1-x343.google.com with SMTP id b11so1879776wmj.4;
 Thu, 12 Dec 2019 03:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5zU+DJOXfjS1+bRYeQ4RZLpFlgWe+thtNslq2ZICykE=;
 b=hHfcMH9h8NCmRQ16XtsYjNcU5wnllo/4KciCrCyoTecByjoL8mEfZZtAC011v9t4QM
 s7fjnpKHpQ6ChoZ6bprrzKln45UpobKmwNyCCZx460GSxkPPX14r+dEIb3eLH0pMXGSB
 fb+8Fo7zKTfE83kS67Me/iROxU0ehXBmhLg4nAV7O+KG51ZlNOJ7ygngrychtv+q8tyO
 E5FTMc70m7qsSmIFxIKX+aJs/OTKgKl/MnHks3SaGHADi58DH5V5m1tgfFzDjVbnrXVN
 +9NmjSPZgcWUmHQzPux1KdjglQot14vCd7s5E5ZsO6UHSsFu8qIRTApBdY3evaTN5ANu
 xtBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5zU+DJOXfjS1+bRYeQ4RZLpFlgWe+thtNslq2ZICykE=;
 b=TkhJ9nxDIiZCZeqRMgStVMPhqcP+Nf30OtJJa6UqUyUQLz0FFux0/jmLOdhte6vwLi
 mnU7Eur6Y/c6O+ALw2jERXSqNil+s4Lsq21RKsLoZFSi8Zq6+X3CPR7H/VFaR50YQFwH
 AcZiFxP5CChQp2norQb5kfJ8/7k+GfOF/isiAZtWYHL0G0VAHw69tbpFuhGge28eOl9W
 PIlySZEGokMh6VEioc1IN9/Egd86jIuWpux5Ji6IfSuXIrYlnkNG3xNR6xdfDMpTQsmJ
 4tfAdLQlESHTif+L02XqJsLbmilBluKEbyTc6/pJQwfFc9zLgHz/35xIgu0HuBNbwynl
 CJZw==
X-Gm-Message-State: APjAAAXZERq743HQrA9/x3/U+TRNaxZp4K+9hP3fNv6ApLsHF+7oxrBb
 yPqhTpzoTgtOK5kzlWjAqNgTrUvql0Od1YyicduaVlMt
X-Google-Smtp-Source: APXvYqwmwFL0vg3lNLUIVh4yfWx5K3n3bIzPrUqNrbD7Y/5LgM2ZSvqBPixIjpGmA0vHSxG+cLPvZVHcl0nL4JY12TU=
X-Received: by 2002:a05:600c:219a:: with SMTP id
 e26mr6306951wme.42.1576148746878; 
 Thu, 12 Dec 2019 03:05:46 -0800 (PST)
MIME-Version: 1.0
References: <20191211162050.970199-1-stefanb@linux.vnet.ibm.com>
 <20191211162050.970199-2-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20191211162050.970199-2-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 12 Dec 2019 15:05:33 +0400
Message-ID: <CAJ+F1CKo2zkn5s+_ZmWOVt_w_6jPa_roVwAAV3h96vWxXTDefg@mail.gmail.com>
Subject: Re: [PACTH v3 1/5] tpm_spapr: Support TPM for ppc64 using CRQ based
 interface
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "open list:sPAPR pseries" <qemu-ppc@nongnu.org>,
 QEMU <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Dec 11, 2019 at 8:25 PM Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
>
> Implement support for TPM on ppc64 by implementing the vTPM CRQ interface
> as a frontend. It can use the tpm_emulator driver backend with the extern=
al
> swtpm.
>
> The Linux vTPM driver for ppc64 works with this emulation.
>
> This TPM emulator also handles the TPM 2 case.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/tpm/Makefile.objs |   1 +
>  hw/tpm/tpm_spapr.c   | 405 +++++++++++++++++++++++++++++++++++++++++++
>  hw/tpm/trace-events  |  12 ++
>  include/sysemu/tpm.h |   3 +
>  qapi/tpm.json        |   6 +-
>  5 files changed, 424 insertions(+), 3 deletions(-)
>  create mode 100644 hw/tpm/tpm_spapr.c
>
> diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
> index de0b85d02a..f9f29e0082 100644
> --- a/hw/tpm/Makefile.objs
> +++ b/hw/tpm/Makefile.objs
> @@ -4,3 +4,4 @@ common-obj-$(CONFIG_TPM_TIS) +=3D tpm_tis.o
>  common-obj-$(CONFIG_TPM_CRB) +=3D tpm_crb.o
>  common-obj-$(CONFIG_TPM_PASSTHROUGH) +=3D tpm_passthrough.o
>  common-obj-$(CONFIG_TPM_EMULATOR) +=3D tpm_emulator.o
> +obj-$(CONFIG_PSERIES) +=3D tpm_spapr.o

looks good to me, but why not introduce CONFIG_TPM_SPAPR ?

> diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
> new file mode 100644
> index 0000000000..c4a67e2403
> --- /dev/null
> +++ b/hw/tpm/tpm_spapr.c
> @@ -0,0 +1,405 @@
> +/*
> + * QEMU PowerPC pSeries Logical Partition (aka sPAPR) hardware System Em=
ulator
> + *
> + * PAPR Virtual TPM
> + *
> + * Copyright (c) 2015, 2017 IBM Corporation.
> + *
> + * Authors:
> + *    Stefan Berger <stefanb@linux.vnet.ibm.com>
> + *
> + * This code is licensed under the GPL version 2 or later. See the
> + * COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "qapi/error.h"
> +#include "hw/qdev-properties.h"
> +#include "migration/vmstate.h"
> +
> +#include "sysemu/tpm_backend.h"
> +#include "tpm_int.h"
> +#include "tpm_util.h"
> +
> +#include "hw/ppc/spapr.h"
> +#include "hw/ppc/spapr_vio.h"
> +#include "trace.h"
> +
> +#define DEBUG_SPAPR 0
> +
> +#define VIO_SPAPR_VTPM(obj) \
> +     OBJECT_CHECK(SPAPRvTPMState, (obj), TYPE_TPM_SPAPR)
> +
> +typedef struct VioCRQ {
> +    uint8_t valid;  /* 0x80: cmd; 0xc0: init crq */
> +                    /* 0x81-0x83: CRQ message response */
> +    uint8_t msg;    /* see below */
> +    uint16_t len;   /* len of TPM request; len of TPM response */
> +    uint32_t data;  /* rtce_dma_handle when sending TPM request */
> +    uint64_t reserved;
> +} VioCRQ;
> +
> +typedef union TPMSpaprCRQ {
> +    VioCRQ s;
> +    uint8_t raw[sizeof(VioCRQ)];
> +} TPMSpaprCRQ;
> +
> +#define SPAPR_VTPM_VALID_INIT_CRQ_COMMAND  0xC0
> +#define SPAPR_VTPM_VALID_COMMAND           0x80
> +#define SPAPR_VTPM_MSG_RESULT              0x80
> +
> +/* msg types for valid =3D SPAPR_VTPM_VALID_INIT_CRQ */
> +#define SPAPR_VTPM_INIT_CRQ_RESULT           0x1
> +#define SPAPR_VTPM_INIT_CRQ_COMPLETE_RESULT  0x2
> +
> +/* msg types for valid =3D SPAPR_VTPM_VALID_CMD */
> +#define SPAPR_VTPM_GET_VERSION               0x1
> +#define SPAPR_VTPM_TPM_COMMAND               0x2
> +#define SPAPR_VTPM_GET_RTCE_BUFFER_SIZE      0x3
> +#define SPAPR_VTPM_PREPARE_TO_SUSPEND        0x4
> +
> +/* response error messages */
> +#define SPAPR_VTPM_VTPM_ERROR                0xff
> +
> +/* error codes */
> +#define SPAPR_VTPM_ERR_COPY_IN_FAILED        0x3
> +#define SPAPR_VTPM_ERR_COPY_OUT_FAILED       0x4
> +
> +#define MAX_BUFFER_SIZE TARGET_PAGE_SIZE
> +
> +typedef struct {
> +    SpaprVioDevice vdev;
> +
> +    TPMSpaprCRQ crq; /* track single TPM command */
> +
> +    uint8_t state;
> +#define SPAPR_VTPM_STATE_NONE         0
> +#define SPAPR_VTPM_STATE_EXECUTION    1
> +#define SPAPR_VTPM_STATE_COMPLETION   2
> +
> +    unsigned char buffer[MAX_BUFFER_SIZE];
> +
> +    TPMBackendCmd cmd;
> +
> +    TPMBackend *be_driver;
> +    TPMVersion be_tpm_version;
> +
> +    size_t be_buffer_size;
> +} SPAPRvTPMState;
> +
> +static void tpm_spapr_show_buffer(const unsigned char *buffer,
> +                                  size_t buffer_size, const char *string=
)
> +{
> +    size_t len, i;
> +    char *line_buffer, *p;
> +
> +    len =3D MIN(tpm_cmd_get_size(buffer), buffer_size);
> +
> +    /*
> +     * allocate enough room for 3 chars per buffer entry plus a
> +     * newline after every 16 chars and a final null terminator.
> +     */
> +    line_buffer =3D g_malloc(len * 3 + (len / 16) + 1);
> +
> +    for (i =3D 0, p =3D line_buffer; i < len; i++) {
> +        if (i && !(i % 16)) {
> +            p +=3D sprintf(p, "\n");
> +        }
> +        p +=3D sprintf(p, "%.2X ", buffer[i]);
> +    }
> +    trace_tpm_spapr_show_buffer(string, len, line_buffer);
> +
> +    g_free(line_buffer);
> +}
> +
> +/*
> + * Send a request to the TPM.
> + */
> +static void tpm_spapr_tpm_send(SPAPRvTPMState *s)
> +{
> +    if (trace_event_get_state_backends(TRACE_TPM_SPAPR_SHOW_BUFFER)) {
> +        tpm_spapr_show_buffer(s->buffer, sizeof(s->buffer), "To TPM");
> +    }
> +
> +    s->state =3D SPAPR_VTPM_STATE_EXECUTION;
> +    s->cmd =3D (TPMBackendCmd) {
> +        .locty =3D 0,
> +        .in =3D s->buffer,
> +        .in_len =3D MIN(tpm_cmd_get_size(s->buffer), sizeof(s->buffer)),
> +        .out =3D s->buffer,
> +        .out_len =3D sizeof(s->buffer),
> +    };
> +
> +    tpm_backend_deliver_request(s->be_driver, &s->cmd);
> +}
> +
> +static int tpm_spapr_process_cmd(SPAPRvTPMState *s, uint64_t dataptr)
> +{
> +    long rc;
> +
> +    /* a max. of be_buffer_size bytes can be transported */
> +    rc =3D spapr_vio_dma_read(&s->vdev, dataptr,
> +                            s->buffer, s->be_buffer_size);
> +    if (rc) {
> +        error_report("tpm_spapr_got_payload: DMA read failure");
> +    }
> +    /* let vTPM handle any malformed request */
> +    tpm_spapr_tpm_send(s);
> +
> +    return rc;
> +}
> +
> +static int tpm_spapr_do_crq(struct SpaprVioDevice *dev, uint8_t *crq_dat=
a)
> +{
> +    SPAPRvTPMState *s =3D VIO_SPAPR_VTPM(dev);
> +    TPMSpaprCRQ local_crq;
> +    TPMSpaprCRQ *crq =3D &s->crq; /* requests only */
> +    int rc;
> +
> +    memcpy(&local_crq.raw, crq_data, sizeof(local_crq.raw));
> +
> +    trace_tpm_spapr_do_crq(local_crq.raw[0], local_crq.raw[1]);
> +
> +    switch (local_crq.s.valid) {
> +    case SPAPR_VTPM_VALID_INIT_CRQ_COMMAND: /* Init command/response */
> +
> +        /* Respond to initialization request */
> +        switch (local_crq.s.msg) {
> +        case SPAPR_VTPM_INIT_CRQ_RESULT:
> +            trace_tpm_spapr_do_crq_crq_result();
> +            memset(local_crq.raw, 0, sizeof(local_crq.raw));
> +            local_crq.s.valid =3D SPAPR_VTPM_VALID_INIT_CRQ_COMMAND;
> +            local_crq.s.msg =3D SPAPR_VTPM_INIT_CRQ_RESULT;
> +            spapr_vio_send_crq(dev, local_crq.raw);
> +            break;
> +
> +        case SPAPR_VTPM_INIT_CRQ_COMPLETE_RESULT:
> +            trace_tpm_spapr_do_crq_crq_complete_result();
> +            memset(local_crq.raw, 0, sizeof(local_crq.raw));
> +            local_crq.s.valid =3D SPAPR_VTPM_VALID_INIT_CRQ_COMMAND;
> +            local_crq.s.msg =3D SPAPR_VTPM_INIT_CRQ_COMPLETE_RESULT;
> +            spapr_vio_send_crq(dev, local_crq.raw);
> +            break;
> +        }
> +
> +        break;
> +    case SPAPR_VTPM_VALID_COMMAND: /* Payloads */
> +        switch (local_crq.s.msg) {
> +        case SPAPR_VTPM_TPM_COMMAND:
> +            trace_tpm_spapr_do_crq_tpm_command();
> +            if (s->state =3D=3D SPAPR_VTPM_STATE_EXECUTION) {
> +                return H_BUSY;
> +            }
> +            /* this crq is tracked */
> +            memcpy(crq->raw, crq_data, sizeof(crq->raw));
> +
> +            rc =3D tpm_spapr_process_cmd(s, be32_to_cpu(crq->s.data));
> +
> +            if (rc =3D=3D H_SUCCESS) {
> +                crq->s.valid =3D be16_to_cpu(0);
> +            } else {
> +                local_crq.s.valid =3D SPAPR_VTPM_MSG_RESULT;
> +                local_crq.s.msg =3D SPAPR_VTPM_VTPM_ERROR;
> +                local_crq.s.data =3D cpu_to_be32(SPAPR_VTPM_ERR_COPY_IN_=
FAILED);
> +                spapr_vio_send_crq(dev, local_crq.raw);
> +            }
> +            break;
> +
> +        case SPAPR_VTPM_GET_RTCE_BUFFER_SIZE:
> +            trace_tpm_spapr_do_crq_tpm_get_rtce_buffer_size(s->be_buffer=
_size);
> +            local_crq.s.msg |=3D SPAPR_VTPM_MSG_RESULT;
> +            local_crq.s.len =3D cpu_to_be16(s->be_buffer_size);
> +            spapr_vio_send_crq(dev, local_crq.raw);
> +            break;
> +
> +        case SPAPR_VTPM_GET_VERSION:
> +            local_crq.s.msg |=3D SPAPR_VTPM_MSG_RESULT;
> +            local_crq.s.len =3D cpu_to_be16(0);
> +            switch (s->be_tpm_version) {
> +            case TPM_VERSION_UNSPEC:
> +                local_crq.s.data =3D cpu_to_be32(0);
> +                break;
> +            case TPM_VERSION_1_2:
> +                local_crq.s.data =3D cpu_to_be32(1);
> +                break;
> +            case TPM_VERSION_2_0:
> +                local_crq.s.data =3D cpu_to_be32(2);
> +                break;
> +            }
> +            trace_tpm_spapr_do_crq_get_version(be32_to_cpu(local_crq.s.d=
ata));
> +            spapr_vio_send_crq(dev, local_crq.raw);
> +            break;
> +
> +        case SPAPR_VTPM_PREPARE_TO_SUSPEND:
> +            trace_tpm_spapr_do_crq_prepare_to_suspend();
> +            local_crq.s.msg |=3D SPAPR_VTPM_MSG_RESULT;
> +            spapr_vio_send_crq(dev, local_crq.raw);
> +            break;
> +
> +        default:
> +            trace_tpm_spapr_do_crq_unknown_msg_type(crq->s.msg);
> +        }
> +        break;
> +    default:
> +        trace_tpm_spapr_do_crq_unknown_crq(local_crq.raw[0], local_crq.r=
aw[1]);
> +    };
> +
> +    return H_SUCCESS;
> +}
> +
> +static void tpm_spapr_request_completed(TPMIf *ti, int ret)
> +{
> +    SPAPRvTPMState *s =3D VIO_SPAPR_VTPM(ti);
> +    TPMSpaprCRQ *crq =3D &s->crq;
> +    uint32_t len;
> +    int rc;
> +
> +    s->state =3D SPAPR_VTPM_STATE_COMPLETION;
> +
> +    /* a max. of be_buffer_size bytes can be transported */
> +    len =3D MIN(tpm_cmd_get_size(s->buffer), s->be_buffer_size);
> +    rc =3D spapr_vio_dma_write(&s->vdev, be32_to_cpu(crq->s.data),
> +                             s->buffer, len);
> +
> +    if (trace_event_get_state_backends(TRACE_TPM_SPAPR_SHOW_BUFFER)) {
> +        tpm_spapr_show_buffer(s->buffer, len, "From TPM");
> +    }
> +
> +    crq->s.valid =3D SPAPR_VTPM_MSG_RESULT;
> +    if (rc =3D=3D H_SUCCESS) {
> +        crq->s.msg =3D SPAPR_VTPM_TPM_COMMAND | SPAPR_VTPM_MSG_RESULT;
> +        crq->s.len =3D cpu_to_be16(len);
> +    } else {
> +        error_report("%s: DMA write failure", __func__);
> +        crq->s.msg =3D SPAPR_VTPM_VTPM_ERROR;
> +        crq->s.len =3D cpu_to_be16(0);
> +        crq->s.data =3D cpu_to_be32(SPAPR_VTPM_ERR_COPY_OUT_FAILED);
> +    }
> +
> +    rc =3D spapr_vio_send_crq(&s->vdev, crq->raw);
> +    if (rc) {
> +        error_report("%s: Error sending response", __func__);
> +    }
> +}
> +
> +static int tpm_spapr_do_startup_tpm(SPAPRvTPMState *s, size_t buffersize=
)
> +{
> +    return tpm_backend_startup_tpm(s->be_driver, buffersize);
> +}
> +
> +static void tpm_spapr_update_deviceclass(SpaprVioDevice *dev)
> +{
> +    SPAPRvTPMState *s =3D VIO_SPAPR_VTPM(dev);
> +    SpaprVioDeviceClass *k =3D VIO_SPAPR_DEVICE_GET_CLASS(dev);
> +
> +    switch (s->be_tpm_version) {
> +    case TPM_VERSION_UNSPEC:
> +        assert(false);
> +        break;
> +    case TPM_VERSION_1_2:
> +        k->dt_name =3D "vtpm";
> +        k->dt_type =3D "IBM,vtpm";
> +        k->dt_compatible =3D "IBM,vtpm";
> +        break;
> +    case TPM_VERSION_2_0:
> +        k->dt_name =3D "vtpm";
> +        k->dt_type =3D "IBM,vtpm";
> +        k->dt_compatible =3D "IBM,vtpm20";
> +        break;
> +    }
> +}
> +
> +static void tpm_spapr_reset(SpaprVioDevice *dev)
> +{
> +    SPAPRvTPMState *s =3D VIO_SPAPR_VTPM(dev);
> +
> +    s->state =3D SPAPR_VTPM_STATE_NONE;
> +
> +    s->be_tpm_version =3D tpm_backend_get_tpm_version(s->be_driver);
> +    tpm_spapr_update_deviceclass(dev);
> +
> +    s->be_buffer_size =3D MAX(ROUND_UP(tpm_backend_get_buffer_size(s->be=
_driver),
> +                                     TARGET_PAGE_SIZE),
> +                            sizeof(s->buffer));
> +
> +    tpm_backend_reset(s->be_driver);
> +    tpm_spapr_do_startup_tpm(s, s->be_buffer_size);
> +}
> +
> +static enum TPMVersion tpm_spapr_get_version(TPMIf *ti)
> +{
> +    SPAPRvTPMState *s =3D VIO_SPAPR_VTPM(ti);
> +
> +    if (tpm_backend_had_startup_error(s->be_driver)) {
> +        return TPM_VERSION_UNSPEC;
> +    }
> +
> +    return tpm_backend_get_tpm_version(s->be_driver);
> +}
> +
> +static const VMStateDescription vmstate_spapr_vtpm =3D {
> +    .name =3D "tpm-spapr",
> +    .unmigratable =3D 1,
> +};
> +
> +static Property tpm_spapr_properties[] =3D {
> +    DEFINE_SPAPR_PROPERTIES(SPAPRvTPMState, vdev),
> +    DEFINE_PROP_TPMBE("tpmdev", SPAPRvTPMState, be_driver),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void tpm_spapr_realizefn(SpaprVioDevice *dev, Error **errp)
> +{
> +    SPAPRvTPMState *s =3D VIO_SPAPR_VTPM(dev);
> +
> +    if (!tpm_find()) {
> +        error_setg(errp, "at most one TPM device is permitted");
> +        return;
> +    }
> +
> +    dev->crq.SendFunc =3D tpm_spapr_do_crq;
> +
> +    if (!s->be_driver) {
> +        error_setg(errp, "'tpmdev' property is required");
> +        return;
> +    }
> +}
> +
> +static void tpm_spapr_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    SpaprVioDeviceClass *k =3D VIO_SPAPR_DEVICE_CLASS(klass);
> +    TPMIfClass *tc =3D TPM_IF_CLASS(klass);
> +
> +    k->realize =3D tpm_spapr_realizefn;
> +    k->reset =3D tpm_spapr_reset;
> +    k->signal_mask =3D 0x00000001;
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +    dc->props =3D tpm_spapr_properties;
> +    k->rtce_window_size =3D 0x10000000;
> +    dc->vmsd =3D &vmstate_spapr_vtpm;
> +
> +    tc->model =3D TPM_MODEL_TPM_SPAPR;
> +    tc->get_version =3D tpm_spapr_get_version;
> +    tc->request_completed =3D tpm_spapr_request_completed;
> +}
> +
> +static const TypeInfo tpm_spapr_info =3D {
> +    .name          =3D TYPE_TPM_SPAPR,
> +    .parent        =3D TYPE_VIO_SPAPR_DEVICE,
> +    .instance_size =3D sizeof(SPAPRvTPMState),
> +    .class_init    =3D tpm_spapr_class_init,
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { TYPE_TPM_IF },
> +        { }
> +    }
> +};
> +
> +static void tpm_spapr_register_types(void)
> +{
> +    type_register_static(&tpm_spapr_info);
> +}
> +
> +type_init(tpm_spapr_register_types)
> diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
> index 89804bcd64..6278a39618 100644
> --- a/hw/tpm/trace-events
> +++ b/hw/tpm/trace-events
> @@ -55,3 +55,15 @@ tpm_tis_pre_save(uint8_t locty, uint32_t rw_offset) "l=
octy: %d, rw_offset =3D %u"
>
>  # tpm_ppi.c
>  tpm_ppi_memset(uint8_t *ptr, size_t size) "memset: %p %zu"
> +
> +# hw/tpm/tpm_spapr.c
> +tpm_spapr_show_buffer(const char *direction, size_t len, const char *buf=
) "direction: %s len: %zu\n%s"
> +tpm_spapr_do_crq(uint8_t raw1, uint8_t raw2) "1st 2 bytes in CRQ: 0x%02x=
 0x%02x"
> +tpm_spapr_do_crq_crq_result(void) "SPAPR_VTPM_INIT_CRQ_RESULT"
> +tpm_spapr_do_crq_crq_complete_result(void) "SPAPR_VTPM_INIT_CRQ_COMP_RES=
ULT"
> +tpm_spapr_do_crq_tpm_command(void) "got TPM command payload"
> +tpm_spapr_do_crq_tpm_get_rtce_buffer_size(size_t buffersize) "response: =
buffer size is %zu"
> +tpm_spapr_do_crq_get_version(uint32_t version) "response: version %u"
> +tpm_spapr_do_crq_prepare_to_suspend(void) "response: preparing to suspen=
d"
> +tpm_spapr_do_crq_unknown_msg_type(uint8_t type) "Unknown message type 0x=
%02x"
> +tpm_spapr_do_crq_unknown_crq(uint8_t raw1, uint8_t raw2) "unknown CRQ 0x=
%02x 0x%02x ..."
> diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
> index 5b541a71c8..15979a3647 100644
> --- a/include/sysemu/tpm.h
> +++ b/include/sysemu/tpm.h
> @@ -45,11 +45,14 @@ typedef struct TPMIfClass {
>
>  #define TYPE_TPM_TIS                "tpm-tis"
>  #define TYPE_TPM_CRB                "tpm-crb"
> +#define TYPE_TPM_SPAPR              "tpm-spapr"
>
>  #define TPM_IS_TIS(chr)                             \
>      object_dynamic_cast(OBJECT(chr), TYPE_TPM_TIS)
>  #define TPM_IS_CRB(chr)                             \
>      object_dynamic_cast(OBJECT(chr), TYPE_TPM_CRB)
> +#define TPM_IS_SPAPR(chr)                           \
> +    object_dynamic_cast(OBJECT(chr), TYPE_TPM_SPAPR)
>
>  /* returns NULL unless there is exactly one TPM device */
>  static inline TPMIf *tpm_find(void)
> diff --git a/qapi/tpm.json b/qapi/tpm.json
> index b30323bb6b..63878aa0f4 100644
> --- a/qapi/tpm.json
> +++ b/qapi/tpm.json
> @@ -12,11 +12,11 @@
>  #
>  # @tpm-tis: TPM TIS model
>  # @tpm-crb: TPM CRB model (since 2.12)
> +# @tpm-spapr: TPM SPAPR model (since 5.0)
>  #
>  # Since: 1.5
>  ##
> -{ 'enum': 'TpmModel', 'data': [ 'tpm-tis', 'tpm-crb' ] }
> -
> +{ 'enum': 'TpmModel', 'data': [ 'tpm-tis', 'tpm-crb', 'tpm-spapr' ] }
>  ##
>  # @query-tpm-models:
>  #
> @@ -29,7 +29,7 @@
>  # Example:
>  #
>  # -> { "execute": "query-tpm-models" }
> -# <- { "return": [ "tpm-tis", "tpm-crb" ] }
> +# <- { "return": [ "tpm-tis", "tpm-crb", "tpm-spapr" ] }
>  #
>  ##
>  { 'command': 'query-tpm-models', 'returns': ['TpmModel'] }
> --
> 2.21.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

