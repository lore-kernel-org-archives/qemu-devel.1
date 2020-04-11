Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93640C2BA2B
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 17:31:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C6C02075E
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 17:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sYkEnLLD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C6C02075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNJyR-0002rL-H9
	for qemu-devel@archiver.kernel.org; Sat, 11 Apr 2020 13:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNJxh-0002Q1-Kp
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 13:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNJxg-0005qd-NE
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 13:30:33 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39059)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNJxg-0005pz-HM
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 13:30:32 -0400
Received: by mail-wr1-x442.google.com with SMTP id p10so5661351wrt.6
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2020 10:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6smO96cYDK7ymly+Tzo8lGnfOSJDs8tsQNZfvLm+WUs=;
 b=sYkEnLLDnm1PuoB3onYbVcmiLlp8XiL0t0Cm3grUVan/SGgarF89I8JMch1U6X+gaB
 zpcJ1O0OZgVO3bpkRkB+e8S10VfdaXTgROyS1m7U/Ki95zzlA8ZuupRWwIPwKNDsppPr
 MNboMGXklLinA7FGU/3UxAviobCJNNCBtv7QQcD/Wx4TSnvK3ZygWxuPQ1UonEZqsYO7
 ZsbSD5pCvNSB28bvV3oqeKMXmfUd/yl999+5f7wWM/N2qVq3sGgqLipEl8q80DDDXYBh
 ufte10OKkykLBTtcruOVdj8xWD3wGUbCWWjnSU1tSYZU36WktvNyKYeUq1SNj9bpAtnX
 UUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=6smO96cYDK7ymly+Tzo8lGnfOSJDs8tsQNZfvLm+WUs=;
 b=kSZLwm5hbfYM7SLjhckTHP6/ZmivKzNUzgmFqdg9+DDQ0L3JK5tFwOxI8FpMhSoRvj
 vbr/Ecmqz+KRwJ5UCRaSvVWcuA2Pyhqcfnd54cQ6XpWW9OpXfsn1DA67c1tHOAg3Ix+t
 DiDEuwINZPxczHCnrTVMIka+BFzR99HX5RJhpZ82+AC/tySTSRyqKmcOtgyVOhcKeOtk
 CtgIPhHLBigXFUxWfaSpvWojQ0LkCq/XLzSZkC97HPueJEmJOwgR7W0ZDSXPzGSrou0y
 WseQWTIEwJg9zgVJr2HfHApOsxeDR8W6FDtmozbUbUuKy9/Sol4HqlkBsAih2DLicz8v
 MamA==
X-Gm-Message-State: AGi0PuZ0QUPGT+kCaTYNn7UYtgLj37Vsd3a14jHS+B5iWFF/0kkDZXVr
 9Q0EqLsVsIlS6PLcXJl+Uzc=
X-Google-Smtp-Source: APiQypIsbS47UKyKpDaX1C9nvEuR7bE9L1yWZZ/aOh0wibdPAa+TE3J6VxSV4+zR/aDau7Axazte3g==
X-Received: by 2002:adf:f5c5:: with SMTP id k5mr11354243wrp.403.1586626231203; 
 Sat, 11 Apr 2020 10:30:31 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id k133sm7999970wma.0.2020.04.11.10.30.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Apr 2020 10:30:30 -0700 (PDT)
Subject: Re: [PATCH 0/7] hw/sparc/leon3: Few fixes and disable HelenOS test
To: qemu-devel@nongnu.org
References: <20200331105048.27989-1-f4bug@amsat.org>
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
Message-ID: <81737d76-06c6-4c83-1287-b0d14db4ce2f@amsat.org>
Date: Sat, 11 Apr 2020 19:30:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200331105048.27989-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, Jiri Gaisler <jiri@gaisler.se>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/31/20 12:50 PM, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (7):
>   hw/misc/grlib_ahb_apb_pnp: Avoid crash when writing to AHB PnP
>     registers
>   hw/misc/grlib_ahb_apb_pnp: Fix AHB PnP 8-bit accesses

Ping ^^^ for 5.0?

>   hw/misc/grlib_ahb_apb_pnp: Add trace events on read accesses
>   hw/timer/grlib_gptimer: Display frequency in decimal
>   target/sparc/int32_helper: Remove DEBUG_PCALL definition
>   target/sparc/int32_helper: Extract and use excp_name_str()
> 
>  hw/misc/grlib_ahb_apb_pnp.c             | 24 ++++++++++++++++++++++--
>  target/sparc/int32_helper.c             | 23 ++++++++++++-----------
>  hw/misc/trace-events                    |  4 ++++
>  hw/timer/trace-events                   |  2 +-
>  tests/acceptance/machine_sparc_leon3.py |  4 ++++
>  5 files changed, 43 insertions(+), 14 deletions(-)
> 

