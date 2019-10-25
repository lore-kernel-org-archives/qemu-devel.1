Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC5FCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:02:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 546692084C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cdRLwXJn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 546692084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNzEk-0003L3-SP
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 09:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57114)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNzD8-000123-OH
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:01:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNzD6-0005tB-F4
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:00:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39403
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNzD4-0005sJ-P6
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572008454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dMuGshlOcdLFtgqx2TDrxMQZ7pp4OoO/H3Y6PPNSuyI=;
 b=cdRLwXJne+tlX9ig1LyVkt6TtiSAHlKJR/nq7d405uf7H9mjI38xse5NCelYzG2Vy0BNmS
 ZLCFUoA+q9dATZ+dmfpG7l/bcNt0auaESn+1DekcB+QZ1qAMUJWpSqgNNMSQFqSoubgIjp
 RAPav29U6P4kRoagQupwwwMN/Hd8w08=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-I6xGR258NcmnroRtON3Qfw-1; Fri, 25 Oct 2019 09:00:52 -0400
Received: by mail-wm1-f69.google.com with SMTP id k184so1110214wmk.1
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 06:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZAqLm7z/H1+fdijhZV+XinNA4BIztaeJI5hiDXk6Vvc=;
 b=l7Y9iQYw98OEXXtWugGfq3l7dpYJfhlIPG5272/RgffMT6q65iYxncHIKJ7gBEiIcf
 BA+taJDGSHfGL90q6+UU74CRph7qFhOl45Kk7b0uaPj1x70Bp7HFvnakRCWAzH5Spvj2
 U/9oe1sdFNQTYcyP2Odi+zzEUQATtlJhbXabiJRxKtZIFd4FE0gmpgAcrpB5KGMMA7bd
 vqCMKgr7KF1WRDbXX3xQvEOvPfftwjQra9QMak93+CMiB68Q0zdbh2vGcao4oAFhtLkJ
 DjIs30kCzK/FK+txHYgeGcPX8HvxnxeaaHgPGwSVqN3krdT5r1zU0czLNBJouBGaw53g
 k99A==
X-Gm-Message-State: APjAAAVCIG3DOukGYcxoIlgBosg96baOtkETWDTh84pEbETIaPPAFcSe
 BxjxjeT4+KYdRA5EE5ZOqCjbRm8qKs8VdWBp4e38yWik18bXITunJ6bybytWMM4yZnorfhWsBzV
 w0TJadka1Osio37w=
X-Received: by 2002:adf:b21a:: with SMTP id u26mr3007099wra.119.1572008451266; 
 Fri, 25 Oct 2019 06:00:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzgXLZ5iNysk3Yvugmiq2ohdgVDzpq+Uj7uOpX9We1iN1SyeX44YERL+kUhCXMC0UtwAyThSw==
X-Received: by 2002:adf:b21a:: with SMTP id u26mr3007080wra.119.1572008451086; 
 Fri, 25 Oct 2019 06:00:51 -0700 (PDT)
Received: from [192.168.1.115] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id c189sm2104240wme.24.2019.10.25.06.00.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2019 06:00:50 -0700 (PDT)
Subject: Re: [PATCH v2 02/12] tests/tcg/multiarch/linux-test: Fix error check
 for shmat
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191025113921.9412-1-richard.henderson@linaro.org>
 <20191025113921.9412-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ecb31841-0e85-3e77-c583-1777fb47aadc@redhat.com>
Date: Fri, 25 Oct 2019 15:00:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191025113921.9412-3-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: I6xGR258NcmnroRtON3Qfw-1
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
Cc: alex.bennee@linaro.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/25/19 1:39 PM, Richard Henderson wrote:
> The error indicator for this syscall is -1, not 0.
>=20

Fixes: e374bfa35bf

A more than 15 years old bug :>

> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tests/tcg/multiarch/linux-test.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/tcg/multiarch/linux-test.c b/tests/tcg/multiarch/linux=
-test.c
> index fa4243fc04..673d7c8a1c 100644
> --- a/tests/tcg/multiarch/linux-test.c
> +++ b/tests/tcg/multiarch/linux-test.c
> @@ -503,8 +503,9 @@ static void test_shm(void)
>  =20
>       shmid =3D chk_error(shmget(IPC_PRIVATE, SHM_SIZE, IPC_CREAT | 0777)=
);
>       ptr =3D shmat(shmid, NULL, 0);
> -    if (!ptr)
> +    if (ptr =3D=3D (void *)-1) {
>           error("shmat");
> +    }
>  =20
>       memset(ptr, 0, SHM_SIZE);
>  =20
>=20


