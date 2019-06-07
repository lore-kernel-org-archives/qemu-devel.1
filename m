Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DBAC468BD
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 15:56:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCB0C208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 15:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a2pzJQII"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB0C208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49070 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZHEf-0006Kw-4y
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 11:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57041)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hZFrV-0005Gn-3q
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:28:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hZFrT-0002WE-V6
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:28:57 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35126)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hZFrT-0002UZ-OC
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:28:55 -0400
Received: by mail-oi1-x243.google.com with SMTP id y6so1579908oix.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 07:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uL+WsF784Ri8OoyzYhosiFOv+CKxNTk5WrYld7yybN8=;
 b=a2pzJQII1Dtzmp+du/YNmsMq+Od79XinUzRmez8IRvPUKKiq3vK6SF+NmTZb602aXP
 w4kP5Kgr9NXcnGLQnZeKbYjOZPJUKAM9Pbm2nJ093+Bgk2VoO6LUa2Vlj+TdujM1Di3J
 W/ICpgALd9JS1tZ9W7TCuKJDyfBAaLkNeaD+95SAXWNzUbdxHUFVJknYVQH3s+7s4z0+
 S16nrRpklqMrGiY2pdCWLBhoRsgUDlQ91HEkmas4oQLSqgUs+fFYbhaTDwbflSfIjbTq
 7A343TjhSslhlwrP8jIapX+GXJLMYbGgDSupUitcDmF11t45KK/AC38c9UIa+jcEQQf6
 ZR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uL+WsF784Ri8OoyzYhosiFOv+CKxNTk5WrYld7yybN8=;
 b=IN5jjPCw60gEvMFl5JbPp/O47eZt/yrXwYCg49k9Li7nTztPh+8FosRltsLWWn0hsJ
 T/HZtqCIU16mwJAK7jKrDGrA61ad/AHW+ofEls7gFAKYkYOkhHc8EbALt5x0BGE7CxeF
 EI2EJWQgxq6hGG+tkXdbRpuXnsI4qhCNrWv3SCmcsp0Xl7QK1KqDtR2MAUcVZMGmROCt
 iT9zScf3Swm/snj4/gvTwa//tmuz8KGFohjv79zhNQdAHQHsXtJmKsLQJZxPooSOFBsk
 j90k3JoKLvsbiAD1ZbNVpFvlQgiiVWsUKsrkFkwtXj+SbPufTwmO5OiE6tAUzsSuPPYJ
 1BWQ==
X-Gm-Message-State: APjAAAVnb+lS5E1e1qWiT2acFyRX6dyWilUT1frr/st8zovg6YuaKqX/
 BCgy9OJGYIm/o+MZyhZqYz5bzg==
X-Google-Smtp-Source: APXvYqzYrLjyTn/PGdYz0Vml1Lo8pQ7WmXODF+T0rNjWgZ0XSa+XA3QSuTP2P4VhIOWeLKuQT3OCbw==
X-Received: by 2002:aca:6c4c:: with SMTP id h73mr4146236oic.40.1559917733992; 
 Fri, 07 Jun 2019 07:28:53 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
 [200.56.192.86])
 by smtp.gmail.com with ESMTPSA id t206sm759468oig.30.2019.06.07.07.28.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Jun 2019 07:28:53 -0700 (PDT)
To: Laurent Vivier <lvivier@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, peter.maydell@linaro.org
References: <20190529065017.15149-1-david@gibson.dropbear.id.au>
 <20190529065017.15149-24-david@gibson.dropbear.id.au>
 <31966f5b-d46c-4b86-6852-c949d9f72497@redhat.com>
 <9218989c-c92d-6e7b-71a9-08d511c3a0b3@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <32a8e668-80f5-1429-58f4-8935c973dd2b@linaro.org>
Date: Fri, 7 Jun 2019 09:28:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <9218989c-c92d-6e7b-71a9-08d511c3a0b3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PULL 23/44] target/ppc: Use vector variable
 shifts for VSL, VSR, VSRA
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
Cc: clg@kaod.org, rth@twiddle.net, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/7/19 9:09 AM, Laurent Vivier wrote:
> On 07/06/2019 11:29, Laurent Vivier wrote:
>> On 29/05/2019 08:49, David Gibson wrote:
>>> From: Richard Henderson <richard.henderson@linaro.org>
>>>
>>> The gvec expanders take care of masking the shift amount
>>> against the element width.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> Message-Id: <20190518191430.21686-2-richard.henderson@linaro.org>
>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>>> ---
>>>  target/ppc/helper.h                 | 12 ----------
>>>  target/ppc/int_helper.c             | 37 -----------------------------
>>>  target/ppc/translate/vmx-impl.inc.c | 24 +++++++++----------
>>>  3 files changed, 12 insertions(+), 61 deletions(-)
>>
>> This patch introduces a regressions
>>  with Fedora 29 guest:
>>
>> - during kernel boot:
>>
>> [   40.397876] crypto_register_alg 'aes' = 0
>> [   40.577517] crypto_register_alg 'cbc(aes)' = 0
>> [   40.743576] crypto_register_alg 'ctr(aes)' = 0
>> [   41.061379] alg: skcipher: Test 1 failed (invalid result) on encryption for p8_aes_xts
>> [   41.062054] 00000000: 91 7c f6 9e bd 68 b2 ec 9b 9f e9 a3 ea dd a6 92
>> [   41.062163] 00000010: 98 10 35 57 5e dc 36 1e 9a f7 bc ba 39 f2 5c eb
>> [   41.062834] crypto_register_alg 'xts(aes)' = 0
>> [   41.077358] alg: hash: Test 2 failed for p8_ghash
>> [   41.077553] 00000000: 5f 89 ab f7 20 57 20 57 20 57 20 57 20 57 20 57
>>
>> - with libssl:
>>
>> # curl -o /dev/null https://www.google.com
>>   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
>>                                  Dload  Upload   Total   Spent    Left  Speed
>>   0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
>> curl: (35) error:1408F119:SSL routines:ssl3_get_record:decryption failed or bad record mac
>>
>> [before, this one fails with:
>> curl: (35) error:04091068:rsa routines:int_rsa_verify:bad signature ]
>>
>> If I revert this patch on top of 0d74f3b427 + "target/ppc: Fix lxvw4x, lxvh8x and lxvb16x", all works fine.
>>
>> Thanks,
>> Laurent
>>
> 
> This seems to fix the problem:
> 
> diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
> index 3b6052fe97..6f0709b307 100644
> --- a/accel/tcg/tcg-runtime-gvec.c
> +++ b/accel/tcg/tcg-runtime-gvec.c
> @@ -874,7 +874,7 @@ void HELPER(gvec_sar8v)(void *d, void *a, void *b,
> uint32_t desc)
>      intptr_t oprsz = simd_oprsz(desc);
>      intptr_t i;
> 
> -    for (i = 0; i < oprsz; i += sizeof(vec8)) {
> +    for (i = 0; i < oprsz; i += sizeof(uint8_t)) {
>          uint8_t sh = *(uint8_t *)(b + i) & 7;
>          *(int8_t *)(d + i) = *(int8_t *)(a + i) >> sh;
>      }

Grr.  I really really need to come up with a solution for testing that allows
me to test paths that the host cpu would not ordinarily take.  This bug is
hidden on a host with AVX2.

Thanks for the digging.


r~

