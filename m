Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6E6C4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 09:23:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9896E2076B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 09:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QEC4tPf+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9896E2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLjwX-0003Qy-Ca
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 05:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kLjvz-00030j-3J
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 05:22:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58432)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kLjvx-0000eP-96
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 05:22:30 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601025748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zjsD4DMXC6loTgnpeXVOyAJu+Zr/FKzSVkfEe4i71dM=;
 b=QEC4tPf+X0CuHtKCTq1ch60Hqg6oF6Cqwuwyj0WOaoJWgu4GQ8fSgAji50EUfF+HeVA+dw
 OIn1VyGlY+Fpf4ZvIrORA6a4gOMGmNV5YtG0AEFRgs588yp9nZzkIL1ZlSvT5j0b39uvKD
 ZCeu3ymjxgWGmsBCHuytmTUO2TydyWc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-Jlb5gy7WOMCmNRtxYt0AzA-1; Fri, 25 Sep 2020 05:22:23 -0400
X-MC-Unique: Jlb5gy7WOMCmNRtxYt0AzA-1
Received: by mail-wm1-f69.google.com with SMTP id t8so608407wmj.6
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 02:22:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=zjsD4DMXC6loTgnpeXVOyAJu+Zr/FKzSVkfEe4i71dM=;
 b=VnMLg0rxZsIJEahMABuVPJJl/ujJHyqKcNae/o0EGyOwqn9qTigbbNUrPqw7RDtO/J
 X/EfJey0lSUbScbtcvaYU/5hzKsZUZrqoA/IDz/K5Mr9dOyhPP3UQyIE4J7mzUa5kest
 uSj0lILNWcu7qcKEEdZ4DjFpEZrYfTUHDxY0QZCLnWR0FWCZV3qj9NbnSPq5sLAJwmec
 qZ56v4jcGkkSSWrN074RLv7+4N2NzIyZkw7g6rN/bOVGeK6234nABmBInIR3Pk6QP94i
 gpuph4FnCyJHkh4xrod8pgUdDRp7CrrO+Qno/A5S8Hm44kCeYE0udfwBNmxvS7zjOe/t
 vgCQ==
X-Gm-Message-State: AOAM531yG1zT7ZESs9VFQg6hQaNejvLxVTMK49128gg4qx/aW8cPNlKV
 KudTv4DK2iqjTddyAlarpPA74wU5nuAi99XWUse1ndQde8L/bFzXPYY348v3U3b/E0CC5z+rSS2
 tie+gPmyYgzO8WfY=
X-Received: by 2002:adf:f701:: with SMTP id r1mr3415547wrp.341.1601025742631; 
 Fri, 25 Sep 2020 02:22:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNp4E7SxWS9PhLpqcIkijCrS1NjQDPE9ht4sGPfqIbeO9nYoOSRe6Hy9tjxqgOm+LuV3oLPQ==
X-Received: by 2002:adf:f701:: with SMTP id r1mr3415519wrp.341.1601025742348; 
 Fri, 25 Sep 2020 02:22:22 -0700 (PDT)
Received: from [192.168.1.34] (234.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.234])
 by smtp.gmail.com with ESMTPSA id u8sm2087372wmj.45.2020.09.25.02.22.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 02:22:21 -0700 (PDT)
Subject: Re: [PATCH 4/4] qemu/bswap: Remove <byteswap.h> dependency
To: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20200923100220.674903-1-philmd@redhat.com>
 <20200923100220.674903-5-philmd@redhat.com>
 <CAFEAcA9XOpCyWr0QXn6T_y9nh4ZX5Op2ztonefr-pV2oQfU3iw@mail.gmail.com>
 <fd8a9c3e-45f2-caae-25ab-5e1365fd9298@redhat.com>
 <2a2cc60d-2d30-eb38-369e-0a26f0eac9bd@linaro.org>
 <CAFEAcA-+ssh05EdeYLSoF=m8Yvg_ENoChrV6vT6H=NVSPUPFAw@mail.gmail.com>
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
Message-ID: <70564f81-d2a6-9bad-b761-40e0d5c69961@redhat.com>
Date: Fri, 25 Sep 2020 11:22:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-+ssh05EdeYLSoF=m8Yvg_ENoChrV6vT6H=NVSPUPFAw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Alexander von Gluck IV <kallisti5@unixzen.com>,
 Ed Maste <emaste@freebsd.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/24/20 9:33 PM, Peter Maydell wrote:
> On Thu, 24 Sep 2020 at 20:30, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 9/23/20 3:30 AM, Philippe Mathieu-Daudé wrote:
>>> On 9/23/20 12:16 PM, Peter Maydell wrote:
>>>> I suppose if we wanted to just use the __builtin_bswap*
>>>> implementation on all hosts (ie drop the special casing
>>>> of CONFIG_MACHINE_BSWAP_H/FreeBSD/Haiku) we'd need to
>>>> rename our macros to avoid potential conflicts with the
>>>> versions in the system headers there in case they were
>>>> pulled in via some other path ?
>>>
>>> Yes, this is why I couldn't get ride of everything
>>>
>>> After reading Paolo's suggestion to use qatomic*, I
>>> am tempted to suggest qbswap* but I am still looking
>>> for better alternatives...
>>
>> Hum, maybe.  It's pretty ugly.  We could just leave those alone and hope the
>> system version is decent enough.
> 
> Mostly what I would like is to be able to be rid of the
> configure machinery so we could just use a single
> portable implementation.

Good news. Using the Haiku image provided by Alexander,
GCC is pretty recent and supports builtin atomic:

> uname -a
Haiku shredder 1 hrev54154+115 Jun 30 2020 15:20 x86_64 x86_64 Haiku
> gcc --version
gcc (2019_05_24) 8.3.0
Copyright (C) 2018 Free Software Foundation, Inc.

The <endian.h> include (/system/develop/headers/posix/endian.h)
only defines BYTE_ORDER.

Looking at FreeBSD, bswap*() are defined as macro:
https://github.com/freebsd/freebsd/blob/master/sys/sys/endian.h#L58
So we could eventually undefine them... but the manpage
describe them as functions [*]:

DESCRIPTION
    The bswap16(), bswap32(), and bswap64() functions return
    a byte order swapped integer.

So theoretically they could change the prototype still respecting
the documentation contract, and undefines wouldn't work anymore.

Would this be acceptable? Any clever idea?

[*] https://www.freebsd.org/cgi/man.cgi?query=bswap32&apropos=0&sektion=9

> 
> thanks
> -- PMM
> 


