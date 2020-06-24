Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F8DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 13:21:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B171720738
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 13:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FWvEDpnU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B171720738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo5LY-0001ig-TD
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 09:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jo5Jn-00087a-Dw
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 09:19:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28620
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jo5Jk-0006nx-J2
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 09:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593004795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cCZx2lUMN99NAyNQwbN5ow+ciC0/KM5Ou+DR+2vPhi8=;
 b=FWvEDpnUedY8yK+m27p7QDWXQAuCdYGSRC0Rou8FuWAfshV558trVXkFKUmUCDAjwU3bG8
 2Wfh769BJSiEDsYAgJgobqt6xzEG6o/UdtnxIUpQqxoaJ0tXk/tS7mnP65ArGkdDxgN4dP
 b5PWLwz1AyxiZBnfZXDTnI30F6K1mXM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-3N544_XnMT6G2lcVEG7jwg-1; Wed, 24 Jun 2020 09:19:51 -0400
X-MC-Unique: 3N544_XnMT6G2lcVEG7jwg-1
Received: by mail-wr1-f72.google.com with SMTP id i12so2849787wrx.11
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 06:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cCZx2lUMN99NAyNQwbN5ow+ciC0/KM5Ou+DR+2vPhi8=;
 b=rWsJR57BZXhBrFTqKOMx/1OyeUanvRUmvlClrmD8FPPQ77KwSIw9mT4veR5LCBnWIw
 loEibRApk8ax+rbk3LeawfRgGVeFsJGgzC0eXWINqoEZ79aH6Z0OXaf8Eqs/JtID/tba
 0n9MdR6t4LJHvFF9aeDdHKxHPP1w4WK8SLSZv7TvNwOBxjnK+5ygMNEpws3s7eSVrdwx
 kfu2lXm3fiVfrgP57ZKZ339shaeMVGmemmxQnUgF+q5FzgNKpdfqTpSfdaNOQhlhh0az
 tqJRbf1NMuoQcJXKCaqGmT5TunXwG2PCEFZY0YaKm4JKkkU3fYZdX5NqHx2HZqNv0LeD
 aq7A==
X-Gm-Message-State: AOAM533YTAKqW01VqyCa+IVby//eefEHvtFCemvko0NuTAwDq2Ooormg
 +llmZDSkAFQ1lxCJ1PBDDjGTv2gFRtNMd2t3leifssY8p/IWdnvIQODwoFW8xlN0EE5sk3B+s/e
 WtEijwcSiPOf+Ckc=
X-Received: by 2002:a7b:c944:: with SMTP id i4mr29381235wml.22.1593004790067; 
 Wed, 24 Jun 2020 06:19:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpneyQ8VE7K5QpHhNJ0ZnwAX8+VIjBzBJdmMOBlFcMbv2rPWRzPrEhW0gM9aV0a1C7E7RawA==
X-Received: by 2002:a7b:c944:: with SMTP id i4mr29381213wml.22.1593004789795; 
 Wed, 24 Jun 2020 06:19:49 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id m1sm2160874wrv.37.2020.06.24.06.19.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2020 06:19:49 -0700 (PDT)
Subject: Re: [PULL 25/31] osdep: Make MIN/MAX evaluate arguments only once
To: Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
References: <20200624104917.375143-1-pbonzini@redhat.com>
 <20200624105048.375353-25-pbonzini@redhat.com>
 <1101afa3-7523-4408-8918-265b1f2dbc3b@redhat.com>
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
Message-ID: <573384fe-b7ad-7e80-1a81-36c0dcb750b5@redhat.com>
Date: Wed, 24 Jun 2020 15:19:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1101afa3-7523-4408-8918-265b1f2dbc3b@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 02:33:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/24/20 2:13 PM, Eric Blake wrote:
> On 6/24/20 5:50 AM, Paolo Bonzini wrote:
>> From: Eric Blake <eblake@redhat.com>
>>
>> I'm not aware of any immediate bugs in qemu where a second runtime
>> evalution of the arguments to MIN() or MAX() causes a problem, but
> 
> evaluation
> 
>> Update the MIN/MAX macros to only evaluate their argument once at
>> runtime;
> 
>> Use of MIN when MIN_CONST is needed:
>>
>> In file included from /home/eblake/qemu/qemu-img.c:25:
>> /home/eblake/qemu/include/qemu/osdep.h:249:5: error: braced-group
>> within expression allowed only inside a function
>>    249 |     ({                                                  \
>>        |     ^
>> /home/eblake/qemu/qemu-img.c:92:12: note: in expansion of macro â€˜MINâ€™
> 
> UTF-8 mojibake in the commit message ;(

Oh, this is not a git-publish bug:
https://github.com/bonzini/qemu/commit/6f9ff58baae

> 
> 
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>> Message-Id: <20200604215236.2798244-1-eblake@redhat.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
> 
>> +#define MIN_CONST(a, b)                                         \
>> +    __builtin_choose_expr(                                      \
>> +        __builtin_constant_p(a) && __builtin_constant_p(b),     \
>> +        (a) < (b) ? (a) : (b),                                  \
>> +        ((void)0))
> 
> This one is correct...
> 
>> +#undef MAX
>> +#define MAX(a, b)                                       \
>> +    ({                                                  \
>> +        typeof(1 ? (a) : (b)) _a = (a), _b = (b);       \
>> +        _a > _b ? _a : _b;                              \
>> +    })
>> +#define MAX_CONST(a, b)                                         \
>> +    __builtin_choose_expr(                                      \
>> +        __builtin_constant_p(a) && __builtin_constant_p(b),     \
>> +        (a) > (b) ? (a) : (b),                                  \
>> +        __builtin_unreachable())
> 
> ...but this one should also use ((void)0), to match the commit message.
> 
>> +
>> +/* Minimum function that returns zero only if both values are zero.
>>    * Intended for use with unsigned values only. */
> 
> And checkpatch complains about the formatting here.
> 
> Ah well.  I had all these things fixed in my tree, but failed to post a
> v5.  Not worth holding up this pull request in isolation, but if there
> are any other build issues, I'll post a v5 of this patch, otherwise a
> followup.
> 


