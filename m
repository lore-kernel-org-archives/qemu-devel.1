Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF011C2BA2B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:33:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA469206F9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYTEjcj4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA469206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jObcG-0003IS-U2
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 02:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39746)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jObUM-0004f6-PH
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 02:25:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jObUL-0003cq-Nu
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 02:25:34 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:35613)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jObUL-0003cH-Hm
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 02:25:33 -0400
Received: by mail-ed1-x544.google.com with SMTP id c7so3237214edl.2
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 23:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0fb2a3YH+MoXgR0j8ASkXt6fWvPYN2nnXE9gAwXg/EM=;
 b=MYTEjcj4tqmOhiXdnyfHIkJQx4VIf9P2c3DL7WKJYzJe83qUFL7xIzreNfzah0l+rM
 pOPbPn0y7qoWduNpE5xZP7zPDrHKvo/BiKJP6JrKcN5AHpEQk6lXvyVAL7xjrErrOsCz
 zDQSiwolub9t/9Xa59p7TndBCmjLbl/5tgUJhy+ONDV/9zzPkYXMY8I7wKim6ae+VXVa
 OYu/4csGx/pgQcvLy20sykyNd4V6IqqIv/v1fndwlPrbA8w7gqONW6IREpef7nrTytY0
 5irMvQrDgdFUbfm8laerWj8UKnb29CSeoP4eefTP6W9CXTvrUDzRBpmXRWpNMm2K45uX
 gt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=0fb2a3YH+MoXgR0j8ASkXt6fWvPYN2nnXE9gAwXg/EM=;
 b=hxHUEZd7Jx+xvfkT+vWauWefAlq4YE+8sCW8Vt4fEmDojyt6FP/SsLcYvt+1tUk54l
 UUfqE40Wo9ALs6pmbxCHZoiTteGUcUHEYmma7U4YqstwBz5dtwnonSBHu7q6QhxJwfxH
 aMgqeVy8GDqZLSCuZgfCaw5vM1jVPK9hhkf4C9SEOM1oT+F6MI0GFN+P7VNAa52vhzXw
 1P+yapCk9WQHDh5oLUmOOaqWrYLYarAQQU0dfiXeiD760uwNi8TVAr8rbXr6V3hGh86g
 IS1U+tSCX1CN3g/MMw8CrZOOIAda4rXVThk1ncOODEJqaXpJnHn59rDPk73kiAcd3mg/
 Hjjw==
X-Gm-Message-State: AGi0PuZvofuZH5nQpR/sdF7RA22R+zkQdVTDcILWg4bRQuu8GvIHaEXa
 PRnQu7gfDIQaU8PWf/iiMBw=
X-Google-Smtp-Source: APiQypJqTjlmmOSwemkkXaqnAzSWBXk9mg0OFAqZjmfdXPAZlB0wipQfFCvdCMq7YSRtZOnm59znBg==
X-Received: by 2002:a17:907:414d:: with SMTP id
 od21mr3729086ejb.178.1586931931839; 
 Tue, 14 Apr 2020 23:25:31 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id ce16sm2451308ejc.74.2020.04.14.23.25.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2020 23:25:31 -0700 (PDT)
Subject: Re: [PATCH v41 01/21] target/avr: Add outward facing interfaces and
 core CPU logic
To: Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200118191416.19934-1-mrolnik@gmail.com>
 <20200118191416.19934-2-mrolnik@gmail.com>
 <80141c57-7fb7-6e95-4070-54f7cc23e166@redhat.com>
 <CAK4993ie33Awp=sqUOcubqCLFqTd5mTPAkWQfhh3zvorMwnSig@mail.gmail.com>
 <8ac9a03a-a02f-1b48-c75d-77e4b8aea9ef@linaro.org>
 <45d68295-416b-b6d2-a512-86f6120432f0@redhat.com>
 <CAK4993iVT358BOU9gQKcNEDLw_smTfvzm0ePDO1WLubtGx_Mvw@mail.gmail.com>
 <CAK4993ignoQ2c8hz7WSYVORTmmzrFaLM+XB-yczSAaTcyVs8Dw@mail.gmail.com>
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
Message-ID: <c34681d7-1dc6-9f71-81fd-139358e6e89f@amsat.org>
Date: Wed, 15 Apr 2020 08:25:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAK4993ignoQ2c8hz7WSYVORTmmzrFaLM+XB-yczSAaTcyVs8Dw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::544
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
Cc: Thomas Huth <thuth@redhat.com>, Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>, QEMU Developers <qemu-devel@nongnu.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Michael,

On 4/12/20 11:14 AM, Michael Rolnik wrote:
> hi all.
> 
> are there any news / updates about AVR support?

Aleksandar is not very active on qemu-devel recently, I suppose he is busy.

I have ~15 patches on top of your series, but I'm waiting update on the
status on this target before posting them.

> 
> On Mon, Mar 23, 2020 at 10:14 PM Michael Rolnik <mrolnik@gmail.com
> <mailto:mrolnik@gmail.com>> wrote:
> 
>     thanks Philippe.
> 
>     On Mon, Mar 23, 2020 at 9:20 PM Philippe Mathieu-Daudé
>     <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
> 
>         On 3/23/20 7:03 PM, Richard Henderson wrote:
>         > On 3/23/20 10:03 AM, Michael Rolnik wrote:
>         >> Hi Philippe.
>         >>
>         >> It's been a while. let me think about it and get back to you.
>         what is your
>         >> concern ?
> 
>         We are using this series with Joaquin for a Google Summit of Code
>         project, so we are noticing some bugs and fixing them.
>         As it has not been merged, we work in a fork.
>         Since it was posted on the list, I prefer to ask on the list than
>         directly to you.
> 
>         >
>         > It shouldn't be there.  See commit 1f5c00cfdb81.
> 
>         Ah it has been moved to cpu_common_reset, thanks :)
>         I suppose it is because this port is based on some quite old work.
> 
>         >
>         >>      > +    memset(env->r, 0, sizeof(env->r));
>         >>      > +
>         >>      > +    tlb_flush(cs);
>         >>
>         >>      Why are you calling tlb_flush() here?
>         >
>         >
>         > r~
>         >
> 
> 
> 
>     -- 
>     Best Regards,
>     Michael Rolnik
> 
> 
> 
> -- 
> Best Regards,
> Michael Rolnik

