Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C0FC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 16:58:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D49E2073B
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 16:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CmOJv2bb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D49E2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jctxh-0001Fr-8B
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 12:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jctx1-0000oz-9m
 for qemu-devel@nongnu.org; Sun, 24 May 2020 12:58:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22775
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jctwz-0000Os-Qu
 for qemu-devel@nongnu.org; Sun, 24 May 2020 12:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590339492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SlMaaUy6qyvr76YHRph29KaF3pnRBrCzvTgkLoAeYeA=;
 b=CmOJv2bbtj7KeMZUo/+CL99r0+FMD1zR1/WuPH3PRk63A5Ni/1mpgLOMIvt94KroD9tlwo
 ZB1p9RHt3eMps2qLmfnoV/AiUwtDVpVDZfP4TDamM9RwXZzqzPgU5AS/zNkaKFvPXCLGqk
 sE3iVG8UPbln/VRKB1ggoK/+rhstyVg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-nbh27r29MguBSErUZAJqmQ-1; Sun, 24 May 2020 12:58:03 -0400
X-MC-Unique: nbh27r29MguBSErUZAJqmQ-1
Received: by mail-wr1-f72.google.com with SMTP id p8so7066724wrj.5
 for <qemu-devel@nongnu.org>; Sun, 24 May 2020 09:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=SlMaaUy6qyvr76YHRph29KaF3pnRBrCzvTgkLoAeYeA=;
 b=UtfPjXFvJIcyLmCVcb6svoi1phsqJbCrRLN6ip4cyUnSZADiFLDAUUe7KAwDg865p5
 oWHKs2uwVliCium9JIJfftyGVi0O29PFd853WG0j2IRLliWI1kkSI50h7LYZTetZ+car
 4hlXZzz0uUWa0W/nbSecC7Xt+JJWlTtpdrMAGHahcMnWxX9U66Bl2tyK4wn/W1lZEgT8
 K101FnfQeMZ6Wq3l/gPZ1qTzggI6jCeu0duo6ipWqo/OwE+kVTc9LI64468Nv196GIKB
 6O2TKFJiJ2gOqqVNcYhL+/g2f0a5t0VOitzDSQfX/P9lAxU6nLBRqjAa9bz1uaQPj73K
 1uZQ==
X-Gm-Message-State: AOAM530oQTPKph+WY4pW9Kq9cy9i0K58LrlHcfuKSOuaaWf9wSc2+04X
 cSftLCYCYwMQ8JIk1tTn7QlcQ/tE1pqFYIcZWsNe5gSpwyOjmCCgdljXs3fmX5vXdTTZ1+k6lo3
 kK3uLCNtCT2YWHpg=
X-Received: by 2002:a1c:5a86:: with SMTP id o128mr17631241wmb.77.1590339481955; 
 Sun, 24 May 2020 09:58:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+tl0V6CM3htFuoy8dYP6/tPHHJBCCiqq5rvwZuPg9JZYcWX80XFqIH+hYbJrbLfFLFmdHsA==
X-Received: by 2002:a1c:5a86:: with SMTP id o128mr17631228wmb.77.1590339481764; 
 Sun, 24 May 2020 09:58:01 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id h27sm4034438wrb.18.2020.05.24.09.58.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 May 2020 09:58:01 -0700 (PDT)
Subject: Re: [PATCH 0/7] hw/misc/empty_slot: Spring cleaning
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200510152840.13558-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <2906ea36-d6c4-f05b-3242-d9380986d48c@redhat.com>
Date: Sun, 24 May 2020 18:58:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200510152840.13558-1-f4bug@amsat.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/24 12:39:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping?

On 5/10/20 5:28 PM, Philippe Mathieu-Daudé wrote:
> New Spring, new opportunity to clean this device :)
> (v1 was in 2018, v2 in 2019).
> 
> - lower device priority
> - follow qdev model and use properties
> - convert to trace events
> - describe with slot name
> - move under hw/misc/ and cover in MAINTAINERS
> 
> Peter, I hope you are OK adding it wit UNIMP device,
> as both are very similar, and don't have much activity.
> 
> Only MIPS/SPARC32 targets use this device.
> 
> v2: https://www.mail-archive.com/qemu-devel@nongnu.org/msg626498.html
> v1: https://www.mail-archive.com/qemu-devel@nongnu.org/msg564060.html
> 
> Philippe Mathieu-Daudé (7):
>   hw/sparc/sun4m: Use UnimplementedDevice for I/O devices
>   hw/misc/empty_slot: Lower address space priority
>   hw/misc/empty_slot: Convert 'size' field as qdev property
>   hw/misc/empty_slot: Add a 'name' qdev property
>   hw/misc/empty_slot: Convert debug printf() to trace event
>   hw/misc/empty_slot: Move the 'hw/misc' and cover in MAINTAINERS
>   hw/misc/empty_slot: Name the slots when created
> 
>  include/hw/empty_slot.h        |  9 -------
>  include/hw/misc/empty_slot.h   | 19 ++++++++++++++
>  hw/mips/mips_malta.c           |  4 +--
>  hw/{core => misc}/empty_slot.c | 47 +++++++++++++++++++---------------
>  hw/sparc/sun4m.c               | 23 +++++++++++------
>  MAINTAINERS                    |  4 ++-
>  hw/core/Makefile.objs          |  1 -
>  hw/misc/Makefile.objs          |  1 +
>  hw/misc/trace-events           |  4 +++
>  9 files changed, 70 insertions(+), 42 deletions(-)
>  delete mode 100644 include/hw/empty_slot.h
>  create mode 100644 include/hw/misc/empty_slot.h
>  rename hw/{core => misc}/empty_slot.c (66%)
> 


