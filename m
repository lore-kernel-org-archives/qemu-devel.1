Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771A2C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 10:54:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 426C82068F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 10:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQ7MKaVa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 426C82068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxTR9-0001NX-HW
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 06:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jxTQJ-0000qF-C8
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 06:53:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44880
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jxTQH-0007JI-2n
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 06:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595242407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GLYPXR7iusazP8bNYPPjCm2qXnuRGI2hMdpr81EZjbo=;
 b=QQ7MKaVauGuqbzsC/t3WtklaO5sgBFP1+hQ5UjT8MAur7zcujmb4L3QPtFP8jeSSekvAwK
 NoYzws7k45dPjvlvdOoXZcerkrgoci1WiucpzgwHmNiVat8pQe3FKMjFmFXfCTgQr/3jPR
 Z34LXH7EZSJry5c7KGq6B6Grcq95UwU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-ZTu1yn93OEq0C1yDCBDSnw-1; Mon, 20 Jul 2020 06:53:24 -0400
X-MC-Unique: ZTu1yn93OEq0C1yDCBDSnw-1
Received: by mail-wr1-f72.google.com with SMTP id e12so897004wra.13
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 03:53:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=GLYPXR7iusazP8bNYPPjCm2qXnuRGI2hMdpr81EZjbo=;
 b=REJtumhEJPTZi/vR4blIp9Evcq9nHAO/ovetOh3Up/QfTaTPPaWfb96vWwrQdz9L+x
 L8OWY1ObTJ4B/9T3kIS5PPeZd+M//Kz68Ze2qF4BeHmVJvQymwg0FzFchjVanYbEupbq
 2RKtyOKPQxq9E21yhC1xJaTw4Hvm7Nnn7fUGDup0vO4fQBmlzD0hdGDMU1Fv9wNrB8U/
 a5cSzgr7HCmKzFyJhJdpfoUSUQzvP9b6MRwDIp84YAHGQg0GvKSg8k9oQ+y2GXzaW7Qz
 6rMyvr+EEnXMj2Vl8vo7ci/PvNE8+LbdSrWSvnxLzyBQQ5L7z/EUbX+5NU6RJFrRbiuB
 GjqA==
X-Gm-Message-State: AOAM5325GP49gRELSiBV6fWQxFdOphX/jTQgLKYc2EoKMvpLsq6cBlPe
 FmFVJxGj1j9083OCxfQkr1nnqo4jDp5cH3lCjaIUfBZ7Z1PmGzmQi1nYB4Gy9klk9O8kS4elfgB
 cHi/SdVglvnxbSFM=
X-Received: by 2002:adf:f341:: with SMTP id e1mr8325334wrp.207.1595242403388; 
 Mon, 20 Jul 2020 03:53:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTfg3bB9MkoRbVfPLWdZrS5u/VaG2VdJ7s6x4koPlh+8JbI2MpV0KwPIf/5UnGCyLVUksKdg==
X-Received: by 2002:adf:f341:: with SMTP id e1mr8325311wrp.207.1595242403118; 
 Mon, 20 Jul 2020 03:53:23 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id y16sm33054383wro.71.2020.07.20.03.53.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2020 03:53:22 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] scripts/tracetool: Fix dtrace generation for macOS
To: Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200717093517.73397-1-r.bolshakov@yadro.com>
 <20200717093517.73397-2-r.bolshakov@yadro.com>
 <34c236c5-e047-6f15-6bb6-d0df65129622@redhat.com>
 <20200720105015.GA73320@SPB-NB-133.local>
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
Message-ID: <4e439685-3106-1c3e-d821-795603912192@redhat.com>
Date: Mon, 20 Jul 2020 12:53:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200720105015.GA73320@SPB-NB-133.local>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 03:17:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/20/20 12:50 PM, Roman Bolshakov wrote:
> On Sun, Jul 19, 2020 at 03:52:08PM +0200, Philippe Mathieu-Daudé wrote:
>> On 7/17/20 11:35 AM, Roman Bolshakov wrote:
>>> dtrace USDT is fully supported since OS X 10.6. There are a few
>>> peculiarities compared to other dtrace flavors.
>>>
>>> 1. It doesn't accept empty files.
>>> 2. It doesn't recognize bool type but accepts C99 _Bool.
>>> 3. It converts int8_t * in probe points to char * in
>>>    header files and introduces [-Wpointer-sign] warning.
>>>
>>> Cc: Cameron Esfahani <dirty@apple.com>
>>> Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
>>> ---
>>>  scripts/tracetool/format/d.py | 15 ++++++++++++++-
>>>  1 file changed, 14 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/scripts/tracetool/format/d.py b/scripts/tracetool/format/d.py
>>> index 0afb5f3f47..353722f89c 100644
>>> --- a/scripts/tracetool/format/d.py
>>> +++ b/scripts/tracetool/format/d.py
>>> @@ -13,6 +13,7 @@ __email__      = "stefanha@redhat.com"
>>>  
>>>  
>>>  from tracetool import out
>>> +from sys import platform
>>>  
>>>  
>>>  # Reserved keywords from
>>> @@ -34,7 +35,8 @@ def generate(events, backend, group):
>>>  
>>>      # SystemTap's dtrace(1) warns about empty "provider qemu {}" but is happy
>>>      # with an empty file.  Avoid the warning.
>>> -    if not events:
>>> +    # But dtrace on macOS can't deal with empty files.
>>> +    if not events and platform != "darwin":
>>
>> or?
> 
> no, the event list is empty for some files where all events are
> disabled (e.g. hppa/trace-events), so it should have an "and" here. This
> limits early exit only on macOS.

Ah yes you are right, I misread it.

> The precendence looks correct:
> 
> https://docs.python.org/3/reference/expressions.html#operator-precedence
> 
>>
>>>          return
>>>  
>>>      out('/* This file is autogenerated by tracetool, do not edit. */'
>>> @@ -44,6 +46,17 @@ def generate(events, backend, group):
>>>      for e in events:
>>>          args = []
>>>          for type_, name in e.args:
>>> +            if platform == "darwin":
>>> +                # macOS dtrace accepts only C99 _Bool
>>
>> Why not do that for all platforms?
>>
> 
> Because I can only test the changes on darwin :)
> I don't know how other dtrace flavors behave and whether it is an issue
> for dtrace on Linux/Solaris/FreeBSD/etc.
> 
> Thanks,
> Roman
> 
>>> +                if type_ == 'bool':
>>> +                    type_ = '_Bool'
>>> +                if type_ == 'bool *':
>>> +                    type_ = '_Bool *'
>>> +                # It converts int8_t * in probe points to char * in header
>>> +                # files and introduces [-Wpointer-sign] warning.
>>> +                # Avoid it by changing probe type to signed char * beforehand.
>>> +                if type_ == 'int8_t *':
>>> +                    type_ = 'signed char *'
>>>              if name in RESERVED_WORDS:
>>>                  name += '_'
>>>              args.append(type_ + ' ' + name)
>>>
>>
> 


