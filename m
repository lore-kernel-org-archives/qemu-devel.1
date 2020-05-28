Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D61EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 15:13:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F9B2089D
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 15:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFdOX6zu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F9B2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeKDV-0004wh-El
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 11:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeKCh-0004BP-A2
 for qemu-devel@nongnu.org; Thu, 28 May 2020 11:12:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35678
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeKCf-0007mH-46
 for qemu-devel@nongnu.org; Thu, 28 May 2020 11:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590678735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oUwkh3vYK2W5oWR5R5A1bsqzDhTSw9EYgO/7+rdw5yw=;
 b=VFdOX6zusg9NslliA3uKkUQCZshQcvki/eyDKHA1ndK2v0SrAL2bttCrM9x2yQwLVHmgTV
 +HHxsr2dNruRfT8asBibqge0i3R0DOnKo/YJsgwRWYGFhFih1T9qnvMpYU1Zx3/EZv9g0l
 cUS3tc9dSwlkFIRjRVUWype1+Vi5+/Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-QTuLoaFBOB64LX4DfD-ypg-1; Thu, 28 May 2020 11:12:13 -0400
X-MC-Unique: QTuLoaFBOB64LX4DfD-ypg-1
Received: by mail-wm1-f71.google.com with SMTP id g84so844991wmf.4
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 08:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=oUwkh3vYK2W5oWR5R5A1bsqzDhTSw9EYgO/7+rdw5yw=;
 b=ucazcW0g2tk0q3XLMMdcZH01TXvDYOSvCbaTF4gf2VYuvrrj8TZCyvVspig05bgNmu
 3trGgiYG2mu3Hl/+uGJr54pb3k8OaU3ES2nV9j6QiOOgcq1hjKBjzP6SKCzLfkXgeFoz
 Ue5TvuZklKhCmefNK/MkiRc3psosMZdSrl1Je0ik3JgHbVgH/NkMipniL6veSgXCqXAG
 5uW/oe/u0roFvuKGHyCLzynAWYkngJM7jY6140Rt8y1X/h7CpJ5K4rDitk/Y/JUzfTTv
 aCeqwa2vsG2e+9lGE9iFERUkhHZfS6iCROjsP/aET7qPKmRCMzxIsqGiHh4qTQj4xexl
 gU5A==
X-Gm-Message-State: AOAM532qLTIxZklg/6z0TaGfJHc8toVhWyzSYjkNGJdWMRO9Xn0JHGdc
 RK7c2/xdV+VzgGG9xXXonguvVO/GMeAMsPbbR9GXgANiKp7oX1vIekbUovyDKV4UDgeog23arXe
 M1UyWRIM0npHKL6k=
X-Received: by 2002:a1c:2e41:: with SMTP id u62mr4058483wmu.91.1590678732349; 
 Thu, 28 May 2020 08:12:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwhjHCjfGOhuWdkyltX5LbNcE9JuGoQuzPBiT9vmWAmDs0nPdllK22fu1DX2Bmcj/Evpm3YQ==
X-Received: by 2002:a1c:2e41:: with SMTP id u62mr4058461wmu.91.1590678732025; 
 Thu, 28 May 2020 08:12:12 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id 71sm4144800wmb.34.2020.05.28.08.12.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2020 08:12:11 -0700 (PDT)
Subject: Re: [PATCH 2/2] hmp: Simplify qom_set
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20200520151108.160598-1-dgilbert@redhat.com>
 <20200520151108.160598-3-dgilbert@redhat.com>
 <1f627a6b-9c5f-09b3-8f75-64e95a4f5d02@redhat.com>
 <20200520190344.GG2820@work-vm> <87y2pge6nv.fsf@dusky.pond.sub.org>
 <20200528140644.GG3069@work-vm>
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
Message-ID: <76651901-333f-e28f-ee0c-d4081b618d51@redhat.com>
Date: Thu, 28 May 2020 17:12:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200528140644.GG3069@work-vm>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 01:51:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, berrange@redhat.com, clg@kaod.org,
 afaerber@suse.de, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/28/20 4:06 PM, Dr. David Alan Gilbert wrote:
