Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A427C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 20:48:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16C2E2073B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 20:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhqnFAg3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16C2E2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iemQw-0002f2-TK
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 15:48:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iemPz-0001uv-C4
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 15:47:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iemPy-0008Az-6v
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 15:47:39 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39659)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iemPy-0008Al-2V
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 15:47:38 -0500
Received: by mail-oi1-x243.google.com with SMTP id a67so11154032oib.6
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 12:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=AeBQEsADmybiYKhX8VsW5czdDjhnU10eSR69iRn/+LM=;
 b=EhqnFAg3gV5K2q/6UUYY0qHQcZoqIOaz0VW4cUAnSq4P4skaNlNpMkW337XskRC2Vj
 wLewav7g+19wf5vkPm9nfHdwF1Hw80nEF7RtvYi1cSozMqwuOiiM6H1mCqtLaSYULkxd
 8Kb9hOPY2WcjhCF1dhu8KKci61mEn/ofVPn+IpqRWvBD3r2HsIzClslvp/WzUhfPDwXW
 AFwZqtqJXHMU36AGQHtnZ2Pl8FE9HBgRctVLePv2TpRWyFCKlr4P7KOjnABju3zADUme
 mu4U1dRtJFWmiiLCraZDbuDU6WV6JdDzjWhYnWBuwBJGjkEE7qUjXIJKCzCZ36Tes1lJ
 uXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=AeBQEsADmybiYKhX8VsW5czdDjhnU10eSR69iRn/+LM=;
 b=dWkQmHmbMqQMHXhdUMz9knnV4X7DE3wSQkq918WtrXuUVorgtzQZSVX/feS/O/ggbz
 Wq0DpOl3vvlDzYc+R+aPxp4Fu6NDJrg8By3WRs4FsDgf3pqC/xqKynPTAuLpqXCwuow3
 xq/c09MKeeJ7v7v4rHkd5/UUbKSDJ7jpk3G8EAc8B2pgEkiLNgnAiF5edt8y4SWP7EN3
 t5NQ2OaPP3LFlu9jcMn3rcatwFt8VK2438i4rTsh8EJ0aPjAHGtQP8Gwe/Bn1iV+fKUL
 MLJ8ig6QUh/ldKUrs9qnktwYB6XRS9HvHQyb4ZY0FgGRowaieijQIGw2AIju1ccUBhci
 w8JA==
X-Gm-Message-State: APjAAAVwJmEazoKODxcyyWt5n6C6NeIs4DZjQUnnzwIcocKW41iDSXy3
 Bu0mleU+P0OLbt0fOhyKjpzHP6OPxdhDOkBDu+U=
X-Google-Smtp-Source: APXvYqwPSqKinUC2ZtFmEvFH5iNQ1PhQOIyQBX/RoeLq+A6dO3HIiCqvOqISTPH6vawkO4cAG87UF4oztju9nN5/uqA=
X-Received: by 2002:a05:6808:64e:: with SMTP id
 z14mr729123oih.79.1576010857188; 
 Tue, 10 Dec 2019 12:47:37 -0800 (PST)
MIME-Version: 1.0
References: <20191208183922.13757-1-mrolnik@gmail.com>
 <20191208183922.13757-18-mrolnik@gmail.com>
 <CAL1e-=guE3xT3n2P5j0=UVoVDw8WKqbK02=otf+Pf90Mi8hfmQ@mail.gmail.com>
 <CAK4993i16R-HUb+cKRGhQ3NsXtWgmcbLmOLDDxT5vEkj-fehaw@mail.gmail.com>
In-Reply-To: <CAK4993i16R-HUb+cKRGhQ3NsXtWgmcbLmOLDDxT5vEkj-fehaw@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 10 Dec 2019 21:47:26 +0100
Message-ID: <CAL1e-=hL_MQCb9B1Y2Qcprm9ShhuvRLa=X3NpLxQ6G0brTmGKA@mail.gmail.com>
Subject: Re: [PATCH v38 17/22] target/avr: Register AVR support with the rest
 of QEMU
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "me@xcancerberox.com.ar" <me@xcancerberox.com.ar>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Dec 9, 2019 at 7:31 PM Michael Rolnik <mrolnik@gmail.com> wrote:
>
> I prefer to remove it, as nobody uses it. what do you think? the full lis=
t is in target/avr/cpu.h file
>

