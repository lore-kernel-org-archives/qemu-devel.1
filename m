Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E3FC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:37:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DFC3227BF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcHqLelc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DFC3227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihf85-0002G8-9L
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 14:37:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36800)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ihf6y-0001F7-09
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:35:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ihf6w-00046j-PN
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:35:55 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39610)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ihf6w-000459-HH; Wed, 18 Dec 2019 14:35:54 -0500
Received: by mail-oi1-x244.google.com with SMTP id a67so1739415oib.6;
 Wed, 18 Dec 2019 11:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VK5GlKScKbS+LVQgUi0a1RrhyXld8LpQu4ZIhT+sCNU=;
 b=GcHqLelclak/OyqMf38yZqxV5ZiMqkKMutruD8DaF04uaoSjHPCNUV2AGeYFzx7A6b
 g3AGX2NBV1YTqljlNJ+WHHw+ovx1dg01hKfl5OlVI/ainIUZV3Qen0wGzLPvqCiXOVfJ
 KSR6fbVWjf+GSF18wfEh/YnclX2/NLrR+mHGfPw1favDLCKwekrI32nhxSCRw4NIW+o8
 EIDrYllbHbJcwtp70emV3nQIvrzpwehKinz3nbuJQsRiKV1O630MEJ/4nplsrl1HbINt
 idFseZ5JscYmRBrpaEzYxJ6tu3SK1hvaDhjUF2uztkGrLmV4n5Of7ghOnP/aLwHCtCEl
 8d/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VK5GlKScKbS+LVQgUi0a1RrhyXld8LpQu4ZIhT+sCNU=;
 b=D/ht3JyrkRoY4pP5UWir+AiS6bFg6MqLhrjydOY4WfElv00kQF/RYmGefn98HRaL5R
 8finnP9fVA05+gbEvJGBQ/hAXlhyyUAxtUZDrxQCMECKFcnnZpF+FdfV8PPaIef92IXk
 P/kUVu29nsN2m/PqIE20J6rgzoQg5F9IxJE3AktHXDkxIeECswB3N6z+w3xo7wX0fj4I
 pKU0GjjDEJxCx+4/4MHsAcAseo0RK+xoKxMjmxmPwmVYDpfzurA5dUkg8qe8KgETJT5T
 NMbzyFpisGm/rZ8JW6dhdESpG+loomjHZEvBvZs2Afkqndz+32pHWmEupTwWFlMvQp7r
 63rg==
X-Gm-Message-State: APjAAAU3UVhovvlFNfuCTv4WqWkPqFp0Q6em+U55Rno0kX+7wrpfhUV/
 to7X7e+EdF031gzZQl11pBe0iCRUS6QY/ucuGeg=
X-Google-Smtp-Source: APXvYqxzcBNqABZZ37apWPolbGs8nBof19JxLJKIrqt9w8Y6lh583PclgQR9rFTXLwwoiwUCC3WuRdD3gnNX55kTrmM=
X-Received: by 2002:aca:1b08:: with SMTP id b8mr1236876oib.106.1576697753655; 
 Wed, 18 Dec 2019 11:35:53 -0800 (PST)
MIME-Version: 1.0
References: <20191218192526.13845-1-philmd@redhat.com>
 <20191218192526.13845-6-philmd@redhat.com>
In-Reply-To: <20191218192526.13845-6-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 18 Dec 2019 20:35:42 +0100
Message-ID: <CAL1e-=i19ETZwmB56WUo4E1YKzYsM0RW8Vd0xC_OVZ_N=xOKow@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/6] hw/net/imx_fec: Remove unuseful FALLTHROUGH
 comments
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 "open list:Stellaris" <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Dec 18, 2019 at 8:29 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> We don't need to explicit these obvious switch fall through
> comments. Stay consistent with the rest of the codebase.
>
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

> Cc: Peter Chubb <peter.chubb@nicta.com.au>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: qemu-arm@nongnu.org
> ---
>  hw/net/imx_fec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
> index c01ce4f078..5a83678f64 100644
> --- a/hw/net/imx_fec.c
> +++ b/hw/net/imx_fec.c
> @@ -901,8 +901,8 @@ static void imx_eth_write(void *opaque, hwaddr offset=
, uint64_t value,
>              s->regs[index] =3D 0;
>          }
>          break;
> -    case ENET_TDAR1:    /* FALLTHROUGH */
> -    case ENET_TDAR2:    /* FALLTHROUGH */
> +    case ENET_TDAR1:
> +    case ENET_TDAR2:
>          if (unlikely(single_tx_ring)) {
>              qemu_log_mask(LOG_GUEST_ERROR,
>                            "[%s]%s: trying to access TDAR2 or TDAR1\n",
> --
> 2.21.0
>
>

