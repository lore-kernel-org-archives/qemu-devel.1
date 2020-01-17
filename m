Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E66AC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 06:43:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0788D20730
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 06:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iudx1DaO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0788D20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isLLY-00074t-5n
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 01:43:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54011)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isLKx-0006D0-4I
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 01:42:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isLKw-0004Pc-5p
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 01:42:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37256
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isLKw-0004P2-2E
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 01:42:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579243349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cNh2iarTwW04r8WJLvqFdZ+tBa2yksb3g9CA+7+7gQ0=;
 b=Iudx1DaOzrvpAea5acdIxE4DrgQ+EYmSPwYfx7LgLKgEo5bRIPhJBUYwqbkNFYz1wkn08L
 o6xkKfeTzvf93V2M9pVCh1o1gAVUkhFqpOeCX8T8BEHY/CsFwpEePCC1SvRQbcROHyjN+5
 BlGxglrvxGsD6UJYhKu0/6uA8drUw/0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-bjdK7SCoMECbABKVa3ap5A-1; Fri, 17 Jan 2020 01:42:28 -0500
Received: by mail-wr1-f69.google.com with SMTP id 90so10092440wrq.6
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 22:42:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+dEQQPJi6po0tnmAODXwZodY93cxaCQNnaOzieI1y7w=;
 b=cYlkfgGraG1h8E8oIiau7Pi3YLolLWAzhVlL+IK19rGDDcSULrVd/y90CBNjch/Z0s
 EBiikuNk3i1By7PBQOBfIT559dDSGqen5GIrOdMEdmTqvtqVcKn4cMw2zq5Sx90wZe8R
 smIYcdwoVHDlWBxNbYyiYq8E+04szn8YgYueKp82Zi/TdYlo/yajVAjvTuYesLWHfmGW
 CbVVeHLDC5PXnvUGTMvHTT5COBmmKr9MJYKUGMmX/nlbdAETk6FUE4/v207nsdPxesm5
 40f+ywqnnJJic5VykDGVMkV+u8tlR48rcDlFNYlAm9tOUnHbmLQkQsag7c5Ydu+kVsMV
 Rifw==
X-Gm-Message-State: APjAAAXOjtiZ2oC12yUXvbsexkqXOI7nswEbHdxTKxaB8fq7mx7w1fN7
 IRzEzS2kmuoHDMStvXD+uGCAKrpHC2K8dO8cytTanA9nBtr6TJR22Rm4qEOWolUZGgGQjg+/b9C
 nk+KQX7CpAg4Y9yg=
X-Received: by 2002:a5d:4a91:: with SMTP id o17mr1281748wrq.232.1579243345678; 
 Thu, 16 Jan 2020 22:42:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqxHsz2C4fmT4EQWNmNVs8RQZu+oInSCVjhotLbabQhRYQu06mV6ceXEDOCmLbSfMCWqD8nwGg==
X-Received: by 2002:a5d:4a91:: with SMTP id o17mr1281725wrq.232.1579243345418; 
 Thu, 16 Jan 2020 22:42:25 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id b18sm33015548wru.50.2020.01.16.22.42.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2020 22:42:24 -0800 (PST)
Subject: Re: [PATCH 2/4] tests/tcg/aarch64: Fix compilation parameters for
 pauth-%
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200116230809.19078-1-richard.henderson@linaro.org>
 <20200116230809.19078-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cbc8fdd9-ddc8-641d-2614-380ffab5d10f@redhat.com>
Date: Fri, 17 Jan 2020 07:42:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200116230809.19078-3-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: bjdK7SCoMECbABKVa3ap5A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: peter.maydell@linaro.org, vincent.dehors@smile.fr, alex.bennee@linaro.org,
 adrien.grassein@smile.fr
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/17/20 12:08 AM, Richard Henderson wrote:
> Hiding the required architecture within asm() is not correct.
> Add it to the cflags of the (cross-) compiler.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tests/tcg/aarch64/pauth-1.c       | 2 --
>   tests/tcg/aarch64/pauth-2.c       | 2 --
>   tests/tcg/aarch64/Makefile.target | 1 +
>   3 files changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/tests/tcg/aarch64/pauth-1.c b/tests/tcg/aarch64/pauth-1.c
> index a3c1443cd0..ea0984ea82 100644
> --- a/tests/tcg/aarch64/pauth-1.c
> +++ b/tests/tcg/aarch64/pauth-1.c
> @@ -2,8 +2,6 @@
>   #include <sys/prctl.h>
>   #include <stdio.h>
>  =20
> -asm(".arch armv8.4-a");
> -
>   #ifndef PR_PAC_RESET_KEYS
>   #define PR_PAC_RESET_KEYS  54
>   #define PR_PAC_APDAKEY     (1 << 2)
> diff --git a/tests/tcg/aarch64/pauth-2.c b/tests/tcg/aarch64/pauth-2.c
> index 2fe030ba3d..9bba0beb63 100644
> --- a/tests/tcg/aarch64/pauth-2.c
> +++ b/tests/tcg/aarch64/pauth-2.c
> @@ -1,8 +1,6 @@
>   #include <stdint.h>
>   #include <assert.h>
>  =20
> -asm(".arch armv8.4-a");
> -
>   void do_test(uint64_t value)
>   {
>       uint64_t salt1, salt2;
> diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefi=
le.target
> index df3fe8032c..374c8d6830 100644
> --- a/tests/tcg/aarch64/Makefile.target
> +++ b/tests/tcg/aarch64/Makefile.target
> @@ -20,6 +20,7 @@ run-fcvt: fcvt
>   # Pauth Tests
>   AARCH64_TESTS +=3D pauth-1 pauth-2
>   run-pauth-%: QEMU_OPTS +=3D -cpu max
> +pauth-%: CFLAGS +=3D -march=3Darmv8.3-a

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>  =20
>   # Semihosting smoke test for linux-user
>   AARCH64_TESTS +=3D semihosting
>=20


