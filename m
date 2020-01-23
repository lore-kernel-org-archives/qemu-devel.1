Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BB4C33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:36:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A4D42467B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScJxxz6z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A4D42467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53327 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuXyh-0002VW-IF
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 03:36:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60629)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iuXvZ-0006ub-17
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:33:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iuXvX-0003AW-Q8
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:33:24 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41355)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iuXvU-00033H-2n; Thu, 23 Jan 2020 03:33:20 -0500
Received: by mail-wr1-x444.google.com with SMTP id c9so2046562wrw.8;
 Thu, 23 Jan 2020 00:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RfcFUm3BQiAl9mzacls/FnuBZx1T3le9iUzoIO9A0t8=;
 b=ScJxxz6zt8TuBUoxchheQeCqB6sQHt8c8BOrdnHvuH5fSw+i21SQmN4YwPoZXwcqbC
 hcbiemL7THTMqwPDIMEDcQkuOY3zA0iWw2rB/5bYP8Frr6+3OOEOn6aaUd8tXP66FwNy
 cz1UzoINstnYiakbixWossJqmUuwJelfdHkU14doB7hybJWj4wcr45knlNLgiBmjuhHa
 NYM9MT8cDfnC5fwPVP30n2egHjPxsrHFCmeBAj2K8Giugv4fxt9Lr1REjsv8ruf2zOU8
 r84JSr6sbSUjOu8W0CTvbHv6uH8sn7Y9VS68CAh54ADvuTcW1SiyyspvkYvLdlifJyCH
 mkgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RfcFUm3BQiAl9mzacls/FnuBZx1T3le9iUzoIO9A0t8=;
 b=gqqgO0KFjTyElx+Wz+kccYnNqSyq2A0BBBcMJD5aYPS2hdxeETI4p5wv7ahuBSfn2E
 fqOP3j2fogMF8QQFErVjQDEqCkpW3mwB2QcbVvM389joSDGR5JGbOTHAqm83VYJk+1zA
 A0RjWOArHmxyYzRNG9Yshys0AWJkQ5r94NqozayiFzL/4Zzr5qOMEY5gKyQvRybuzttj
 ae8DaqYubNTygbgZxkcN15fNdtPVZ9k1vH3xXKyZ+Ri1evQJ6RRKiJEtMWBcpZq1Nvlk
 EsAuq4fB7Ka6/8fpte1p7dRgs5lRk3UnSKsAZUaEXEcpm8Caf2n55tQKCM5sEnegfEPy
 JhMw==
X-Gm-Message-State: APjAAAUQ4yz9y9tH4OD2iCG7xB/QjAfbVrNHFCKdU+hVrJ1y5zijWYrN
 +1Z+0JRuM2H/Pup6SXhMa0yEzCelTzXlQQGLeVE=
X-Google-Smtp-Source: APXvYqwnCLmm3eyafUVa9DGOtYsfuwi0//HsG6kdQJUPk4VRLyn11iFjULEsPl97TxbbjBZZjaDYHLGumRyQV6GjCyk=
X-Received: by 2002:a5d:438c:: with SMTP id i12mr16000029wrq.196.1579768389808; 
 Thu, 23 Jan 2020 00:33:09 -0800 (PST)
MIME-Version: 1.0
References: <20200121152935.649898-1-stefanb@linux.ibm.com>
 <20200121152935.649898-5-stefanb@linux.ibm.com>
In-Reply-To: <20200121152935.649898-5-stefanb@linux.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 23 Jan 2020 12:32:56 +0400
Message-ID: <CAJ+F1C+yL+LiHxrxcjphPTrr4sZH1yrOLjsU6zCb8O6+ktuEhw@mail.gmail.com>
Subject: Re: [PATCH v9 4/6] tpm_spapr: Support suspend and resume
To: Stefan Berger <stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: David Gibson <david@gibson.dropbear.id.au>,
 "open list:sPAPR pseries" <qemu-ppc@nongnu.org>, QEMU <qemu-devel@nongnu.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 21, 2020 at 7:30 PM Stefan Berger <stefanb@linux.ibm.com> wrote=
