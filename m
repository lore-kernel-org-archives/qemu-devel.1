Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A59C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 11:01:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E3CE2077B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 11:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxrVbcil"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E3CE2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifMED-0003XW-QD
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 06:01:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ifMD9-0002lQ-9S
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 06:00:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ifMD4-0004II-8T
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 06:00:47 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44581)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ifMCx-00040U-Qt; Thu, 12 Dec 2019 06:00:35 -0500
Received: by mail-wr1-x441.google.com with SMTP id q10so2204518wrm.11;
 Thu, 12 Dec 2019 03:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vFxawnayMwwi7NeCIP5gNG6oodXbS+PylFIHbrRlMFY=;
 b=dxrVbcilftv/1a5UbVH5ifQ8Y3tvOVH7Y2pMa/l8m9X6SHxmW8Qv6eBTogwp1+o0jS
 3cKgMTmJzHAZ55ziZwJI4PK0a+TN/yyJ5M4iLfAAoDfuM2A0plXRu1yc+Z5W+sRpHnaK
 CAJOZyYio7MsC3WXTpzP5QBI0W5PsYDhCW1+7ncNdMQehAVyVxFtXwk1YvF4bBkCfD35
 lhSLpXdn+mFTD1ptMTbFCyoRVz+y8KXEnUDvOpNzrGq2LotBlbKzGjfub8LXPJffvsn8
 V05Ce7rUHRzVKp77HSvXXSfeGvP7gCB9fRRmFOzXeo3BCrszzPpgJYrJjwGKluEvBpDU
 5L1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vFxawnayMwwi7NeCIP5gNG6oodXbS+PylFIHbrRlMFY=;
 b=j4cQKgyiQBSdEL2pkISDrKlwzQeooW22w1NF2LVD97fa60XdmVLOU6/Ht0GdSw4zer
 FTFS5kgIkOdyjb3OReMHIHrj8lvbEJOe6Fq/q6oPn/2W/E4tVORTYq6yCjXx3rn/bpM2
 WMaZSb4ebb7mC48ts2xo6Borhi+kd6/FrSCs50Fi3MuYFqqd6FP7jtxQ1ZDfOGAKthZ5
 M4fJpJ5OY/Pp3cr9ix2QHRCb9PfvKuXPKpF6HKZfi9r3J8ud1vMqhP7pdtiKX8fWId5v
 8C1mMeIeD80EwRR639KrjB44iRNWHw89z/lsPi6Ou2b16+MRltuwPaUfPxmwThJ3xt6t
 GBeA==
X-Gm-Message-State: APjAAAUURJXO0+UGdPOtfVfL5F9csF/xzFWwYKJtq2K6Bp0osCbBDVz4
 g+GgwJRvOSaz/2NlAASzx64Xs3XyBRWxzplJlac=
X-Google-Smtp-Source: APXvYqyNaCH66DlAY2o0TsjiO1XdixIfnrefiG2VS0dPIxeFOAQANU2tXMGkpU+EM3G/5nineO8IbEmcW91UUS4EkVk=
X-Received: by 2002:adf:ff8a:: with SMTP id j10mr5756649wrr.312.1576148434279; 
 Thu, 12 Dec 2019 03:00:34 -0800 (PST)
MIME-Version: 1.0
References: <20191211162050.970199-1-stefanb@linux.vnet.ibm.com>
 <20191211162050.970199-4-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20191211162050.970199-4-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 12 Dec 2019 15:00:21 +0400
Message-ID: <CAJ+F1CL6R5wwn6pnFTRaoTWqXUr7eTDAzMzT27M8zSkG2K7uEw@mail.gmail.com>
Subject: Re: [PACTH v3 3/5] tpm_spapr: Support suspend and resume
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

On Wed, Dec 11, 2019 at 8:27 PM Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
>
> Extend the tpm_spapr frontend with VM suspend and resume support.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  hw/tpm/tpm_spapr.c | 42 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
> index c4a67e2403..d9153bd95c 100644
> --- a/hw/tpm/tpm_spapr.c
> +++ b/hw/tpm/tpm_spapr.c
> @@ -87,6 +87,8 @@ typedef struct {
>      TPMVersion be_tpm_version;
>
>      size_t be_buffer_size;
> +
> +    bool deliver_response; /* whether to deliver response after VM resum=
e */
>  } SPAPRvTPMState;
>
>  static void tpm_spapr_show_buffer(const unsigned char *buffer,
> @@ -339,9 +341,47 @@ static enum TPMVersion tpm_spapr_get_version(TPMIf *=
ti)
>      return tpm_backend_get_tpm_version(s->be_driver);
>  }
>
> +/* persistent state handling */
> +
> +static int tpm_spapr_pre_save(void *opaque)
> +{
> +    SPAPRvTPMState *s =3D opaque;
> +
> +    s->deliver_response =3D tpm_backend_finish_sync(s->be_driver);
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
> +    SPAPRvTPMState *s =3D opaque;
> +
> +    if (s->deliver_response) {
> +        /* deliver the results to the VM via DMA */
> +        tpm_spapr_request_completed(TPM_IF(s), 0);

Why isn't it enough to rely on tpm_spapr_request_completed callback
being called during pre-save when tpm_backend_finish_sync() is called?
(like tis & crb)

> +    }
> +
> +    return 0;
> +}
> +
>  static const VMStateDescription vmstate_spapr_vtpm =3D {
>      .name =3D "tpm-spapr",
> -    .unmigratable =3D 1,
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 0,
> +    .minimum_version_id_old =3D 0,
> +    .pre_save =3D tpm_spapr_pre_save,
> +    .post_load =3D tpm_spapr_post_load,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_SPAPR_VIO(vdev, SPAPRvTPMState),
> +
> +        VMSTATE_UINT8(state, SPAPRvTPMState),
> +        VMSTATE_BUFFER(buffer, SPAPRvTPMState),
> +        VMSTATE_BOOL(deliver_response, SPAPRvTPMState),
> +        VMSTATE_END_OF_LIST(),
> +    }
>  };
>
>  static Property tpm_spapr_properties[] =3D {
> --
> 2.21.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

