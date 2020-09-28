Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B59C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 14:20:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FE722073A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 14:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yl9lMs/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE722073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMu1E-0001BQ-AL
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 10:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kMtzk-0000Gc-IR
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 10:19:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39390)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kMtzg-0002rl-SV
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 10:19:12 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601302745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lfu7g5W6xshKkKqRibs8ELSIG1ovZvO+wKJBDEMDTAc=;
 b=Yl9lMs/40CLlBaW8BceB4xYs5k2y3YaLfONHpWETaCTHdMNI2Q7bQ4L9VeiTG0ST2gnh5z
 qmrVLZLAgpR2Z1JmUFElfG8G/XahLc8amH5l1dpePJmXy4Ya6f2X2SNbu0SrIXhKh/S/Ss
 H+RoTTjdnkllBFOdEodGdeST/Kdbd9U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-6p3JH2OHNYOdevQFXs0jkA-1; Mon, 28 Sep 2020 10:18:49 -0400
X-MC-Unique: 6p3JH2OHNYOdevQFXs0jkA-1
Received: by mail-wm1-f69.google.com with SMTP id b20so2075857wmj.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 07:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=lfu7g5W6xshKkKqRibs8ELSIG1ovZvO+wKJBDEMDTAc=;
 b=NVIsyHf3StjIhLMNcew+/zBtelXEeAiSjerryyzy/jwp9kejbvEtX1rtgYaFvsvsk1
 /KWkPK4kEWyhrsb/4MQ1y9/NlantvhPNGV6WHL3rooMRS0rM8jNqMihWq9cAq1B6ZJw2
 bpAS8xc7Esqfw70lZCATIZPVpb1aeZoXnKYWgEfmbtXiuWMDAP52euKHbLt4eI4QOy+0
 qnCbYg0ipowPCpfiBmsnlNwtWVZewa+BiYBBR8gxNPGFEi+7LGWxzQw7+Bxt+diCk9nR
 3x8FSMdPTS+Jxbr3OR5Ox45Esl59otlp8OBUZm1sVN2JDEB9aBp9Yv+SOSwOjLzHSkti
 1ysA==
X-Gm-Message-State: AOAM531k2WxsdHikuBQWbBGLUCuVjQ/2nOhDIauhp7lZCLMpamvHhkb5
 GR+zLcMYIlZZng+y5GMFJW33ltw6TuuFQvF6PLePL7jwgav7BLR9uaUrCgnZy7RtA8wbvvYJDsj
 30NA/3h09tmFPSlY=
X-Received: by 2002:a1c:4c0d:: with SMTP id z13mr1799172wmf.115.1601302728235; 
 Mon, 28 Sep 2020 07:18:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYwzJxQbsx8qWgMttNE9F1QJ8nEc8dacFdo0AAX2LJY+G2kl+lOg3nW9gs4P19xBK+ru3wUg==
X-Received: by 2002:a1c:4c0d:: with SMTP id z13mr1799150wmf.115.1601302728050; 
 Mon, 28 Sep 2020 07:18:48 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id 63sm1999611wrc.63.2020.09.28.07.18.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2020 07:18:47 -0700 (PDT)
Subject: Re: [PATCH v2 5/8] qemu/bswap: Use compiler __builtin_bswap() on Haiku
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 David CARLIER <devnexen@gmail.com>
References: <20200928131934.739451-1-philmd@redhat.com>
 <20200928131934.739451-6-philmd@redhat.com>
 <CA+XhMqxdb9Y6HL_0Og4Px5OwdTqK5EKJcnKdafd790nJb8yYEQ@mail.gmail.com>
 <20200928141355.GI2230076@redhat.com>
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
Message-ID: <9591c70b-68ff-bf02-5ee3-2d1969acd7f9@redhat.com>
Date: Mon, 28 Sep 2020 16:18:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200928141355.GI2230076@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Fam Zheng <fam@euphon.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Carlo Arenas <carenas@gmail.com>,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/28/20 4:13 PM, Daniel P. Berrangé wrote:
> On Mon, Sep 28, 2020 at 03:09:01PM +0100, David CARLIER wrote:
>> Unfortunately it breaks the build.
> 
> Can you provide details of the errors seen and toolchain versions.
> 
> I notice we don't have any CI support for Haiku right now, nor
> any recipe in tests/vm/  for enabling users to setup a VM with
> Haiku installed. This very much makes Haiku a second class
> citizen right now in terms of QEMU's supported platforms, with
> no expectation of whether it'll work at any point in time.

I provided the tests/vm/ build script from Alexander as patch 8/8
of this series:
https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg10022.html

This is what I used to test this patch/series.

> 
>> On Mon, 28 Sep 2020 at 14:20, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>>
>>> Since commit efc6c070aca ("configure: Add a test for the minimum
>>> compiler version") the minimum compiler version required for GCC
>>> is 4.8, which supports __builtin_bswap().
>>> Remove the Haiku specific ifdef'ry.
>>>
>>> This reverts commit 652a46ebba970017c7a23767dcc983265cdb8eb7
>>> ("bswap.h: Include <endian.h> on Haiku for bswap operations").
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> ---
>>> Cc: David Carlier <devnexen@gmail.com>
>>> Cc: Carlo Arenas <carenas@gmail.com>
>>> ---
>>>  include/qemu/bswap.h | 2 --
>>>  1 file changed, 2 deletions(-)
>>>
>>> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
>>> index 55916670d39..719d620bfe6 100644
>>> --- a/include/qemu/bswap.h
>>> +++ b/include/qemu/bswap.h
>>> @@ -8,8 +8,6 @@
>>>  # include <machine/bswap.h>
>>>  #elif defined(__FreeBSD__)
>>>  # include <sys/endian.h>
>>> -#elif defined(__HAIKU__)
>>> -# include <endian.h>
>>>  #else
>>>  #undef  bswap16
>>>  #define bswap16(_x) __builtin_bswap16(_x)
>>> --
>>> 2.26.2
>>>
>>
> 
> Regards,
> Daniel
> 


