Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA509C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 08:12:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF5F420781
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 08:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G6TiKLHk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF5F420781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k68LJ-0003KH-Rd
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 04:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k68Kj-0002uK-PB
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 04:11:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23895
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k68Kh-0006Qu-7M
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 04:11:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597306290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=X36/R5lKts7iD/RAFKudnjK222+6ENO6wIpqIE/HdCw=;
 b=G6TiKLHk4lXzHVfn40kmLFjzFp43Xnfamb4BaeIZcHeyhR0J+vSzidsz6cEoObXQa8E+Ct
 08QodMMijujZcgdSfnS/rEf4YJRps64xvY4v4RzSD62Q+1k8f3wn+LK2lMq7XkPa9eL7DH
 1zAlVhm7l3pRi46nQgzR8RkxQC9ykdQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-rutgCTMVPNu0VEN_p69vLw-1; Thu, 13 Aug 2020 04:11:28 -0400
X-MC-Unique: rutgCTMVPNu0VEN_p69vLw-1
Received: by mail-wm1-f71.google.com with SMTP id z1so1907011wmf.9
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 01:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=X36/R5lKts7iD/RAFKudnjK222+6ENO6wIpqIE/HdCw=;
 b=MN8eIY5iAQIuem53B07J4YlyMMJ+kECk7c/U3D57+UAMWOr5wEqJoS/sCeajV2zsc8
 h2XtOcKJGW30+v7WFFLWWp/x/C8OLQ82u/oWd3aitl3aAJISkXivsfna4nmRDuLgeNHS
 cTmX0zQmMbkW/18g69bN1d0NTUx+aADuPVA0U+GgeS1L7u74G+GOyvi4hco67VPYJhQ1
 uoTa1iDLNwekH0DXZJ/UVuNGqmcSnWfinzxO91NZ2f51ADPhMUqUMmksMLZ23mZBx/1t
 NZMGrNaLJRTcZAb4o0feHj3YKjGPJkOdPWKBInN24mYVvIgNJOgvsB59xommHsw2v3tr
 rl6Q==
X-Gm-Message-State: AOAM532lpG/LGrQPXDcGpOCXR+8R7Mf9yTPEMbVXqm40ChePSU2Y1vzF
 AGocSZHJo31sNQHC9jEcV+elJEHT2lS5eO3eRKzpXDQZzUA3hUwo1moA7W3vCVD2DWhIa9X/H76
 Yg9MdalmrwDN5uTM=
X-Received: by 2002:a1c:5581:: with SMTP id j123mr3275097wmb.11.1597306287505; 
 Thu, 13 Aug 2020 01:11:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFpeFIpP3tcfudOhoK+6vzrUMDYDzAkVO35D+cIjxIlAAr06k15CGiP1XgQKLbtN8Br3Yk0g==
X-Received: by 2002:a1c:5581:: with SMTP id j123mr3275080wmb.11.1597306287273; 
 Thu, 13 Aug 2020 01:11:27 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id z8sm8040111wmf.42.2020.08.13.01.11.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2020 01:11:26 -0700 (PDT)
Subject: Re: [PATCH 13/17] crypto/builtin: Move AES_cbc_encrypt into
 cipher-builtin.inc.c
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200813032537.2888593-1-richard.henderson@linaro.org>
 <20200813032537.2888593-14-richard.henderson@linaro.org>
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
Message-ID: <a629b923-da33-dd9a-23b3-d7e19e795b3f@redhat.com>
Date: Thu, 13 Aug 2020 10:11:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200813032537.2888593-14-richard.henderson@linaro.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 03:45:42
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
Cc: berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/13/20 5:25 AM, Richard Henderson wrote:
> By making the function private, we will be able to make further
> simplifications.  Re-indent the migrated code and fix the missing
> braces for CODING_STYLE.

