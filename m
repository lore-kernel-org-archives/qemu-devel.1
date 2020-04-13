Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD2EC2BA2B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 21:08:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 555FD206DA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 21:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3eI6SYC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 555FD206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO6JS-0006Pz-I3
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 17:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37451)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO6Ii-0005yd-LO
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 17:07:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO6Ih-0007sl-AY
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 17:07:28 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:33701)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO6Ih-0007sQ-4B
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 17:07:27 -0400
Received: by mail-ed1-x543.google.com with SMTP id j20so1510268edj.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2020 14:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WX32p4HM3SR+ZKiycaCqnP/PPUeQog7dj0foy6QeV5Y=;
 b=K3eI6SYCzpOYGSkG3ffn8RonTbRnoyBw88clGAGd4s4qOt5lyvqWnuQMvQbkk8fmvj
 6/MHpnhl+qyM7PN9IALw/YjghGU48iWNIHmtw9WlWl+WLq/Qv6aHasAy9HLbbBS5IDgQ
 J1RILOywbgJR3QuI47oeWkoUikTp7vCvLgyElLYELZFk2ZALS1DG7+c6cNTiIhcGnWzi
 9G2EpgoVngAe0Hq2VIlRI4PTo1oYFITPnGCEudJ9j1+5MAeqaDWCABK1/TpDXTEVVIW1
 ULRlEYI+fgaRxqDEq6kevsQqwOeUsku0CKoqj+9+RTeXkUfDqWXlVeVqOaS1OEuIPw7B
 t5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=WX32p4HM3SR+ZKiycaCqnP/PPUeQog7dj0foy6QeV5Y=;
 b=YTjPvi6yEeWZTapYvUoczrisAO2O6t5MLePupXnLHsOy0lR3FqE+0loeGdv53WiT2k
 L037Sd0dZd01MktGBBnlQRCZ8xB3uRN9Vnr8MK8t1Yg9nHSg/hpe2DHnhDASm2wZ8bcJ
 NBzsLrAZSpP8j4oHhI46TRhko6wRGySJY7XMd42qZ4EDP08pTX6dxiNg1/T0Px1aVp0t
 fBe/HrzKiYPtOcyaVF/Mcm3iXzJl4gKwZK5EkOB3uvPYtGSE+6HO5LQbDIEeKCYYE14g
 BcgYMPt4hq97h6IUL5QL5ixBvDKmQa5sddSPEsrbToMDt2njvqXctz1NuVtGcVPoctqK
 HOzg==
X-Gm-Message-State: AGi0PuZ2dcC3FIfTGPVvUEFfY85E0lRb0GtI2LNZHIHqfUyYo62A1dkb
 gM7clnv+5YCLAZzLdpwFHis=
X-Google-Smtp-Source: APiQypKNMzv2wTQpk4n8JtuMQyADNwptd/Ek5dvh0/sViNrX5Rz6Fk47ZBYtFnRwvd1iEXfHvks58Q==
X-Received: by 2002:aa7:c681:: with SMTP id n1mr18106927edq.83.1586812046021; 
 Mon, 13 Apr 2020 14:07:26 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id m22sm848938edr.43.2020.04.13.14.07.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2020 14:07:24 -0700 (PDT)
Subject: Re: [PATCH 0/7] hw/sparc/leon3: Few fixes and disable HelenOS test
To: KONRAD Frederic <frederic.konrad@adacore.com>, qemu-devel@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20200331105048.27989-1-f4bug@amsat.org>
 <81737d76-06c6-4c83-1287-b0d14db4ce2f@amsat.org>
 <989bf2f5-0e23-f9c3-e9e1-0bd8c03f3231@adacore.com>
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
Message-ID: <1b7a4c63-5a31-6efe-d807-7092e3ee0ffb@amsat.org>
Date: Mon, 13 Apr 2020 23:07:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <989bf2f5-0e23-f9c3-e9e1-0bd8c03f3231@adacore.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::543
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
 Fabien Chouteau <chouteau@adacore.com>, Jiri Gaisler <jiri@gaisler.se>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Cc'ing Peter]

On 4/13/20 12:12 PM, KONRAD Frederic wrote:
> Le 4/11/20 à 7:30 PM, Philippe Mathieu-Daudé a écrit :
>> On 3/31/20 12:50 PM, Philippe Mathieu-Daudé wrote:
>>> Philippe Mathieu-Daudé (7):
>>>    hw/misc/grlib_ahb_apb_pnp: Avoid crash when writing to AHB PnP
>>>      registers
>>>    hw/misc/grlib_ahb_apb_pnp: Fix AHB PnP 8-bit accesses
>>
>> Ping ^^^ for 5.0?
> 
> Hi Philippe,
> 
> You already have my rb tag for those one, and IMHO they should be good
> candidate
> for 5.0 (if it's not too late).

Yes, thanks for the reviews. I see Mark Cave-Ayland merged this file
first, but you are listed as maintainer :) I was hoping you could send a
pull request.

$ scripts/get_maintainer.pl -f hw/misc/grlib_ahb_apb_pnp.c
Fabien Chouteau <chouteau@adacore.com> (maintainer:Leon3)
KONRAD Frederic <frederic.konrad@adacore.com> (maintainer:Leon3)
qemu-devel@nongnu.org (open list:All patches CC here)

This is a bug but not 'security critical', so it might wait 5.1 and go
via qemu-trivial tree.

Regards,

Phil.

> 
> Cheers,
> Fred
> 
>>
>>>    hw/misc/grlib_ahb_apb_pnp: Add trace events on read accesses
>>>    hw/timer/grlib_gptimer: Display frequency in decimal
>>>    target/sparc/int32_helper: Remove DEBUG_PCALL definition
>>>    target/sparc/int32_helper: Extract and use excp_name_str()
>>>
>>>   hw/misc/grlib_ahb_apb_pnp.c             | 24 ++++++++++++++++++++++--
>>>   target/sparc/int32_helper.c             | 23 ++++++++++++-----------
>>>   hw/misc/trace-events                    |  4 ++++
>>>   hw/timer/trace-events                   |  2 +-
>>>   tests/acceptance/machine_sparc_leon3.py |  4 ++++
>>>   5 files changed, 43 insertions(+), 14 deletions(-)
>>>
> 