> * Markus Armbruster (armbru@redhat.com) wrote:
>> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
>>
>>> * Philippe Mathieu-DaudÃƒÂ© (philmd@redhat.com) wrote:
>>>> On 5/20/20 5:11 PM, Dr. David Alan Gilbert (git) wrote:
>>>>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>>>>
>>>>> Simplify qom_set by making it use qmp_qom_set and the JSON parser.
>>>>>
>>>>> Note that qom-set likes JSON strings quoted with ' not ", e.g.:
>>>>>
>>>>> (qemu) qom-get /machine smm
>>>>> "auto"
>>>>> (qemu) qom-set /machine smm 'auto'
>>>>
>>>> Will I get this output using "?
>>>>
>>>> (qemu) qom-set /machine smm "auto"
>>>> Error: Expecting a JSON value
>>>
>>> The error you get is:
>>>
>>> (qemu) qom-set /machine smm "auto"
>>> Error: JSON parse error, invalid keyword 'auto'
>>>
>>> I think, having seen alphanumerics, it's expecting a keyword;
>>> i.e. a true/false making a bool, or a null.
>>
>> The command parses its argument as JSON.
>>
>> Before we get there, the HMP core extracts the argument from the line of
>> input.  The extraction is guided by the command's .args_type, in this
>> case the 's' in "value:s" in
>>
>>     {
>>         .name       = "qom-set",
>>         .args_type  = "path:s,property:s,value:s",
>>         [...]
>>     },
>>
>> monitor/monitor-internal.h documents type code 's' as
>>
>>  * 's'          string (accept optional quote)
>>
>> The implementation boils down to:
>>
>> 1. Skip whitespace.
>>
>> 2. If looking at '"', get the string enclosed in '"', with C-like escape
>>    sequences \n, \r, \\, \', \".
>>
>> 3. Else, get the string up to the next whitespace.
>>
>> See get_str().
>>
>> Therefore, argument "auto" is the same as auto.  Parsing auto as JSON
>> duly fails.
>>
>> Argument 'auto' works, but only because qobject_from_json() recognizes
>> single-quoted strings.  This is as extension over RFC 8259.
>>
>> Using single quotes falls apart when you want to pass something
>> containing whitespace.  Then you'd have to use
>>
>>     "\"ugly and unintuitive\""
>>
>> or, again relying on the extension
>>
>>     "'ugly and unintuitive'"
>>
>> There's a better way, and Paolo pointed it out in
>>
>>     Subject: Re: [RFC PATCH] qom: Implement qom-get HMP command
>>     Date: Thu, 21 May 2020 16:24:12 +0200
>>     Message-ID: <2c148331-78ae-31f7-8702-d65c37a090b0@redhat.com>
>>
>> Use argument type 'S'.  Documented as
>>
>>  * 'S'          it just appends the rest of the string (accept optional quote)
>>
>> but the parenthesis is confusing.  It really just skips whitespace, then
>> extracts the remainder of the line.  Can't do string with leading
>> whitespace, but that's just fine for us.
> 

Thanks for the detailed explanation.

> Yep, thanks - I spotted Paolo's response but thanks for the deeper
> explanation.
> With that would you give me a Review-by?

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Dave
> 
>> Please squash in:
>>
>> diff --git a/hmp-commands.hx b/hmp-commands.hx
>> index 250ddae54d..28256209b5 100644
>> --- a/hmp-commands.hx
>> +++ b/hmp-commands.hx
>> @@ -1806,7 +1806,7 @@ ERST
>>  
>>      {
>>          .name       = "qom-set",
>> -        .args_type  = "path:s,property:s,value:s",
>> +        .args_type  = "path:s,property:s,value:S",
>>          .params     = "path property value",
>>          .help       = "set QOM property",
>>          .cmd        = hmp_qom_set,
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 