:
>
> From: Stefan Berger <stefanb@linux.vnet.ibm.com>
>
> Extend the tpm_spapr frontend with VM suspend and resume support.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hw/tpm/tpm_spapr.c  | 52 ++++++++++++++++++++++++++++++++++++++++++++-
>  hw/tpm/trace-events |  2 ++
>  2 files changed, 53 insertions(+), 1 deletion(-)
>
> diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
> index 1db9696ae0..8ba561f41c 100644
> --- a/hw/tpm/tpm_spapr.c
> +++ b/hw/tpm/tpm_spapr.c
> @@ -76,6 +76,8 @@ typedef struct {
>
>      unsigned char *buffer;
>
> +    uint32_t numbytes; /* number of bytes to deliver on resume */
> +
>      TPMBackendCmd cmd;
>
>      TPMBackend *be_driver;
> @@ -240,6 +242,14 @@ static void tpm_spapr_request_completed(TPMIf *ti, i=
nt ret)
>
>      /* a max. of be_buffer_size bytes can be transported */
>      len =3D MIN(tpm_cmd_get_size(s->buffer), s->be_buffer_size);
> +
> +    if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
> +        trace_tpm_spapr_caught_response(len);
> +        /* defer delivery of response until .post_load */
> +        s->numbytes =3D len;
> +        return;
> +    }
> +
>      rc =3D spapr_vio_dma_write(&s->vdev, be32_to_cpu(crq->data),
>                               s->buffer, len);
>
> @@ -288,6 +298,7 @@ static void tpm_spapr_reset(SpaprVioDevice *dev)
>      SpaprTpmState *s =3D VIO_SPAPR_VTPM(dev);
>
>      s->state =3D SPAPR_VTPM_STATE_NONE;
> +    s->numbytes =3D 0;
>
>      s->be_tpm_version =3D tpm_backend_get_tpm_version(s->be_driver);
>
> @@ -309,9 +320,48 @@ static enum TPMVersion tpm_spapr_get_version(TPMIf *=
ti)
>      return tpm_backend_get_tpm_version(s->be_driver);
>  }
>
> +/* persistent state handling */
> +
> +static int tpm_spapr_pre_save(void *opaque)
> +{
> +    SpaprTpmState *s =3D opaque;
> +
> +    tpm_backend_finish_sync(s->be_driver);
> +    /*
> +     * we cannot deliver the results to the VM since DMA would touch VM =
memory
> +     */
> +
> +    return 0;
> +}
> +
> +static int tpm_spapr_post_load(void *opaque, int version_id)
> +{
> +    SpaprTpmState *s =3D opaque;
> +
> +    if (s->numbytes) {
> +        trace_tpm_spapr_post_load();
> +        /* deliver the results to the VM via DMA */
> +        tpm_spapr_request_completed(TPM_IF(s), 0);
> +        s->numbytes =3D 0;
> +    }
> +
> +    return 0;
> +}
> +
>  static const VMStateDescription vmstate_spapr_vtpm =3D {
>      .name =3D "tpm-spapr",
> -    .unmigratable =3D 1,
> +    .pre_save =3D tpm_spapr_pre_save,
> +    .post_load =3D tpm_spapr_post_load,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_SPAPR_VIO(vdev, SpaprTpmState),
> +
> +        VMSTATE_UINT8(state, SpaprTpmState),
> +        VMSTATE_UINT32(numbytes, SpaprTpmState),
> +        VMSTATE_VBUFFER_UINT32(buffer, SpaprTpmState, 0, NULL, numbytes)=
,
> +        /* remember DMA address */
> +        VMSTATE_UINT32(crq.data, SpaprTpmState),
> +        VMSTATE_END_OF_LIST(),
> +    }
>  };
>
>  static Property tpm_spapr_properties[] =3D {
> diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
> index 9143a8eaa3..439e514787 100644
> --- a/hw/tpm/trace-events
> +++ b/hw/tpm/trace-events
> @@ -67,3 +67,5 @@ tpm_spapr_do_crq_get_version(uint32_t version) "respons=
e: version %u"
>  tpm_spapr_do_crq_prepare_to_suspend(void) "response: preparing to suspen=
d"
>  tpm_spapr_do_crq_unknown_msg_type(uint8_t type) "Unknown message type 0x=
%02x"
>  tpm_spapr_do_crq_unknown_crq(uint8_t raw1, uint8_t raw2) "unknown CRQ 0x=
%02x 0x%02x ..."
> +tpm_spapr_post_load(void) "Delivering TPM response after resume"
> +tpm_spapr_caught_response(uint32_t v) "Caught response to deliver after =
resume: %u bytes"
> --
> 2.24.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

