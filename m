Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32164C43215
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 11:50:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03A6F206DB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 11:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bn7ZoTFZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A6F206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVDdt-0005NN-IQ
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 06:50:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iVDcs-0004tA-5I
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 06:49:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iVDcn-0006IE-No
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 06:49:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21734
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iVDcn-0006Hi-Av
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 06:49:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573732160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XBSgujUhBLBdE08LTVEsRaMd6az+8SLkrWZ3lFh2yuE=;
 b=bn7ZoTFZYVKGz/cSHzmFxO5c0QckO9eiJEu0pVmGy/xERNqJ4sktIOhMJOn2pXz2F0FgDV
 iBxjh1qRBIfumPvQcraoVHcrrFBEcswy0GUdQdgKTviGxFM2aNhRbvgDYqC6oyFYyBZeEq
 HOJymVljFcIPZ5Faai1ucSr324r84VQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-Lyv_1HJhPHSAAxsJG7-Itw-1; Thu, 14 Nov 2019 06:49:17 -0500
Received: by mail-wm1-f70.google.com with SMTP id z3so3221242wmk.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 03:49:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4hSLvheaCsbrtbYfhnYSddjTkEPhsUlOzw9LBdB9Kso=;
 b=m9zNoFjMdXi3yVRAC1JXMN+h+S4JnfkMo9kKTDtvVA6nHZq5uu2naLMmqFkMs3rMM4
 aqqSKpDuiPvTizyT/OYG/1jllUyJ3lEJt4pORNcywEN0MLp89tXWmSXWB4HnAMh/QHjR
 xfzVTcYMfbTcB82WnCtEVrapWVxu7hNpPpzOc7iun6a30TcXJ72XGaNYBr/1opkejaHy
 bbPecAjvRrll+1cVebxh7nUSyk3K+dYiPTLStt2oqy5EcERq7AW5MYLlgItSxMKAAuqP
 4M+6H3AE0D372o0YHosV/0kNN+jjw+aQGlvPTSVA80ViQHccnNIg5+cyJuWFVoNQcR7y
 P4Ww==
X-Gm-Message-State: APjAAAUEyuuscF7wnzuPN6UqfG/uM59BCRezXeypRYZJDFbUseroAwW8
 IvM2m3e375mkYH86bYzKhktQ1P8LIS0TQ0MKudyALq+3X4pmugFxL+P/a+Ygo8G2YK5oitEoVoK
 bEKAB5WlvgmLaom0=
X-Received: by 2002:a5d:6acb:: with SMTP id u11mr7667932wrw.271.1573732155835; 
 Thu, 14 Nov 2019 03:49:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqyVsIW3RekteeimArT1T0iC49ZnUYJvsprr9cGLCYlpSlYK84Leh2N4oZq9B8oyNOycZ8ZY9Q==
X-Received: by 2002:a5d:6acb:: with SMTP id u11mr7667903wrw.271.1573732155588; 
 Thu, 14 Nov 2019 03:49:15 -0800 (PST)
Received: from [192.168.1.35] (170.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.170])
 by smtp.gmail.com with ESMTPSA id j11sm6687379wrq.26.2019.11.14.03.49.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2019 03:49:14 -0800 (PST)
Subject: Re: [PATCH v2 2/5] MAINTAINERS: Adjust maintainership for Fulong 2E
 board
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 qemu-devel@nongnu.org, Huacai Chen <chenhc@lemote.com>,
 Huacai Chen <zltjiangshi@gmail.com>
References: <1573652826-23987-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1573652826-23987-3-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c053c16c-c6f4-4f73-7383-7b66e54ad696@redhat.com>
Date: Thu, 14 Nov 2019 12:49:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1573652826-23987-3-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
X-MC-Unique: Lyv_1HJhPHSAAxsJG7-Itw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: peter.maydell@linaro.org, aleksandar.rikalo@rt-rk.com, hpoussin@reactos.org,
 amarkovic@wavecomp.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

On 11/13/19 2:47 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>=20
> Change the maintainership for Fulong 2E board to improve its quality.

IIRC you told me once this board is named Fuloong, and its CPU is a=20
=E2=80=8ELoongson, both with 2x 'o' :) I have a patch renaming the various=
=20
occurrences.

> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>   MAINTAINERS | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fd9ba32..3bf2144 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -976,9 +976,10 @@ S: Maintained
>   F: hw/mips/mips_r4k.c
>  =20
>   Fulong 2E
> -M: Aleksandar Markovic <amarkovic@wavecomp.com>
> -R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> -S: Odd Fixes
> +M: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

I am happy to keep the Fuloong working, but this will be on my personal=20
(hobbyist) time. This area is not a priority for my employer, so I'll=20
use my personal email: f4bug@amsat.org.

The original author is active on the Linux kernel, let ask him if he'd=20
be OK to keep an eye on his work.

Huacai, would you agree to be listed as a reviewer on the Fuloong=20
related QEMU files? You don't have to worry about the generic QEMU code=20
plate (like keeping API up to date) I'll manage that, but I'd like to=20
have you listed to assert the hardware is properly modeled.

You would appear as:
R: Huacai Chen <chenhc@lemote.com>

> +R: Herv=C3=A9 Poussineau <hpoussin@reactos.org>

I don't think Herv=C3=A9 is interested by this board, he has not modified t=
he=20
code.

> +R: Aleksandar Markovic <amarkovic@wavecomp.com>
> +S: Maintained

Let keep it as "Odd Fixes" :)

   Odd Fixes:   It has a maintainer but they don't have
                time to do much other than throw the odd
                patch in.

>   F: hw/mips/mips_fulong2e.c
>   F: hw/isa/vt82c686.c
>   F: hw/pci-host/bonito.c
>=20

So the patch would be:

-- 8< --
  Fulong 2E
-M: Aleksandar Markovic <amarkovic@wavecomp.com>
-R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
+M: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
+R: Aleksandar Markovic <amarkovic@wavecomp.com>
+R: Huacai Chen <chenhc@lemote.com>
  S: Odd Fixes
  F: hw/mips/mips_fulong2e.c
  F: hw/isa/vt82c686.c
---

But let's wait to see what Huacai Chen thinks of it, before posting it.

Thanks for taking care of those changes!

Phil.


