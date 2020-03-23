Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D03BC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 15:59:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D690A20714
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 15:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXpHylHN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D690A20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGPTu-0001h0-2x
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 11:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jGPSv-0000iE-0G
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 11:58:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jGPSu-0004dL-3R
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 11:58:12 -0400
Received: from mail-ua1-x943.google.com ([2607:f8b0:4864:20::943]:45101)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jGPSt-0004bZ-VI; Mon, 23 Mar 2020 11:58:12 -0400
Received: by mail-ua1-x943.google.com with SMTP id 9so5142504uav.12;
 Mon, 23 Mar 2020 08:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=M8YISYLxprjf1kzWXEpmDWYbQYJJMFlnRQMRu8MBWHM=;
 b=oXpHylHNOUaYSZg4fvvouJKGdNtzr/SSrOYYCcf7Q7Ptgln46YtSkXeZnTr1LCcCbH
 gBCntqBUz+MS2YdG6MTj1sTenrlTTJqnT7SEdbDHHmChJRfEX8oklwohLyUt/1zECjaF
 UgQNEfruFzk1mI+zCGCqCsffFep3PJmRYWZcF+vyIqMvLMVUvHmumB/iD8ncpGDptYlI
 cUYd8dGmfRYUKzWM4bbUCNacEGVHO7siMBbSUbyM6CfPeQUm/SWJbXV8C+Ex9ffGgF4f
 PVVAxv2xa/ybojMKz4099t+jOxK55TvVqIGo+fBGPrAinFeci+eNilikm6UMLe6G13xX
 dOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=M8YISYLxprjf1kzWXEpmDWYbQYJJMFlnRQMRu8MBWHM=;
 b=B6MD1GZqnkdd7mpXijcTFugC2pF1bpogRFvchFKf+CQiaaBwDcqv0t75WxM9ea24M4
 6BeOk1/v5xeVWuBLt5XnNVoIoazgUPde++suZiDK7MZCdh/Hp56IbbbYZ3GgT5TKSyWM
 4ep71QfiryOzwnDZiFAo+o46zMC82qLhpMBNEw+dZwr5wXtu4GQj/jnEpZWGkLgFRXV1
 HpgTSPrEoux222DXLmQjbl/L2CcPFsWIrKizzUqZnR1FUNOfoW1oHSyng51J+TNV8vWf
 R1AGnn+z8xE7Mb1fkntUf8Ed4vViMZSpZa4F7kWwUgznEnXSQuY4w1UTSor9VF/bCy56
 wcMg==
X-Gm-Message-State: ANhLgQ1NDXiDNJAbdWzLQl+Eoli/kP27zXMEZwBri9jL/N+oJakrrwDe
 CF9lIxmcta2QqUu6VDltVLZiWzpp1YHY1MIgk5w=
X-Google-Smtp-Source: ADFU+vtwPJr/HYV2gQgxrd7bnlB0lHKb9By927CbfK4cdWUNAdaHGv1a4zuuQjB7YyFgCo6qM9Wke0eyf42ibeMGzqo=
X-Received: by 2002:ab0:630b:: with SMTP id a11mr13904640uap.133.1584979091256; 
 Mon, 23 Mar 2020 08:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200321144110.5010-1-philmd@redhat.com>
 <20200321144110.5010-4-philmd@redhat.com>
In-Reply-To: <20200321144110.5010-4-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 23 Mar 2020 08:50:13 -0700
Message-ID: <CAKmqyKNngiNFN7Q1+PRFSPKyg6xubmESFgtp7dkEjRM42bZs-Q@mail.gmail.com>
Subject: Re: [PATCH-for-5.0 v2 03/11] hw/i2c/pm_smbus: Remove dead assignment
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::943
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Mar 21, 2020 at 7:45 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Fix warning reported by Clang static code analyzer:
>
>     CC      hw/i2c/pm_smbus.o
>   hw/i2c/pm_smbus.c:187:17: warning: Value stored to 'ret' is never read
>                   ret =3D 0;
>                   ^     ~
>
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/i2c/pm_smbus.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
> index 36994ff585..4728540c37 100644
> --- a/hw/i2c/pm_smbus.c
> +++ b/hw/i2c/pm_smbus.c
> @@ -184,7 +184,6 @@ static void smb_transaction(PMSMBus *s)
>                  s->smb_stat |=3D STS_HOST_BUSY | STS_BYTE_DONE;
>                  s->smb_data[0] =3D s->smb_blkdata;
>                  s->smb_index =3D 0;
> -                ret =3D 0;
>              }
>              goto out;
>          }
> --
> 2.21.1
>
>

