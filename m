Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA34AC4332B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 22:32:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B236F2076F
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 22:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLgl/ITp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B236F2076F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEhEk-0002dy-Sd
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 18:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39000)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jEhDr-0001mV-NR
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 18:31:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jEhDq-0005Fd-9A
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 18:31:35 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:46279)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jEhDq-0005Dc-51
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 18:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584570693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tZWB/4/QHkBs1WYgfcoh+dupaQRe27/BgTbIcZHr97k=;
 b=hLgl/ITpFgNp1awbnq2opVNx15cYy3CJeVRMBOXQKZwEUAjw4uOg5jm2nviYTH86A9qoue
 NVWTBs4kwURlp3MP43JjCMj64J7kp+2wwlq/Cnk+3kvTV3RwzKkA19sdDPt0TyGV/IHpd2
 CgRH8cudHDk2GlsFmYFYFGw5IhIqg10=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-CyzHcasCN5yf8uxqFL0zQw-1; Wed, 18 Mar 2020 18:31:29 -0400
X-MC-Unique: CyzHcasCN5yf8uxqFL0zQw-1
Received: by mail-wr1-f72.google.com with SMTP id u12so28062wrw.10
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 15:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kCdJq3LoL5hHTpGMpnQ3+srtEBY81UHtDEa+jCv1AX0=;
 b=iCeahckfm964DTIpEiTrBFIvj9cLAd2XBOqUq95ELc0Kb3Izolu6dO9lgky8K/Rlyh
 Nox5DgZH2Jveu3xJ8Ljo9flPnEpYKvnJDjy6mhnheIofinwdQhaUzvo8ONosdHt2pjoj
 pgz1+A8VAI/yB97GkWf+GAjq5JtbkOGY9JHFqeGKEXMbJ1mtjuuWdcRUhhJTaZQm8m8t
 kxRbNXCw9FxEXMu7RzH3iOFNYlpzNdrklOCjLftRLDMd6EleTI3+9Fy55yJkwFpfXs1J
 4tK9dKL1jvq9KahwsiWO7N30rSYbL9dloPLcEdG/kdknSpmcLhlFiGhkXKIk5WB6z5u+
 0bBg==
X-Gm-Message-State: ANhLgQ2l3AsdIjGPKaiO2RIea17dJZ/icJoBi+n1pCfhMzr+oBtpuxPW
 /jU1ucS15VHkA1L+qnoShos8ZddHHhXPZipvP5GfStnFCPTreEyk8FXdI6UYwcCrsKoqNH7jHyd
 5f7B8z6KOB/4nIfQ=
X-Received: by 2002:a1c:2d4f:: with SMTP id t76mr7430189wmt.60.1584570688591; 
 Wed, 18 Mar 2020 15:31:28 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtc+jFwO7VQ/xbBuJEeVD7o/n1Mf/I6It0UoOMkjCqxOvOTvRiQ1yq5pYEcVhre23OB2ayXUw==
X-Received: by 2002:a1c:2d4f:: with SMTP id t76mr7430160wmt.60.1584570688355; 
 Wed, 18 Mar 2020 15:31:28 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id q10sm396607wrx.12.2020.03.18.15.31.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2020 15:31:27 -0700 (PDT)
Subject: Re: [PATCH 5/4] scripts/simplebench: fix python script ! headers
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200318011217.2102748-1-ehabkost@redhat.com>
 <20200318170226.12186-1-vsementsov@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8636cd05-4817-c2c4-5741-494069ba152b@redhat.com>
Date: Wed, 18 Mar 2020 23:31:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318170226.12186-1-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: peter.maydell@linaro.org, aleksandar.qemu.devel@gmail.com,
 ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/18/20 6:02 PM, Vladimir Sementsov-Ogievskiy wrote:
> - simplebench.py is not for executing by itself, so drop the header
> - in bench_block_job.py fix python to python3
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   scripts/simplebench/bench_block_job.py | 2 +-
>   scripts/simplebench/simplebench.py     | 2 --
>   2 files changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/scripts/simplebench/bench_block_job.py b/scripts/simplebench=
/bench_block_job.py
> index 9808d696cf..a0dda1dc4e 100755
> --- a/scripts/simplebench/bench_block_job.py
> +++ b/scripts/simplebench/bench_block_job.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/env python
> +#!/usr/bin/env python3
>   #
>   # Benchmark block jobs
>   #
> diff --git a/scripts/simplebench/simplebench.py b/scripts/simplebench/sim=
plebench.py
> index 59e7314ff6..7e25f3590b 100644
> --- a/scripts/simplebench/simplebench.py
> +++ b/scripts/simplebench/simplebench.py
> @@ -1,5 +1,3 @@
> -#!/usr/bin/env python
> -#
>   # Simple benchmarking framework
>   #
>   # Copyright (c) 2019 Virtuozzo International GmbH.
>=20

I'd rather see this squashed in patches 1 and 2, if not:
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


