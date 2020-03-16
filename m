Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D636AC18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 14:06:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2CC52071C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 14:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U6o43tBE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2CC52071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDqO9-0007Ph-CC
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 10:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50561)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDp0P-0001Cv-5i
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:38:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDp0O-0003Et-0j
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:38:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52672
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDp0N-00038q-SP
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:38:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584362283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X8s1pbMd8HiFdjP0FyxZTLEw+ccXxxpvBh8ui/fgRtc=;
 b=U6o43tBET/rNDe8frZqNUubrr7WMnO818C4uBLnqbe+rpCgwGJS1ZC5F7I5i275NB0fKca
 no3rn2f979H4mdHSPBoCMmqg/drMp52W1s4qDsCTNWPbA1H0E/PCd6Si7NEza6CvJkCyiu
 05HIz0ukPcbVtN4c+ywx9brqngIFi6o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-raHmH3HuOMKikvbd8j9NqA-1; Mon, 16 Mar 2020 08:38:01 -0400
X-MC-Unique: raHmH3HuOMKikvbd8j9NqA-1
Received: by mail-wr1-f72.google.com with SMTP id 94so4288409wrr.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 05:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=74Ivas21HF4MoE96e8hQMSlPbRf3Nzcooh5m6Iuis2I=;
 b=bKjEDe2cfBBMFIc8X22Wu2ub6fI1/Yf8ogpRi8mb9pXrTAwI88MWQUjSfBafmNLrsI
 7s/aF0cTqLgPGTgJ8S6Cm2F42kLEA9XMEtpum2sJ3GbYA432Dgao+CMNydfpNnnXqRZX
 S11sboB+xkjU3D95tLcoPeh8hw8EdsJdV1fa8H97ANZCi/xqv+6j7dqHylDrQjOS/P9h
 f328IzBExD6A5X0/dSkicMylXqDEIedl7W8ozN6zwfeaxA/9FLc7GkZFCsNQPpWhjmTN
 if2eRKproFUb/QP6SkFfQuOyVBFVgEeDH1e61PPmlKCxEI5tRVsk7ibNXv5Ym1IQ+vlx
 q6Iw==
X-Gm-Message-State: ANhLgQ1+QYx7dHqQT/aZsuRABRa+1/g2hHSBY/HnQA2KUqVZeQMGihde
 W6jbgPdEYwEEOJcuRAVzT+SNb/orhJrfXgFpnRvpaypsvmpEAzLPpgDtLuuiz9qTNoCvPO2nmAe
 nR3gHD7CSjROO1/k=
X-Received: by 2002:adf:f18a:: with SMTP id h10mr12780718wro.255.1584362280329; 
 Mon, 16 Mar 2020 05:38:00 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vttllZIVd7rfj2P3jTwFi9aXCPgkpbu9vI1mAOa6elnistYO5w6CJRc6xKANCZ/RXsdh2i4QQ==
X-Received: by 2002:adf:f18a:: with SMTP id h10mr12780704wro.255.1584362280120; 
 Mon, 16 Mar 2020 05:38:00 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.82.39])
 by smtp.gmail.com with ESMTPSA id v2sm6948546wrt.58.2020.03.16.05.37.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 05:37:59 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Mark the LatticeMico32 target as orphan
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?B?w4Frb3MgS292w6Fjcw==?= <akoskovacs@gmx.com>,
 qemu-devel@nongnu.org, Michael Walle <michael@walle.cc>
References: <20200316122641.14017-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ca8fb038-43e4-d702-5ebc-bcc78b99445b@redhat.com>
Date: Mon, 16 Mar 2020 13:37:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316122641.14017-1-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, "Emilio G . Cota" <cota@braap.org>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/03/20 13:26, Philippe Mathieu-Daud=C3=A9 wrote:
> Michael Walle expressed his desire to orphan the lm32 target [*]:
>=20
>   I guess it is time to pull the plug. Mainly, because I have
>   no time for this anymore. I've always worked on this on my
>   spare time and life changed. And secondly, I guess RISC-V is
>   taking over ;) It has a far better ecosystem. Also, to my
>   knowledge the only (public) user of LM32 is milkymist and this
>   project is dead for years now..
>=20
>   So time to say goodbye. It was fun and I've learned a lot -
>   technically and also how a huge open source project works.
>   Thank you everyone for that :)
>=20
>   Basically everything still works and there are even TCG test
>   cases which covers all instructions the processor has.
>=20
> Many thanks to Michael for his substantial contributions to QEMU,
> and for maintaining the LM32 target for various years!
>=20
> [*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg605024.html
>=20
> Cc: Michael Walle <michael@walle.cc>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Michael: Do you want to keep your M: entry, switch it to R: or remove?
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 32867bc636..5376c59581 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -184,7 +184,7 @@ F: include/hw/net/lasi_82596.h
> =20
>  LM32 TCG CPUs
>  M: Michael Walle <michael@walle.cc>
> -S: Maintained
> +S: Orphan
>  F: target/lm32/
>  F: disas/lm32.c
>  F: hw/lm32/
>=20

Cc: qemu-trivial@nongnu.org


