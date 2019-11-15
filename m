Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FCDC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 20:13:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D3112073A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 20:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZwS/pdI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D3112073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVhxj-0006VB-Lj
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 15:12:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41536)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iVhwx-0005wd-7f
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 15:12:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iVhwu-0004jm-Cm
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 15:12:09 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26744
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iVhwt-0004jI-Uc
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 15:12:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573848726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kBYDGqU/WfUq93T5hjLjgiKJXX0T6WRRp3iGpzNC4Y8=;
 b=ZwS/pdI1BHXFaVDK4bDPKDuE/tPGO9WLvwqGWMVK0Rzw8SIv7ZDMrMyeV118qaq4DieWUZ
 2y6iHKjaqqHnf9Y0U8MElF/UbwM0bVQKD/zbmqyqrwKon0os84f4vIzZMfwR8fhQckMbF6
 Zm1/diGW+q/eonC/bavjLNnMCURH2FE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-wqm2KZiKP1mFuuocZgV-Qg-1; Fri, 15 Nov 2019 15:12:05 -0500
Received: by mail-wr1-f71.google.com with SMTP id y3so8580338wrm.12
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 12:12:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ffnsX0Q8XR2BjS9unAeGmtupJtx5eeTPlTk4cVQD4dw=;
 b=AFO6mWUOTFAvelpqAF1N/XJU3nihA9d8e9bfC9ay7zVh5U2b7ow30zgLRxD8o7+0Sf
 081FqxySoOiLcbQT42aS5B36sHXlCaEvSUQGrV0ucIBcbNQV21Vu5YW1mJs/SQVHY3Dp
 ho75OVlpFBD564U7fmNMb36UCDUY3/BM601TckDhkP/4XkmStV4m/sQ8juvCLtXSzG6d
 Tnwgl84aa6ZT9/SYviTAx4r+D6RXxJZ1rw8kjTi1horN0bpGU3nbXaRmv4qpr1YhNiUC
 1SwjdLn4CJWnD4h2HBqGYa5TfsKASQkU+nIE+jvSaZjrMCAntryCS/OBivivbr7Hu5uF
 B5GA==
X-Gm-Message-State: APjAAAUCOF4+6YmqTESnDfIghUOS+XP780Dx52XD+3213WwuEb4tddsi
 oUGjXbAIXvPTSidqnTM6RsErrCrvMx1MUY08iNxL/x2dcAUdytOYHZxjz8c3NOcGB6eukb/j+v2
 QrQceTFOdefibtHM=
X-Received: by 2002:adf:ef86:: with SMTP id d6mr1286195wro.118.1573848724325; 
 Fri, 15 Nov 2019 12:12:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqzdw12Je27rWzeH89NL6E13jn6p8TuUxiba6de1ZjzoHdh9avWu9OGWh3U0kYAKWU9VQNHkzg==
X-Received: by 2002:adf:ef86:: with SMTP id d6mr1286146wro.118.1573848724000; 
 Fri, 15 Nov 2019 12:12:04 -0800 (PST)
Received: from [192.168.1.35] (170.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.170])
 by smtp.gmail.com with ESMTPSA id z9sm12686998wrv.35.2019.11.15.12.12.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Nov 2019 12:12:03 -0800 (PST)
Subject: Re: [PATCH] display: xlnx_dp: Provide sufficient bytes for silent
 audio channel
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 KONRAD Frederic <fred.konrad@greensocs.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <1573833408-2388-1-git-send-email-sai.pavan.boddu@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c3690658-245b-7ebd-a58a-8f665ac16ac5@redhat.com>
Date: Fri, 15 Nov 2019 21:12:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1573833408-2388-1-git-send-email-sai.pavan.boddu@xilinx.com>
Content-Language: en-US
X-MC-Unique: wqm2KZiKP1mFuuocZgV-Qg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Gerd (Audio)

On 11/15/19 4:56 PM, Sai Pavan Boddu wrote:
> Fill the audio channel with required number of bytes to cover the
> elapsed time. This prevents rate control reset, and avoids debug prints
> like below
>=20
> log:
> =09Resetting rate control (65692 samples)
> =09...
> =09Resetting rate control (65721 samples)
> =09...
>=20
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> ---
>   hw/display/xlnx_dp.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
> index fde3b21..7058443 100644
> --- a/hw/display/xlnx_dp.c
> +++ b/hw/display/xlnx_dp.c
> @@ -394,13 +394,18 @@ static void xlnx_dp_audio_callback(void *opaque, in=
t avail)
>               written =3D AUD_write(s->amixer_output_stream,
>                                   &s->out_buffer[s->data_ptr], s->byte_le=
ft);
>           } else {
> +             int len_to_copy;
>               /*
>                * There is nothing to play.. We don't have any data! Fill =
the
>                * buffer with zero's and send it.
>                */
>               written =3D 0;
> -            memset(s->out_buffer, 0, 1024);
> -            AUD_write(s->amixer_output_stream, s->out_buffer, 1024);
> +            while (avail) {
> +                len_to_copy =3D MIN(AUD_CHBUF_MAX_DEPTH, avail);
> +                memset(s->out_buffer, 0, len_to_copy);
> +                avail -=3D AUD_write(s->amixer_output_stream, s->out_buf=
fer,
> +                                   len_to_copy);
> +            }
>           }
>       } else {
>           written =3D AUD_write(s->amixer_output_stream,
>=20


