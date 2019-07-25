Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4F4C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 11:34:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AE652184B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 11:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPVkDc4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE652184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqc16-0006jq-QA
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 07:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50699)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hqc0x-0006Ku-4V
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:34:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hqc0w-0001xA-7h
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:34:27 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41830)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1hqc0v-0001uH-Vi
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:34:26 -0400
Received: by mail-wr1-x443.google.com with SMTP id c2so47177126wrm.8
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 04:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wD8BvA5Ka7KjtvC8eIwNlCRptOJjzjoB2dA+IYrzo/g=;
 b=YPVkDc4fjoTld/6NnfijsjW3PdO/zteQKFJRN1BH3QdkTfak7MjSb1u/CTKBviyrIn
 A9RE+dePtXWUHZHWSDaYu9OtGee0iPwcVmRN1ycl2kyB1lZOwnCM71ibHENG/rw7x7Ya
 T3wOfjsID4VDmLMtTIcmlZKkNFO0/inb+BUeI1jHGErC/vH2OVmEWTuja15WA5bLxQNz
 gE6FqeukGENAjHa9PHfj2USHMNKLQIE2x9IY6lC7FQGmYsaKgMZylqQQLTp8d4e2aG3v
 g4McetJ0bRPF0eNSD/Y2Y5ZHH1cFCD594DlF/H4WvtFjCfBqY9uQnXQyoouEViENp8+P
 AwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wD8BvA5Ka7KjtvC8eIwNlCRptOJjzjoB2dA+IYrzo/g=;
 b=bMxhzn10cWrgM04I7uIiPEfwgxDhk+7ZLAmKSUkAD56MMiBZZPmZmeWrBwxHGvkOYf
 9VbvhB1f5asw+Jc7YBrdgmoP5BMYL5JnEUp0Dys6exaNTFD/m0Qte1MYGv6Vh38udjrI
 QxDz4nX33BnVpUy6G2UHJbiSSPpqWSKrq+5d9PEYddHLmN8RcDkBg138vVFiMOpe2VhA
 J1yHHGZNijEhhST90gtJ1Om2ZY7H9oRh3dTny4RPLK6dZIvADOe+25l3l15psp64IzbT
 eWgjP7RV8PYjzLvEEfDbr8mD5giXCCg8vwMxF5hIUTu+csBacV3ce0kuCNsHJG61rY0T
 QzMQ==
X-Gm-Message-State: APjAAAUhDCfrI0lsSqlOuhB/7f9rBzqZBdoyma3ZTJ0Icwib3w4yPIdK
 vZtRJRrjGvRQkCEhYAYa6gDWaKobfOnsO/36XuE=
X-Google-Smtp-Source: APXvYqypwX0sQyQSc9ZRdPAgHSlZ2mFyrTewDrpFkW1g1OBYg2RwsFYTlylT1JBmL4ZkOgyYtyTeDm2EE/x47DBDct4=
X-Received: by 2002:a5d:6650:: with SMTP id f16mr5038439wrw.89.1564054464146; 
 Thu, 25 Jul 2019 04:34:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190725105842.872625-1-stefanb@linux.vnet.ibm.com>
 <20190725105842.872625-2-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20190725105842.872625-2-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 25 Jul 2019 15:34:12 +0400
Message-ID: <CAJ+F1CKfT6xbZitcfMxeY321FVFB4JMFk162HD1JxB+jF2t7dQ@mail.gmail.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH 1/2] tpm: Exit in reset when backend
 indicates failure
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
Cc: QEMU <qemu-devel@nongnu.org>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 25, 2019 at 2:58 PM Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
>
> Exit() in the frontend reset function when the backend indicates
> intialization failure.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/tpm/tpm_crb.c | 4 +++-
>  hw/tpm/tpm_tis.c | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index 5e2db9e0c4..db0e3e7c67 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -273,7 +273,9 @@ static void tpm_crb_reset(void *dev)
>      s->be_buffer_size =3D MIN(tpm_backend_get_buffer_size(s->tpmbe),
>                              CRB_CTRL_CMD_SIZE);
>
> -    tpm_backend_startup_tpm(s->tpmbe, s->be_buffer_size);
> +    if (tpm_backend_startup_tpm(s->tpmbe, s->be_buffer_size) < 0) {
> +        exit(1);
> +    }
>  }
>
>  static void tpm_crb_realize(DeviceState *dev, Error **errp)
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index 174618ac30..d6b3212890 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -910,7 +910,9 @@ static void tpm_tis_reset(DeviceState *dev)
>          s->rw_offset =3D 0;
>      }
>
> -    tpm_backend_startup_tpm(s->be_driver, s->be_buffer_size);
> +    if (tpm_backend_startup_tpm(s->be_driver, s->be_buffer_size) < 0) {
> +        exit(1);
> +    }
>  }
>
>  /* persistent state handling */
> --
> 2.20.1
>


--=20
Marc-Andr=C3=A9 Lureau

