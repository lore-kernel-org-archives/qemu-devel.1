Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13267C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:50:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D244821D56
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OEYPeuzg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D244821D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j47x3-0001gO-0T
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 13:50:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36475)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j47wK-0001HE-FD
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:49:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j47wJ-0007rP-9K
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:49:48 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36367)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j47wJ-0007qF-3K
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:49:47 -0500
Received: by mail-oi1-x242.google.com with SMTP id c16so21182596oic.3
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 10:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6ndz9R/2Ak+mICgHOUuAFkqW2EslmCysAANW5wyc+i0=;
 b=OEYPeuzg/u9ffkAmlm1Jp8NRqEI99WkLpvE6YCJ+n79GsARgweL2qq7oCgU3JZn/Tr
 g2KCPZU5LlGadCnAaruwk661QkIV7KCdIEtokVVL2nz5ER8B7HGY9NQMj446urvVkNHV
 xBYhPXsZwoItIpCec6oQHQxuMyGtJRYKGgWlp9hwxATdB0tfezXSbh35CdCj7mfj+he5
 5yZfsbRd8g7mGBnx8a21IQqipWUwOT17asBcIipbeKlYlQJjldT2jL7GsYXW4jkiXFYE
 0yryYYXNwh4HZIjcXOFHLnF3xa73hTru6odMa/zzrjnX3g4oymxi1CiVspEv+RnhUlla
 v6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6ndz9R/2Ak+mICgHOUuAFkqW2EslmCysAANW5wyc+i0=;
 b=IJYWzeq33g2yKtuuBi/MByN4mdUZh1W5vU1iD1FhvS65woP/hBekzhNf4PBu7sWkl1
 V+MvSrSHv7jEzPW//qMN3BUjPjkog01I93sotUdh5tBGKt//En0H240O3MhsdXUCwR1u
 tdyb1/q2UW+stu4O4qisvvRH9Ed3hzUXoi1Uh/LULztnCaFouMpE4wFJeT8ww5aDivVo
 vglWTJcooXNEixLT9GeCJO4ODCMmeMqQLHuXt8oWu4i/D+RkSl+WtOhO8tXTZWg44/xn
 BnaWBbsCSBZrH5QPcRoc/2KAD1qoQJRswiNp0hN3NVMfjX+LAKTuUVxSpV8PgdYQ3mP9
 8gzg==
X-Gm-Message-State: APjAAAWhGqpnKRScb3qHq2vpLwokiwM3XjRUrErHmysjhXnl08B900Jt
 NgehwrCnfB+dq11NqDiqXL/WGL/+REpxaLmvgJGmcw==
X-Google-Smtp-Source: APXvYqyVtuGm3F97BkZ9Dz+su/pwUSaiOq3bNc3NwybUJs/P2HmE1EDs0pVB6ZLF87bjbAqQFR1rUjVLZnDpmDFiySk=
X-Received: by 2002:a05:6808:3b2:: with SMTP id
 n18mr2073600oie.146.1582051786092; 
 Tue, 18 Feb 2020 10:49:46 -0800 (PST)
MIME-Version: 1.0
References: <20200218132023.22936-1-philmd@redhat.com>
 <87e06de3-179b-54a1-3451-39a0a30b65f0@weilnetz.de>
In-Reply-To: <87e06de3-179b-54a1-3451-39a0a30b65f0@weilnetz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Feb 2020 18:49:35 +0000
Message-ID: <CAFEAcA9Jr2Yi1K8_9MGUJYt8C=OcKbWDh1UJjTQG1EspLux3JQ@mail.gmail.com>
Subject: Re: [PATCH] Avoid cpu_physical_memory_rw() with a constant is_write
 argument
To: Stefan Weil <sw@weilnetz.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "open list:X86" <xen-devel@lists.xenproject.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Feb 2020 at 17:57, Stefan Weil <sw@weilnetz.de> wrote:
>
> Am 18.02.20 um 14:20 schrieb Philippe Mathieu-Daud=C3=A9:
>
> > This commit was produced with the included Coccinelle script
> > scripts/coccinelle/as-rw-const.patch.
> >
> > Inspired-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > ---
> > Based-on: <20200218112457.22712-1-peter.maydell@linaro.org>
> [...]
> > diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
> > index a8b6e5aeb8..f5971ccc74 100644
> > --- a/target/i386/hax-all.c
> > +++ b/target/i386/hax-all.c
> > @@ -376,8 +376,8 @@ static int hax_handle_fastmmio(CPUArchState *env, s=
truct hax_fastmmio *hft)
> >           *  hft->direction =3D=3D 2: gpa =3D=3D> gpa2
> >           */
> >          uint64_t value;
> > -        cpu_physical_memory_rw(hft->gpa, (uint8_t *) &value, hft->size=
, 0);
> > -        cpu_physical_memory_rw(hft->gpa2, (uint8_t *) &value, hft->siz=
e, 1);
> > +        cpu_physical_memory_read(hft->gpa, (uint8_t *)&value, hft->siz=
e);
> > +        cpu_physical_memory_write(hft->gpa2, (uint8_t *)&value, hft->s=
ize);
>
>
> Maybe those type casts could be removed, too. They are no longer needed
> after your modification.

I think that we should fix the inconsistency where these functions
all take "uint8_t* buf":

 - address_space_rw()
 - address_space_read()
 - address_space_write()
 - address_space_write_rom()
 - cpu_physical_memory_rw()
 - cpu_memory_rw_debug()

but these take void*:
 - cpu_physical_memory_read()
 - cpu_physical_memory_write()
 - address_space_write_cached()
 - address_space_read_cached_slow()
 - address_space_write_cached_slow()
 - pci_dma_read()
 - pci_dma_write()
 - pci_dma_rw()
 - dma_memory_read()
 - dma_memory_write()
 - dma_memory_rw()
 - dma_memory_rw_relaxed()

Depending on which way we go we would either want to remove these
casts, or not.

I guess that we have more cases of 'void*', and that would
certainly be the easier way to convert (otherwise we probably
need to add a bunch of new casts to uint8_t* in various callsites),
but I don't have a strong opinion. Paolo ?

thanks
-- PMM

