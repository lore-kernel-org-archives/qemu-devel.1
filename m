Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA5AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 09:43:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD989206EB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 09:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LLcCKqAI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD989206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyuEt-0007M5-UZ
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 05:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyuE6-0006oG-3g
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 05:42:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41267
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyuE4-0000lS-AV
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 05:42:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595583767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ja51Kybz5qgX+l8YUZ+CddC3/IZtuHxwOP0Drbv2h8A=;
 b=LLcCKqAI8gIs7bScKk/KKjiHc1k8AmR6Y1oQgTyYa2WtpxmU6KP3AAl2JFmRvm8vzeHRSK
 N2ZUGopOQimTWeSE4CYVOWS9k8+zWBgHMHXaBx4YyVX7rRr4tbamW9gYU4lPKdvVR9OJe7
 Yxh+E15hzwe5/Q7y7iDvrMuxCzaDsFQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-v3jUDTawPPmejDBV9ymJIw-1; Fri, 24 Jul 2020 05:42:42 -0400
X-MC-Unique: v3jUDTawPPmejDBV9ymJIw-1
Received: by mail-wr1-f71.google.com with SMTP id v4so2015135wrb.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 02:42:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Ja51Kybz5qgX+l8YUZ+CddC3/IZtuHxwOP0Drbv2h8A=;
 b=B9KmFS8MWC2qou63FV0ZCIGFX8Vw1XAJJu/mYNKbX4/ae2SrbXafC2q4JiwP3kZ6eX
 mO5CApgD26w6ZTB+d12E43KhpnziVHGjttrOGnv/neq1j4NL3asAFQqSKfBI1vZEs2Dp
 mB4tpjUrl+DfcXr9Jzs+d0x1CdZ/Tntw/xPme3KcEx2bUkYqShSy1BQWOsyxAN7wIARz
 ylsxCNcySJbHCIfzH8QLfZ2Y5BqZk4mgEVM9ggsCRqBPsXphPoNDnKijQ/5uhPw6dQLS
 xmV4sPBZWihWOa0Ap2kG/Kk1OHZzRZvarYR3hcGcLzGPdH6beKI/zB3tg6saK6JskOfr
 K7ZA==
X-Gm-Message-State: AOAM5322ivpvTDrG/Snc/Pr8yid49iDMGWIfJ8K7oBeC22Y8Z3S3CJRc
 jKybT02sW5z0etnFXbTmNxgJWy8vvOiBtfUe5LeFNP9WFPXVTpSkFCXHFu6zJIzjc/paXk8Kb00
 fjA0Y7qOtGXs/vxM=
X-Received: by 2002:adf:f44b:: with SMTP id f11mr8177047wrp.114.1595583761173; 
 Fri, 24 Jul 2020 02:42:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxsUvu9nHiv2jybdVmxKXWmUuk4EVQcVCJ8u6m+ZtPYvufWYM2GwnudzTQ5rbvgRAEqbByHA==
X-Received: by 2002:adf:f44b:: with SMTP id f11mr8177039wrp.114.1595583760984; 
 Fri, 24 Jul 2020 02:42:40 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id u17sm665379wrp.70.2020.07.24.02.42.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2020 02:42:40 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Add an entry to review Avocado based
 acceptance tests
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200605165656.17578-1-philmd@redhat.com>
 <87v9ids3lq.fsf@linaro.org>
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
Message-ID: <facccb5c-8a45-d427-9bbf-c74c1f64e1d7@redhat.com>
Date: Fri, 24 Jul 2020 11:42:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87v9ids3lq.fsf@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 00:01:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/24/20 10:45 AM, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
>> Add an entry for to allow reviewers to be notified when acceptance /
>> integration tests are added or modified.
>> The designated reviewers are not maintainers, subsystem maintainers
>> are expected to merge their tests.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

Thanks, but the v2 has already been merged (commit 6634f1c43d).
https://www.mail-archive.com/qemu-devel@nongnu.org/msg675105.html

> 
>> ---
>>  MAINTAINERS | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 3e7d9cb0a5..c2ae2bf390 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2923,6 +2923,14 @@ S: Maintained
>>  F: tests/tcg/Makefile
>>  F: tests/tcg/Makefile.include
>>  
>> +Acceptance (Integration) Testing with the Avocado framework
>> +W: https://trello.com/b/6Qi1pxVn/avocado-qemu
>> +R: Cleber Rosa <crosa@redhat.com>
>> +R: Philippe Mathieu-Daudé <philmd@redhat.com>
>> +R: Wainer dos Santos Moschetta <wainersm@redhat.com>
>> +S: Odd Fixes
>> +F: tests/acceptance/
>> +
>>  Documentation
>>  -------------
>>  Build system architecture
> 
> 


