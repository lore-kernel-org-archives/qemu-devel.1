Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3A9C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 13:59:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 754FD20718
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 13:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W/6Agixt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 754FD20718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY9T8-0000dE-NF
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 08:59:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58288)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iY9SP-0000E0-KX
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 08:58:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iY9SN-0004HM-LP
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 08:58:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55767
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iY9SN-0004H5-Hm
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 08:58:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574431122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iEdXI1kgK5cCAXBLsHL2FaaDXGheEfFHvS6gz9TEaFY=;
 b=W/6AgixtjA9WuJzAO+ZRn/D3kBm07UdrphfKPjj0PUghWD2oHEq2W8DB93086LuMSnPc02
 JTLUJ5AoVuoikQJGBqZcCT+p5tV+glpQKszh4UUhScbPgM9eW7B2Qm6/K/azCr5vfSuoLF
 JmdfrKUTT5KWYJEf5WiYfxcwSIZL19s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-nVY-hg9jNpa4sWyX5XIYZw-1; Fri, 22 Nov 2019 08:58:41 -0500
Received: by mail-wm1-f69.google.com with SMTP id f191so3466483wme.1
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 05:58:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IX4P1o2uUz0OvHQOoyarzv4jv98yUBoc+kvQIr2Od7c=;
 b=Rb6MM2gLhwVNo2nLExz5tunyZ85cf435rjjYVJ8PFUmsmvpczsvHE/ucMGdhtyasvj
 D99C80wfgEhHYmZzG6dBD0kygEfBrczmb5fQ0bKA6Ixa47kwBV6397harcElDG33YFr4
 t6Fc6TivcuP54IbGsnLNwBuJwnNqbMSkraWPfEf2t8aIz6KhdDO6iGqKmj21MOwxmPpO
 b92KFcazn8gsr46eXfLvhJv5Ol59oSK0Jam4lZjP76Htxd9+2p1m1pu1u2LwaMIk/Q9n
 PvgkYxLgbsOfvEqkwexQgmwEyQoRkAYjzKqikEI24r0qQEMyE1rmx5RUheBqwhgxO4nl
 LdRg==
X-Gm-Message-State: APjAAAWmvSRTOIJhSS/XwM2bPKL72hGRl9ckA102f4Ms1DtKz8bRVA31
 OLfcSvtwlPTVh2qbqAsXND2mj21QdWwxV71xEQNpC9/Y7YdIEKawFSM8YPncL8QAJtj5QwKcxro
 Y8Hwz2Vfq0z6P14I=
X-Received: by 2002:a1c:a556:: with SMTP id o83mr16336519wme.165.1574431119419; 
 Fri, 22 Nov 2019 05:58:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqyhHQh9xU538Lp9ppw+KDHtKG5SyBCJGKqL6av9VojRRMPVlbjNOZ7o9H8+HTcDqdmZM/0Gug==
X-Received: by 2002:a1c:a556:: with SMTP id o83mr16336507wme.165.1574431119216; 
 Fri, 22 Nov 2019 05:58:39 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id r2sm3686409wma.44.2019.11.22.05.58.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2019 05:58:38 -0800 (PST)
Subject: Re: [PATCH v2 4/5] MAINTAINERS: Adjust maintainership for R4000
 systems
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1573652826-23987-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1573652826-23987-5-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <78b81f32-0eb0-6d51-6ecc-9c8045be3896@redhat.com>
Date: Fri, 22 Nov 2019 14:58:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1573652826-23987-5-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
X-MC-Unique: nVY-hg9jNpa4sWyX5XIYZw-1
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
> Change the maintainership for R4000 systems to improve its quality.
>=20
> Acked-by: Aurelien Jarno <aurelien@aurel32.net>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>   MAINTAINERS | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6afec32..ba9ca98 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -971,8 +971,9 @@ F: hw/mips/mips_mipssim.c
>   F: hw/net/mipsnet.c
>  =20
>   R4000
> -M: Aurelien Jarno <aurelien@aurel32.net>
> -R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> +M: Herv=C3=A9 Poussineau <hpoussin@reactos.org>

Commit 0c10962a033 from Herv=C3=A9 was part of a bigger refactor series, so=
 I=20
don't think he is interested.

> +R: Aurelien Jarno <aurelien@aurel32.net>
> +R: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>   S: Maintained
>   F: hw/mips/mips_r4k.c

Now back to this board, I am having hard time to understand what it=20
models. IIUC it predates the Malta board, and was trying to model a=20
board able to run the first MIPS cpu when the port was added in 2005=20
(see commit 6af0bf9c7c3a).
The Malta board was added 1 year later (commit 5856de800df) and models a=20
real hardware.

As Aurelien acked to step down maintaining it, it seems the perfect=20
timing to start its deprecation process. I'll prepare a patch for 5.0=20
(unless someone is really using it and willing to maintain it).

Regards,

Phil.


