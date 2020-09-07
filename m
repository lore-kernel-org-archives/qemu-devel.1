Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93633C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:42:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FC922075A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQskbv0P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC922075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFDfD-0001M5-A3
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 05:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFDe9-0008Q3-Ow
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:41:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29381
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFDe8-0005Rg-02
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599471667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=exWqJuu9oMWPbJxqip+LZdXLZmDqyA8FaBmsbvwPpH8=;
 b=QQskbv0PaNu2iZhzrlY5LN5DyRMg5hTs2XhaqerxKupEd8j+AvyWIFfUgS2EZ4cLeBAlqY
 zOWJsWkaDwMbX7cStPchTfcxkg+UujTOEubamPn3Up18S7u7WM+u65rqpBR9VWVhsffkXC
 v0BXxgHZ1PewDzZaiQD6VxCHaQTtGc0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-O3cpOA3lM9mSjcdjhLHGww-1; Mon, 07 Sep 2020 05:41:05 -0400
X-MC-Unique: O3cpOA3lM9mSjcdjhLHGww-1
Received: by mail-wr1-f70.google.com with SMTP id v5so5462366wrs.17
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 02:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=exWqJuu9oMWPbJxqip+LZdXLZmDqyA8FaBmsbvwPpH8=;
 b=klSjvlt5Uw+O9NlfiE1Evolw2+5dRw6gWoqe9oFzUPuepCa01057pP3hEigBWR+r6M
 oh4RbPCRub31QFbN/B4k/8IK69GHV2BEivBwr0tvjig6PMXPGnPzy0sOBv2xyTTrdLsi
 eIlKyBsR5ZosXkw4LQojpsUSqgjvtSMljAONpBtEGlrAWZImPug7r+HpIJE5K+obzeH7
 jSbNbucL/8gHn+6if9YCSKCaoNs+vxkU/duPB9umfbBY+NYKD4y3znvlKtIpOCAYT063
 YaV0CdCpftfbPkr3IuR7FdN+FgT+SZQoGOTwqHiREU7jghk4qenDyyAkK5euazKPemvY
 ChXQ==
X-Gm-Message-State: AOAM530CD/PAze//ygNPQkXnZ1pWxIHo8oQNijP8eE73gTrVUa2AlnzS
 dXWmIXrsrns+kRVjYFusC0oODJXVSJp+zzwsrLXIJqyrOw3Pv4RmQKD50rxaUB6YAwXL4Uaoutl
 o8J0Q11gMMKhfeAE=
X-Received: by 2002:a1c:a444:: with SMTP id n65mr19466755wme.122.1599471663130; 
 Mon, 07 Sep 2020 02:41:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5tK0M9y7Fvapr+WCyx7psnAK46eeK6LcGxXVZR/4VEjUlrWynbU/Jat8jBQGn1rjmue7PdA==
X-Received: by 2002:a1c:a444:: with SMTP id n65mr19466727wme.122.1599471662914; 
 Mon, 07 Sep 2020 02:41:02 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id f19sm26107689wmh.44.2020.09.07.02.41.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2020 02:41:02 -0700 (PDT)
Subject: Re: [PATCH v1 6/8] tests/meson.build: fp tests don't need CONFIG_TCG
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20200903112107.27367-1-alex.bennee@linaro.org>
 <20200903112107.27367-7-alex.bennee@linaro.org>
 <CABgObfZ_Xdd-pnRjpWO=8NjEznZhz84DTq95OzCdjL_rxnw=XQ@mail.gmail.com>
 <87a6y2rlwq.fsf@linaro.org>
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
Message-ID: <6c8531d2-a695-e964-bacf-a4322d4c9f40@redhat.com>
Date: Mon, 7 Sep 2020 11:41:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87a6y2rlwq.fsf@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 02:54:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.69, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, qemu-devel <qemu-devel@nongnu.org>,
 "Emilio G. Cota" <cota@braap.org>, stefanha@redhat.com,
 marcandre.lureau@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/7/20 11:11 AM, Alex Bennée wrote:
> 
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> Il gio 3 set 2020, 13:21 Alex Bennée <alex.bennee@linaro.org> ha scritto:
>>
>>> As the tests build only softfloat.c no actual TCG machinary is neede
>>> to test them (as is evidenced by GCC check-softfloat). Might as well
>>> fix the wording on Travis while at it.
>>>
>>
>> The reason is that softfloat is not built at all into QEMU if !CONFIG_TCG.
>> We similarly skip block layer tests if !CONFIG_SOFTMMU &&
>> !CONFIG_TOOLS.
> 
> It's not built anyway if you don't call the test. Are you saying a
> --disable-system and --disable-user build is invalid for running unit
> tests? That is what check-softfloat is doing as it doesn't involve
> softfloat built into any qemu binary.

FYI my tools build dir is configured as:

'--enable-trace-backends=log' '--disable-docs' '--enable-debug'
'--disable-system' '--disable-user' '--enable-tools'

and it still works after the Meson conversion.

> 
>>
>> Paolo
>>
>>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> ---
>>>  .travis.yml       | 2 +-
>>>  tests/meson.build | 3 ++-
>>>  2 files changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/.travis.yml b/.travis.yml
>>> index 1d0ade0a133..65341634d02 100644
>>> --- a/.travis.yml
>>> +++ b/.travis.yml
>>> @@ -138,7 +138,7 @@ jobs:
>>>
>>>
>>>      # Just build tools and run minimal unit and softfloat checks
>>> -    - name: "GCC check-softfloat (user)"
>>> +    - name: "GCC check-unit and check-softfloat"
>>>        env:
>>>          - BASE_CONFIG="--enable-tools"
>>>          - CONFIG="--disable-user --disable-system"
>>> diff --git a/tests/meson.build b/tests/meson.build
>>> index fe2c6d8e6b6..bdcc5d75293 100644
>>> --- a/tests/meson.build
>>> +++ b/tests/meson.build
>>> @@ -7,8 +7,9 @@ test('decodetree', sh,
>>>       workdir: meson.current_source_dir() / 'decode',
>>>       suite: 'decodetree')
>>>
>>> +subdir('fp')
>>> +
>>>  if 'CONFIG_TCG' in config_host
>>> -  subdir('fp')
>>>    if 'CONFIG_PLUGIN' in config_host
>>>      subdir('plugin')
>>>    endif
>>> --
>>> 2.20.1
>>>
>>>
> 
> 


