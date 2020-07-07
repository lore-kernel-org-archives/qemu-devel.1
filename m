Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD28C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 06:12:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B480F20739
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 06:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HK0L0C8v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B480F20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsgpv-00015e-Ur
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 02:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jsgpG-0000gQ-Hj
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 02:11:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39072
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jsgpD-0003jl-NN
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 02:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594102285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JhufWyhRIktoR/bxE978AaQBCmkyHPsXzemQzto6upM=;
 b=HK0L0C8veklgSZxI4T7++gXZnfyByN2GCuDIurgSJK2ClkmGYy8rVZrJDjJA81cn8bnl2x
 KoFJjU8fslSmjcaNKvTLrmRg3bMrPxseYui+54CM9xl9zvmGeuHenKeZv5AeMF5IOtYmzw
 5Vo3ErSZY9T/12Js+MRL45Q3K5xpGk8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-2Stwd2J-N7Kry6FEyG7ybQ-1; Tue, 07 Jul 2020 02:11:24 -0400
X-MC-Unique: 2Stwd2J-N7Kry6FEyG7ybQ-1
Received: by mail-wm1-f71.google.com with SMTP id 65so31674687wmd.8
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 23:11:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=JhufWyhRIktoR/bxE978AaQBCmkyHPsXzemQzto6upM=;
 b=XvFEhkSgq5Q6RTOWU2NcPdHCoFgtjvBZVXL8/8FVxJ8lHSzs3YerjmJni1xgkUKXKR
 iLttx96Ng76u5gkQm3qF5fYrODM4pRgNSEGH+ZC5aET4xupSO8JgbkSY7cRJesn7UoRJ
 RCChvs/px4vUDTI4t4uREPUNkQ+Jkzn/Dbi4/fPzaTidW428Qh6msEhp5NAGUB9qR0q+
 Oqn6+Uuz7KzyUsJ15ceZvbYhrqTyRGmzre8o1OA+H2+zmhgWrl++ilFJDqEBCBXPz6aE
 l7Dc8bgF7fAF/mkyfG4SB8IpBLFHbAoR4AzkjiwFWKQVKtNCawHiPgg/SV881dmYAHhf
 yCiw==
X-Gm-Message-State: AOAM533NVLNmFgfApEWOiL/LNMIgZVL1Wkjps00HSTIMrZ5wOsEQlD4s
 4axz5txQCrxdXVi9lbPHdpEBDmHGNXTeTd+3zknJe10isFkYQu0LGTF8rVqRipAqDK3gP/Wsiny
 WiikraR3AuDPF2OY=
X-Received: by 2002:adf:eccd:: with SMTP id s13mr55830800wro.217.1594102283058; 
 Mon, 06 Jul 2020 23:11:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBXfH4rpp1KpdLrLKeMQ8g01Yh/J8FDuwJXk9eBn2OzuLUjc0bGSzv4GRQkYZAFioVdzoMfg==
X-Received: by 2002:adf:eccd:: with SMTP id s13mr55830775wro.217.1594102282779; 
 Mon, 06 Jul 2020 23:11:22 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id a123sm2100995wmd.28.2020.07.06.23.11.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2020 23:11:22 -0700 (PDT)
Subject: Re: [PATCH v2] util/qemu-option: Document the get_opt_value() function
To: Markus Armbruster <armbru@redhat.com>
References: <20200629070858.19850-1-philmd@redhat.com>
 <87imezan9b.fsf@dusky.pond.sub.org>
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
Message-ID: <e3a29383-ee77-e9be-c6a0-f795cdfc53cb@redhat.com>
Date: Tue, 7 Jul 2020 08:11:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87imezan9b.fsf@dusky.pond.sub.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:46:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2eBerrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/7/20 7:48 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
>> Coverity noticed commit 950c4e6c94 introduced a dereference before
>> null check in get_opt_value (CID1391003):
>>
>>   In get_opt_value: All paths that lead to this null pointer
>>   comparison already dereference the pointer earlier (CWE-476)
>>
>> We fixed this in commit 6e3ad3f0e31, but relaxed the check in commit
>> 0c2f6e7ee99 because "No callers of get_opt_value() pass in a NULL
>> for the 'value' parameter".
>>
>> Since this function is publicly exposed, it risks new users to do
>> the same error again. Avoid that documenting the 'value' argument
>> must not be NULL.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>> v2: Drop confuse comment (Damien Hedde)
>> ---
>>  include/qemu/option.h | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/include/qemu/option.h b/include/qemu/option.h
>> index eb4097889d..ac50d25774 100644
>> --- a/include/qemu/option.h
>> +++ b/include/qemu/option.h
>> @@ -28,6 +28,19 @@
>>  
>>  #include "qemu/queue.h"
>>  
>> +/**
>> + * get_opt_value
>> + * @p: a pointer to the option name, delimited by commas
>> + * @value: a non-NULL pointer that will received the delimited options
> 
> s/received/receive/
> 
>> + *
>> + * The @value char pointer will be allocated and filled with
>> + * the delimited options.
>> + *
>> + * Returns the position of the comma delimiter/zero byte after the
>> + * option name in @p.
>> + * The memory pointer in @value must be released with a call to g_free()
>> + * when no longer required.
>> + */
>>  const char *get_opt_value(const char *p, char **value);
>>  
>>  void parse_option_size(const char *name, const char *value,
> 
> You are adding a *second* doc comment: the definition already has one.
> It's clearer than yours on some things, and less explicit on others.
> Feel free to improve or replace it.  But do put it next to the
> definition.

Hmm I haven't noticed it, because my reflex is to look at the usage
description in the prototype declaration, not in the implementation.

I know, 2 different schools.

Maybe we can make both schools less unhappy by simply duplicating the
function description in both the header and the source files...

> 
> I'm not trying to re-argue where to put doc comments.

We could, because the origin of both this patch and the commits
referenced that produced CID1391003.

> I *am* arguing
> for local consistency while we lack global consistency.  For code I
> maintain, I insist on local consistency.
> 
> The code belonging to MAINTAINERS section "Command line option argument
> parsing" has doc comments next to the definition.  Except for
> qemu_opt_has_help_opt(), which predates my maintainer mandate.
> 
Please disregard this patch, I don't mind about get_opt_value().


