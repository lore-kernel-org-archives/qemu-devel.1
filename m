Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BA7C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 20:39:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF86A2089D
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 20:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ceOifxFX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF86A2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jov8B-0004r0-7J
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 16:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jov7J-00049P-UQ
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 16:38:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59188
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jov7H-000542-O4
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 16:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593203911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nTBbaiBJdiDQnpZLEl/lxWvdGQAAyCK4GjJQWl+WFeU=;
 b=ceOifxFXHB7YwSFWqN3nXt9LPz4us0lf0xPKvwxs+eR2r+ZIADe6Z6KcBn7MlO1xE/iZ9H
 Ktxm6mz24uBv5rFc5DIek3wA4LyBHENb3iaZ0Wa6d+97hVq78uaPvQ96o2Nv9WZz7ve8En
 wVnZRX/LYYCYnWr3SuPfugdzUJCl1dY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236--klN2B8AMIeX9vzURe4kZQ-1; Fri, 26 Jun 2020 16:38:29 -0400
X-MC-Unique: -klN2B8AMIeX9vzURe4kZQ-1
Received: by mail-wm1-f71.google.com with SMTP id y204so1253437wmd.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 13:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=nTBbaiBJdiDQnpZLEl/lxWvdGQAAyCK4GjJQWl+WFeU=;
 b=fPm6/OYidxEGfwHuRWhhdAnqaL7SRZCwfBuczrB1mZY9nMjXTysjN5826JVMjoN8RT
 L0vF9n5Biu/XHP4oh+XshHm5trg3oRMzCL8oNyuwE8gf37oVHJ53FNQvvlqtX/QDVq54
 ER+siJBdBYpWG/n32u8rOTrwP2T90AhkJNWmoK5DE8DKzhvF2b5dIsoDbuIUvbDj0Tv3
 vhbZ9lhWq/EY2GANpwt8sUDz9IJiRuK1ZumZghU3UmFd5k4xgzlGYgjgNqAoYyDGaLs1
 bbmcBQQCOpP9kV1O5FLuKUV+lMeghMO2bqFKWrhlCvX3lORUDIjUXkn4jpqZS59WhERX
 sT6g==
X-Gm-Message-State: AOAM532rFFWfgyMWUN7g1mkWxf+KKYGP+vCvW0ZjQAYmhg24VZ+t6m8n
 miYly4VeZ3pbp+PmtpvlIF3N/4j4ZfzVV1mmmI2zFTlRoB3/fVMFPeT9EI1tLa8/M2UJDxI9lD0
 MytismdxyWFoKaWA=
X-Received: by 2002:adf:e811:: with SMTP id o17mr5885479wrm.53.1593203907804; 
 Fri, 26 Jun 2020 13:38:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDJZ98mW5zzTSroZSX9P6MLyrbxoe1ER6ezo7Rj0XXm6SVO492n7nkKj3MBHEDOODDMsrXfA==
X-Received: by 2002:adf:e811:: with SMTP id o17mr5885462wrm.53.1593203907582; 
 Fri, 26 Jun 2020 13:38:27 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id f17sm19090899wrq.3.2020.06.26.13.38.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2020 13:38:27 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] tests/qht-bench: Adjust threshold computation
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200626200950.1015121-1-richard.henderson@linaro.org>
 <20200626200950.1015121-3-richard.henderson@linaro.org>
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
Message-ID: <6f38dcac-131c-b831-47db-813713d90c64@redhat.com>
Date: Fri, 26 Jun 2020 22:38:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200626200950.1015121-3-richard.henderson@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 01:55:55
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
Cc: cota@braap.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/26/20 10:09 PM, Richard Henderson wrote:
> In 06c4cc3660b3, we split the multiplication in two parts to avoid
> a clang warning.  But because double still rounds to 53 bits, this
> does not provide additional precision beyond multiplication by
> nextafter(0x1p64, 0), the largest representable value smaller
> than 2**64.
> 
> However, since we have eliminated 1.0, mutiplying by 2**64 produces
> a better distribution of input values to the output values.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tests/qht-bench.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qht-bench.c b/tests/qht-bench.c
> index ad885d89d0..362f03cb03 100644
> --- a/tests/qht-bench.c
> +++ b/tests/qht-bench.c
> @@ -289,11 +289,25 @@ static void pr_params(void)
>  
>  static void do_threshold(double rate, uint64_t *threshold)
>  {
> +    /*
> +     * For 0 <= rate <= 1, scale to fit in a uint64_t.
> +     *
> +     * Scale by 2**64, with a special case for 1.0.
> +     * The remainder of the possible values are scattered between 0
> +     * and 0xfffffffffffff800 (nextafter(0x1p64, 0)).
> +     *
> +     * Note that we cannot simply scale by UINT64_MAX, because that
> +     * value is not representable as an IEEE double value.
> +     *
> +     * If we scale by the next largest value, nextafter(0x1p64, 0),
> +     * then the remainder of the possible values are scattered between
> +     * 0 and 0xfffffffffffff000.  Which leaves us with a gap between
> +     * the final two inputs that is twice as large as any other.
> +     */
>      if (rate == 1.0) {
>          *threshold = UINT64_MAX;
>      } else {
> -        *threshold = (rate * 0xffff000000000000ull)
> -                   + (rate * 0x0000ffffffffffffull);
> +        *threshold = rate * 0x1p64;
>      }
>  }
>  
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