Patch easier to review using 'git-diff --color-moved=dimmed-zebra
--color-moved-ws=allow-indentation-change'.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/crypto/aes.h        |  4 ---
>  crypto/aes.c                | 51 ---------------------------------
>  crypto/cipher-builtin.inc.c | 56 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 56 insertions(+), 55 deletions(-)
> 
> diff --git a/include/crypto/aes.h b/include/crypto/aes.h
> index 12fb321b89..ba297d6a73 100644
> --- a/include/crypto/aes.h
> +++ b/include/crypto/aes.h
> @@ -16,7 +16,6 @@ typedef struct aes_key_st AES_KEY;
>  #define AES_set_decrypt_key QEMU_AES_set_decrypt_key
>  #define AES_encrypt QEMU_AES_encrypt
>  #define AES_decrypt QEMU_AES_decrypt
> -#define AES_cbc_encrypt QEMU_AES_cbc_encrypt
>  
>  int AES_set_encrypt_key(const unsigned char *userKey, const int bits,
>  	AES_KEY *key);
> @@ -27,9 +26,6 @@ void AES_encrypt(const unsigned char *in, unsigned char *out,
>  	const AES_KEY *key);
>  void AES_decrypt(const unsigned char *in, unsigned char *out,
>  	const AES_KEY *key);
> -void AES_cbc_encrypt(const unsigned char *in, unsigned char *out,
> -		     const unsigned long length, const AES_KEY *key,
> -		     unsigned char *ivec, const int enc);
>  
>  extern const uint8_t AES_sbox[256];
>  extern const uint8_t AES_isbox[256];
> diff --git a/crypto/aes.c b/crypto/aes.c
> index 0f6a195af8..159800df65 100644
> --- a/crypto/aes.c
> +++ b/crypto/aes.c
> @@ -1599,54 +1599,3 @@ void AES_decrypt(const unsigned char *in, unsigned char *out,
>  }
>  
>  #endif /* AES_ASM */
> -
> -void AES_cbc_encrypt(const unsigned char *in, unsigned char *out,
> -                     const unsigned long length, const AES_KEY *key,
> -                     unsigned char *ivec, const int enc)
> -{
> -
> -        unsigned long n;
> -        unsigned long len = length;
> -        unsigned char tmp[AES_BLOCK_SIZE];
> -
> -        assert(in && out && key && ivec);
> -
> -        if (enc) {
> -                while (len >= AES_BLOCK_SIZE) {
> -                        for(n=0; n < AES_BLOCK_SIZE; ++n)
> -                                tmp[n] = in[n] ^ ivec[n];
> -                        AES_encrypt(tmp, out, key);
> -                        memcpy(ivec, out, AES_BLOCK_SIZE);
> -                        len -= AES_BLOCK_SIZE;
> -                        in += AES_BLOCK_SIZE;
> -                        out += AES_BLOCK_SIZE;
> -                }
> -                if (len) {
> -                        for(n=0; n < len; ++n)
> -                                tmp[n] = in[n] ^ ivec[n];
> -                        for(n=len; n < AES_BLOCK_SIZE; ++n)
> -                                tmp[n] = ivec[n];
> -                        AES_encrypt(tmp, tmp, key);
> -                        memcpy(out, tmp, AES_BLOCK_SIZE);
> -                        memcpy(ivec, tmp, AES_BLOCK_SIZE);
> -                }
> -        } else {
> -                while (len >= AES_BLOCK_SIZE) {
> -                        memcpy(tmp, in, AES_BLOCK_SIZE);
> -                        AES_decrypt(in, out, key);
> -                        for(n=0; n < AES_BLOCK_SIZE; ++n)
> -                                out[n] ^= ivec[n];
> -                        memcpy(ivec, tmp, AES_BLOCK_SIZE);
> -                        len -= AES_BLOCK_SIZE;
> -                        in += AES_BLOCK_SIZE;
> -                        out += AES_BLOCK_SIZE;
> -                }
> -                if (len) {
> -                        memcpy(tmp, in, AES_BLOCK_SIZE);
> -                        AES_decrypt(tmp, tmp, key);
> -                        for(n=0; n < len; ++n)
> -                                out[n] = tmp[n] ^ ivec[n];
> -                        memcpy(ivec, tmp, AES_BLOCK_SIZE);
> -                }
> -        }
> -}
> diff --git a/crypto/cipher-builtin.inc.c b/crypto/cipher-builtin.inc.c
> index 4d971a2b82..416d44b38e 100644
> --- a/crypto/cipher-builtin.inc.c
> +++ b/crypto/cipher-builtin.inc.c
> @@ -100,6 +100,62 @@ static void do_aes_decrypt_ecb(const void *vctx, size_t len,
>      }
>  }
>  
> +static void AES_cbc_encrypt(const unsigned char *in, unsigned char *out,
> +                            const unsigned long length, const AES_KEY *key,
> +                            unsigned char *ivec, const int enc)
> +{
> +    unsigned long n;
> +    unsigned long len = length;
> +    unsigned char tmp[AES_BLOCK_SIZE];
> +
> +    assert(in && out && key && ivec);
> +
> +    if (enc) {
> +        while (len >= AES_BLOCK_SIZE) {
> +            for (n = 0; n < AES_BLOCK_SIZE; ++n) {
> +                tmp[n] = in[n] ^ ivec[n];
> +            }
> +            AES_encrypt(tmp, out, key);
> +            memcpy(ivec, out, AES_BLOCK_SIZE);
> +            len -= AES_BLOCK_SIZE;
> +            in += AES_BLOCK_SIZE;
> +            out += AES_BLOCK_SIZE;
> +        }
> +        if (len) {
> +            for (n = 0; n < len; ++n) {
> +                tmp[n] = in[n] ^ ivec[n];
> +            }
> +            for (n = len; n < AES_BLOCK_SIZE; ++n) {
> +                tmp[n] = ivec[n];
> +            }
> +            AES_encrypt(tmp, tmp, key);
> +            memcpy(out, tmp, AES_BLOCK_SIZE);
> +            memcpy(ivec, tmp, AES_BLOCK_SIZE);
> +        }
> +    } else {
> +        while (len >= AES_BLOCK_SIZE) {
> +            memcpy(tmp, in, AES_BLOCK_SIZE);
> +            AES_decrypt(in, out, key);
> +            for (n = 0; n < AES_BLOCK_SIZE; ++n) {
> +                out[n] ^= ivec[n];
> +            }
> +            memcpy(ivec, tmp, AES_BLOCK_SIZE);
> +            len -= AES_BLOCK_SIZE;
> +            in += AES_BLOCK_SIZE;
> +            out += AES_BLOCK_SIZE;
> +        }
> +        if (len) {
> +            memcpy(tmp, in, AES_BLOCK_SIZE);
> +            AES_decrypt(tmp, tmp, key);
> +            for (n = 0; n < len; ++n) {
> +                out[n] = tmp[n] ^ ivec[n];
> +            }
> +            memcpy(ivec, tmp, AES_BLOCK_SIZE);
> +        }
> +    }
> +}
> +
> +
>  static int qcrypto_cipher_encrypt_aes(QCryptoCipher *cipher,
>                                        const void *in,
>                                        void *out,
> 


