Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C645C433EB
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 15:10:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFAC62083B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 15:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WaZn0GIB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFAC62083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw5Wy-0003np-64
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 11:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jw5Vw-0002kn-FG
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 11:09:36 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50984
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jw5Vu-0006cH-1j
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 11:09:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594912170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mimyS3XHIJ+fAdaFvbTPlN7UvNcjRoDzQUWs4fX8Iy4=;
 b=WaZn0GIBCPIP3YZ6a4T+J0ielMznTF+Fape6I/R84u+WMfgeMr7LLV1papeGllIbJFIQp5
 ty3EiNBffARJec2zhlfhd1dujvjUai1xJabfbF+EFriRAGIT7TJrz2Tm3B5ES0prWamEbU
 MnURkegA30qJoVn73dmCzy48KUymliw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-why7NNssPLuQq42yw9ai7w-1; Thu, 16 Jul 2020 11:09:12 -0400
X-MC-Unique: why7NNssPLuQq42yw9ai7w-1
Received: by mail-wr1-f70.google.com with SMTP id z1so5603450wrn.18
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 08:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=mimyS3XHIJ+fAdaFvbTPlN7UvNcjRoDzQUWs4fX8Iy4=;
 b=k9HSyeUufj29P73sUMFEkjmkaLSjDRprnFm+KsnLL7XHVNkblgcDjsdNWSLZW8LOMv
 i1TxO+c7ipkYTRTVLMf6/8CWB2NpZz13IXQwPzvmGwWNt0xccg5drk0vD+/IqEVTcHAi
 8+vK3JMGFkNUFyjDYKBJtxeSe8vVJW9O5m7jDd/V9/Bqe4KEs2IM276B+rp7aZOdjBnc
 YPDvsqCeaGLpjf3/bJSTPpSj5hLXMUMRr4194XkslF/a7bqQssAMt0CLWAYPsTGA5Zc4
 cy2/S8gr2ZnTtL4rpu/a1YoKMXNxZrjwmriuae45BJCx6w13O2iHKQmimWQ9m0LCTTEr
 zNRg==
X-Gm-Message-State: AOAM533cEW4rUI5ofHr0fAeC+wOwJtUutMeymQarYsCx2ifOVGMWz4iC
 UFY1kwjHaeQDcpc/ttcI2ITkDhELww0BaW2Bc/ATvhGsIAcU5eatboKjHXfyW5o5XyxNl/hAbwl
 aGDPpXzxC2YKmLwg=
X-Received: by 2002:a5d:5587:: with SMTP id i7mr5472652wrv.314.1594912150527; 
 Thu, 16 Jul 2020 08:09:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxo7cGDO/2xwpDwoxUr4yI6E8kmHIVL0zS0HRMTFeWvYoHHPZqozGWZ3LblNo1xTOODWrcwog==
X-Received: by 2002:a5d:5587:: with SMTP id i7mr5472606wrv.314.1594912149900; 
 Thu, 16 Jul 2020 08:09:09 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id a4sm10494649wrg.80.2020.07.16.08.09.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2020 08:09:09 -0700 (PDT)
Subject: Re: [PATCH] target/i386: floatx80: avoid compound literals in static
 initializers
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
References: <20200716144251.23004-1-lersek@redhat.com>
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
Message-ID: <a38a3da3-7406-0ba3-ca32-e96a99915c97@redhat.com>
Date: Thu, 16 Jul 2020 17:09:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200716144251.23004-1-lersek@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 04:55:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Joseph Myers <joseph@codesourcery.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/16/20 4:42 PM, Laszlo Ersek wrote:
> Quoting ISO C99 6.7.8p4, "All the expressions in an initializer for an
> object that has static storage duration shall be constant expressions or
> string literals".
> 
> The compound literal produced by the make_floatx80() macro is not such a
> constant expression, per 6.6p7-9. (An implementation may accept it,
> according to 6.6p10, but is not required to.)
> 
> Therefore using "floatx80_zero" and make_floatx80() for initializing
> "f2xm1_table" and "fpatan_table" is not portable. And gcc-4.8 in RHEL-7.6
> actually chokes on them:
> 
>> target/i386/fpu_helper.c:871:5: error: initializer element is not constant
>>      { make_floatx80(0xbfff, 0x8000000000000000ULL),
>>      ^

This reminds me of:

commit 6fa9ba09dbf4eb8b52bcb47d6820957f1b77ee0b
Author: Kamil Rytarowski <n54@gmx.com>
Date:   Mon Sep 4 23:23:06 2017 +0200

    target/m68k: Switch fpu_rom from make_floatx80() to make_floatx80_init()

    GCC 4.7.2 on SunOS reports that the values assigned to array members
are not
    real constants:

    target/m68k/fpu_helper.c:32:5: error: initializer element is not
constant
    target/m68k/fpu_helper.c:32:5: error: (near initialization for
'fpu_rom[0]')
    rules.mak:66: recipe for target 'target/m68k/fpu_helper.o' failed

    Convert the array to make_floatx80_init() to fix it.
    Replace floatx80_pi-like constants with make_floatx80_init() as they are
    defined as make_floatx80().

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> We've had the make_floatx80_init() macro for this purpose since commit
> 3bf7e40ab914 ("softfloat: fix for C99", 2012-03-17), so let's use that
> macro again.
> 
> Fixes: eca30647fc07
> Fixes: ff57bb7b6326
> Link: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg06566.html
> Link: https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg04714.html
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Joseph Myers <joseph@codesourcery.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
> 
> Notes:
>     I can see that there are test cases under "tests/tcg/i386", but I don't
>     know how to run them.

Yeah it is not easy to figure...

Try 'make run-tcg-tests-i386-softmmu'
but you need docker :^)

(There is also 'make check-softfloat', listed in 'make check-help')

> 
>  include/fpu/softfloat.h  |   1 +
>  target/i386/fpu_helper.c | 426 +++++++++++++++++++--------------------
>  2 files changed, 214 insertions(+), 213 deletions(-)
> 
> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> index f1a19df066b7..659218b5c787 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -822,6 +822,7 @@ static inline bool floatx80_invalid_encoding(floatx80 a)
>  }
>  
>  #define floatx80_zero make_floatx80(0x0000, 0x0000000000000000LL)
> +#define floatx80_zero_init make_floatx80_init(0x0000, 0x0000000000000000LL)
>  #define floatx80_one make_floatx80(0x3fff, 0x8000000000000000LL)
>  #define floatx80_ln2 make_floatx80(0x3ffe, 0xb17217f7d1cf79acLL)
>  #define floatx80_pi make_floatx80(0x4000, 0xc90fdaa22168c235LL)
> diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
> index f5e6c4b88d4e..4ea73874d836 100644
> --- a/target/i386/fpu_helper.c
> +++ b/target/i386/fpu_helper.c
> @@ -868,201 +868,201 @@ struct f2xm1_data {
>  };
...


