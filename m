Return-Path: <SRS0=UCRd=3I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EBEC33CAF
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 22:51:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A5920678
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 22:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAcwQdlU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A5920678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itJQ2-0008Fk-Sj
	for qemu-devel@archiver.kernel.org; Sun, 19 Jan 2020 17:51:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53394)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itJPH-0007q1-3X
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 17:51:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itJPF-00037Q-MC
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 17:50:58 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35280)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itJPF-000376-GD
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 17:50:57 -0500
Received: by mail-wm1-x344.google.com with SMTP id p17so12903490wmb.0
 for <qemu-devel@nongnu.org>; Sun, 19 Jan 2020 14:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RN5ZTGuu7dEC8iHjgdUH2rCVo5Mz9f02X+w7V3jHfCU=;
 b=AAcwQdlUj/MN7FHSKNMcx9A2kaMMfgbA2/vkwpLZHcnNTYnqjMCFVFGlUpIC4BwVZP
 0otAasdO6SfK6BqgWIpRAmYnnPqIMt/Goom1o7VNF/2VVjVs4YynI5aqIfq21uVuMu6Q
 1Ikvh79i3VZ6p92wUpF10Hwe0UC8yurB46hMmfavvN89/gXTksRn/M15Z1bU/Q8CHPkE
 SGSVAPJry5afPOKqjFgq9TL8tEtjFhabmV6d+l1+aLl2lxFdMxlyJomB+XukMYlSL9M3
 VZOYF+i4hr0KNDzF7MmBeXvbD+ehsylJpRajo2WSEM7ZZGDrzig6Q/a+X0m3P/jVwwdR
 Qq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=RN5ZTGuu7dEC8iHjgdUH2rCVo5Mz9f02X+w7V3jHfCU=;
 b=lY490DyesTYP8lqG6ERCKunZQotdfnmsGCc40o3NXSx1JRWRlT2lnt6IgdpYE1ZZ3U
 RCokNSxFO01WWP/DVBR8d37zPaIzsQ70bKUjZEQnePYpEvUFOC2KogF+T/HB3pke3VHt
 Jd5IFy6NvLX95QUCEKxDccEZ+/25uKC9cJfeiuakV83/RpKoE6vGMgq6ArL6IYObZrn3
 gX26i/cgvmdHY6J6xmEdoNT/vaQRIQ9sE76sP86g4UbzmwRD4q5jlICSKTuwzKqYpy0b
 7rKXmdXvSxr7uMd/SOnIeMLmcbSMW3poDZg/rpWrVjdLFADAPmidz8NmXa5aDtm889J5
 liTA==
X-Gm-Message-State: APjAAAWIAjEqR9S3VeOHNzbVfgArrMDtcPW8Qs8/J6NGREY/LTyounq4
 IL2Cyva4mT7QI4FJsqEvCqs=
X-Google-Smtp-Source: APXvYqzSV1V+rdnLIPk+Vj2lmAmwT+sTMGM20oqvoX/oBxSAHTHIQSAaE8LQqZHRHK+b2P7wu978xw==
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr15787660wmk.172.1579474255525; 
 Sun, 19 Jan 2020 14:50:55 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id m10sm45380528wrx.19.2020.01.19.14.50.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Jan 2020 14:50:54 -0800 (PST)
Subject: Re: [PATCH v3 0/8] hw/avr: Introduce the Arduino boards
To: Michael Rolnik <mrolnik@gmail.com>
References: <20191229224505.24466-1-f4bug@amsat.org>
 <CAK4993jswyYwanXZ4G4y4XwJ6nrtSLXZjvsE+LK+KRJASpe9Kw@mail.gmail.com>
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
Message-ID: <c6d7f25d-b74c-a29f-14e8-885659262bdf@amsat.org>
Date: Sun, 19 Jan 2020 23:50:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAK4993jswyYwanXZ4G4y4XwJ6nrtSLXZjvsE+LK+KRJASpe9Kw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sarah Harris <S.E.Harris@kent.ac.uk>, QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Michael,

On 12/30/19 7:17 PM, Michael Rolnik wrote:
> Hi Philippe.
> 
> Thank you for joining the effort.

Could you test this series?

Are you OK if we use the Arduino machines it introduces to replace your
'sample' board?

> Regards,
> Michael Rolnik
> 
> 
> On Mon, Dec 30, 2019 at 12:45 AM Philippe Mathieu-Daudé <f4bug@amsat.org
> <mailto:f4bug@amsat.org>> wrote:
> 
>     Hi,
> 
>     This series add the arduino boards, aiming at removing the
>     'sample' board that doesn't follow any specification.
> 
>     Since v2:
>     - rebased on Michael's v40
> 
>     Since v1:
>     - Addressed Igor comments
>     - Addressed Aleksandar comments
>     - Fixed UART issue (was due to IRQ shifted by 2 in CPU)
> 
>     TODO after merge is:
>     - Extract Timer8 common parts from Timer16
>     - Add GPIOs
>     - Connect LED to GPIO on Arduino
>     - Plug to Scratch (See http://s4a.cat/).
>       (I plan to purpose that as a GSoC idea).
> 
>     Michael, thank you for having insisted with this port during so long!
> 
>     Regards,
> 
>     Phil.
> 
>     Series available at https://gitlab.com/philmd/qemu/commits/arduino-v3
> 
>     Regards,
> 
>     Phil.
> 
>     Based-on: <20191229215158.5788-1-mrolnik@gmail.com
>     <mailto:20191229215158.5788-1-mrolnik@gmail.com>>
>     https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg05309.html
> 
>     Philippe Mathieu-Daudé (8):
>       hw/char/avr: Reduce USART I/O size
>       hw/timer/avr_timer16: Rename memory region debugging name
>       hw/avr: Add some ATmega microcontrollers
>       hw/avr: Add some Arduino boards
>       tests/boot-serial-test: Test some Arduino boards (AVR based)
>       tests/acceptance: Do not set the machine type manually
>       tests/acceptance: Keep multilines comment consistent with other tests
>       tests/acceptance: Test the Arduino MEGA2560 board
> 
>      hw/avr/atmega.h                  |  48 ++++
>      hw/avr/arduino.c                 | 177 ++++++++++++
>      hw/avr/atmega.c                  | 464 +++++++++++++++++++++++++++++++
>      hw/char/avr_usart.c              |   2 +-
>      hw/timer/avr_timer16.c           |   6 +-
>      tests/boot-serial-test.c         |   2 +
>      hw/avr/Makefile.objs             |   2 +
>      tests/acceptance/machine_avr6.py |  11 +-
>      8 files changed, 701 insertions(+), 11 deletions(-)
>      create mode 100644 hw/avr/atmega.h
>      create mode 100644 hw/avr/arduino.c
>      create mode 100644 hw/avr/atmega.c
> 
>     -- 
>     2.21.0
> 
> 
> 
> -- 
> Best Regards,
> Michael Rolnik

