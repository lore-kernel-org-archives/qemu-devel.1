Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D68C33CB3
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 20:53:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA3EC2063A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 20:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+C89i0O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA3EC2063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixzlh-0004ur-LJ
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 15:53:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ixzkl-0004Lt-MP
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 15:52:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ixzkk-0006aH-M7
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 15:52:31 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40713)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ixzki-0006ZO-Eu; Sat, 01 Feb 2020 15:52:28 -0500
Received: by mail-wm1-x342.google.com with SMTP id t14so12579326wmi.5;
 Sat, 01 Feb 2020 12:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NqK1GXAOTKGpO87hYdAu4c51wDau9DzpCnA+D6eEA80=;
 b=U+C89i0Orrgv8LNOQGIf7D+QglYaJrrcHYkGr797GOgatTUkBcBNPjyq4TFwztDC7T
 10yReYqAP6t42qOjTvLVNPBL0od/cEeXDejPb+XYQCcL7LSOw/gp6yogdfIuBK7/3N3X
 rxKKZDuVZ9u7UkqV4Ew7ierd++Wb9ivESsXjpWqdLgQFEdd0kI0kaXFidyN131XLgMPf
 vutKk20NZLecOD/EWBHwRwxRtXHkQMGB/R31N/9kMW9hzrIT2Oj+kUaLY5OyD8Fn0Lv1
 XGZFAv+TTDUdS9oYH42j3mHL1tFeNRIQghbCjUmvP2dKStoFvPa/3q+BrJifs5yq8XDv
 VVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=NqK1GXAOTKGpO87hYdAu4c51wDau9DzpCnA+D6eEA80=;
 b=D3pGXSn0KxIYFdJ/G5wnOLHfMbZuB0QQJGyBsC50WNtlg+MLLeDQcLofSInprpOu0j
 yCpSd/MjY+stj7A5dNl0tQ1XsAEhbMlqn10hZPb7PNUWeNjJxqo1QqB1cJFW5HSL2yGH
 aguERxGyoSwyfU3fEvDjxKW6YZvZCuR/KPUFOt/AzYh1dhzLjmHdib1ZZ0LCy0m110SZ
 QIP3oYOKKb7+NJDmJbEJCvEqXEN806EMr6bDmQ7c/f/TsbG/yaIN5F6DOV34bn28EFvr
 8nxj6Ig8ggryLYvNx4+jttipTgwRWkOdJ/ygbvC5yM30i6J5tv75QYHdl+pWqaHBnC0R
 eoYQ==
X-Gm-Message-State: APjAAAWqOxj3d27GPerpalBmHsDS+mXlMJoa2W/uRTEEvTa7G/Kvrn/X
 W46Nphi/YkAYTeW0A0sRNKg=
X-Google-Smtp-Source: APXvYqwTO0AU2K3GtI6zK06OMNVZ1Ag5s5A/sIove70Jhr5goqGqdLtVtBZR2zmndadIH1ry7xbIHw==
X-Received: by 2002:a05:600c:214f:: with SMTP id
 v15mr19973024wml.110.1580590347142; 
 Sat, 01 Feb 2020 12:52:27 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id n8sm18340149wrx.42.2020.02.01.12.52.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Feb 2020 12:52:26 -0800 (PST)
Subject: Re: [PATCH v4 01/20] hw/arm: add Allwinner H3 System-on-Chip
To: Niek Linnenbank <nieklinnenbank@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200119005102.3847-1-nieklinnenbank@gmail.com>
 <20200119005102.3847-2-nieklinnenbank@gmail.com>
 <4aca4ea1-fb06-c0bf-d636-e6b842380a15@redhat.com>
 <CAPan3WqTsyx-N6UQwonfDb83BPadYvvLm3DOnn7o8g017W_KCg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <ac340817-cfac-c4b3-396d-829e08eccba9@amsat.org>
Date: Sat, 1 Feb 2020 21:52:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAPan3WqTsyx-N6UQwonfDb83BPadYvvLm3DOnn7o8g017W_KCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Peter Maydell <peter.maydell@linaro.org>, jasowang@redhat.com,
 QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/1/20 8:21 PM, Niek Linnenbank wrote:
> Hi Philippe,
> 
> I just got back from traveling and will start processing these and the
> other comments soon.
> 
> On Sun, Jan 19, 2020 at 7:01 PM Philippe Mathieu-Daudé
> <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
> 
>     On 1/19/20 1:50 AM, Niek Linnenbank wrote:
>     > The Allwinner H3 is a System on Chip containing four ARM Cortex A7
>     > processor cores. Features and specifications include DDR2/DDR3 memory,
>     > SD/MMC storage cards, 10/100/1000Mbit Ethernet, USB 2.0, HDMI and
>     > various I/O modules. This commit adds support for the Allwinner H3
>     > System on Chip.
>     >
>     > Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com
>     <mailto:nieklinnenbank@gmail.com>>
>     > ---
[...]
>     > diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>     > index 3d86691ae0..bb75c1de17 100644
>     > --- a/hw/arm/Kconfig
>     > +++ b/hw/arm/Kconfig
>     > @@ -295,6 +295,14 @@ config ALLWINNER_A10
>     >       select SERIAL
>     >       select UNIMP
>     >   
>     > +config ALLWINNER_H3
>     > +    bool
>     > +    select ALLWINNER_A10_PIT
> 
>     We should now rename this as ALLWINNER_PIT.
> 
> 
> I see your point, now both SoCs are using the A10 specific PIT timer.
> Previously we agreed to do the generalization of that timer in a
> separate patch series.
> I think it makes sense to also do the rename of this item as part of
> that separate series.

Fine by me.