I have mixed filings about that.

I can just imagine someone in future might make a "superassembler"
that uses this header, and than avr info would be than missing if you
delete this hunk...

But I don't have a strong preference.

Thanks,
Aleksandar

> On Mon, Dec 9, 2019 at 8:16 PM Aleksandar Markovic <aleksandar.m.mail@gma=
il.com> wrote:
>>
>>
>>
>> On Sunday, December 8, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:
>>>
>>> Add AVR related definitions into QEMU
>>>
>>> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
>>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>>> ---
>>>  qapi/machine.json          | 3 ++-
>>>  include/disas/dis-asm.h    | 6 ++++++
>>>  include/sysemu/arch_init.h | 1 +
>>>  arch_init.c                | 2 ++
>>>  4 files changed, 11 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/qapi/machine.json b/qapi/machine.json
>>> index ca26779f1a..8c6df54921 100644
>>> --- a/qapi/machine.json
>>> +++ b/qapi/machine.json
>>> @@ -21,11 +21,12 @@
>>>  #        is true even for "qemu-system-x86_64".
>>>  #
>>>  # ppcemb: dropped in 3.1
>>> +# avr: since 5.0
>>>  #
>>>  # Since: 3.0
>>>  ##
>>>  { 'enum' : 'SysEmuTarget',
>>> -  'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32'=
,
>>> +  'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'cris', 'hppa', 'i386',=
 'lm32',
>>>
>>>               'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
>>>               'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
>>>               'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
>>> diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
>>> index e9c7dd8eb4..8bedce17ac 100644
>>> --- a/include/disas/dis-asm.h
>>> +++ b/include/disas/dis-asm.h
>>> @@ -211,6 +211,12 @@ enum bfd_architecture
>>>  #define bfd_mach_m32r          0  /* backwards compatibility */
>>>    bfd_arch_mn10200,    /* Matsushita MN10200 */
>>>    bfd_arch_mn10300,    /* Matsushita MN10300 */
>>> +  bfd_arch_avr,       /* Atmel AVR microcontrollers.  */
>>> +#define bfd_mach_avr1          1
>>> +#define bfd_mach_avr2          2
>>> +#define bfd_mach_avr3          3
>>> +#define bfd_mach_avr4          4
>>> +#define bfd_mach_avr5          5
>>
>>
>> Incomplete list. I already explained why in reply to v37.
>>
>>
>>>
>>>    bfd_arch_cris,       /* Axis CRIS */
>>>  #define bfd_mach_cris_v0_v10   255
>>>  #define bfd_mach_cris_v32      32
>>> diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
>>> index 62c6fe4cf1..893df26ce2 100644
>>> --- a/include/sysemu/arch_init.h
>>> +++ b/include/sysemu/arch_init.h
>>> @@ -24,6 +24,7 @@ enum {
>>>      QEMU_ARCH_NIOS2 =3D (1 << 17),
>>>      QEMU_ARCH_HPPA =3D (1 << 18),
>>>      QEMU_ARCH_RISCV =3D (1 << 19),
>>> +    QEMU_ARCH_AVR =3D (1 << 20),
>>>  };
>>>
>>>  extern const uint32_t arch_type;
>>> diff --git a/arch_init.c b/arch_init.c
>>> index 705d0b94ad..6a741165b2 100644
>>> --- a/arch_init.c
>>> +++ b/arch_init.c
>>> @@ -89,6 +89,8 @@ int graphic_depth =3D 32;
>>>  #define QEMU_ARCH QEMU_ARCH_UNICORE32
>>>  #elif defined(TARGET_XTENSA)
>>>  #define QEMU_ARCH QEMU_ARCH_XTENSA
>>> +#elif defined(TARGET_AVR)
>>> +#define QEMU_ARCH QEMU_ARCH_AVR
>>>  #endif
>>>
>>>  const uint32_t arch_type =3D QEMU_ARCH;
>>> --
>>> 2.17.2 (Apple Git-113)
>>>
>
>
> --
> Best Regards,
> Michael Rolnik

