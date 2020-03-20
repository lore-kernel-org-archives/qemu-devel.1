Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A05C4332E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:33:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8175B2076F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DE/GqW3r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8175B2076F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFKaT-0004oK-Lv
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 12:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47213)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFKZi-0004OP-Ea
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:32:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFKZg-0004BP-Ea
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:32:45 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:26958)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFKZg-0004AL-Aq
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:32:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584721963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9KYypFR0Bngz2x6xxZiN41SZ4DYuNd5P2xluYyj2TKc=;
 b=DE/GqW3rpbewVKyT5qLP94TR1zyRXzAgYUGq+t/bdck98Mgbl5JneEZRl2o2t0AGJZ8B4t
 y0FI9Libq5uf4nhHxeSsqwE2Ws7+WzaXSmKGDHHWgXDc8Im2Gi0D6ebSf08y3DXlktr9yX
 vCnpUhjth7PGPg5fRnKNAwPoLjh2OiM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-Wxg_X1e3Mr2ER2eJ86lPSw-1; Fri, 20 Mar 2020 12:32:41 -0400
X-MC-Unique: Wxg_X1e3Mr2ER2eJ86lPSw-1
Received: by mail-ed1-f71.google.com with SMTP id b9so4421638edj.10
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 09:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2BgqZJ5ZgGUpX+17N2Td1tuyw+e7czSTepi0W9SZG7Q=;
 b=ePln3HETQIe/iOLzVhe+2W0zUsZPPxkBdmWpRsNm9MhWAFYflARXLQFNiJEYJ1itRB
 yBzNn6us2GooLGVKsXNe1nI3nQ67X+LsjcwvqTPzxXrf8jcwD4YR0C7vdbV06bxj6hmQ
 qbOAYUXyN1EnF2dHkcm3u11NsZ/SGj/3oLzb1Okk8cVbydjpf0K3EP+NGnTEJxjoLTRh
 IIXw4hNhTn+1mnyR8ElhgBJkAfB7YbMFVkTwUXQMtKraOFEgMrTn5m73sxG9QgRjawxC
 GjRAeGGU7Tz+1x4KVYkDRd2GrXhRPRIpXcsrvE1zKICeY6MP3QMlVSG+ndBW1tp+w+xN
 REBw==
X-Gm-Message-State: ANhLgQ2W2yqLSIzn8gaeM8pYhhhs413LIXQ6645lxjTGWhhzOvC7ZYhG
 zazDQ3qMDN6bWVSWaDpqcrbNvX47zNJpIiHy3qGz11qHOAhDaXKB06m6YQQlebILBwEVV5pWi94
 rOYnxhvy/sv5Brl4=
X-Received: by 2002:a05:6402:cc:: with SMTP id
 i12mr8648559edu.270.1584721960445; 
 Fri, 20 Mar 2020 09:32:40 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuctbHzRqHW8lVP0VIIhV5uJiy0/kJjFqEsRMmHrpeDH7nXgAYcNc9nGdDwpcq2JazHBkGeLQ==
X-Received: by 2002:a05:6402:cc:: with SMTP id
 i12mr8648540edu.270.1584721960196; 
 Fri, 20 Mar 2020 09:32:40 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id l24sm423288ejx.8.2020.03.20.09.32.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2020 09:32:39 -0700 (PDT)
Subject: Re: [PULL v2 05/13] target/rx: CPU definitions
To: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20200320103551.29246-1-f4bug@amsat.org>
 <20200320103551.29246-2-f4bug@amsat.org>
 <c7cf4bab-b9ac-4387-0709-a02c04b24061@redhat.com>
 <e4bc22f6-128d-99e9-9359-3253f666c065@linaro.org>
 <CAFEAcA8RM6U1hKX1Wn5YmR71y=VrGimt46z_OR=+O1i9neahiw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <70930618-a369-cb26-1b9b-aa7864deefc9@redhat.com>
Date: Fri, 20 Mar 2020 17:32:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8RM6U1hKX1Wn5YmR71y=VrGimt46z_OR=+O1i9neahiw@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/20/20 5:21 PM, Peter Maydell wrote:
> On Fri, 20 Mar 2020 at 16:19, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 3/20/20 9:04 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Not related to this patch, but this line generates a warning with Clang=
:
>>>
>>>    CC      rx-softmmu/target/rx/cpu.o
>>> target/rx/cpu.c:158:33: warning: The result of the left shift is undefi=
ned
>>> because the left operand is negative
>>>      address =3D physical =3D addr & TARGET_PAGE_MASK;
>>>                                  ^~~~~~~~~~~~~~~~
>>> include/exec/cpu-all.h:234:45: note: expanded from macro 'TARGET_PAGE_M=
ASK'
>>> #define TARGET_PAGE_MASK   ((target_long)-1 << TARGET_PAGE_BITS)
>>>                              ~~~~~~~~~~~~~~~ ^
>>> 1 warning generated.
>>
>> >From configure:
>>
>>> # We use -fwrapv to tell the compiler that we require a C dialect where
>>> # left shift of signed integers is well defined and has the expected
>>> # 2s-complement style results. (Both clang and gcc agree that it
>>> # provides these semantics.)
>>
>> Clang is *supposed* to be not generating those warnings.
>=20
> I do have clang in my build tests, so at least some versions of
> clang do indeed correctly handle -fwrapv. What version are
> you using, Philippe ?

-fwrapv is here indeed.

I use=20
--extra-cflags=3D-fsanitize=3Daddress,alignment,array-bounds,bool,builtin,e=
num,float-cast-overflow,float-divide-by-zero,function,integer-divide-by-zer=
o,nonnull-attribute,null,pointer-overflow,return,returns-nonnull-attribute,=
shift-base,shift-exponent,signed-integer-overflow,unreachable,vla-bound,vpt=
r

Apparently -fwrapv is ignored. Probably one of shift-base/shift-exponent=20
sanitizer plugins.

>=20
> thanks
> -- PMM
>=20


